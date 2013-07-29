function [scn] = case2scn(caseName)
%CASE2SCN Case To Scenario
%   scn = case2scn(caseName) extracts the scenario template name from the
%   case name caseName.
%
%   See also case2rlz, case2cls, rlz2cls.

%%

scn = caseName(14:end);


end

