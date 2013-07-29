function [] = texVP(scnTmp,dim)
%TEXVP Tex Variational Plots
%   texVP(scnTmp,dim) takes the scenario template name scnTmp and dimension
%   of changing variable, dim, which varies between 1 and five currently
%   corresponding to fault, lobosity,... and produces the latex format file
%   for plots related to the variable understudy. The file will be stored
%   in the TEX folder under SCN_RPT.
%
%   See also rptVar.

%%
switch dim,
    case 1,
        prop = 'FLT';
    case 2,
        prop = 'LOB';        
    case 3,
        prop = 'BAR';        
    case 4,
        prop = 'AGR';        
    case 5,
        prop = 'PRG';        
    otherwise
        display('Not valid dimension is provided, nothing will be done.');
        return
end
%
pth = [enclDir 'DATA/SCN_PLT/PLT_' scnTmp '/' prop '/'];
%
if ~exist(pth), 
    display(['The variational plots not made for dimension ' ...
        num2str(dim) '.']);
    return
end
dL = dir(pth);
%
for prop = [{'DOFlx'},{'DWFlx'},{'FPR'},{'L2R'},{'LOFlx'},{'lrgstPlm'},...
        {'LWFlx'},{'mdnPlm'},{'mnPlm'},{'OL2R'},{'ROFlx'},{'RWFlx'},...
        {'stdPlx'},{'totMobCo2'},{'totResCo2'},{'WBHP'},{'WCIR'},{'WL2R'}],
    %
    figName = [];
    for i=1:length(dL),
        [pN rN eN] = fileparts(char(dL(i).name));
        if strcmp(eN,'.jpg'),
            if strfind(rN,char(prop)),
                figName{1+end} = rN;
            end
        end
    end
    %
    texFN = [enclDir 'DATA/SCN_RPT/TEX/dim' num2str(dim) '_' ...
        char(prop) '.tex'];
    %
    texFig(pth, dim,figName,texFN);
    %
end
    
end

