function [] = rmSmry(caseName,varargin)
%RMSMRY Remove Summary
%   rmSmry(caseName,varargin) cleans up the run directory for summaries
%   and filters the required data, given by a vector in varargin as the 
%   report numbers to be left, after the run is finished. 
%
%   See also mkEcl, runEcl.

%%
%
if isempty(varargin), 
    display(['No report is specified! All summaries of case ' caseName ...
        ' will be deleted.']);
    rptNum = [];
else
    rptNum = varargin{1};
end
% Explore the run directory
fLst = dir(pthSCN(caseName));
%
for i=1:length(fLst),
    itemName = char(fLst(i).name);
    % Check if the read item is a restart file
    if isSmry(itemName),
        [p r s] = fileparts(itemName);
        % Check if the file belongs to the same case
        if strcmp(r,caseName),
            deleteIt = true;
            for j=1:length(rptNum),
                if strcmp(itemName,[caseName ...
                    '.A' kpdg(rptNum(j),4)]) || ...
                    strcmp(itemName,[caseName ...
                    '.S' kpdg(rptNum(j),4)]),
                    deleteIt = false;
                end 
            end
            if deleteIt,
                cmd = ['rm ' pthSCN(caseName) itemName];
                system(cmd);
            end
        end
    end       
end

