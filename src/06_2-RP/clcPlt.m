function [] = clcPlt(caseName)
%CLCPLT Calculate Plot Vectors
%   clcPlt(caseName) calculates plot vectors for the run results 
%   of caseName. These vectors will be saved in mat files for the case.
%
%   See also mkCP.
%
msg = ['Started calulating plot vectors for case ' caseName '...'];
display(msg);
logIt(msg);
% 
%% Load Information
[Grd,init,smry,rst] = loadData(caseName);

%% Calculations
%
nx = 40; ny = 120; nz = 20;
%
scnTmp = case2scn(caseName);
%
msg = ['Started plot calculations for case ' caseName '...'];
display(msg);
logIt(msg);
% 
smryT = smry.TIME*day/year;
rstT = rst.times*day/year;
rstTI = rst.timeindex;
%
rB = boxIndFltr(Grd, 1,nx,1,2,1,nz);
lB = boxIndFltr(Grd, 1,nx,ny-1,ny,1,nz);
dB = boxIndFltr(Grd, 1,2,1,ny,1,nz);  
%
[smryEOI,rstEOI] = eOI(smry,rst);
%
% _/\_/\__/\_/\__/\_/\__/\_/\__
% Flow into the boundaries     ||||||||||||||||||||||||||||||||||||||||>
% ==============================
%
msg = ['Flow into the boundaries...'];
display(msg);
logIt(msg);
% 
threshold = 0.001;

%======Left Boundary====<
%
msg = ['Flow into the left boundary...'];
display(msg);
logIt(msg);
% 
%-> Boundary Fluxes
    %--------% 
    FLOWATJ = cellfun(@(v) v(lB), rst.FLOWATJ,'UniformOutput', false);
    LWFlx = [0 (sum([FLOWATJ{:}]))]; 
    %--------%
    FLOOILJ = cellfun(@(v) v(lB), rst.FLOOILJ,'UniformOutput', false);
    LOFlx = [0 (sum([FLOOILJ{:}]))];       
    %--------%
%-> BreakThrough Time
    %--------%
    leftBT = rstT(find(LOFlx>threshold,1));
    if isempty(leftBT), leftBT = inf; end
    %--------%
%======Right Boundary====<
%
msg = ['Flow into the right boundary...'];
display(msg);
logIt(msg);
% 
%-> Boundary Fluxes
    %--------%
    FLOWATJ = cellfun(@(v) v(rB), rst.FLOWATJ,'UniformOutput', false);
    RWFlx = [0 -(sum([FLOWATJ{:}],1))]; 
    %--------%
    FLOOILJ = cellfun(@(v) v(rB), rst.FLOOILJ,'UniformOutput', false);
    ROFlx = [0 -(sum([FLOOILJ{:}]))];       
    %--------%
%-> BreakThrough Time
    %--------%
    rightBT = rstT(find(ROFlx>threshold,1));
    if isempty(rightBT), rightBT = inf; end
    %--------%
%======Down Boundary====<    
%
msg = ['Flow into the down boundary...'];
display(msg);
logIt(msg);
% 
%-> Boundary Fluxes
    %--------%
    FLOWATI = cellfun(@(v) v(dB), rst.FLOWATI,'UniformOutput', false);
    DWFlx = [0 -(sum([FLOWATI{:}],1))]; 
    %--------%
    FLOOILI = cellfun(@(v) v(dB), rst.FLOOILI,'UniformOutput', false);
    DOFlx = [0 -(sum([FLOOILI{:}]))];       
    %--------%
%-> BreakThrough Time
    %--------%
    downBT = rstT(find(DOFlx>threshold,1));
    if isempty(downBT), downBT = inf; end 
    %--------%
%===== Left / Right Fluxes ====<    
    %--------%
    OL2R = LOFlx./ROFlx;
    OL2R(find(isnan(OL2R))) = 0;     
    %--------%
    WL2R = LWFlx./RWFlx;
    WL2R(find(isnan(WL2R))) = 0;     
    %--------%
    L2R = (LOFlx+LWFlx)./(ROFlx+RWFlx);
    L2R(find(isnan(L2R))) = 0;     
    %--------%
% _/\_/\__/\_/\__/\_/\__/\_/\__
% Volumes of CO2     ||||||||||||||||||||||||||||||||||||||||>
% ==============================
%
%
msg = ['CO_2 Volume calculations...'];
display(msg);
logIt(msg);
% 
satThres = 0.001;
%
SCO_2 = cellfun(@(v) 1-v, rst.SWAT,'UniformOutput', false);
% %
% [smryEOI rstEOI] = eOI(smry,rst);
%
totMobCo2 =[];totResCo2 =[];largestPlume =[];meanPlume =[];
medianPlume =[];stdPlume =[];plumeNum = [];leakageRisk = [];

