function [] = encl(scnTmp)
%ENCL Enceladus Version 01
%   encl(scnTmp) performs a fully automated procedure to implement the
%   scenario scnTmp on all realizations and produce the run results
%   reports.
%
%%%----........................ENCELADUS..........................----%%%

% %% List the available realizations
% mkRL;
% 
% %% Data Classification
% clnAllVAR;
% dataClass;

% %% Construct Eclipse Data Files 
% % Make and publish titles for simulation cases
% ttlPblsh(scnTmp);
% % Make Eclipse data files
% mkAllCase(scnTmp);
% %

%% Run Submission and Output Conversion
submitRun(scnTmp);
%
clcAllPlt(scnTmp);
%% RV
mkAllRV(scnTmP);
%% RP

%% RPT


end

