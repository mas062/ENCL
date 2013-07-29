%% Intersection Of Filters
% Finds the intersection of filtered cells specified in the input.
function fltrCell = fltrAnd(fltrCell1,fltrCell2,varargin)
    fltrCell = intersect(fltrCell1,fltrCell2);
    if length(varargin) >= 1
        for i=1:length(varargin)
            fltrCell = intersect(fltrCell,varargin{i});
        end
    end
end