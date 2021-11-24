p = currentProject;
strProjectRootDir = p.RootFolder; % = cd();

%% Designate C++ files 
strHeaderFile = fullfile(strProjectRootDir, './VissimConnectorDLL/VissimConnectorDLL/VissimConnector.h');
strDLLFile = fullfile(strProjectRootDir, './VissimConnectorDLL/x64/Release/VissimConnectorDLL.dll');
strLibFile = fullfile(strProjectRootDir, './VissimConnectorDLL/x64/Release/VissimConnectorDLL.lib');
strIncludePath = fullfile('C:\Program Files\PTV Vision\PTV Vissim 2021\API\DrivingSimulator_DLL\include');

strInterfacePackageName = "VissimInterface";

[strDLLFilepath, strDLLName, strDLLExt ]=fileparts(strDLLFile);
strInterfacePackageDir  = fullfile(strProjectRootDir, strInterfacePackageName);

strOutputFolder = fullfile(strProjectRootDir, 'VissimInterfaceBuild');

fprintf("HeaderFile: %s\n", strHeaderFile);
fprintf("DLLFile: %s\n", strDLLFile);
fprintf("LibFile: %s\n", strLibFile);
fprintf("IncludePath: %s\n", strIncludePath);
fprintf("InterfacePackageName: %s\n", strInterfacePackageName);
fprintf("InterfacePackageDir: %s\n", strInterfacePackageDir);
fprintf("OutputFolder: %s\n", strOutputFolder);

%% Delete old items
delete(fullfile(strOutputFolder, strcat('define', strInterfacePackageName, '.m')));
delete(fullfile(strOutputFolder, strcat('define', strInterfacePackageName, '.mlx')));
delete(fullfile(strOutputFolder, strcat(strInterfacePackageName, 'Data.xml')));
delete(fullfile(strInterfacePackageDir, strcat(strInterfacePackageName,"Interface.dll")));
if exist(strInterfacePackageDir, 'dir')
    rmdir(strInterfacePackageDir);
end
disp("--------- Deletion Complete ----------");

%% Generate library definition 

%clibgen.generateLibraryDefinition(strHeaderFile, 'Libraries', strLibFile, 'PackageName', strInterfacePackageName, ...
%    'Verbose', true);
clibgen.generateLibraryDefinition(strHeaderFile, 'Libraries', strLibFile, 'PackageName', strInterfacePackageName, ...
    'IncludePath', strIncludePath, 'OutputFolder', strOutputFolder, 'Verbose', true);
disp("--------- Generation Complete ----------");

%% Build C++-MATLAB interface DLL
cd(strOutputFolder);
libDef = eval( strcat('define', strInterfacePackageName, '()') ); % define<PackageName>()
libDef.build;
cd(strProjectRootDir);
movefile( fullfile(strOutputFolder, strInterfacePackageName), strProjectRootDir);
disp("--------- Build Complete ----------");
