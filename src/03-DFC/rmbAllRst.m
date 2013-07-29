function [] = rmbAllRst(scnTmp)
%rmbAllRst Remove All Backup Rst
%   rmbAllRst(scnTmp) takes the scenario template scnTmp and removes all
%   restart files of cases of the given scenario.
%
%   See also rmbRst.
h =@(x) rmbRst(x);
allCases(scnTmp,h);
end

