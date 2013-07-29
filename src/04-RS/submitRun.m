function [] = submitRun(scnTmp)
%SUBMITRUN Submit Run
%   submitRun(scnTmp) performs run submission for scenario scnTmp over the
%   realizations.
%
%   See also mkAllEcl, runAllEcl(scnTmp).

%%
% Make run command files
%mkAllEcl(scnTmp);
% Run the Eclipse launching command files
runAllEcl(scnTmp);
end

