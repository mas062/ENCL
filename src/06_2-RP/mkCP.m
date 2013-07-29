function [] = mkCP(figName,fldName,caseName,varargin)
%MKCP Make Case Plot
%   mkRP(figName,fldName,caseName) produces line plots for the run results 
%   of caseName. Also it is possible to make compare plots for more
%   than one case. 
%       figName is used in saving figures. figName is imported
%   because the function independently can not decide about the name based
%   on the combination of cases in the plots. If figName is empty, the
%   single case plots will be generated and vectors will be saved in mat
%   files for the case. 
%   The same for fldName, which is used for making specific folder for 
%   each set of figures.
%
%   See also mkRV, rpAll.

%% Cases Record
cs = caseName;
%
cst = strrep(cs,'_','\_'); 
if ~isempty(varargin), 
    for i=1:length(varargin),
        cs = [cs;char(varargin(i))];
        cst = [cst;strrep(char(varargin(i)),'_','\_')];
    end
end
%
hLWFlx = 1;hLOFlx = 2;hRWFlx = 3;hROFlx = 4;hDWFlx = 5;hDOFlx = 6;
hOL2R = 7;hWL2R = 8;hL2R = 9;htotMobCo2 = 10;htotResCo2 = 11;
hlargestPlume = 12;hmeanPlume = 13;hmedianPlume = 14;hstdPlume = 15;
hFPR = 16; hWBHP = 17; hWIR = 18;hplumeNum = 19;htotResMob = 20;
hrisk = 21;
%
close all;
% for fig=1:18,
%     figure(fig);
%     clf;
% end
%
pltCol = ['b' 'g' 'r' 'k' 'y' 'c' ];

for ci = 1:size(cs,1),
    %% Load Information
    scnTmp = case2scn(cs(ci,:));
    yesDo = false;
    % Plot information
    fbN_PLT = [pthVCT(cs(ci,:)) cs(ci,:) '_PLT.mat'];
    if ~exist(fbN_PLT,'file'),
%         yesDo = input(['No plot vectors are available for case ' ...
%             cs(ci,:) ' shall try to produce them? (yes/no)'],'s');
%         for t = 1:15,
%             pause(1);
%         end
%         if ~ismember(yesDo,{'yes','Yes','YES','yEs','yES','YEs','YeS'...
%                 ,'Yeah','yeah','ya','y','Y'}),
%             close all;
            return;
%         else
%             clcPlt(cs(ci,:));
%         end
    end
    %
    load(fbN_PLT);
    if length(rstT) ~= length(LWFlx),
        % From restart files
        %
        msg = ['Loading restart information for case ' caseName '...'];
        display(msg);
        logIt(msg);
        % 
        fN_RST = [pthVCT(caseName) caseName '_RST.mat'];
        if ~exist(fN_RST,'file'),
            convEclDyn(caseName);
        end
        load(fN_RST);
        rstT = rstT(rst.timeindex+1);
        pltMat = [pthVCT(caseName) caseName '_PLT.mat'];
        save(pltMat,'rstT','-append');
    end
