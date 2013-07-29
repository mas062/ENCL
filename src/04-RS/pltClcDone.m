function [] = pltClcDone(caseName)
%pltClcDone Plot Calculation Is Done
%   pltClcDone(caseName) adds caseName into the list of cases for which
%   plot calculations are done. The list are included in the file
%   scn_plt.lst in LOG directory.
%
%   See also clcPlt, clcAllPlt.

%%
fid = fopen([enclDir 'LOG/' case2scn(caseName) '_plt.lst'],'a+');
fprintf(fid,'%s \n',caseName);
fclose(fid);
%
end

