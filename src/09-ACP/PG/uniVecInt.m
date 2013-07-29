function [ homoVec,htmVec ] = uniVecInt(hetroVec,timeVec)
%UNIVECINT Unified Vector Interpolation
% [ homoVec,htmVec ] = uniVecInt(hetroVec,timeVec)
%   
%%


nel = length(hetroVec);

% find the maximum resolution time vector (htmVec)
maxInd = 1;
htmVec = timeVec{1};
for i=1:nel,
    if length(timeVec{i})>length(htmVec),
        maxInd = i;
        htmVec = timeVec{i};
    end
end
%
tel = length(htmVec);
%
homoVec = [];
%
for i=1:nel,
    for j=1:tel,
    	homoVec{i}(j) = interp1(timeVec{i},hetroVec{i},htmVec(j));
    end     
end
end
