function [ varargout ] = rvAll(scnTmp)
%RVALL Result Visualizations for All Cases
%   rvAll(scnTmp) takes the scenario template scnTmp and performs 
%   visualization on grid for all realization runs on that scenario.
%
%   See also mkRv.

%%
%
for i=1:3
    for j=1:3
        csDir =[enclDir '02-HetVarStudy/C' num2str(i) ...
            num2str(j) '/'];
        rLst = dir(csDir);
        for k=4:length(rLst)
            rlz = char(rLst(k).name);
            caseName = ['ENCL' rlz(2:end) '_' scnTmp(6:10)];
            display(['Visualization for '  ])
            mkRV(caseName);
        end
    end
end
end