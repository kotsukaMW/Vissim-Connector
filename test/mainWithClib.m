clear classes;
close all;
p = currentProject;
strProjectRootDir = p.RootFolder; % = cd();

%% Designate C++ files 
strVissimConnectorDLLFile = './VissimConnectorDLL/x64/Release/VissimConnectorDLL.dll';
strInterfaceDLLFile       = "./VissimInterface/VissimInterfaceInterface.dll";
strVissimDLLFile          = 'C:\Program Files\PTV Vision\PTV Vissim 2021\API\DrivingSimulator_DLL\bin\VS2013\x64\DrivingSimulatorProxy.dll';

[strVissimConnectorDLLFilepath, ~,  ~] = fileparts(strVissimConnectorDLLFile);
[strInterfaceDLLFilepath,       ~,  ~] = fileparts(strInterfaceDLLFile);
[strVissimDLLFilepath,          ~,  ~] = fileparts(strVissimDLLFile);


%% Use C++ DLL through clib object
addpath( strInterfaceDLLFilepath );
setenv('PATH',strcat(strVissimConnectorDLLFilepath,';',strInterfaceDLLFilepath,';',strVissimDLLFilepath) );

%% Instantiate Vissim Connector.
strINPXFile = fullfile(strProjectRootDir, "./VissimScenario/MyVIssimScenario.inpx");
obj = clib.VissimInterface.VissimConnector(strINPXFile);


%% Connect to Vissim
frequency = 10;
radius = -1;
bSuccessConnect = obj.connect(frequency, radius, 10, 10, 0, 50000, 50000, 0);

%% Run simulation
ego = clib.VissimInterface.Simulator_Veh_Data;
ego.VehicleID = 1;
ego.VehicleType = 100;

% Prepare plotter
bep = birdsEyePlot('XLimits',[-10,420],'YLimits',[-340,10]);
dp1 = bep.detectionPlotter('DisplayName','Actors','MarkerFaceColor','b');
dp2 = bep.detectionPlotter('DisplayName','Ego','MarkerFaceColor','r');

%% Perform co-sim with Visisim
simulationTime = 100;
for t = 1 : 1/frequency : 100
    
    % Ego will get in a way
    ego.Position_X = 10 ;
    ego.Position_Y = 2 * cos(t/2.5);
    
    % Set ego position to Vissim
    obj.setDriverVehiclesData(1,ego);
    
    % Proceed one step co-sim.
    obj.step();
    
    % Obtain num of Actors in Vissim
    numActors = obj.getTrafficVehiclesDataCount();
    fprintf("NumActors at time %f: %d\n", t, numActors);
    
    x = zeros(numActors,1);
    y = zeros(numActors,1);
    z = zeros(numActors,1);
    id = zeros(numActors,1);
    xEgo = -10;
    yEgo = -10;
    
    % Get information for all actors in Vissim
    for i = 1 : numActors
        actor = obj.getTrafficVehiclesData(i-1);
        x(i,1) = actor.Position_X;
        y(i,1) = actor.Position_Y;
        z(i,1) = actor.Position_Z;
        id(i,1) = actor.VehicleID;
        isEgo = ~actor.ControlledByVissim;
        
        fprintf("    Actor %d = [%f,%f,%f]", i, x(i), y(i), z(i)); 
        if isEgo
            fprintf(" EGO\n");
            xEgo = x(i,1);
            yEgo = y(i,1);
        else
            fprintf("\n")
        end
        
        
    end
    
    % Visialize
    dp1.plotDetection([x,y], string(id'));
    dp2.plotDetection([xEgo,yEgo]);
end


%% Disconnect to Vissim and clear objects.
obj.disconnect();
clibRelease(obj);
close all;
