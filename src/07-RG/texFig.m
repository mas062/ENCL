function [] = texFig(figPth,dim,figName,texFN)
%TEXFIG Tex Figures
%   texFig(pth,dim,prop,title,texFN) makes the latex file for figures in
%   figName, which are on the path pth with made for variational parameter
%   of dimension dim.
%
%   See also texVP.

%%
%
switch dim,
    case 1,
        title = 'Fault Variation Plots';
    case 2,
        title = 'Lobosity Variation Plots';        
    case 3,
        title = 'Barrier Variation Plots';        
    case 4,
        title = 'Aggradation Variation Plots';        
    case 5,
        title = 'Progradation Variation Plots';        
end
%
fid = fopen(texFN, 'w+');
%
header = [enclDir '/DATA/SCN_RPT/TEX/TMP/VR_H.tex'];
hid = fopen(header, 'rt+');
%
while ~feof(hid),
    lin = fgetl(hid);
    if lin~=-1,
        fprintf(fid,'%s \n',lin);
    end
end
%
lin = ['\titleIt{' title '}'];
%
fprintf(fid,'%s\n',lin);
%
for i=1:length(figName),
    figFullName = [figPth figName{i}];
    %
    lin = ['\addFigure{' figFullName '}{' figCap(figName{i}) '}'];
    %
    fprintf(fid,'%s\n',lin);
end
%
lin = ['\end{document}'];
%
fprintf(fid,'%s\n',lin);
%
fclose(fid);
%
end


