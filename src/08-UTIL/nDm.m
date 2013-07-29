function [ind] = nDm(cls)
%ND n Dimensional Index
%   [ind] = nDm(cls) returns the n dimensional index for class cls.
%
%   See also nD2lin.

%%
%
f = str2num(cls(2));
l = str2num(cls(3)); 
b = str2num(cls(4));
a = str2num(cls(5));
p = str2num(cls(6));
%
ind = [f l b a p];
%
end

