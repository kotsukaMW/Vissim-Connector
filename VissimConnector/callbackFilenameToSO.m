function callbackFilenameToSO(model, paramName, filename)
% callbackFilenameToSO Sets value into specified fields of mask.

if ~isempty(filename)
    set_param(model, paramName, filename);
end

end