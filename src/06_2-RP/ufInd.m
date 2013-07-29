function [ uf ] = ufInd(ind)
%UFIND Unfaulted Linear Index
%   [ uf ] = ufInd(ind) returns the linear index of the unfaulted case with
%   the same class attributes of the case of linear index ind.
%
%   see also nD.

%%
%
uf = [];
for i=1:length(ind),
    uf(end+1) = nD2lin(lin2nD(ind(i)).*[0 1 1 1 1]);
end
%
end

