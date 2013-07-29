function [] = mkRV(caseName)
%MKRV Make Result Visualizations
%   mkRV(caseName) takes the case root name caseName and produces the
%   visualizing figures for the run results of the case.
%
%   See also mkAllRV, mkRP, mkRSLT, valFltr, convEclData.

%%
%
msg = ['Producing result visualizations for case ' caseName];
display(msg);
logIt(msg);
%
%% Load Data
% 

[Grd,init,smry,rst] = loadData(caseName);
nx = Grd.cartDims(1); nmx = floor(nx/2);
ny = Grd.cartDims(2); nmy = floor(ny/2);
nz = Grd.cartDims(3); nmz = floor(nz/2);

frq = 10;
%        
l=1;
% Check if VIZ folder exist
mkVIZ(caseName);

%%

% Static Data
% % Grid Geometery
% depth = Grd.cells.centroids(:,3);
% pn  = 'Grd';
h = figure;
% gridViz(Grd,Grd.cells.indexMap,depth,'','k');
% axis off;
% view(270,45);
% colorbar;
% ttlColBar(h,pn)
% saveVizFig(h,caseName,pn);
% clf(h);

layer = clrFltr(Grd);%boxIndFltr(Grd,1,40,1,120,l,l);
% Poro
prop = init.PORO.values;
gprop = prop(find(~isinf(prop)));
pn = 'Poro';
gridViz(Grd,layer,prop,'','none');
figTitle=([caseName ' ' pn]);
title(strrep(figTitle,'_','\_'));
axis off;
view(270,45);
colorbar;
ttlColBar(h,pn)
saveVizFig(h,caseName,pn,l)
clf(h);

% PermXY
cn =5;
prop = log10(sqrt((init.PERMX.values*darcy).*...
    (init.PERMX.values*darcy)));
gprop = prop(find(~isinf(prop)));
pn = 'log10PermXY';
gridViz(Grd,layer,prop,'','none');
figTitle=([caseName ' ' pn '(mD)']);
title(strrep(figTitle,'_','\_'));
axis off;
view(270,45);
discretecolor(cn);
discretecolorbar(h,min(gprop),max(gprop),cn,pn);
saveVizFig(h,caseName,pn,l)
clf(h);
colormap('default');

% MultZ
prop = init.MULTZ.values;
gprop = prop(find(~isinf(prop)));
cells = valFltr(gprop,0,0.1);
pn = 'MultZ';
plotGrid(Grd,'FaceColor','none','EdgeColor',[0.65 0.65 0.65]);
gridViz(Grd,cells,gprop,'','none');
figTitle=([caseName ' ' pn ]);
title(strrep(figTitle,'_','\_'));
axis off;
view(270,45);
colorbar;
ttlColBar(h,pn);
saveVizFig(h,caseName,pn,l);
clf(h);


% DynamicData

[smryEOI,rstEOI] = eOI(smry,rst);
msryEOS = length(smry.TIME);
rstEOS = length(rst.timeindex);
dyn = [rstEOI rstEOS]

for t = rstEOI rstEOS,
    display(['Plotting for timestep ' num2str(t)])
    % Sco_2
    prop = 1-rst.SWAT{t};
    gprop = prop(find(~isinf(prop)));
    pn = 'SCO2';
    gridViz(Grd,layer,prop,'','none');
    figTitle=([caseName ' ' pn  ' at time ' ...
        num2str(rst.times(rst.timeindex(t))*day/year)...
        'Year(s)']);
    title(strrep(figTitle,'_','\_'));
    axis off;
    view(270,45);
    colorbar;
    ttlColBar(h,pn)
    saveVizFig(h,caseName,pn,l,t)
    clf(h);
    clear prop pn;
    % Res/Mob CO2
% Sco_2
    prop = 1-rst.SWAT{t};
    gprop = prop(find(~isinf(prop)));
    pn = 'SCO2_mobile';
    plotGrid(Grd,'FaceColor','none','EdgeColor',[0.65 0.65 0.65]);
    layer = valFltr(prop,SrCO2(case2scn(caseName))+eps,1);
    gridViz(Grd,layer,prop,'','none');
    figTitle=([caseName ' ' pn  ' at time ' ...
        num2str(rst.times(rst.timeindex(t))*day/year) ' Year(s)']);
    title(strrep(figTitle,'_','\_'));
    axis off;
    view(270,45);
    colorbar;
    ttlColBar(h,pn)
    saveVizFig(h,caseName,pn,l,t)
    clf(h);
    clear prop pn;

    % Sco_2 slice
    layer = boxIndFltr(Grd,1,nx,nmy,nmy,1,nz);
    prop = 1-rst.SWAT{t};
    gprop = prop(find(~isinf(prop)));
    pn = 'SCO2_Slc';
    gridViz(Grd,layer,prop,'','none');
    figTitle=([caseName ' ' pn  ' at time ' ...
        num2str(rst.times(rst.timeindex(t))*day/year) ' Year(s)']);
    title(strrep(figTitle,'_','\_'));
    axis off;
    view(10,0);
    colorbar;
    ttlColBar(h,pn);
    saveVizFig(h,caseName,pn,l,rst.times(rst.timeindex(t)))
    clf(h);
    clear prop pn;        

    % Res/Mob CO2
    % Pressure
    layer = clrFltr(Grd);
    prop = rst.PRESSURE{t};
    gprop = prop(find(~isinf(prop)));
    pn = 'Press';
    gridViz(Grd,layer,prop,'','none');
    figTitle=([caseName ' ' pn  ' at time ' ...
        num2str(rst.times(rst.timeindex(t))*day/year) ' Year(s)']);
    title(strrep(figTitle,'_','\_'));
    axis off;
    view(270,45);
    colorbar;
    ttlColBar(h,pn)
    saveVizFig(h,caseName,pn,l,rst.times(rst.timeindex(t)))
    clf(h);
    clear prop pn;        

    % Pressure slice
    
    layer = boxIndFltr(Grd,1,nx,nmy,nmy,1,nz);
%     ,...
%     boxIndFltr(Grd,1,nx,nmy,nmy,1,nz));
    prop = rst.PRESSURE{t};
    gprop = prop(find(~isinf(prop)));
    pn = 'PressSlc';
    gridViz(Grd,layer,prop,'','none');
    figTitle=([caseName ' ' pn  ' at time ' ...
        num2str(rst.times(rst.timeindex(t))*day/year) ' Year(s)']);
    title(strrep(figTitle,'_','\_'));
    axis off;
    view(10,0);
    colorbar;
    ttlColBar(h,pn);
    saveVizFig(h,caseName,pn,l,rst.times(rst.timeindex(t)))
    clf(h);
    clear prop pn;        

    
    % Well location

    % C0_2 Plume
%     close all;
end
%
msg = ['Visualizations done for case ' caseName];
display(msg);
logIt(msg);
%
end

