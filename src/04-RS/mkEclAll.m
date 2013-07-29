function [ varargout ] = mkEclAll(scnTmp)
%MKECLALL Eclipse All
%   mkEclAll(scnTmp) takes the scenario template name scnTmp and produces
%   the csh command file for all the generated cases. This can be called by
%   eclRun or eclAll functions.
% 
%   See also eclRun, mkEclRun, mkScn, eclAll.

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
            mkEclRun(caseName);
        end
    end
end

end
