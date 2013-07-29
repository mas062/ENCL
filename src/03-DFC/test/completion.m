clear all;
n = 3;thr = 0.6;
nx = n; ny = n; nz = 2;
g = cartGrid([nx,ny,nz]);
p = rand(nx,ny,nz);
f = p>thr;
s = find(f);
c = connectedCells(g,s);
cl = rnkCol(g,p);
