function [X] = nrm(x)
%NRM Normalize 
%   X = nrm(x) normlizes vector x over its range into vector X, which
%   canges between 0 and 1. 
%
%   See also crossAll.

% %%
% rngx = max(x) - min(x);
% %
% if rngx ~= 0,
%     X = (x-min(x))./rngx;
% else
%     X = 0;
% end
X=x;
%
end

