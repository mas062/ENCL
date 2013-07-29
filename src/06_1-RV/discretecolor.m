function [ varargout ] = discretecolor(cn)
%DISCRETECOLOR Discrete Color 
%   discretecolor(cn) shrinkes the color map to cn colors for discrete
%   color plots.
%
%   See also colorbar, gridViz.

%%
%   
switch cn
    case 1
        c = [0 1 0];
    case 2
        c = [0 0 1; 1 0 0];
    case 3 
        c = [0 0 1; 0 1 0; 1 0 0];
    case 4
        c = [0 0 1; 0 1 0; 1 1 0; 1 0 0];
    case 5
        c = [0 0 1; 0 1 1; 0 1 0; 1 1 0; 1 0 0];
    otherwise
        colormap('default');
        c = colormap;
        ci = linspace(1,64,cn);
        c = c(ci,:);
end
colormap(c);
end

