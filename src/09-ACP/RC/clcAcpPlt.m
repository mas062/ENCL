function [] = clcAcpPlt(nd)
%CLCACPPLT Calculate ACP Plots
%   clcAcpPlt() calculates the plot vectors for ACP runs
%
%   See also inVar, fndCln.


%% Load Collocation Bases
pN = ['~/prjII/aPC/DATA/' num2str(nd) '/'];
%Load workspace variables
polyFile = [pN 'polynomial.mat'];
load(polyFile,'CollocationPointsBase');

for i=1:size(CollocationPointsBase,1),
    cs = col2cs(CollocationPointsBase(i,:),nd);
    %
    if runOk(cs),
        unzipRst(cs);
        %
%         convEclGrd(cs);
%         %
%         convEclInit(cs);
%         %
%         convEclDyn(cs);    
        %
        clcPlt(cs);
        %
        pltClcDone(cs);
        %
        zipRst(cs);
        %
        rmRst(cs);
        %
    end
end

end
