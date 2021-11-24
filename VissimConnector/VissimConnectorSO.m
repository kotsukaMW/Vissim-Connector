classdef VissimConnectorSO < matlab.System
    % VissimConnectorSO manages communication with Vissim.

    % Public, non-tunable properties
    properties(Nontunable)
        % m_strFilename Vissim file name (*.inpx)
        m_strFilename (1,:) char = 'E:\OneDrive - MathWorks\projects\vissim-connector\data\VissimScenario\MyVissimScenario.inpx';
        % Vissim simulation frequency (Hz)
        m_dFrequency (1,1) double = 10;
        % Radius to detect actors (m)
        m_dRadius (1,1) double = -1;
        % Maximum number of actors
        m_dMaxNumActors (1,1) double = 50;
        
        
        % Path to Vissim Connnector DLL (VissimConnectorDLL.dll)
        m_strVissimConnectorDLLFile (1,:) char = './VissimConnectorDLL/x64/Release/VissimConnectorDLL.dll';
        % Path to Vissim Interface DLL file (VissimInterfaceInterface.dll)
        m_strInterfaceDLLFile       (1,:) char = './VissimInterface/VissimInterfaceInterface.dll';
        % Path to Driving Simulator Proxy DLL (DrivingSimulatorProxy.dll)
        m_strVissimDLLFile          (1,:) char = 'C:\Program Files\PTV Vision\PTV Vissim 2021\API\DrivingSimulator_DLL\bin\VS2013\x64\DrivingSimulatorProxy.dll';
        
    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)
        % clib.MyInterface.VissimConnector object
        m_cppobj = [];
        % True if m_cppObj is connecting to Vissim
        m_bIsConnected = false;
        % Ego Actor ID
        m_dEgoActorID = [];
        
        % Previous actor positions to calculate velocity.
        m_prevActorPositions;
        % Previous actor angular velocity to calculate angular velocity.
        m_prevActorAngles   ;
        % Previous actor time to calculate velocity and angular velocities.
        m_prevActorTime     ;

    end
    
    methods
        
        function obj = VissimConnectorSO()
            % VissimConnectorSO Constructor.
            % Initialize internal state and path to DLLs.
            
            logger = getLogger();
            logger.trace("Enter");
            
            % Reset key-value pair containers
            obj.m_prevActorPositions = containers.Map('KeyType','double','valuetype','any');
            obj.m_prevActorAngles    = containers.Map('KeyType','double','valuetype','any');
            obj.m_prevActorTime      = containers.Map('KeyType','double','valuetype','any');
            
            % Set logger level
            % TODO: Set log level externally.
            logger.setLevel(Log4m.Level.INFO);
        end
        
        function delete(obj)
            % delete Destructor.
            % Disconnect to Vissim if available.
            
            logger = getLogger();
            logger.trace("Enter");
        end
        
        function connect(obj)
            % connect Connects to Vissim.
            %
            % connect(obj)
            
            logger = getLogger();
            logger.trace("Enter");
            
            % Initialize PATH environemnt variable and path
            [strVissimConnectorDLLFilepath, ~,  ~] = fileparts(obj.m_strVissimConnectorDLLFile);
            [strInterfaceDLLFilepath,       ~,  ~] = fileparts(obj.m_strInterfaceDLLFile);
            [strVissimDLLFilepath,          ~,  ~] = fileparts(obj.m_strVissimDLLFile);
            addpath( strInterfaceDLLFilepath );
            
            syspath = getenv('PATH');
            dllpath = strcat(strVissimConnectorDLLFilepath,';',strInterfaceDLLFilepath,';',strVissimDLLFilepath,';');
            if ~contains(syspath,dllpath) % Avoid multiple registration to PATH environment variable.
                setenv('PATH',strcat(dllpath,';',syspath) );
            end
            
            % Check file existence and connect to Vissim.
            if ~obj.checkFiles()
                logger.error("File check failed.");
                error("File check failed.");
            elseif obj.m_bIsConnected
                logger.warn("Already connected.", obj.m_strFilename);
            else
                % Connect to Vissim.
                obj.m_cppobj = clib.VissimInterface.VissimConnector(obj.m_strFilename);
                obj.m_bIsConnected = obj.m_cppobj.connect(obj.m_dFrequency, obj.m_dRadius, 10, 10, 0, 50000, 50000, 0);
            end
        end
        
        function bIsConnected = isConnected(obj)
            % isConnected Return true if the object is connecting to Vissim.
            % 
            % bIsConnected = isConnected(obj)
            % 
            % [Output]
            % bIsConnected: True if the object is connected to Vissim.
            
            logger = getLogger();
            logger.trace("Enter. bIsConnected=%d", obj.m_bIsConnected);
            
            bIsConnected = obj.m_bIsConnected;
        end
        
        function disconnect(obj, bForce)
            % DISCONNECT Disconnect from Vissim
            %
            % disconnect(obj, bForce)
            %
            % [Input]
            % bForce: True if you want to perform forced dosconnection.
            
            logger = getLogger();
            logger.trace("Enter");
            
            bPerformDisconnect = true;
            
            if ~obj.m_bIsConnected
                logger.error("Not connected.");
                bPerformDisconnect = false;
            elseif isempty(obj.m_cppobj)
                logger.error("cppobj is empty.");
                bPerformDisconnect = false;
            end
            
            
            if nargin == 2 && bForce
                bPerformDisconnect = true;
            end
                
            if bPerformDisconnect 
                obj.m_cppobj.disconnect();
                clibRelease(obj.m_cppobj);
                obj.m_cppobj = [];
                obj.m_bIsConnected = false;
            end
        end
        
        function [actorsOut, egoOut] = oneStep(obj, actorsIn, egoIn, simTime)
            % oneStep Perfrom one-step execution with Vissim.
            %
            % Ego and Actors specified with actorsIn and egoIn will be sent to Vissim and
            % be interacted with traffic flow in Vissim.
            % Then merged traffic flow will be reteruned in egoOut and actorsOut.
            % 
            % ActorID in egoIn and actorsIn are retained and new ActorID will be assigned
            % for traffic flow generated by Vissim.
            %
            % [actorsOut, egoOut] = oneStep(obj, actorsIn, egoIn, simTime)
            %
            % [Input]
            % actorsIn : Actor information specified with struct
            % egoIn    : Ego information specified with struct
            % simTime  : Simulation Time in second.
            %
            % [Output]
            % actorsOut: Merged actor information interacted with Vissim.
            % egoOut   : Merged Ego information interacted with Vissim.
            
            logger = getLogger();
            logger.trace("Enter");
            
            % Set Ego info
            obj.m_dEgoActorID = egoIn.ActorID;
            obj.setDriverVehiclesData(egoIn.ActorID, egoIn.Position, egoIn.Velocity, egoIn.Roll, egoIn.Pitch, egoIn.Yaw);
            
            % Set Actors info
            for i=1:actorsIn.NumActors
                actor = actorsIn.Actors(i);
                obj.setDriverVehiclesData(actor.ActorID, actor.Position, actor.Velocity, actor.Roll, actor.Pitch, actor.Yaw);
            end
            
            % Step
            bSuccess = obj.m_cppobj.step();
            
            % Obtain info from Vissim.
            [actorsOut, egoOut] = obj.getTrafficVehiclesData(simTime);
            
            logger.trace("oneStep() Success=%d, NumActors=(%d,%d)", bSuccess, actorsOut.NumActors, length(actorsOut.Actors));
        end
    end
    
    methods (Access = private)
        
        function bOK = checkFiles(obj)
            % checkFile Checks file existence and connect to Vissim.
            %
            % bOK = checkFile(obj)
            %
            % [Output]
            % bOK : Returns true if all specified files exist. Else stop processing.
            logger = getLogger();
            logger.trace("Enter");
            
            bOK = true;
            if ~isfile(obj.m_strFilename)
                bOK = false;
                logger.error("Vissim file not found. filename = %s", obj.m_strFilename);
                error("Vissim file not found. filename = %s", obj.m_strFilename);
            elseif ~isfile(obj.m_strVissimConnectorDLLFile)
                bOK = false;
                logger.error("Dependency file not found. Toolbox is correctly installed?  filename = %s", obj.m_strVissimConnectorDLLFile);
                error("Dependency file not found. Toolbox is correctly installed? filename = %s", obj.m_strVissimConnectorDLLFile);
            elseif ~isfile(obj.m_strInterfaceDLLFile)
                bOK = false;
                logger.error("Dependency file not found. Toolbox is correctly installed?  filename = %s", obj.m_strInterfaceDLLFile);
                error("Dependency file not found. Toolbox is correctly installed? filename = %s", obj.m_strInterfaceDLLFile);
            elseif ~isfile(obj.m_strVissimDLLFile)
                bOK = false;
                logger.error("Vissim DLL file not found. PTV Vissim is correctly installed? filename = %s", obj.m_strVissimDLLFile);
                error("Vissim DLL file not found. PTV Vissim is correctly installed? filename = %s", obj.m_strVissimDLLFile);
            end
        end
        
        function setDriverVehiclesData(obj, id, position, velocity, roll, pitch, yaw)
            % setDriverVehiclesData Set specified vehicle information to Vissim.
            % 
            % setDriverVehiclesData(obj, id, position, velocity, roll, pitch, yaw)
            % 
            % [Input]
            % id      : Actor ID
            % position: Position (m) [x y z]
            % velocity: Velocity (m/s) [vx vy vz]
            % roll    : Roll (deg)
            % pitch   : Pitch (deg)
            % yaw     : Yaw (deg)
            
            arguments 
                obj;
                id (1,1) int32;
                position (1,3) double;
                velocity (1,3) double;
                roll (1,1) double;
                pitch (1,1) double;
                yaw (1,1) double;
            end
            
            logger = getLogger();
            logger.trace("Enter");
            
            vehicleData = clib.VissimInterface.Simulator_Veh_Data;
            vehicleData.VehicleID= id;
            vehicleData.VehicleType = 100; %TBD
            vehicleData.Position_X = position(1);
            vehicleData.Position_Y = position(2);
            vehicleData.Position_Z = position(3);
            vehicleData.Speed = 0.0;%norm(velocity);
            vehicleData.Orient_Heading = deg2rad(yaw);
            vehicleData.Orient_Pitch = -deg2rad(pitch);
            
            obj.m_cppobj.setDriverVehiclesData(id,vehicleData);
            
            clibRelease(vehicleData);
        end
        
        function [actors, ego] = getTrafficVehiclesData(obj, time)
            % getTrafficVehiclesData Get vehicle information from Vissim.
            %
            % [actors, ego] = getTrafficVehiclesData(obj, time)
            %
            % [Input]
            % time: Simulation time
            %
            % [Output]
            % actors: Actor information specified with struct containing ActorInfo struct
            % ego   : Ego information specified with ActorInfo struct
            
            logger = getLogger();
            logger.trace("Enter");
            
            numVehicles = obj.m_cppobj.getTrafficVehiclesDataCount();
            numVehicles = min(numVehicles, obj.m_dMaxNumActors);
            
            %actors = createActorsStruct(numVehicles);
            actors = createActorsStruct(obj.m_dMaxNumActors);
            
            actors.NumActors = double(numVehicles);
            actors.Time = time; %TODO;
            for i=1:numVehicles
                trafficVehicleData = obj.m_cppobj.getTrafficVehiclesData(i-1); % Note that C++ index starts with zero.
                actorId = double(trafficVehicleData.VehicleID);
                
                actors.Actors(i).ActorID  = actorId;
                actors.Actors(i).Position = [trafficVehicleData.Position_X, trafficVehicleData.Position_Y, trafficVehicleData.Position_Z];
                actors.Actors(i).Yaw   =  rad2deg(trafficVehicleData.Orient_Heading);
                actors.Actors(i).Pitch = -rad2deg(trafficVehicleData.Orient_Pitch);
                actors.Actors(i).Roll  =  rad2deg(0);
                
                angle = [actors.Actors(i).Roll, actors.Actors(i).Pitch, actors.Actors(i).Yaw];
                if ~obj.m_prevActorPositions.isKey(actorId)
                    actors.Actors(i).Velocity        = [0 0 0];
                    actors.Actors(i).AngularVelocity = [0 0 0];
                else
                    dt = (time-obj.m_prevActorTime(actorId));
                    actors.Actors(i).Velocity        = (actors.Actors(i).Position - obj.m_prevActorPositions(actorId)) / dt;
                    actors.Actors(i).AngularVelocity = (angle - obj.m_prevActorAngles(actorId)) / dt;
                  
                end
                obj.m_prevActorPositions(actorId) = actors.Actors(i).Position;
                obj.m_prevActorAngles(actorId)    = angle;
                obj.m_prevActorTime(actorId)      = time;
                
                clibRelease(trafficVehicleData);
            end
            
            % If ego vehicle exists, find index then move actors.Actor(idx) to ego, then remove it from actor list.
            egoIndex = [];
            for i=1:numVehicles
                actorId = actors.Actors(i).ActorID;
                if actorId == obj.m_dEgoActorID
                    egoIndex = i;
                    break;
                end
            end
            if isempty(egoIndex)
                ego = createActorsActorsStruct();
            else
                ego = actors.Actors(i);
                actors.Actors(i) = [];
                actors.Actors(end+1) = createActorsActorsStruct();
                actors.NumActors = actors.NumActors - 1;
            end
                
        end
    end
    
    % -------------------------
    % Simulink configurations:
    % -------------------------
    
    methods(Access = protected)
        %% Common functions
        function setupImpl(obj)
            % setupImpl overwrites information specifed in parent mask.
            logger = getLogger();
            logger.trace("Enter");
            
            % ----
            % TODO: Find way to specify following (string) information directly from mask.
            % ---
            if ~isempty(gcs)
                strParentModel = gcs;
                obj.m_strFilename               = get_param(strParentModel, 'msk_strFilename');
                obj.m_strInterfaceDLLFile       = get_param(strParentModel, 'msk_strInterfaceDLLFile');
                obj.m_strVissimConnectorDLLFile = get_param(strParentModel, 'msk_strVissimConnectorDLLFile');
                obj.m_strVissimDLLFile          = get_param(strParentModel, 'msk_strVissimDLLFile');
            end
            
            % If Vissim Blockset is installed and being used, and file does not exist, then change DLL path.
            strVissimConnectorSODir = which('VissimConnectorSO');
            if contains(strVissimConnectorSODir,"MATLAB Add-Ons")
                [strAddOnPath, ~, ~] = fileparts(strVissimConnectorSODir);
                if ~isfile(obj.m_strInterfaceDLLFile)
                    obj.m_strInterfaceDLLFile = fullfile(strAddOnPath,obj.m_strInterfaceDLLFile);
                end
                if ~isfile(obj.m_strVissimConnectorDLLFile)
                    obj.m_strVissimConnectorDLLFile = fullfile(strAddOnPath,obj.m_strVissimConnectorDLLFile);
                end
            end
            
            % Check file existence
            if ~obj.checkFiles()
                logger.error("File check failed.");
                error("File check failed.");
            end
            
            % Connect to Vissim
            if obj.isConnected()
                obj.disconnect();
            end
            obj.connect();
            
        end

        function [actorsOut, egoOut] = stepImpl(obj, actorsIn, egoIn, simTime)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            logger = getLogger();
            logger.trace("Enter");
            
            [actorsOut, egoOut] = obj.oneStep(actorsIn, egoIn, simTime);
            
            printDebug(actorsOut, egoOut, simTime)
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
            logger = getLogger();
            logger.trace("Enter");
            
        end
        
        function releaseImpl(obj)
            % Release resources.
            logger = getLogger();
            logger.trace("Enter");
            
            if obj.isConnected()
                obj.disconnect();
            end
        end
    end
    
    methods(Access = protected)
        
        %% Simulink functions
        function ds = getDiscreteStateImpl(obj)
            % Return structure of properties with DiscreteState attribute
            logger = getLogger();
            logger.trace("Enter");
            
            ds = struct([]);
        end

        function flag = isInputSizeMutableImpl(obj,index)
            % Return false if input size cannot change
            % between calls to the System object
            logger = getLogger();
            logger.trace("Enter");
            
            flag = false;
        end

        function [out1, out2] = getOutputSizeImpl(obj)
            % Return size for each output port
            logger = getLogger();
            logger.trace("Enter");
            
            out1 = [1 1];
            out2 = [1 1];

            % Example: inherit size from first input port
            % out = propagatedInputSize(obj,1);
        end
        
        function [flag1, flag2] = isOutputFixedSizeImpl(obj)
            logger = getLogger();
            logger.trace("Enter");
            flag1 = true;
            flag2 = true;
        end
        
        function [flag1, flag2] = isOutputComplexImpl(obj)
            logger = getLogger();
            logger.trace("Enter");
            flag1 = false;
            flag2 = false;
        end
        
        function [out1, out2] = getOutputDataTypeImpl(obj)
            logger = getLogger();
            logger.trace("Enter");
            logger.trace("MaxNumActors=%d",obj.m_dMaxNumActors);
            
            strBusActorsName = "VissimBusActors";
            strBusActorsActorsName = "VissimBusActorsActors";
            
            createBusActor(obj.m_dMaxNumActors, strBusActorsName, strBusActorsActorsName);
            
            out1 = strBusActorsName;
            out2 = strBusActorsActorsName;
        end

        function icon = getIconImpl(obj)
            % Define icon for System block
            logger = getLogger();
            logger.trace("Enter");
            
            icon = mfilename("class"); % Use class name
            % icon = "My System"; % Example: text icon
            % icon = ["My","System"]; % Example: multi-line text icon
            % icon = matlab.system.display.Icon("myicon.jpg"); % Example: image file icon
        end
    end

    methods(Static, Access = protected)
        %% Simulink customization functions
        function header = getHeaderImpl
            % Define header panel for System block dialog
            logger = getLogger();
            logger.trace("Enter");
            
            header = matlab.system.display.Header(mfilename("class"));
        end

        function group = getPropertyGroupsImpl
            % Define property section(s) for System block dialog
            logger = getLogger();
            logger.trace("Enter");
            
            group = matlab.system.display.Section(mfilename("class"));
        end
        
    end
    
