%% Union Of Filters
% Finds the comination of filtered cells specified in the input.
function fltrCell = fltrOr(fltrCell1,fltrCell2,varargin)
    fltrCell = union(fltrCell1,fltrCell2);
    if length(varargin) >= 1
        for i=1:length(varargin)
            fltrCell = union(fltrCell,varargin{i});
        end
    end
end