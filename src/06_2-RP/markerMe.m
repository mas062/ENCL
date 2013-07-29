function [mkr] = markerMe(ind)
%MARKERME Marker Me,
%   mkr = markerMe(ind) gets the linear index ind and returns the marker
%   mkr corresponding to the level of lobosity: square = flat, circle =
%   one lob and diamond = two lobs.
%
%   See also colorMe, sizeMe.

%%
nD = lin2nD(ind);
switch nD(2),
    case 1,
        mkr = 's';
    case 2,
        mkr = 'o';
    case 3,
        mkr = 'd';
end
end
