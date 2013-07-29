function [varargout] = mkCP(figName,caseName,varargin)
%MKCP Make Case Plot
%   mkRP(figName,caseName) produces line plots for the run results 
%   of caseName. Also it is possible to make compare plots for more
%   than one case. figName is used in saving figures. figName is imported
%   because the function independently can not decide about the name based
%   on the combination of cases in the plots.
%
%   See also mkRV, rpAll.

%% Cases Record
cs = caseName;
if ~isempty(varargin), 
    for i=1:length(varargin),
        cs(end+1) = char(varargin(i));
    end
end

%
pltCol = ['b' 'r' 'g' 'k' 'y' 'c' ];

for c = 1:size(cs,1),
    %% Load Information
    scnTmp = case2scn(cs(c,:));
    
    % Grid information
    fN_GRD = [pthVCT(cs(c,:)) cs(c,:) '_GRD.mat'];
    load(fN_GRD);
    
    % From init file
    fN_INIT = [pthVCT(cs(c,:)) cs(c,:) '_INIT.mat'];
    load(fN_INIT);

    % From summary files
    fN_SMRY = [pthVCT(cs(c,:)) cs(c,:) '_SMRY.mat'];
    load(fN_SMRY);
    
    % From restart files
    fN_RST = [pthVCT(cs(c,:)) cs(c,:) '_RST.mat'];
    load(fN_RST);

    %% Calculations And Plots

    smryT = smry.TIME*day/year;
    rstT = rst.times*day/year;
    %
