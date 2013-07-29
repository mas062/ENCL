function [sz] = sizeMe(ind)
%SIZEME Size Me,
%   sz = sizeMe(ind) gets the linear index ind and returns the size
%   sz corresponding to the level of barrier: square = low, circle =
%   medium and diamond = high.
%
%   See also markerMe, colorMe.

%%
nD = lin2nD(ind);
switch nD(3),
    case 1,
        sz = 30;
    case 2,
        sz = 70';
    case 3,
        sz = 200;
end
end