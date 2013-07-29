function [] = runDsgn(nd)
%SCNDSGN Scenario Design
%   scnDsgn loads the collocation points and creats the Eclipse data files
%   required for tuning the polynmoials.
%
%   See also inVar, fndCln.
%%

%% Scenario Template 
scnT(nd);

%% Eclipse Data Files
csDim(nd);
%% Eclipse Commands
mkAcpCmd(nd);

end