%% Modify Loaded Data
%
%rstT = reshape(rstT(end-400:end),1,401);
%% Plots
    
    % _/\_/\__/\_/\__/\_/\__/\_/\__
    % Flow into the boundaries     ||||||||||||||||||||||||||||||||||||||||>
    % ==============================
    %======Left Boundary====<
    %-> Boundary Fluxes
        %--------% 
        figure(hLWFlx);hold on;
        plot(rstT,LWFlx,pltCol(ci));
        %--------%
        figure(hLOFlx);hold on;
        plot(rstT,LOFlx,pltCol(ci));
        %--------%
    %-> BreakThrough Time
        %--------%
        %
        display(leftBT);
        %--------%
    %======Right Boundary====<
    %-> Boundary Fluxes
        %--------%
        figure(hRWFlx);hold on;
        plot(rstT,RWFlx,pltCol(ci));       
        %--------%
        figure(hROFlx);hold on;
        plot(rstT,ROFlx,pltCol(ci));
        %--------%
    %-> BreakThrough Time
        %--------%
        display(rightBT);
        %--------%
    %======Down Boundary====<    
    %-> Boundary Fluxes
        %--------%
        figure(hDWFlx);hold on;
        plot(rstT,DWFlx,pltCol(ci));
        %--------%
        figure(hDOFlx);hold on;
        plot(rstT,DOFlx,pltCol(ci));
        %--------%
    %-> BreakThrough Time
        %--------%
        display(downBT);
        %--------%
    %===== Left / Right Fluxes ====<    
        %--------%
        figure(hOL2R);hold on;
        plot(rstT,OL2R,pltCol(ci));  
        %--------%
        figure(hWL2R);hold on;
        plot(rstT,WL2R,pltCol(ci));  
        %--------%
        figure(hL2R);hold on;
        plot(rstT,L2R,pltCol(ci));  
        %--------%
    % _/\_/\__/\_/\__/\_/\__/\_/\__
    % Volumes of CO2     ||||||||||||||||||||||||||||||||||||||||>
    % ==============================
    %
    figure(htotMobCo2);hold on;
    plot(rstT,totMobCo2,pltCol(ci));     
    %
    figure(htotResCo2);hold on;
    plot(rstT,totResCo2,pltCol(ci));     
    %
    figure(hlargestPlume);hold on;
    plot(rstT,largestPlume,pltCol(ci));     
    %
    figure(hmeanPlume);hold on;
    plot(rstT,meanPlume,pltCol(ci));     
    %
    figure(hmedianPlume);hold on;
    plot(rstT,medianPlume,pltCol(ci));     
    %
    figure(hstdPlume);hold on;
    plot(rstT,stdPlume,pltCol(ci));     
    %
    figure(hplumeNum);hold on;
    plot(rstT,plumeNum,pltCol(ci));     
    %
    if isempty(varargin),
        figure(htotResMob);hold on;
        plot(rstT,totMobCo2,pltCol(ci),'LineWidth',2);hold on;     
        plot(rstT,totResCo2,[pltCol(ci+1) '--'],'LineWidth',2);hold on;
        outFlx = LOFlx + ROFlx + DOFlx;
        rsdT = [0; rstT(2:end)-rstT(1:end-1)]';
        outVol = outFlx .* rsdT*(year/day);
        accOutVol(1) = outVol(1);
        for tstp = 2:length(outVol),
            accOutVol(1+end) = accOutVol(end) + outVol(tstp);
        end
        plot(rstT,accOutVol,[pltCol(ci+2) ':'],'LineWidth',3,'MarkerSize',10);hold on;    
        plot(rstT,totResCo2+totMobCo2+accOutVol,[pltCol(ci+3) '.'],'LineWidth',2);hold on;
    end
    %
    % _/\_/\__/\_/\__/\_/\__/\_/\__
    % Pressures     ||||||||||||||||||||||||||||||||||||||||>
    % ==============================
    % Field average pressure       
    %--------%
    figure(hFPR);hold on;
    plot(smryT,FPR,pltCol(ci));  
    %--------%
    % Well bottom hole pressure       
    %--------%
    figure(hWBHP);hold on;
    plot(smryT,WBHP,pltCol(ci));  
    %--------%        
    % _/\_/\__/\_/\__/\_/\__/\_/\__
    % Injection Rate     ||||||||||||||||||||||||||||||||||||||||>
    % ==============================
    % Field average pressure       
    %--------%
    figure(hWIR);hold on;
    plot(smryT,WCIR,pltCol(ci));  
    %--------%
     % _/\_/\__/\_/\__/\_/\__/\_/\__
    % Risk Of Leakage     ||||||||||||||||||||||||||||||||||||||||>
    % ==============================
    figure(hrisk);hold on;
    if exist('leakageRisk','var'),
        plot(rstT,reshape(leakageRisk(end-length(rstT)+1:end),size(rstT)),pltCol(ci));  
    end
    %--------%
    
end
%% Save Plots
oneCase = false;
if isempty(varargin),
    oneCase = true;
    mkPLT(caseName);
    figPth = pthPLT(caseName);
    figName = caseName;
else
    scn = case2scn(caseName);
    mkbScnPLT(scn);
    figPth = [pthScnPLT(scn) fldName '/'];
    if ~exist(figPth,'dir'), 
        cmd = ['mkdir ' figPth];
        system(cmd);
    end
