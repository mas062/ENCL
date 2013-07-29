function [ varargout ] = convAllEcl( scnTmp )
%CONVALLECL Convert All Eclipse Data
%   convAllEcl(scnTmp) loads and converts Eclipse outputs for all the
%   realizations into a format available for plots and visualization. Data
%   related to runs of scenario template scnTmp are used.
%
%   See also convEclData, rsltPlot, rsltCompare.

%%
%
for i=1:3
    for j=1:3
        csDir =[enclDir '02-HetVarStudy/C' num2str(i) ...
            num2str(j) '/'];
        rLst = dir(csDir);
        for k=4:length(rLst)
            rlz = char(rLst(k).name);
            caseName = ['ENCL' rlz(2:end) scnTmp(5:10)];
            convEclData(caseName);
        end
    end
end
end

