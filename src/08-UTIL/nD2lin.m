function [lin] = nD2lin(nD)
%ND2LIN n Dimensional To Linear Indexing
%   Lin = nD2lin(nD) converts the n dimensional indexing to linear index
%   for the cases in the data structure. n is 5 for the current structure.
%
%   See also lin2nD.

%%
% Dimension lengths
nf = 2;ni = 3;nj = 3;nk = 3;
nD(1) = nD(1)+1;% f in {0,1}
% 
indL = [1 nf nf*ni nf*ni*nj nf*ni*nj*nk];
lin = sum((nD-1).*indL)+1;
%
 end

