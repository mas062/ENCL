function [ ] = mkAcpCmd(nd)
%MKACPCMD Make ACP Commands
%   mkAcpCmd(nd) generates run commands for the ACP Eclipse models.
%
%   See also csDim.

%% Loop Over Cases
pD = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
plN = [pD 'Log/acpNotRun.lst'];
cmdD = [pD 'Cmd/'];
if ~exist(cmdD,'dir'); 
	system(['mkdir ' cmdD]);
end
logAcpRun(nd);
pcN = [cmdD 'acpCmd.lst'];
fid = fopen(plN,'rt');
cid = fopen(pcN,'wt');

while ~feof(fid),
    %%  Monitoring
    % Check the list of cases in ACP
    cs = strtrim(fgetl(fid));    

    % Check for the cases run situation
    notRun = ~runOk(cs);
    
    %% Write Out Commands
    % Write commands in a seperate file.
    cmd = ['sh ' pthCMD(cs) cs '.csh'];
    if notRun, fprintf(cid,'%s \n',cmd);end
    %
end
fclose(cid);
fclose(fid);

end

