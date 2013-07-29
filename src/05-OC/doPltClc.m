function [ yes_no ] = doPltClc(caseName)
%DOPLTCLC Do Plot Calculation
%   [ yes_no ] = doPltClc(caseName) returns Boolean value which is true if
%   the plot calculations have not been performed for case caseName, and 
%   no if that's already done. This uses scn_plt.lst file in LOG directory.
%
%   See also runEclAll.

%%
yes_no = true;
%
pltLst = [enclDir 'LOG/' case2scn(caseName) '_plt.lst'];
if exist(pltLst,'file'),
    fid = fopen(pltLst,'rt');
    while ~feof(fid) && yes_no,
        lin = fgetl(fid);
        if lin ~= -1,
            cs = textscan(lin,'%s');
            yes_no = ~strcmp(caseName,char(cs{1}));
        end
    end
    fclose(fid);
end
end
