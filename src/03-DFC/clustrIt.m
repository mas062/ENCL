function [clstr] = clustrIt(Grd,p,thr)
%CLUSTERIT Cluster It
%   clustrIt(Grd,p,thr) finds the cluster clstr of connected cells in grid
%   Grd filtered for the property p above treshold thr.
%
%   See also perf.

%% 
pm = max(max(max(p)));
cells = valFltr(p,thr,pm);
clstr = connectedCells(Grd,cells);
end

