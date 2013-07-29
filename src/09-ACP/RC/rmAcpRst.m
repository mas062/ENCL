function [ ] = rmAcpRst(nd)
%RMACPRST Remove ACP Rst
%   rmAcpRst generates run commands for the ACP Eclipse models.
%
%   See also csDim.

%% Loop Over Cases
pD = [enclDir 'ACP/' num2str(nd) '/'];
plN = [pD 'Log/acpRun.lst'];
fid = fopen(plN,'rt');

while ~feof(fid),
    %%  Monitoring
    % Check the list of cases in ACP
    cs = strtrim(fgetl(fid));    

    % Check for the cases run situation
    yesRun = runOk(cs);
    goodZip =false;
    zipF = [pthSCN(cs) cs '_RST.tar.gz'];
    isZip = exist(zipF);
    if isZip,
    	w=dir(zipF);
    	if w.bytes>100000000,
    		goodZip = true;
    	end
 	end
   if yesRun,
   	if goodZip,
   	 	rmRst(cs);    	
    	else
    	  	zipRst(cs); 
   	 	rmRst(cs);
	 	end
   end
    %
end
fclose(fid);

end

