isoValue = 0.3; marVal = 0.01;

xmap(G.cells.indexMap) = G.cells.centroids(:,1);
ymap(G.cells.indexMap) = G.cells.centroids(:,2);
zmap(G.cells.indexMap) = G.cells.centroids(:,3);

xmap(end+1) = xmap(end);
ymap(end+1) = ymap(end);
zmap(end+1) = zmap(end);



X = reshape(xmap,G.cartDims);
Y = reshape(ymap,G.cartDims);
Z = reshape(zmap,G.cartDims);

prop_map(G.cells.indexMap)=prop;
prop_map(end+1) = 0;
prop3D = reshape(prop_map, G.cartDims);

% isoCells = find((prop >= isoValue - marVal).*...
%                 (prop <= isoValue + marVal));
% allFaces =1:G.faces.num;
% isBoundary = any(prod(single(G.faces.neighbors),2),2) ;
% isoFaces = boundaryFaces(G,isoCells);
% isoFront = find(ismember(allFaces',isoFaces).*~isBoundary);              
% 
% if ~isempty(isoFront)
%     plotFaces(G,isoFaces);
% end
% view(3)
% 
% minX = min(G.cells.centroids(:,1));
% maxX = max(G.cells.centroids(:,1));
% 
% minY = min(G.cells.centroids(:,2));
% maxY = max(G.cells.centroids(:,2));
% 
% minZ = min(G.cells.centroids(:,3));
% maxZ = max(G.cells.centroids(:,3));
% 
% xi = linspace(minX,maxX, G.cartDims(1));
% yi = linspace(minY,maxY, G.cartDims(2));
% zi = linspace(minZ,maxZ, G.cartDims(3));
% 
% [XI YI ZI] = meshgrid(xi, yi, zi);
% 
% HyperPlane = griddata3(X, Y, Z, prop3D, XI, YI, ZI);
% 

% 
% p = patch(isosurface(XI,YI,ZI,HyperPlane, isoValue));
% set(p,'FaceColor','b','EdgeColor','none');
% view(3); axis tight
% camlight 
% lighting gouraud
% plotGrid(G,'FaceColor','none','EdgeColor','none');

