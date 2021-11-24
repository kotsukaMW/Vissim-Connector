files = [
    "VissimConnector/createBusActor.m"
    "VissimConnector/PTVVissimLogo.png"
    "VissimConnector/callbackFilenameFromDialog.m"
    "VissimConnector/callbackFilenameToSO.m"
    "VissimConnector/VissimConnectorSO.m"
    "VissimConnector/VissimConnectorLib.slx"
    "VissimConnector/slblocks.m"
];

dirs = [
    "VissimConnector/+Log4m"
];

dlls = [
    "VissimInterface/VissimInterfaceInterface.dll"
    "VissimConnectorDLL/x64/Release/VissimConnectorDLL.dll"
];   

destination = "./build";

for i=1:length(files)
    filename = files(i);
    if exist(filename,'file')
        [~,name,ext] = fileparts(filename);
        f = strcat(name,ext);
        destfile = fullfile(destination,f);
        copyfile(filename, destfile, 'f');
        fprintf('File copied. From: %s\n', f);
        fprintf('               To: %s\n', destfile);
    else
        warning('File does not exist. Filename: %s', filename);
    end
end

for i=1:length(dirs)
    dirname = dirs(i);
    if exist(dirname,'dir')
        [~,d,~] = fileparts(dirname);
        destdir = fullfile(destination,d);
        copyfile(dirname, destdir,'f');
        fprintf('Directory copied. From: %s\n', dirname);
        fprintf('                    To: %s\n', destdir);
    else
        warning('Directory does not exist. Dirname: %s', filename);
    end
end

dlldir = fullfile(destination,'dll');
if ~exist(dlldir,'dir'), mkdir(dlldir), end
for i=1:length(dlls)
    dllname = dlls(i);
    if exist(dllname,'file')
        [~,name,ext] = fileparts(dllname);
        f = strcat(name,ext);
        destdll = fullfile(dlldir,f);
        copyfile(dllname, destdll, 'f');
        fprintf('DLL copied. From: %s\n', dllname);
        fprintf('              To: %s\n', destdll);
    else
        warning('DLL does not exist. Filename: %s', filename);
    end
end