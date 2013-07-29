function [clsD] = clsDir(cls)
%CLSDIR Class Directory
%   clsDir(cls) returns the directory path to cls class folder.
%
%   See also rpth.

%%

clsD = [enclDir 'CLS/' cls '/'];

end

