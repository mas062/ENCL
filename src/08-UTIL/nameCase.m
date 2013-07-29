function [caseName] = nameCase(scnTmp,rlz)
%NAMECASE Name Case
%   nameCase(scnTmp,rlz) names the case which combines the realization rlz
%   and scnTmp scenario. 
%
%   See also mkCase, mkScn.

%%

caseName = [rlz(3:end) '_' scnTmp(1:5)];

end

