function [G2d,G2dF,PCO2,PfCO2,PsCO2,PsfCO2] = clcProbSat(scnTmp)
%CLCPROBSAT Calculate Probable Saturation
%   [PCO2] = clcProbSat(scnTmp) calculates the average saturation for the top most
%   layer over all the cases in scenario from scnTmp. The saturations are
%   weighted by the plume size they are attached to.
%
%   See also clcPlt.
%

%%
global PCO2 PfCO2 PsCO2 PsfCO2 csFno caseNum totInj pth2save;
PCO2 = [];
PfCO2 = [];
PsCO2 = [];
PsfCO2 = [];
caseNum = 0;
csFno = 0;
totInj = 1e7;
pth2save = '/scratch/SAIGUP/DATA/RPT/SCN/SATAV/';
%
msg = ['Started calulating probable saturation for scenario ' scnTmp '...'];
display(msg);
logIt(msg);
% 
GfN = [pth2save 'G2D.mat'];
if ~exist(GfN),
    %%
    cs1 = ['C01111_SC001_' scnTmp];
    cs2 = ['C11111_SC005_' scnTmp];
    % Load Eclipse data file
    fbN1 = [pthSCN(cs1) cs1 '.DATA'];
    fbN2 = [pthSCN(cs2) cs2 '.DATA'];
    %
    if exist(fbN1,'file')
        G1 = readGRDECL(fbN1);
    else
        msg = ['Eclipse data file not found for ' cs1];
        display(msg);
        logIt(msg);
    end
    if exist(fbN2,'file')
        G2 = readGRDECL(fbN2);
    else
        msg = ['Eclipse data file not found for ' cs2];
        display(msg);
        logIt(msg);
    end
    %
    G2d = cutGrdecl(G1, [1 G1.cartDims(1);...
                         1 G1.cartDims(2);...
                         1 1]);
    G2d = processGRDECL(G2d);                     
    G2d = computeGeometry(G2d(1));                     
    %
    G2dF = cutGrdecl(G2, [1 G2.cartDims(1);...
                         1 G2.cartDims(2);...
                         1 1]);
    G2dF = processGRDECL(G2dF);                     
    G2dF = computeGeometry(G2dF(1));                     

    save(GfN,'G2d','G2dF');
else
    clear 'G2d' 'G2dF';
    load(GfN);
end
%%
allCases(scnTmp,@task);
%
PfCO2 = PfCO2/csFno;
PCO2  = PCO2/(caseNum-csFno);
PsfCO2 = PsfCO2/csFno;
PsCO2  = PsCO2/(caseNum-csFno);

%
%% Save to disk
outN = [pth2save 'SATAV_' scnTmp '.mat'];
save(outN,'G2d','G2dF','PCO2','PfCO2','PsCO2','PsfCO2');
%
end
%
function [] = task(caseName)
%%
global PCO2 PfCO2  PsCO2 PsfCO2 csFno caseNum totInj pth2save;

%% Separate Faulted Cases
isFaulted = caseName(2)=='1';

%
satavN = [pth2save caseName '_SATAV.mat'];
%
%%
if ~exist(satavN,'file')
    
     %% Load Information
    [Grd,init,smry,rst] = loadData(caseName);


    %% Calculations
    %
    nx = Grd.cartDims(1); ny = Grd.cartDims(2); nz = Grd.cartDims(3);
    %
    scn = case2scn(caseName);
    % 
    % smryT = smry.TIME*day/year;
    % rstT = rst.times*day/year;
    % %
    % [smryEOI,rstEOI] = eOI(smry,rst);
    %
    satThres = 0.001;
    %
    SCO_2 = cellfun(@(v) 1-v, rst.SWAT,'UniformOutput', false);
    % %   
    t = length(SCO_2);
    %=====Total Volumes=====<
    %-> Mobile CO_2 In Place
    inside = valFltr(init.FIPNUM.values,1,2);
    mobCells = fltrAnd(invFltr(Grd,valFltr(SCO_2{t},...
        -inf,SrCO2(scn))),inside);
    %
    PORV = init.PORO.values.*Grd.cells.volumes.*init.NTG.values;
    mobCo2 = PORV(mobCells).*SCO_2{t}(mobCells);
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
    % _/\_/\__/\_/\__/\_/\__/\_/\__
    % Leakage Risk     ||||||||||||||||||||||||||||||||||||||||>
    % ==============================
    % Connectivity weight
    %--------%
    topLayer = boxIndFltr(Grd,1,nx,1,ny,1,1); 
    % Mobile saturation of topmost layer
    mobSat = zeros(size(SCO_2{t}));
    mobSat(mobCells) = SCO_2{t}(mobCells);
    topSat = mobSat(topLayer);
    topCO2 = PORV(topLayer).*topSat;
    %--------%
    % 
    plumeWeight = conPlmVct/sum(conPlmVct);
    %
    wijk = zeros(Grd.cells.num,1);
    for pln = 1:size(conPlmVct,2),
        for cnum = 1:numel(Co2Clusters{pln}),
            wind = Co2Clusters{pln}(cnum);
            wijk(wind) = plumeWeight(pln);
        end
    end
    %
    caseTopCO2 = topCO2.*wijk(topLayer);
    caseTopSat = topSat.*wijk(topLayer);
    %
    save(satavN,'caseTopCO2','caseTopSat');
else
    clear 'caseTopCO2' 'caseTopSat';
    load(satavN);
end
%%
if caseNum==0,
    PfCO2 = caseTopCO2*isFaulted;
    PCO2 = caseTopCO2*isFaulted;
    PsfCO2 = caseTopSat*~isFaulted;
    PsCO2 = caseTopSat*~isFaulted;
elseif isFaulted,        
    PfCO2 = PfCO2 + caseTopCO2;
    PsfCO2 = PsfCO2 + caseTopSat;        
else
    PCO2 = PCO2 + caseTopCO2;    
    PsCO2 = PsCO2 + caseTopSat;    
end

%

if isFaulted,
    csFno = csFno + 1;
end
caseNum = caseNum + 1;
%
end