%     dtSmry = Time(2:end)-Time(1:end-1);
%     dtRst =  
    %
    rB = boxIndFltr(Grd, 1,40,2,2,1,20);
    lB = boxIndFltr(Grd, 1,40,119,119,1,20);
    dB = boxIndFltr(Grd, 2,2,1,120,1,20);  
    %
    
    % _/\_/\__/\_/\__/\_/\__/\_/\__
    % Flow into the boundaries     ||||||||||||||||||||||||||||||||||||||||>
    % ==============================
    threshold = 0.001;

    %======Left Boundary====<
    %-> Boundary Fluxes
        %--------% 
        FLOWATJ = cellfun(@(v) v(lB), rst.FLOWATJ,'UniformOutput', false);
        LWFlx = (sum([FLOWATJ{:}],1)); 
        % 
        figure(hLWFlx);hold on;
        plot(rstT,LWFlx,pltCol(c));
        %--------%
        FLOOILJ = cellfun(@(v) v(lB), rst.FLOOILJ,'UniformOutput', false);
       LOFlx = (sum([FLOOILJ{:}]));       
        % 
        figure(hLOFlx);hold on;
        plot(rstT,LWFlx,pltCol(c));
        %--------%
    %-> BreakThrough Time
        %--------%
        leftBT = rstT(find(LOFlx>threshold,1));
        if isempty(leftBT), leftBT = inf; end
        %
        display(leftBT);
        %--------%
    %======Right Boundary====<
    %-> Boundary Fluxes
        %--------%
        FLOWATJ = cellfun(@(v) v(rB), rst.FLOWATJ,'UniformOutput', false);
        RWFlx = -(sum([FLOWATJ{:}],1)); 
        %
        figure(hRWFlx);hold on;
        plot(rstT,RWFlx,pltCol(c));       
        %--------%
        FLOOILJ = cellfun(@(v) v(rB), rst.FLOOILJ,'UniformOutput', false);
        ROFlx = -(sum([FLOOILJ{:}]));       
        %
        figure(hROFlx);hold on;
        plot(rstT,ROFlx,pltCol(c));
        %--------%
    %-> BreakThrough Time
        %--------%
        rightBT = rstT(find(ROFlx>threshold,1));
        if isempty(rightBT), rightBT = inf; end
        %
        display(rightBT);
        %--------%
    %======Down Boundary====<    
    %-> Boundary Fluxes
        %--------%
        FLOWATI = cellfun(@(v) v(dB), rst.FLOWATI,'UniformOutput', false);
        DWFlx = -(sum([FLOWATI{:}],1)); 
        %
        figure(hDWFlx);hold on;
        plot(rstT,DWFlx,pltCol(c));
        %--------%
        FLOOILI = cellfun(@(v) v(dB), rst.FLOOILI,'UniformOutput', false);
        DOFlx = -(sum([FLOOILI{:}]));       
        %
        figure(hDOFlx);hold on;
        plot(rstT,DOFlx,pltCol(c));
        %--------%
    %-> BreakThrough Time
        %--------%
        downBT = rstT(find(DOFlx>threshold,1));
        if isempty(downBT), downBT = inf; end 
        %
        display(downBT);
        %--------%
    %===== Left / Right Fluxes ====<    
        %--------%
        OL2R = LOFlx./ROFlx;
        OL2R(find(isnan(OL2R))) = 0;     
        %
        figure(hOL2R);hold on;
        plot(rstT,OL2R,pltCol(c));  
        %--------%
        WL2R = LWFlx./RWFlx;
        WL2R(find(isnan(WL2R))) = 0;     
        %
        figure(hWL2R);hold on;
        plot(rstT,WL2R,pltCol(c));  
        %--------%
        L2R = (LOFlx+LWFlx)./(ROFlx+RWFlx);
        L2R(find(isnan(L2R))) = 0;     
        %
        figure(hL2R);hold on;
        plot(rstT,L2R,pltCol(c));  
        %--------%
    % _/\_/\__/\_/\__/\_/\__/\_/\__
    % Volumes of CO2     ||||||||||||||||||||||||||||||||||||||||>
    % ==============================

    satThres = 0.001;
    SCO_2 = cellfun(@(v) 1-v, rst.SWAT,'UniformOutput', false);
    [smryEOI rstEOI] = eOI(smry,rst);
    
    %=====Total Volumes=====<
    %-> Mobile CO_2 In Place
    mobCellsEoi = invFltr(Grd,valFltr(SCO_2{rstEOI},...
        -inf,SrCO2(scnTmp)));
    mobCellsEos = invFltr(Grd,valFltr(SCO_2{end},...
        -inf,SrCO2(scnTmp)));
    %
    mobCo2Eoi = init.PORV.values(mobCellsEoi).*SCO_2{rstEOI}(mobCellsEoi);
    mobCo2Eos = init.PORV.values(mobCellsEos).*SCO_2{end}(mobCellsEos);
    %
    totMobCo2Eoi = sum(mobCo2Eoi);
    totMobCo2Eos = sum(mobCo2Eos);

    %-> Residual Trapped CO_2 In Place
    resCellsEoi = valFltr(SCO_2{rstEOI},...
        satThres,SrCO2(scnTmp));
    resCellsEos = valFltr(SCO_2{end},...
        satThres,SrCO2(scnTmp));
    %
    resCo2Eoi = init.PORV.values(resCellsEoi).*SCO_2{rstEOI}(resCellsEoi);
    resCo2Eos = init.PORV.values(resCellsEos).*SCO_2{end}(resCellsEos);
    %
    totResCo2Eoi = sum(resCo2Eoi);
    totResCo2Eos = sum(resCo2Eos);

    % totTrappedCo2 = totMobCo2Eoi-totMobCo2Eos;

    %=====Connected Volumes=====<
    %-> Mobile CO_2 In Place
    Co2ClustersEoi = connectedCells(Grd,mobCellsEoi);
    Co2ClustersEos = connectedCells(Grd,mobCellsEos);
    %
    clusterVolEoi = cellfun(@(v) abs(init.PORV.values(v).*...
                    SCO_2{rstEOI}(v)), Co2ClustersEoi,...
                    'UniformOutput', false);
    clusterVolEos = cellfun(@(v) abs(init.PORV.values(v).*...
                    SCO_2{rstEOI}(v)), Co2ClustersEos,...
                    'UniformOutput', false);                
    %
    conPlumeEoi = cellfun(@(v) sum(v), clusterVolEoi,...
                    'UniformOutput', false);    
    conPlumeEos = cellfun(@(v) sum(v), clusterVolEos,...
                    'UniformOutput', false);    
    %
    largestPlumEoi = max([conPlumeEoi{:}]);
    largestPlumEos = max([conPlumeEos{:}]);
    %
    meanPlumEoi = mean([conPlumeEoi{:}]);
    meanPlumEos = mean([conPlumeEos{:}]);
    %
    medianPlumEoi = median([conPlumeEoi{:}]);
    medianPlumEos = median([conPlumeEos{:}]);
    %
    stdPlumEoi = std([conPlumeEoi{:}]);
    stdPlumEos = std([conPlumeEos{:}]);
    %
    

    %=====Departed Volumes=====<
   

    %% Save Plots
    % _/\_/\__/\_/\__/\_/\__/\_/\__
    % Flow into the boundaries     ||||||||||||||||||||||||||||||||||||||||>
    % ==============================
    %======Left Boundary====<
    %-> Boundary Fluxes
    h1 = figure;
    plot(Time,qwlb,Time,qclb);




    % _/\_/\__/\_/\__/\_/\__/\_/\__
    % Volumes of CO2     ||||||||||||||||||||||||||||||||||||||||>
    % ==============================
end
end

