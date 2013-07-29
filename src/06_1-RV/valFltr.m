%% Value Filter
% Filters the grid for a specified value interval of the selected property.
function fltrCell = valFltr(prop,minVal,maxVal)
    fltrCell = find((prop >= minVal).*(prop <= maxVal));
end