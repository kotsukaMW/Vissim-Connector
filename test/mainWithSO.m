clear classes;
close all;
clear VissimConnectorSO
p = currentProject;
strProjectRootDir = p.RootFolder; % = cd();

%% Designate C++ files 
%{
strVissimConnectorDLLFile = "./VissimConnectorDLL/x64/Release/VissimConnectorDLL.dll";
strInterfaceDLLFile       = "./VissimInterface/VissimInterfaceInterface.dll";
strVissimDLLFile          = "C:\Program Files\PTV Vision\PTV Vissim 2021\API\DrivingSimulator_DLL\bin\VS2013\x64\DrivingSimulatorProxy.dll";

[strVissimConnectorDLLFilepath, ~,  ~] = fileparts(strVissimConnectorDLLFile);
[strInterfaceDLLFilepath,       ~,  ~] = fileparts(strInterfaceDLLFile);
[strVissimDLLFilepath,          ~,  ~] = fileparts(strVissimDLLFile);
%}

%% Use C++ DLL through clib object
%{
addpath( strInterfaceDLLFilepath );
setenv('PATH',strcat(strVissimConnectorDLLFilepath,';',strInterfaceDLLFilepath,';',strVissimDLLFilepath) );
%}

%% Instantiate Vissim Connector.
strINPXFile = fullfile(strProjectRootDir, "./data/VissimScenario/MyVIssimScenario.inpx");
obj = VissimConnectorSO();
obj.m_strFilename = strINPXFile;


%% Connect to Vissim
obj.connect();
bSuccessConnect = obj.isConnected;

%% Run simulation

% Prepare plotter
bep = birdsEyePlot('XLimits',[-10,420],'YLimits',[-340,10]);
dp1 = bep.detectionPlotter('DisplayName','Actors','MarkerFaceColor','b');
dp2 = bep.detectionPlotter('DisplayName','Ego','MarkerFaceColor','r');

%% Perform co-sim with Visisim
simulationTime = 100;
for t = 0 : 1/obj.m_dFrequency : 1000
    
    % Ego will get in a way
    x = 10 ;
    y = 2 * cos(t/2.5);
    vx = 10;
    vy = 10;
    
    egoIn = struct( ...
        'ActorID',1, ...
        'Position', [x y 0], ...
        'Velocity', [vx vy 0], ...
        'Roll', 0, ...
        'Pitch', 0, ...
        'Yaw', 0, ...
        'AngularVelocity', [0 0 0]);
    
    actorsactors = struct( ...
        'ActorID',2, ...
        'Position', [x+10 y 0], ...
        'Velocity', [vx vy 0], ...
        'Roll', 0, ...
        'Pitch', 0, ...
        'Yaw', 45, ...
        'AngularVelocity', [0 0 0]);
    actorsIn = struct( ...
        'NumActors', 1, ...
        'Time', t, ...
        'Actors', actorsactors);
    
    % Proceed one step co-sim.
    [actorsOut, egoOut] = obj.oneStep(actorsIn, egoIn, t);
    
    % Ego
    xEgo = egoOut.Position(1);
    yEgo = egoOut.Position(2);
    zEgo = egoOut.Position(3);
    fprintf("Time = %f\n", t);
    fprintf("    Ego = [%f,%f,%f]\n", xEgo, yEgo, zEgo); 
    
    % Get information for all actors in Vissim
    for i = 1 : actorsOut.NumActors
        actor = actorsOut.Actors(i);
        x(i,1) = actor.Position(1);
        y(i,1) = actor.Position(2);
        z(i,1) = actor.Position(3);
        id(i,1) = actor.ActorID;
        
        fprintf("    Actor %d = [%f,%f,%f]\n", id(i), x(i), y(i), z(i)); 

    end
    
    % Visialize
    if actorsOut.NumActors > 0
        dp1.plotDetection([x,y], string(id'));
    end
    dp2.plotDetection([xEgo,yEgo]);
end


%% Disconnect to Vissim and clear objects.
obj.disconnect();
close all;