end

% -------------------------
% Supplementary functions:
% -------------------------

function s = createActorsStruct(maxNumActors)
% createActorsStruct returns bus struct container.
    sActorsActors = repmat(createActorsActorsStruct(),maxNumActors,1);
    s = struct( ...
        'NumActors', 0, ...
        'Time', 0, ...
        'Actors', sActorsActors);
end

function s = createActorsActorsStruct()
% createActorsActorsStruct returns bus struct container.
    s = struct( ...
        'ActorID', nan, ...
        'Position', [nan nan nan], ...
        'Velocity', [nan nan nan], ...
        'Roll', nan, ...
        'Pitch', nan, ...
        'Yaw', nan, ...
        'AngularVelocity', [nan nan nan]);
    end

function instance = getLogger()
% getLogger Returns logger instalnce.
    instance = Log4m.Logger.getInstance();
end

function printDebug(actors, ego, time)
% printDebug Prints ego and actor status with trace level.
    logger = getLogger();
    
    logger.trace("---Time=%f---",time);
    logger.trace("Ego:")
    logger.trace("    ego.ActorID         = %d", ego.ActorID);
    logger.trace("    ego.Position        = [%f, %f, %f]", ego.Position);
    logger.trace("    ego.Velocity        = [%f, %f, %f]", ego.Velocity);
    logger.trace("    ego.Roll,Pitch,Yaw  = [%f %f %f]", ego.Roll, ego.Pitch, ego.Yaw);
    logger.trace("    ego.AngularVelocity = [%f %f %f]", ego.AngularVelocity);
    logger.trace("Actor (NumActor=%d,Time=%f):", actors.NumActors, actors.Time);
    for i=1:actors.NumActors
        logger.trace("Actor %d:", i);
        actor = actors.Actors(i);
        logger.trace("    actor.ActorID         = %d", actor.ActorID);
        logger.trace("    actor.Position        = [%f, %f, %f]", actor.Position);
        logger.trace("    actor.Velocity        = [%f, %f, %f]", actor.Velocity);
        logger.trace("    actor.Roll,Pitch,Yaw  = [%f %f %f]", actor.Roll, actor.Pitch, actor.Yaw);
        logger.trace("    actor.AngularVelocity = [%f %f %f]", actor.AngularVelocity);
    end
    
end
