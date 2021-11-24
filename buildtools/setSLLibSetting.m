%% Set VissimConnectorLib as a library brouser item 
% https://jp.mathworks.com/help/simulink/ug/adding-libraries-to-the-library-browser.html

filename = './VissimConnector/VissimConnectorLib.slx';
libname  = 'VissimConnectorLib';

%% Open library model
open(filename);

%% Unlock model
set_param(libname,'Lock','off');

%% Set to enable library browser repository
set_param('VissimConnectorLib','EnableLBRepository','on');

%% Save and close
save_system(libname);
close_system(libname);