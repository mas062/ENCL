function [ varargout ] = eclAll(scnTmp)
%ECLALL Eclipse All
%   eclRun(scnTmp) Submits runs to Eclipse for all the generated cases
%   relevant to scnTmp scenario template.
%
%   See also eclRun, mkEclRun, mkScn.

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
            eclRun(caseName);
        end
    end
end

end
