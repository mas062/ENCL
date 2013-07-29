function [ var_path ] = pthbVAR( rlz )
%PTHBVAR Back-up Path to VAR folder
%   var_path = pthbVAR(rlz) returns the path to the realization VAR folder.
%   rlz is the realization name. VAR folder is the directory which 
%   stores the realization variable properties, say Eclipse keywords in
%   seperate files. This is the path on the backup disk.
%
%   See also pthbSCN, pthVIZ, pthPLT, pthRINC.

%%
cls = rlz2cls(rlz);
var_path = [bkDisk 'CLS/' cls '/' rlz '/VAR/'];

end

