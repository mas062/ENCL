function [] = mkAlledNNC(scnTmp)
%MKALLEDNNC  
%   
%   See edNnc .
h =@(x) task(x);
allCases(scnTmp,h);
end
function [] = task(caseName)
rlz = case2rlz(caseName);
if isRlz(rlz),
    edNnc(rlz);
end
end
