%% Box Index Filter
%
% Filters cells in an index box limit.
function fltrCell = boxIndFltr(G, imin,imax,jmin,jmax,kmin,kmax)
%%
% * Map the linear index to ijk-index on the active grid:     
    clear ijk
    [ijk{1:3}] = ind2sub(G.cartDims, G.cells.indexMap);
    ijk = [ijk{:}];
%%
% * Store the list of selected box ijk indices:
    indx = [ imin : imax ];
    indy = [ jmin : jmax ];
    indz = [ kmin : kmax ]; 
%%    
% * Find the cells in the selected box:
    fltrCell =find(ismember(ijk(:,1),indx).*...
                  ismember(ijk(:,2),indy).*...
                  ismember(ijk(:,3),indz));
end