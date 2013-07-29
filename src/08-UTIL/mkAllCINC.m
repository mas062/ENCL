function [] = mkAllCINC()
%MKCINC Make CINC Folder
%   mkAllCINC() Makes the directory CINC of all classes.
%
%   See also mkCINC.

for f=1:2,
    for i=1:3,
        for j=1:3,
            for k=1:3,
                for l=1:3,
                    cls =['C' num2str(f-1) num2str(i) num2str(j)...
                         num2str(k) num2str(l)];
                    clsD = caseDir(cls);
                    if ~exist(clsD,'dir'),
                        cmd = ['mkdir ' clsD];
                        system(cmd);
                    end
                    if ~exist(pthCINC(cls),'dir'),
                        mkCINC(cls);
                    end
                end
            end
        end
    end
end
end

