function [] = logAcpCase(caseName)
%LOGACPCASE  Log ACP Cases
%   logAcpCase(caseName) takes the case name caseName and makes a
%   list of cases to be considered for run in ACP risk analysis.
%
%   See also mkRL, mkCase, dataClass, fltrCases.

	 nds = caseName(end-1); 
    plD = ['/Home/siv16/mas062/prjII/aPC/DATA/' nds '/Log/'];
    if ~exist(plD,'dir'), system(['mkdir ' plD]);end
    pN = [plD 'acpCase.lst'];
    fid = fopen(pN,'at');
    fprintf(fid,'%s \n',caseName);
    fclose(fid);
end