end
%
mkPLT(caseName);
%1
h = hLWFlx;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Flux, m3/day');
title('Left Boundary Water FLux, m3/day');
pn = 'LWFlx';
savePltFig(h,figName,figPth,pn);
%2
h = hLOFlx;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Flux, m3/day');
title('Left Boundary CO_2 FLux, m3/day');
pn = 'LOFlx';
savePltFig(h,figName,figPth,pn);
%3
h = hRWFlx;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Flux, m3/day');
title('Right Boundary Water FLux, m3/day');
pn = 'RWFlx';
savePltFig(h,figName,figPth,pn);
%4
h = hROFlx;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Flux, m3/day');
title('Right Boundary CO_2 FLux, m3/day');
pn = 'ROFlx';
savePltFig(h,figName,figPth,pn);
%5
h = hDWFlx;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Flux, m3/day');
title('Down Boundary Water FLux, m3/day');
pn = 'DWFlx';
savePltFig(h,figName,figPth,pn);
%6
h = hDOFlx;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Flux, m3/day');
title('Down Boundary CO_2 FLux, m3/day');
pn = 'DOFlx';
savePltFig(h,figName,figPth,pn);
%7
h = hOL2R;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Flux Ratio');
title('Left To Right CO_2 FLux');
pn = 'OL2R';
savePltFig(h,figName,figPth,pn);
%8
h = hWL2R;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Flux Ratio');
title('Left To Right Water FLux');
pn = 'WL2R';
savePltFig(h,figName,figPth,pn);
%9
h = hL2R;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Flux Ratio');
title('Left To Right Total FLux');
pn = 'L2R';
savePltFig(h,figName,figPth,pn);
%10
h = htotMobCo2;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Volume, m^3');
title('Total Mobile CO_2 Volume, m3');
pn = 'totMobCo2';
savePltFig(h,figName,figPth,pn);
%11
h = htotResCo2;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Volume, m^3');
title('Total Residual CO_2 Volume, m3');
pn = 'totResCo2';
savePltFig(h,figName,figPth,pn);
%12
h = hlargestPlume;
figure(h);
h_legend = legend(cst,'Location','SouthEast');
set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Volume, m^3');
title('Largest CO_2 Plume Volume, m3');
pn = 'lrgstPlm';
savePltFig(h,figName,figPth,pn);
%13
h = hmeanPlume;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Volume, m^3');
title('Average CO_2 Plume Volume, m3');
pn = 'mnPlm';
savePltFig(h,figName,figPth,pn);
%14
h = hmedianPlume;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Volume, m^3');
title('Median CO_2 Plume Volume, m3');
pn = 'mdnPlm';
savePltFig(h,figName,figPth,pn);
%15
h = hstdPlume;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Volume, m^3');
title('Standard Deviation CO_2 Plume Volume, m3');
pn = 'stdPlm';
savePltFig(h,figName,figPth,pn);
%16
h = hFPR;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Pressure, bar');
title('Average Field Pressure, bar');
pn = 'FPR';
savePltFig(h,figName,figPth,pn);
%
%17
h = hWBHP;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Pressure, bar');
title('Injector Bottom Hole Pressure, bar');
pn = 'WBHP';
savePltFig(h,figName,figPth,pn);
%
%18
h = hWIR;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Rate, m^3/day');
title('CO_2 Injection Rate, m^3/day');
pn = 'WCIR';
savePltFig(h,figName,figPth,pn);
%
%19
h = hplumeNum;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Total number');
title('Number Of CO_2 Plumes');
pn = 'plumeNum';
savePltFig(h,figName,figPth,pn);
%
if isempty(varargin),
%20
    h = htotResMob;
    figure(h);
    h_legend = legend([cst 'Mobile CO_2'],'Residual CO_2',...
        'CO_2 lefts the domain','Res+Mob+outLeft CO_2','Location','East');
    set(h_legend,'FontSize',6);
    xlabel('Time, year(s)');ylabel('CO_2 Volume In Place`');
    title('Total, Residual and Mobile CO_2 Volumes');
    pn = 'totResMob';
    savePltFig(h,figName,figPth,pn);
    %
end
%21
h = hrisk;
figure(h);
h_legend = legend(cst);set(h_legend,'FontSize',6);
xlabel('Time, year(s)');ylabel('Risk Measure');
title('Risk Of Leakage');
pn = 'risk';
savePltFig(h,figName,figPth,pn);
%
logLst(caseName,'CP');
%
end

