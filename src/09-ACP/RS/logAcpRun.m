function [] = logAcpRun(nd)
%LOGACPCASE  Log ACP Runs
%   logAcpRun(caseName) takes the case name caseName and makes a
%   list of cases that are *NOT* run successfully for ACP risk analysis.
%
%   See also logAcpCase, mkRL, mkCase, dataClass, fltrCases.

	 nds = num2str(nd); 
    plD = ['/Home/siv16/mas062/prjII/aPC/DATA/' nds '/Log/'];
    if ~exist(plD,'dir'), system(['mkdir ' plD]);end
    pN = [plD 'acpRun.lst'];
    cN = [plD 'acpCase.lst'];
    nN = ['acpNotRun.lst'];
    fid = fopen(pN,'wt');
    nid = fopen(nN,'wt');
    cid = fopen(cN,'rt');    
    while ~feof(cid),
		lin = fgetl(cid);       
		cs = strtrim(lin);
    	if runOk(cs), 
    		fprintf(fid,'%s \n',cs);
 		else,
 			fprintf(nid,'%s \n',cs);
		end
    end
    fclose(cid);
	 fclose(nid);	
    fclose(fid);
end

