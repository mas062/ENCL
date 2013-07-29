function [yes_no] = runOk(caseName)
%RUNOK Run Went OK
%   yes_no = runOk(caseName) checks if the run for case caseName, is 
%   completed successfuly.
%
%   See also itsRun, runIt, runEcl, runAllEcl.

%%
yes_no = false;
%
fEclEnd = [pthSCN(caseName) caseName '.ECLEND'];
if exist(fEclEnd,'file'),
    fid = fopen(fEclEnd,'rt');
    while ~feof(fid),
       lin = fgetl(fid);
       if ~isempty(lin),
          if lin(1)~=-1,
            err = textscan(lin,'%s');
            if strcmp(char(err{1}(1)),'Errors') && ...
                   strcmp(char(err{1}(2)),'0'),
               yes_no = true;
            end
          end
       end
    end
end
end

