function blkStruct = slblocks
% https://jp.mathworks.com/help/simulink/ug/adding-libraries-to-the-library-browser.html

		% This function specifies that the library should appear
		% in the Library Browser
		% and be cached in the browser repository

		Browser.Library = 'VissimConnectorLib';
		Browser.Name = 'Vissim Blockset';

		blkStruct.Browser = Browser; 
end