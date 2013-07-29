function [ ] = extCase(caseName,varargin)
%EXTCASE Extract Case
%   extCase(caseName,varargin) takes the Eclipase data file and all 
%   belonging include files for case caseName and put them together in the
%   path which is given in the varargin. If that's not given, a directory
%   on the Desktop will be made named by caseName.
%   This is useful when one wants to use a SAIGUP model for her/his own
%   experiment.
%
%   See also .

%% Run Directory
if isempty(varargin),
    runPth = ['/scratch/' caseName '/'];
else
    runPth = char(varargin{1});
end
%
cmd = ['mkdir ' runPth ];
system(cmd);
%
%% Copy Include Folders
%
% INC
incD = [enclDir() '/INC/* ' runPth 'INC/']; 
cmd = ['mkdir ' incD]; 
system(cmd);
cmd = ['yes | cp -r ' incD]; 
system(cmd);
%
% CINC
cincD = [pthCINC(case2cls(caseName)) '* ' runPth 'CINC/'];
cmd = ['mkdir ' cincD];
system(cmd);
cmd = ['yes | cp -r ' cincD];
system(cmd);
%
% VAR
varD = [pthVAR(case2rlz(caseName)) '* ' runPth 'VAR/'];
cmd = ['mkdir ' varD];
system(cmd);
cmd = ['yes | cp -r ' varD]; 
system(cmd);
%
% SINC
sincD = [pthSINC(caseName) '* ' runPth 'SINC/'];
cmd = ['mkdir ' sincD];
system(cmd);
cmd = ['yes | cp -r ' sincD]; 
system(cmd);
%
%% Modify The Data File
% Open the data file
fN = [pthSCN(caseName) caseName '.DATA'];
pN = [runPth caseName '.DATA'];
fip = fopen(pN,'w+');
fid = fopen(fN,'rt');
if fid ~= -1,
    while ~feof(fid),
        %
        lin = fgetl(fid);
        %
        if lin==-1
            error('Problem in reading the template file!');
            return;
        end
        %
        lin = strrep(lin,'../','');
        fprintf(fip, '%s \n',lin);
    end
end
fclose(fip);
fclose(fid);
end
