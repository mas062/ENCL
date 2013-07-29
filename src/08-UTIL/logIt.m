function [] = logIt(lgmsg)
%LOGIT Log It
%   logIt(lgmsg) prints out the message lgmsg in the log file, located at
%   DATA/LOG folder.
%
%   

%%
%
fN_LOG = [enclDir 'LOG/encl.log'];
%
fid = fopen(fN_LOG,'a+');
%
lin = '>=================>';
fprintf(fid,'%s \n',lin);
lin = datestr(clock);
fprintf(fid,'%s \n',lin);
fprintf(fid,'%s \n',lgmsg);
%
fclose(fid);
%
end

