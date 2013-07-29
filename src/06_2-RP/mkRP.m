function [varargout] = mkRP(caseName)
%MKRP Make Result Plot
%   mkRP(caseName) produces line plots for the run results of caseName.
%
%   See also mkRV, rpAll.

%% Load Information
scnTmp = ['ENCL_SCN' caseName(18:19) '.TMP'];

% Form Init and Restart files
rN = [rpth(caseName) caseName];
fN_MAT = [rN '.mat'];
load(fN_MAT);

% From Summary files
fN_SMRY = [rN '_SMRY.mat'];
load(fN_SMRY);

%% Calculations

Time = smry.TIME*day/year;
dt = Time(2:end)-Time(1:end-1);

% _/\_/\__/\_/\__/\_/\__/\_/\__
% Flow into the boundaries     ||||||||||||||||||||||||||||||||||||||||>
% ==============================
threshold = 100;

%======Left Boundary====<
%-> Boundary Fluxes
    LWIP = double(smry.RWIP(5,:));
    LCIP = smry.ROIP(5,:);
    dWIPl = LWIP(2:end)-LWIP(1:end-1);
    dCIPl = LCIP(2:end)-LCIP(1:end-1);
    qwlb = [0 dWIPl./dt];
    qclb = [0 dCIPl./dt];
%-> BreakThrough Time
    leftBT = Time(find(qclb>threshold,1));
    
%======Right Boundary====<
%-> Boundary Fluxes
    RWIP = smry.RWIP(3,:);
    RCIP = smry.ROIP(3,:);
    dWIPr = RWIP(2:end)-RWIP(1:end-1);
    dCIPr = RCIP(2:end)-RCIP(1:end-1);
    qwrb = [0 dWIPr./dt];
    qcrb = [0 dCIPr./dt];
%-> BreakThrough Time
    rightBT = Time(find(qcrb>threshold,1));

%======Down Boundary====<    
%-> Boundary Fluxes
    DWIP = smry.RWIP(4,:);
    DCIP = smry.ROIP(4,:);
    dWIPd = DWIP(2:end)-DWIP(1:end-1);
    dCIPd = DCIP(2:end)-DCIP(1:end-1);
    qwdb = [0 dWIPd./dt];
    qcdb = [0 dCIPd./dt];
%-> BreakThrough Time
    downBT = Time(find(qcdb>threshold,1));

%===== Left / Right Fluxes ====<    
     LtoR = (qwlb+qclb)./(qwrb+qcrb);
     LtoR(find(isinf(LtoR))) = LWIP(1);     

% _/\_/\__/\_/\__/\_/\__/\_/\__
% Volumes of CO2     ||||||||||||||||||||||||||||||||||||||||>
% ==============================
satThres = 0.001;

%=====Total Volumes=====<
%-> Mobile CO_2 In Place
mobCellsEoi = invFltr(Grd,valFltr(SCO_2{1}(Grd.cells.indexMap),...
    -inf,SrCO2(scnTmp)));
mobCellsEos = invFltr(Grd,valFltr(SCO_2{2}(Grd.cells.indexMap),...
    -inf,SrCO2(scnTmp)));
%
mobCo2Eoi = PORV(mobCellsEoi).*SCO_2{1}(mobCellsEoi);
mobCo2Eos = PORV(mobCellsEos).*SCO_2{2}(mobCellsEos);
%
totMobCo2Eoi = sum(mobCo2Eoi);
totMobCo2Eos = sum(mobCo2Eos);

%-> Residual Trapped CO_2 In Place
resCellsEoi = valFltr(SCO_2{1}(Grd.cells.indexMap),...
    satThres,SrCO2(scnTmp));
resCellsEos = valFltr(SCO_2{2}(Grd.cells.indexMap),...
    satThres,SrCO2(scnTmp));
%
resCo2Eoi = PORV(resCellsEoi).*SCO_2{1}(resCellsEoi);
resCo2Eos = PORV(resCellsEos).*SCO_2{2}(resCellsEos);
%
resCo2Eoi = resCo2Eoi;
resCo2Eos = resCo2Eos;
%
totResCo2Eoi = sum(resCo2Eoi);
totResCo2Eos = sum(resCo2Eos);

% totTrappedCo2 = totMobCo2Eoi-totMobCo2Eos;

%=====Connected Volumes=====<
%-> Mobile CO_2 In Place
Co2ClustersEoi = connectedCells(Grd,mobCellsEoi);
Co2ClustersEos = connectedCells(Grd,mobCellsEos);
%
clusterVolEoi = PORV(Co2ClustersEoi{1}).*SCO_2{1}(Co2ClustersEoi{1});
clusterVolEos = PORV(Co2ClustersEos{1}).*SCO_2{2}(Co2ClustersEos{1});
%
largestPlumeEoi = sum(clusterVolEoi)
largestPlumeEos = sum(clusterVolEos)
%
for i=1:length(Co2ClustersEoi),
    clusterVolEoi = PORV(Co2ClustersEoi{i}).*SCO_2{1}(Co2ClustersEoi{i});
    clusterVolEos = PORV(Co2ClustersEos{i}).*SCO_2{2}(Co2ClustersEos{i});
%        
    largestPlumeEoi = max(largestPlumeEoi,sum(clusterVolEoi));
    largestPlumeEos = max(largestPlumeEos,sum(clusterVolEos));
end

%=====Departed Volumes=====<
departedCO2 = LCIP + RCIP + DCIP;

%% Plots
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

