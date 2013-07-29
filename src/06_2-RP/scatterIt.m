function [] = scatterIt(x,y,c,d)
%SCATTERIT Scatter It
%   scatterIt(x,y) makes scatter plot for on the current active figure.
%
%   See also 

%%

%
for e=1:length(c),
%     c = nD2lin(nD(case2cls(caseName)));
%     d = str2num(caseName(10:12));
    clsInd = lin2nD(c(e));
    f = clsInd(1);
    switch f,
     case 0,
         thck = 1;
     case 1,
         switch d(e),
             case 5,
                 thck = 2;
             case 41,
                 thck = 3;
         end
    end
    hold on;
    scatter(x(e),y(e),sizeMe(c(e)),colorMe(c(e)),markerMe(c(e)) ...
        ,'LineWidth',thck);
end
end

