function [] = rmbRst(caseName,varargin)
%RMBRST Remove Backup Restart
%   rmbRst(caseName,varargin) cleans up the run directory and filters 
%   the required data, given by a vector in varargin as the report numbers  
%   to be left, after the run is finished. 
%
%   See also mkEcl, runEcl.

%%
%
msg = ['Removing restart files for case ' caseName '. '];
display(msg);
logIt(msg);
%
rmCounter = 0;
if isempty(varargin), 
    display(['No report is specified! All restarts of case ' caseName ...
        ' will be deleted.']);
    rptNum = [];
else
    rptNum = varargin{1};
end
% Explore the run directory
fLst = dir(pthbSCN(caseName));
%
for i=1:length(fLst),
    itemName = char(fLst(i).name);
    % Check if the read item is a restart file
    if isRst(itemName),
        [p r s] = fileparts(itemName);
        % Check if the file belongs to the same case
        if strcmp(r,caseName),
            deleteIt = true;
            for j=1:length(rptNum),
                if strcmp(itemName,[caseName ...
                    '.F' kpdg(rptNum(j),4)]) || ...
                    strcmp(itemName,[caseName ...
                    '.X' kpdg(rptNum(j),4)]),
                    deleteIt = false;
                end 
            end
            if deleteIt,
                cmd = ['rm ' pthbSCN(caseName) itemName];
                system(cmd);
                rmCounter = rmCounter +1;
            end
        end
    end       
end
%
indRst = [pthbSCN(caseName) caseName '.FRSSPEC'];
if exist(indRst,'file') && isempty(varargin),
    cmd = ['rm ' indRst];
    system(cmd);
end
%
msg = ['Removing ' num2str(rmCounter) ' restart file(s) for case ' ...
    caseName ' is done successfully.'];
display(msg);
logIt(msg);
%

end
