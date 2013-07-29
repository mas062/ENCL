function [] = mkChkEcl(nd)
%MKCHKECL Make Check Eclipse
%   mkChkEcl() makes eclipse cases to be checked with polynomial approximations.
%
%   See also .


%% Load Collocation Bases
pN = [enclDir 'ACP/' num2str(nd) '/'];
%Load workspace variables
cssFile = [pN 'chkCss.mat'];
load(cssFile,'css');

for c=1:length(css),
	cs = css{c};
	rlz = case2rlz(cs);
	scn = case2scn(cs);
	mkCase(scn,rlz);
end

end
