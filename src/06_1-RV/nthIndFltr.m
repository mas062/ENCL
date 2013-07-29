%% Every N'th Index Filter
% 
% Filters every n'th row/layer in the grid
function fltrCell = nthIndFltr(G,ni,nj,nk)
%%
% * Map the linear index to ijk-index on the active grid: 
    clear ijk
    [ijk{1:3}] = ind2sub(G.cartDims, G.cells.indexMap);
    ijk = [ijk{:}];
%%
% * Store the list of selected rows and layers:
    indx=[1:ni:G.cartDims(1)];
    indy=[1:nj:G.cartDims(2)];
    indz=[1:nk:G.cartDims(3)];
%%    
% * Find the cells in the selected rows and layers:
    fltrCell =find(~(...
        ~ismember(ijk(:,1),indx)+...
        ~ismember(ijk(:,2),indy)+...
        ~ismember(ijk(:,3),indz)));
end