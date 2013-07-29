function [nD] = lin2nD(lin)
%LIN2ND Linear To n Dimensional Indexing
%   nD = lin2nD(lin) converts the linear indexing to n dimensional index
%   for the cases in the data structure. n is 5 for the current structure.
%
%   See also nD2lin.

%%
% Dimension lengths
nf=2;ni=3;nj=3;nk=3;
% 
d5 = floor(lin/(nf*ni*nj*nk));
m5 = mod(lin,(nf*ni*nj*nk));
nD(5) = d5+(m5~=0);
%
d4 = floor((lin-(nD(5)-1)*(nf*ni*nj*nk))/(nf*ni*nj));
m4 = mod((lin-(nD(5)-1)*(nf*ni*nj*nk)),(nf*ni*nj));
nD(4) = d4+(m4~=0);
%
d3 = floor((lin-(nD(5)-1)*(nf*ni*nj*nk)-(nD(4)-1)*(nf*ni*nj))/(nf*ni));
m3 = mod((lin-(nD(5)-1)*(nf*ni*nj*nk)-(nD(4)-1)*(nf*ni*nj)),(nf*ni));
nD(3) = d3+(m3~=0);
%
d2 = floor((lin-(nD(5)-1)*(nf*ni*nj*nk)-(nD(4)-1)*(nf*ni*nj)-(nD(3)-1)...
    *(nf*ni))/(nf));
m2 = mod((lin-(nD(5)-1)*(nf*ni*nj*nk)-(nD(4)-1)*(nf*ni*nj)-(nD(3)-1)...
    *(nf*ni)),(nf));
nD(2) = d2+(m2~=0);
%
nD(1) = lin-(nD(5)-1)*(nf*ni*nj*nk)-(nD(4)-1)*(nf*ni*nj)-(nD(3)-1)*...
    (nf*ni)-(nD(2)-1)*nf-1;
end

