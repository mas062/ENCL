function [] = oxed()
%OXED Oxford Conference Realizations
%   ox() converts and restructure the faulted given realizations into
%   Enceladus format. 
% 
%     The result of running this function is realization files in the 
%   format of R_C1####_SC005.grdecl and R_C1####_SC041.grdecl in RS 
%   folder. This prepares the step to run mkRlz function afterwards.
% 
%   See also mkRlz, dataClass.

%%
% folders and paths
rsDir  = [enclDir 'RS/'];
fltKld = [enclDir 'RS/faultfiles/'];
fltGrd = [enclDir 'RS/SAIGUP_COMMON/'];
oxDir  = [enclDir 'RS/OX/'];
%
orders = [fltKld 'OXF.txt'];
%
%%
[fid,msg] = fopen(orders,'rt');
ctr =0;
for p = 1:2,
    for a = [2,1,3],
        for l = 1:3,
            for b = 1:3,
                ctr = ctr + 1;
                ufltCls = ['C0' num2str(l) num2str(b)...
                    num2str(a) num2str(p)];
                fltCls  = ['C1' num2str(l) num2str(b)...
                    num2str(a) num2str(p)];
                fltDir = [oxDir fltCls '/'];
                cmd = ['mkdir ' fltDir];
                system(cmd);
                if (ctr ~= 29),
                %
                    rlz005 = ['R_' fltCls '_SC005'];
                    rlz041 = ['R_' fltCls '_SC041'];
                    rlz005Dir = [fltDir rlz005 '/'];
                    rlz041Dir = [fltDir rlz041 '/'];                    
                    cmd = ['mkdir ' rlz005Dir];
                    system(cmd);
                    cmd = ['mkdir ' rlz041Dir];
                    system(cmd);
                %
                    lin = fgetl(fid);
                    rn = textscan(lin,'%s');
                    rn = char(rn{1});
                    fltOrg = [fltKld kpdg(rn,3) '/FAULT_PROPERTIES/'];
                    zp005r = [ kpdg(rn,3) '_B21*'];
                    zp041r = [ kpdg(rn,3) '_B25*'];
                    zp005N = [fltOrg zp005r];
                    zp041N = [fltOrg zp041r];
                %
%                     cmd = ['cp ' zp005N ' ' rlz005Dir];
%                     system(cmd);
%                     cmd = ['cp ' zp041N ' ' rlz041Dir];
%                     system(cmd);
                %
%                     ZP005 = [rlz005Dir zp005r];
%                     ZP041 = [rlz041Dir zp041r];
                %
%                     cmd = ['gzip -d ' ZP005];
%                     system(cmd);
%                     cmd = ['gzip -d ' ZP041];
%                     system(cmd);
                %
                    urlz = ['R_' ufltCls '_SC001.grdecl'];
                    urlzf = [rsDir urlz];
                    zp005fe = [rlz005Dir 'R_' fltCls '_SC005_EDIT.INC'];
                    zp041fe = [rlz041Dir 'R_' fltCls '_SC041.EDIT.INC'];
                    if exist(zp005fe,'file'), 
                        cmd = ['rm ' zp005fe];system(cmd);
                    end
                    if exist(zp041fe,'file'), 
                        cmd = ['rm ' zp041fe];system(cmd);
                    end
                %
                    cmd = ['touch ' zp005fe];system(cmd);
                    cmd = ['touch ' zp041fe];system(cmd);
                %
                    appendFiles(zp005fe,[rlz005Dir kpdg(rn,3)...
                        '_B21.EDITNNC.001']);
                    appendFiles(zp005fe,[rlz005Dir kpdg(rn,3)...
                        '_B21.EDITNNC']);
                    appendFiles(zp005fe,[rlz005Dir kpdg(rn,3)...
                        '_B21.TRANX']);
                    appendFiles(zp005fe,[rlz005Dir kpdg(rn,3)...
                        '_B21.TRANY']);
                    %
                    appendFiles(zp041fe,[rlz041Dir kpdg(rn,3)...
                        '_B25.EDITNNC.001']);
                    appendFiles(zp041fe,[rlz041Dir kpdg(rn,3)...
                        '_B25.EDITNNC']);
                    appendFiles(zp041fe,[rlz041Dir kpdg(rn,3)...
                        '_B25.TRANX']);
                    appendFiles(zp041fe,[rlz041Dir kpdg(rn,3)...
                        '_B25.TRANY']);
                %
                    mkVAR(rlz005);
                    mkVAR(rlz041);
                    %
                    rdN005 = [pthVAR(rlz005) rlz005 '_EDIT.INC'];
                    rdN041 = [pthVAR(rlz041) rlz041 '_EDIT.INC'];
                    cmd = ['cp ' zp005fe ' ' rdN005]; system(cmd);
                    cmd = ['cp ' zp041fe ' ' rdN041]; system(cmd);
                %
                    grdF    = [fltGrd 'SAIGUP_B2.ZCORN'];
                    GRDf005 = [pthVAR(rlz005) rlz005 '_ZCORN.INC'];
                    GRDf041 = [pthVAR(rlz041) rlz041 '_ZCORN.INC'];
                    %
                    cmd = ['cp ' grdF ' ' GRDf005]; system(cmd);
                    cmd = ['yes | cp ' grdF ' ' GRDf041]; system(cmd);
                else
                    lin = fgetl(fid);
                end
            end
        end
    end
end
%
fclose(fid);
%
end
%
function [] = appendFiles(af,bf)
%%
%
[aid , amsg] = fopen(af,'a+');
[bid , bmsg] = fopen(bf,'rt');
while ~feof(bid),
    lin = fgetl(bid); 
    fprintf(aid,'%s \n',lin);
end
fclose(bid);
fclose(aid);
end
    
