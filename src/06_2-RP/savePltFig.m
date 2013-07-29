function [] = savePltFig(h,figName,figPth,pn)
%SAVEPLTFIG Save Plot Figure
%   savePltFig(h,figName,figPth,pn) saves the figure in handle h in 
%   to PLT folder relevant to the figure name figName. The property name
%   pn is used for naming the file. figPth is the path address to the 
%   folder in which the figure is to be saved. 
%
%   See also mkCP, saveVizFig .

%%
%
rN = ['FIG_' figName '_' pn];
fN =[figPth rN];% '.eps'];
%
saveas(h,fN,'epsc');
saveas(h,fN,'fig');
%
end
