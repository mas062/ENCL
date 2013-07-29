function [] = convEclSmry(caseName )
%CONVECLSMRY Convert Eclipse Summary Files
%   convEclSmry(caseName) takes the case root name caseName and loads, 
%   converts and saves the Eclipse summary outputs into a format available
%   for plot and visualization in a .mat file with the same root name 
%   in VCT folder.
%
%   See also convAllSmry, mkRP.

%%
msg = ['Converting Eclipse Summary files for case ' caseName];
display(msg);
logIt(msg);
%
fN = [pthSCN(caseName) caseName];
%
if exist([fN '.FSMSPEC'],'file'),
    smry = readEclipseResults(fN,'UniformOutput',false);
%
    mkVCT(caseName);
    fN_MAT = [pthVCT(caseName) caseName '_SMRY.mat'];
%
    save(fN_MAT, 'smry');
else
    msg = ['Summary file(s) not found for ' caseName];
    display(msg);
    logIt(msg);
end
end

