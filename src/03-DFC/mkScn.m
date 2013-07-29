function [ ] = mkScn( scnTmp )
%MKSCN  Scenario Construction Function
%   mkScn(scnTmp) takes the scenario template scnTmp and makes relevant
%   Eclipse data files for all classes and subclasses of realizations.
%
%   See also mkRL, mkCase, dataClass.
for i=1:3
    for j=1:3
        csDir =[enclDir '02-HetVarStudy/C' num2str(i) ...
            num2str(j) '/'];
        rLst = dir(csDir);
        for k=4:length(rLst)
            mkCase(scnTmp,char(rLst(k).name));
        end
    end
end
end

