%% Run Results Plots
%
function [] = rsltPlot(scenNum)
%% Load Information
% close all;clc;
%
    fN = [enclDir '02-output/Grid.mat'];load(fN);
%
    fN = [enclDir '02-output/Rock.mat'];load(fN);
%
    fN = [enclDir '02-output/Encl_Scen_' int2str(scenNum)...
        '/SvsT.mat'];load(fN);
%     
    fN = [enclDir '02-output/Encl_Scen_' int2str(scenNum)...
        '/PvsT.mat']; load(fN);
%
    fN = [enclDir '02-output/Encl_Scen_' int2str(scenNum)...
        '/Iq.mat'];load(fN);
%
    fN = [enclDir '02-output/Encl_Scen_' int2str(scenNum)...
        '/P1q.mat'];load(fN);
%
    fN = [enclDir '02-output/Encl_Scen_' int2str(scenNum)...
        '/P2q.mat'];load(fN);
%
    fN = [enclDir '02-output/Encl_Scen_' int2str(scenNum)...
        '/Ibhp.mat'];load(fN);
%
    fN = [enclDir '02-output/Encl_Scen_' int2str(scenNum)...
        '/P1bhp.mat'];load(fN);
%
    fN = [enclDir '02-output/Encl_Scen_' int2str(scenNum)...
        '/P2bhp.mat'];load(fN);


%%     
    nx = G.cartDims(1);
    ny = G.cartDims(2);
    nz = G.cartDims(3);
    dt = 0.2.*SvsT{1}(1);
    stpMax = length(SvsT)-1;
    time = dt*[1:stpMax];
    
%  Saturation end points
    Swt = 0.7;
    Swc = 0.2;
    Sgt = 0.7;
    Sgc = 0.2;
    
    well_cellP1 = zeros(nz,1);
    for iz=1:nz
        well_cellP1(iz) = cart2active(G,sub2ind(G.cartDims,4,8,iz));
    end
    
    well_cellP2 = zeros(nz,1);
    for iz=1:nz
        well_cellP2(iz) = cart2active(G,sub2ind(G.cartDims,4,ny-8,iz));
    end

%% Calculations
%
    S1 = [];S2 = []; CO2_Vol_tot = [];
    injRate =  [];P1Rate = [];P2Rate = [];injBhp = [];
    P1Bhp = [];P1Bhp = [];
    
    % Layers for areal efficiency calculations
    lyr = [];
    for i =1:nz
        lyr{i} = boxIndFltr(G,1,G.cartDims(1),1,G.cartDims(2),i,i);
    end
    
    % Slices for vertical efficiency calculations
    xlrow = boxIndFltr(G,1,1,1,ny,1,nz);
    xmrow = boxIndFltr(G,nx/2,nx/2,1,ny,1,nz);
    xrrow = boxIndFltr(G,nx-10,nx-10,1,ny,1,nz);
    ylrow = boxIndFltr(G,1,nx,1,1,1,nz);
    ymrow = boxIndFltr(G,1,nx,ny/2,ny/2,1,nz);
    yrrow = boxIndFltr(G,1,nx,ny,ny,1,nz);
    
    
    for i = 1:stpMax

    % CO_2 cut in producers
        S1(i) = mean(SvsT{i+1}(well_cellP1));
        S2(i) = mean(SvsT{i+1}(well_cellP2));
    
    % Mixing CO2 volume
        mixCond = (SvsT{i+1}>0.3).*(SvsT{i+1}<0.7);
        CO2_mix_Vol(i) = sum((1-SvsT{i+1}).*G.cells.volumes...
            .*rock.poro.*mixCond);
    
    % Areal sweep efficiency
        swept{i} = invFltr(G,valFltr(G,SvsT{i+1},1-Sgc,1));
        xlswept(i) = length(fltrAnd(xlrow,swept{i}))/length(xlrow);
        xmswept(i) = length(fltrAnd(xmrow,swept{i}))/length(xmrow);
        xrswept(i) = length(fltrAnd(xrrow,swept{i}))/length(xrrow);
        ylswept(i) = length(fltrAnd(ylrow,swept{i}))/length(ylrow);
        ymswept(i) = length(fltrAnd(ymrow,swept{i}))/length(ymrow);
        yrswept(i) = length(fltrAnd(yrrow,swept{i}))/length(yrrow);
        ASE(i) = mean([xlswept(i),xmswept(i),xrswept(i),...
            ylswept(i),ymswept(i),yrswept(i)]);

    % Vertical sweep efficiency
        lyrSE = [];
        for ii=1:nz
            lyrSE{i}(ii) = length(fltrAnd(lyr{ii},swept{i}))/...
                length(lyr{ii});
        end
        VSE(i) = mean(lyrSE{i});
        
    % Field pressure
        FPR(i) = sum(PvsT{i+1}.*...
                     G.cells.volumes.*...
                     rock.poro)./sum(G.cells.volumes.*...
                     rock.poro);
        
    % Total injected CO2 volume
        CO2_Vol_tot(i) = sum((1-SvsT{i+1}).*G.cells.volumes...
            .*rock.poro);
        
    % Injection rate
        injRate(i) = sum(Iq{i+1});

    % Production rate
        P1Rate(i) = sum(P1q{i+1});
        P2Rate(i) = sum(P2q{i+1});  
        
    % Injection bhp
        injBhp(i) = Ibhp{i+1};
                
    % Production bhp
        P1Bhp(i) = P1bhp{i+1};
        P2Bhp(i) = P2bhp{i+1};
    end
    
%% Plots
    figure;hold on;
    plot(time,S1);
    plot(time,S2);
    title('CO2 Cut In The Producers');
    axis tight;
%%    
        
    figure; hold off;
    plot(time,FPR/barsa);
    title('Field Pressure, barsa');
    axis tight;
%%    
    figure; hold off;
    plot(time,CO2_mix_Vol);
    title('mixed Injected CO2 Volume, m3');
    axis tight;
%%    
    figure; hold off;
    plot(time,CO2_Vol_tot);
    title('Total Injected CO2 Volume, m3');
    axis tight;
%%    
    figure; hold off;
    plot(time,CO2_mix_Vol./CO2_Vol_tot);
    title('mixed Injected CO2 Volume Fraction');
    axis tight;
%%    
    figure; hold off;
    plot(time,ASE);
    title('Areal Sweep Efficiency');
    axis tight;    
%%    
    figure; hold off;
    plot(time,VSE);
    title('Vertical Sweep Efficiency');
    axis tight;       
%%    
    figure; hold off;
    plot(time,injRate*day);
    title('Injection Rate, m3/day');
    axis tight;
%  %%   
%     for i = 1:length(Iq{2});
%         injConRate = [];
%         for j = 2:length(Iq)
%           injConRate(end+1) = Iq{j}(i);  
%         end
%         figure;
%         plot(time,injConRate);
%         contitle = ['Connection Number-' num2str(i) ', Rate'];
%         title(contitle);    
%         axis tight;
%     end
%%    
    figure; hold on;
    plot(time,-1*P1Rate*day);
    plot(time,-1*P2Rate*day,'r');
    title('Production Rates, m3/day');
    axis tight;
%%    
    figure; hold off;
    plot(time,injBhp/barsa);
    title('Injector BHP, barsa');
    axis tight;
%%    
    figure; hold on;
    plot(time,P1Bhp/barsa);
    plot(time,P2Bhp/barsa,'r');
    title('Producers BHP, barsa');
    axis tight;

end