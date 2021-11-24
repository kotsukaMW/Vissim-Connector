function filename = callbackFilenameFromDialog(filter, model, paramName)
% callbackFilenameFromDialog Obtains file name from dialog and sets value into specified fields of mask.

[file, path] = uigetfile(filter,"Select file");
if isequal(file,0)
    filename = '';
else
    filename = fullfile(path,file);
end
%filename = strcat('''',filename,''''); 
callbackFilenameToSO(model, paramName, filename);

end