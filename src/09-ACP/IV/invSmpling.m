function [ X ] = invSmpling(x,F,l)
%INVSMPLING Inverse Sampling
%   [ X ] = invSmpling(x,F,l) takes the input array x within interval [0,1]
%   and cummulative density function F, and generates samples X in the
%   interval l = [a,b] based on F. F and x must be corresponding and of the
%   same size.

%%
if length(F)~=length(x),
    error(['The input vector x and cummulative density vector are '...
         'of the same size!']);
end
ns = length(x);
u  = rand(1,ns);
X  = [];
for i =1:ns,
    X(1+end) = l(1)+(l(2)-l(1))*interp1(F,x,u(i),'linear','extrap');
end
end

