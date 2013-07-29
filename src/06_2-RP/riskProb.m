function [ fij ] = riskProb(Grd,frstLyr)
%RISKPROB Risk Probability Function
%   [ fij ] = riskProb(Grd,frstLyr,rskFun) takes the grid Grd and the first
%   layer cell array frstLyr and implements the risk function rskFun on the
%   model. The output is a risk probability values in the cells of first
%   layer. 
%   
%   See also clcPlt, mkCP.

%%
% Model dimensions in x and y directions
xg = Grd.cells.centroids(:,1);
yg = Grd.cells.centroids(:,2);
%
x = xg(frstLyr);
y = yg(frstLyr);
%
%
xi = min(x);xe = max(x);lx = xe-xi;
yi = min(y);ye = max(y);ly = ye-yi;
%
xn = (x-xi)./lx;
yn = (y-yi)./ly;
%
A = 1;
sx = 0.2;
sy = 0.2;
xo = 2000;%xi+lx/5;
yo = yi+ly/2;
xno = (xo-xi)./lx;
yno = (yo-yi)./ly;
%
fij = A*exp(-((xn-xno).^2/(2*sx^2)+(yn-yno).^2/(2*sy^2)));
%
%
xx = linspace(xi,xe,10);
yy = linspace(yi,ye,30);
[X,Y] = meshgrid(xx,yy);
Xn = (X-xi)/lx;
Yn = (Y-yi)/ly;
Fij = A*exp(-((Xn-xno).^2/(2*sx^2)+(Yn-yno).^2/(2*sy^2)));
surf(X,Y,Fij);
end

