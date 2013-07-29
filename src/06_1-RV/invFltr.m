%% Invert Filter
% Inverts the filter selection
function invCell = invFltr(G,cellNum)
        allCells = [1:G.cells.num]';
        invCell = allCells;
        invCell(find(ismember(allCells,cellNum)))= [];
end