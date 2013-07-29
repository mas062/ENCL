%% Average 2D Map
% Plots the vertically averaged 2D map of the selected property. 
function [Xm,Ym,Smap] = aveMap(G,prop)
%%
% * Specifiy the resolution of the 2D map(default values):
    xres = 100;
    yres = 100;
%%
% * Calculate the volume weights of the cells:
    volWgt = G.cells.volumes./mean(G.cells.volumes);
%%
% * Remove the third component of all cell centers to map them on the zero
% depth plane:
    Xo = G.cells.centroids(:,1);
    Yo = G.cells.centroids(:,2);
%%
% * Prodcue a uniformly distributed 2D mesh with the specified resolution:
    xm = linspace(min(Xo),max(Xo),xres);
    ym = linspace(min(Yo),max(Yo),yres);
    [Xm,Ym] = meshgrid(xm,ym);
%%
% * Map grid data on the uniform 2D mesh:
    Smap = griddata(Xo,Yo,volWgt.*prop,Xm,Ym);
    
    snapnow;
end