%
for t = 1:length(rst.PRESSURE),
    %=====Total Volumes=====<
    %-> Mobile CO_2 In Place
%    srco2 = SrCO2(scnTmp);
    srco2 = 0.2;
    inside = valFltr(init.FIPNUM.values,1,2);
    mobCells = fltrAnd(invFltr(Grd,valFltr(SCO_2{t},...
        -inf,srco2)),inside);
    %
    PORV = init.PORO.values.*Grd.cells.volumes.*init.NTG.values;
    mobCo2 = PORV(mobCells).*SCO_2{t}(mobCells);
    %
    totMobCo2(end+1) = sum(mobCo2);
    %-> Residual Trapped CO_2 In Place
    resCells = fltrAnd(valFltr(SCO_2{t}, satThres,srco2+satThres),inside);
    %
    resCo2 = PORV(resCells).*SCO_2{t}(resCells);
    %
    totResCo2(end+1) = sum(resCo2);
    %
    %=====Connected Volumes=====<
    %-> Mobile CO_2 In Place
    %
    Co2Clusters = connectedCells(Grd,mobCells);
    %
    if isempty(mobCells),Co2Clusters=[];end
    %
    if isempty(mobCells),
        clusterVol=[];
    else
        clusterVol = cellfun(@(v) abs(PORV(v).*...
                    SCO_2{t}(v)), Co2Clusters,...
                    'UniformOutput', false);               
    end
    %
    if isempty(mobCells),
%         conPlume = [];
        conPlmVct = [];        
    else
        conPlume = cellfun(@(v) sum(v), clusterVol,...
                    'UniformOutput', false);
        conPlmVct = [conPlume{:}];                
    end
    
    %
    netConVct = [conPlmVct(find(conPlmVct))];
    %
    if isempty(netConVct), netConVct=0;end
    %
    largestPlume(end+1) = max(netConVct);
    %
    meanPlume(end+1) = mean(netConVct);
    %
    medianPlume(end+1) = median(netConVct);
    %
    stdPlume(end+1) = std(netConVct);
    %
    if netConVct==0;
        plumeNum(end+1) = 0;
    else
        plumeNum(end+1) = numel(netConVct);
    end
    %=====Departed Volumes=====<
    % _/\_/\__/\_/\__/\_/\__/\_/\__
    % Leakage Risk     ||||||||||||||||||||||||||||||||||||||||>
    % ==============================
    % Normalisation data
    totInjVol = 30*365*3650;% years of inj*days in a year*rate per day
    worstRisk = 3936;% top layer cell number
    % Connectivity weight
    %--------%
    topLayer = boxIndFltr(Grd,1,nx,1,ny,1,1); 
    % Probability 2D function
    %--------%
    fij = riskProb(Grd,topLayer);    
    % 
    plumeWeight = conPlmVct/totInjVol;%sum(conPlmVct);
    %
    wijk = zeros(Grd.cells.num,1);
    for pln = 1:size(conPlmVct,2),
        for cnum = 1:numel(Co2Clusters{pln}),
            wind = Co2Clusters{pln}(cnum);
            wijk(wind) = plumeWeight(pln);
        end
    end
    leakageRisk(end+1) = sum(fij.*wijk(topLayer))/worstRisk;
%     weightedSat(end+1) = sum(fij.*wijk(topLayer));
end

%
% _/\_/\__/\_/\__/\_/\__/\_/\__
% Pressures     ||||||||||||||||||||||||||||||||||||||||>
% ==============================
%
msg = ['Pressures...'];
display(msg);
logIt(msg);
% 
% Field average pressure       
%--------%
FPR = smry.RPR(1,:);  
%--------%
% Well bottom hole pressure       
%--------%
WBHP = smry.WBHP(1,:);  
%--------%        
% _/\_/\__/\_/\__/\_/\__/\_/\__
% Injection Rate     ||||||||||||||||||||||||||||||||||||||||>
% ==============================
% Field average pressure       
%--------%
if isfield(smry,'WVIR'),
    WCIR = smry.WVIR(1,:);  
else
    WCIR = smry.WOIR(1,:); 
end



%--------%
%% Save Vectors
%
msg = ['Save Vectors'];
display(msg);
logIt(msg);
% 
%
pltMat = [pthVCT(caseName) caseName '_PLT.mat'];

save(pltMat,'smryT','rstT','rstTI','LWFlx','LOFlx','RWFlx','ROFlx',...
'DWFlx','DOFlx','OL2R','WL2R','L2R','totMobCo2','totResCo2',...
'largestPlume','meanPlume','medianPlume','stdPlume','FPR',...
'plumeNum','WBHP','WCIR','leftBT','rightBT','downBT','leakageRisk');
%
msg = ['Plot vectors produced and saved successfully for case ' ...
    caseName '.' ];
display(msg);
logIt(msg);
% 
logLst(caseName,'clc');
%
end

