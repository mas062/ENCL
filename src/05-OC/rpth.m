function [ rP ] = rpth( rN )
%RPTH Root Path
%   Returns the path to the root case name provided by rN in the input.
%

%%
rP =[enclDir '02-HetVarStudy/' rN(6:8) '/R' rN(5:13) '/' ...
    rN '/SCN/'];
end

