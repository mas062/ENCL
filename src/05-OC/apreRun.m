function [] = apreRun(caseName)
%APRERUN After Run
%   apreRun(caseName) performs the tasks required after each run.
%
%   See also mkCase, mkEcl, runEcl, mkAllCase, mkAllEcl.

%% Convert Data
% Grid information
convEclGrd(caseName);
% Initial time information
convEclInit(caseName);
% Dynamic (restart and summary) data
convEclDyn(caseName);
%
%% Zip Data
% Zip restart files
zipRst(caseName);
% Remove restarts
rmRst(caseName);

%% Make Backup
% Back up the run folder
%bkCase(caseName);

%% Remove Zipped Data
%
%rmRun(caseName);
%
%rmVCT(caseName);
%
end
