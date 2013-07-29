%% OX3
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
                if (ctr ~= 29),
                %
                    rlz001    = ['R_' ufltCls '_SC001'];
                    rlz005 = ['R_' fltCls '_SC005'];
                    rlz041 = ['R_' fltCls '_SC041'];
                    %
                    rlz001D = pthVAR(rlz001);
                    rlz005D = pthVAR(rlz005);
                    rlz041D = pthVAR(rlz041);
                    %
                    cmd = ['cp -r ' rlz001D '* ' rlz005D];system(cmd);
                    cmd = ['cp -r ' rlz001D '* ' rlz041D];system(cmd);
                %
                else
                    lin = fgetl(fid);
                end
            end
        end
    end
end