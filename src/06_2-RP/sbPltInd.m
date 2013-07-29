function [ ind ] = sbPltInd( nt,ni )
%SBPLTIND SubPlot Index returns 3 digit integer represents the index used
%in subplot function. The inputs are the number of plots and the order of
%the current plot.
if nt<=3
    a = nt;
    b = 1;
elseif  nt==4
    a = 2;
    b = 2;
elseif nt<=27
    a = floor(nt/3)+1;
    b = 3;
elseif nt <=81
    a = 9
    b = floor(nt/9)+1;
else
    error('Number of plots exceeds the allowed number 81.');
end
c = ni;
ind = str2num([num2str(a) num2str(b) num2str(c)]);
end

