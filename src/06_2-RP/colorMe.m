function [clr] = colorMe(ind)
%COLORME Color Me,
%   clr = colorMe(ind) gets the linear index ind and returns the color name
%   clr corresponding to the level of aggradation: blue = low, green =
%   medium and red = high.
%
%   See also markerMe, sizeMe.

%%
nD = lin2nD(ind);
switch nD(4),
    case 1,
        clr = [0 0 0.5];
    case 2,
        clr = [0 0.5 0];
    case 3,
        clr = [0.5 0 0];
end
%
   
end
