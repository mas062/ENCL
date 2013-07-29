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
                    cmd = ['mv ' rlz005D rlz001 '_ACTNUM.INC '...
                            rlz005D rlz005 '_ACTNUM.INC '];
                    system(cmd);
                    cmd = ['mv ' rlz041D rlz001 '_ACTNUM.INC '...
                            rlz041D rlz041 '_ACTNUM.INC '];
                    system(cmd);
                        %
                    cmd = ['mv ' rlz005D rlz001 '_COORD.INC '...
                            rlz005D rlz005 '_COORD.INC '];
                    system(cmd);
                    cmd = ['mv ' rlz041D rlz001 '_COORD.INC '...
                            rlz041D rlz041 '_COORD.INC '];
                    system(cmd);
                    %
                    cmd = ['mv ' rlz005D rlz001 '_MULTX.INC '...
                            rlz005D rlz005 '_MULTX.INC '];
                    system(cmd);
                    cmd = ['mv ' rlz041D rlz001 '_MULTX.INC '...
                            rlz041D rlz041 '_MULTX.INC '];
                    system(cmd);
                    %
                    cmd = ['mv ' rlz005D rlz001 '_MULTY.INC '...
                            rlz005D rlz005 '_MULTY.INC '];
                    system(cmd);
                    cmd = ['mv ' rlz041D rlz001 '_MULTY.INC '...
                            rlz041D rlz041 '_MULTY.INC '];
                    system(cmd);
                    %
                    cmd = ['mv ' rlz005D rlz001 '_MULTZ.INC '...
                            rlz005D rlz005 '_MULTZ.INC '];
                    system(cmd);
                    cmd = ['mv ' rlz041D rlz001 '_MULTZ.INC '...
                            rlz041D rlz041 '_MULTZ.INC '];
                    system(cmd);
                    %
                    cmd = ['mv ' rlz005D rlz001 '_NTG.INC '...
                            rlz005D rlz005 '_NTG.INC '];
                    system(cmd);
                    cmd = ['mv ' rlz041D rlz001 '_NTG.INC '...
                            rlz041D rlz041 '_NTG.INC '];
                    system(cmd);
                    %
                    cmd = ['mv ' rlz005D rlz001 '_PERMX.INC '...
                            rlz005D rlz005 '_PERMX.INC '];
                    system(cmd);
                    cmd = ['mv ' rlz041D rlz001 '_PERMX.INC '...
                            rlz041D rlz041 '_PERMX.INC '];
                    system(cmd);
                    %
                    cmd = ['mv ' rlz005D rlz001 '_PERMY.INC '...
                            rlz005D rlz005 '_PERMY.INC '];
                    system(cmd);
                    cmd = ['mv ' rlz041D rlz001 '_PERMY.INC '...
                            rlz041D rlz041 '_PERMY.INC '];
                    system(cmd);
                    %
                    cmd = ['mv ' rlz005D rlz001 '_PERMZ.INC '...
                            rlz005D rlz005 '_PERMZ.INC '];
                    system(cmd);
                    cmd = ['mv ' rlz041D rlz001 '_PERMZ.INC '...
                            rlz041D rlz041 '_PERMZ.INC '];
                    system(cmd);
                    %
                    cmd = ['mv ' rlz005D rlz001 '_PORO.INC '...
                            rlz005D rlz005 '_PORO.INC '];
                    system(cmd);
                    cmd = ['mv ' rlz041D rlz001 '_PORO.INC '...
                            rlz041D rlz041 '_PORO.INC '];
                    system(cmd);
                    %
                    cmd = ['mv ' rlz005D rlz001 '_SATNUM.INC '...
                            rlz005D rlz005 '_SATNUM.INC '];
                    system(cmd);
                    cmd = ['mv ' rlz041D rlz001 '_SATNUM.INC '...
                            rlz041D rlz041 '_SATNUM.INC '];
                    system(cmd);
                    %
                    cmd = ['mv ' rlz005D rlz001 '_SPECGRID.INC '...
                            rlz005D rlz005 '_SPECGRID.INC '];
                    system(cmd);
                    cmd = ['mv ' rlz041D rlz001 '_SPECGRID.INC '...
                            rlz041D rlz041 '_SPECGRID.INC '];
                    system(cmd);
                    %
                    cmd = ['mv ' rlz005D rlz001 '_ZCORN.INC '...
                            rlz005D rlz005 '_ZCORN.INC '];
                    system(cmd);
                    cmd = ['mv ' rlz041D rlz001 '_ZCORN.INC '...
                            rlz041D rlz041 '_ZCORN.INC '];
                    system(cmd);
                    
                %
                else
                    lin = fgetl(fid);
                end
            end
        end
    end
end