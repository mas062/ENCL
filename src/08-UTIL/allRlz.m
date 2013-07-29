function [] = allRlz(task)
%ALLCASES All Cases
%   allCases(scnTmp,task) performs function handle task on the cases
%   related to scenario template scnTmp. This is used to make the functions
%   on cases independent to the data structure.
%
%   See also mkAllEcl.

%%
for f=1:2,
    for i=1:3,
        for j=1:3,
            for k=1:3,
                for l=1:2,
                    cls =['C' num2str(f-1) num2str(i) num2str(j)...
                         num2str(k) num2str(l)];
                    rLst = dir(clsDir(cls));
                    for lst=1:length(rLst)
                         rlz = char(rLst(lst).name);
                        if isRlz(rlz),
                            task(rlz);
                        end
                    end
                end
            end
        end
    end
end
end

