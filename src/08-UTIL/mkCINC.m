function [] = mkCINC(cls)
%MKCINC Make CINC Folder
%   mkCINC(cls) Makes the directory CINC of class cls.
%
%   See also pthCINC.

cmd = ['mkdir ' pthCINC(cls)];
system(cmd);

end

