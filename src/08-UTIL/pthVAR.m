function [ var_path ] = pthVAR( rlz )
%PTHVAR Path to VAR folder
%   var_path = pthVAR(rlz) returns the path to the realization VAR folder.
%   rlz is the realization name. VAR folder is the directory which 
%   stores the realization variable properties, say Eclipse keywords in
%   seperate files.
%
%   See also pthSCN, pthVIZ, pthPLT, pthRINC.

%%
cls = rlz2cls(rlz);
var_path = [enclDir 'CLS/' cls '/' rlz '/VAR/'];

end

