function [] = convEclGrd(caseName )
%CONVECLGRD Convert Eclipse Grid Data
%   convEclGrd(caseName) takes the case root name caseName and loads, 
%   converts and saves the Eclipse grid data into a format available 
%   for plot and visualization in a .mat file containing the same root 
%   name in VCT folder.
%
%   See also convAllInit, mkRP, mkRV.

%%
msg = ['Converting Eclipse grid data for case ' caseName];
display(msg);
logIt(msg);
% Load Eclipse data file
fN_DATA = [pthSCN(caseName) caseName '.DATA'];
if exist(fN_DATA,'file')
    G = readGRDECL(fN_DATA);
    Grd = processGRDECL(G);
    Grd = computeGeometry(Grd(1));
    % Save to mat file
    mkVCT(caseName);
    fN_MAT = [pthVCT(caseName) caseName '_GRD.mat'];
    save(fN_MAT,'Grd');
else
    msg = ['Eclipse data file not found for ' caseName];
    display(msg);
    logIt(msg);
end
end
