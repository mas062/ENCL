function [] = mkCLS()
%mkCLS Make CLass Directories
%   MKCLS makes the class directories into CLS folder.
%
%  See also, mkRL.


%%
for f=1:2,
    for i=1:3,
        for j=1:3,
            for k=1:3,
                for l=1:3,
                    cls =['C' num2str(f-1) num2str(i) num2str(j)...
                         num2str(k) num2str(l)];
                     cmd = ['mkdir ' enclDir() 'DATA/CLS/' cls];
                     system(cmd);
                end
            end
        end
    end
end


end

