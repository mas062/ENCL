function [] = clnAllVAR()
%CLNALLVAR Clean All VAR Directories
%   clnAllVAR() cleans all VAR directories in the DATA structure.
%
%   See also clnVAR.

%%
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
                            clnVAR(rlz);
                        end
                    end
                end
            end
        end
    end
end
%
end

