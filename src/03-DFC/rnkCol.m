function [rnk_col] = rnkCol(Grd,p,bx)
%RNKCOL Rank Column
%   rnkCol(Grd,p) ranks the values on each column of the grid property 
%   p over the grid Grd by giving an order number to the cells. 
%
%   See also perf.

%% 

nx = Grd.cartDims(1);
ny = Grd.cartDims(2);
nz = Grd.cartDims(3);


rnk_col = zeros(nx,ny,nz);
for i = bx(1):bx(2),
    for j = bx(3):bx(4),
        col = boxIndFltr(Grd,i,i,j,j,bx(5),bx(6));
        [s,ind] = sort(p(col));
        rnk_col(col(ind)) = 1:length(ind);
    end
end
end
