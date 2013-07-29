function [] = clnVAR(rlz)
%clnVAR Clean VAR Directory
%   clnVAR(rlz) cleans the VAR directory specific to realization rlz.
%
%   See also clnSCN.

%%
mkVAR(rlz);
varD = pthVAR(rlz);
cmd = ['rm ' varD '*'];
system(cmd);

end

