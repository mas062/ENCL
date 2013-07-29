function [clsbD] = clsbDir(cls)
%CLSBDIR Class Backup Directory
%   clsbDir(cls) returns the directory path to backup cls class folder.
%
%   See also rpth.

%%

clsbD = [bkDisk 'CLS/' cls '/'];

end

