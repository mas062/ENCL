function [] = clnUpScn(scnTmp)
%CLNUPSCN Clean Scenario
%   clnUpScn(scnTmp) takes the scenario template scnTmp and cleans up all the
%   files and folders which are made for this scenario in all classes and
%   subclasses.
%
%   See also clnSCN

%%
%
for f=1:2,
    for i=1:3,
        for j=1:3,
            for k=1:3,
                for l=1:3,
                    cls =['C' num2str(f-1) num2str(i) num2str(j)...
                         num2str(k) num2str(l)];
                    rLst = dir(clsDir(cls));
                    for lst=1:length(rLst)
                        rlz = char(rLst(lst).name);
                        if isRlz(rlz),
                            caseName = nameCase(scnTmp,rlz);
                            caseD = caseDir(caseName);
                            cmd = ['rm -r ' caseD];
                            system(cmd);
                            lstF = [enclDir 'DATA/CASE' caseName ...
                                    '_runs.lst']
                            if exist(lstF,'file'), 
                                fid = fopen(lstF,'wt');
                                fclose(fid);
                            end                                    
                        end
                    end
                end
            end
        end
    end
end



end

