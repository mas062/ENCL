function [] = mvBkAllCase(scnTmp)
%MVBKALLCASE  Move Back All Cases
%   mvBkAllCase(scnTmp) takes the scenario template scnTmp and moves back
%   all run cases results for the given scenario.
%
%   See also mvBkCase, mvBk.
h =@(x) mvBkCase(x);
allCases(scnTmp,h);
end

