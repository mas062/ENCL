%% Run Results Plots
%
function [] = rsltCompare(varargin)
%% Load Information
% close all;clc;

%
    fN = [enclDir '02-output/Grid.mat'];load(fN);
%
    fN = [enclDir '02-output/Rock.mat'];load(fN);
%%     
    nx = G.cartDims(1);
    ny = G.cartDims(2);
    nz = G.cartDims(3);
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
    
     
%% Scenario Records
%
    S1 = [];S2 = []; CO2_Vol_tot = [];
    injRate =  [];P1Rate = [];P2Rate = [];injBhp = [];
    P1Bhp = [];P1Bhp = [];
for i=1:length(varargin);

    %
        fN = [enclDir '02-output/Encl_Scen_' int2str(varargin{i})...
            '/SvsT.mat'];load(fN); St{i} = SvsT;
    %     
        fN = [enclDir '02-output/Encl_Scen_' int2str(varargin{i})...
            '/PvsT.mat']; load(fN); Pt{i} = PvsT;
    %
        fN = [enclDir '02-output/Encl_Scen_' int2str(varargin{i})...
            '/Iq.mat'];load(fN); I{i} = Iq;
    %
        fN = [enclDir '02-output/Encl_Scen_' int2str(varargin{i})...
            '/P1q.mat'];load(fN); P1{i} = P1q;
    %
        fN = [enclDir '02-output/Encl_Scen_' int2str(varargin{i})...
            '/P2q.mat'];load(fN); P2{i} = P2q;
    %
        fN = [enclDir '02-output/Encl_Scen_' int2str(varargin{i})...
            '/Ibhp.mat'];load(fN); Ip{i} = Ibhp;
    %
        fN = [enclDir '02-output/Encl_Scen_' int2str(varargin{i})...
            '/P1bhp.mat'];load(fN); P1p{i} = P1bhp;
    %
        fN = [enclDir '02-output/Encl_Scen_' int2str(varargin{i})...
            '/P2bhp.mat'];load(fN); P2p{i} = P2bhp;
        
        stpMax(i) = length(SvsT)-1; 
        dt(i) = 0.2*SvsT{1}(1);
        time{i} =  dt(i)*[1:stpMax(i)];
    %
    %
        for j=1:stpMax(i)
        % CO_2 cut in producers           
            cut1{i}(j) = mean(1-St{i}{j+1}(well_cellP1));
            cut2{i}(j) = mean(1-St{i}{j+1}(well_cellP2));

        % Mixing CO2 volume
            mixCond = (St{i}{j+1}>0.3).*(St{i}{j+1}<0.7);
            CO2_mix_Vol{i}(j) = sum((1-St{i}{j+1}).*G.cells.volumes...
                .*rock.poro.*mixCond);    
        % Areal sweep efficiency
            swept{i}{j} = invFltr(G,valFltr(G,St{i}{j+1},1-Sgc,1));
        %
            xlswept{i}(j) = length(fltrAnd(xlrow,swept{i}{j}))/length(xlrow);
            xmswept{i}(j) = length(fltrAnd(xmrow,swept{i}{j}))/length(xmrow);
            xrswept{i}(j) = length(fltrAnd(xrrow,swept{i}{j}))/length(xrrow);
            ylswept{i}(j) = length(fltrAnd(ylrow,swept{i}{j}))/length(ylrow);
            ymswept{i}(j) = length(fltrAnd(ymrow,swept{i}{j}))/length(ymrow);
            yrswept{i}(j) = length(fltrAnd(yrrow,swept{i}{j}))/length(yrrow);
        %    
            ASE{i}(j) = mean([xlswept{i}(j),xmswept{i}(j),xrswept{i}(j),...
                ylswept{i}(j),ymswept{i}(j),yrswept{i}(j)]);

        % Vertical sweep efficiency
            lyrSE = [];
            for ii=1:nz
                lyrSE{i}{j}(ii) = length(fltrAnd(lyr{ii},swept{i}{j}))/...
                    length(lyr{ii});
            end
            VSE{i}(j) = mean(lyrSE{i}{j});            

        % Field pressure
            FPR{i}(j) = mean(sum(Pt{i}{j+1}.*...
                         G.cells.volumes.*...
                         rock.poro)./sum(G.cells.volumes.*...
                         rock.poro));   
        % Total injected CO2 volume
            CO2_Vol_tot{i}(j) = sum((1-St{i}{j+1}).*G.cells.volumes...
                .*rock.poro);
        % Injection rate
            injRate{i}(j) = sum(I{i}{j+1});

        % Production rate
            P1Rate{i}(j) = -sum(P1{i}{j+1});
            P2Rate{i}(j) = -sum(P2{i}{j+1});  

        % Injection bhp
            injBhp{i}(j) = Ip{i}{j+1};

        % Production bhp
            P1Bhp{i}(j) = P1p{i}{j+1};
            P2Bhp{i}(j) = P2p{i}{j+1};
        end
end

%% Trim the Time :)
tend = time{1}(end);stend = []; 
for i=2:length(varargin)
    tend = min(tend,time{i}(end));
end
for i=1:length(varargin)
    stend(i) = floor(tend/dt(i));
end
    
%% Plots
%
    col = [ 'g' 'r' 'b' 'k' 'c' 'y'];
%%
    figure;hold on;
    for i=1:length(varargin)
        plot(time{i}(1:stend(i)),cut1{i}(1:stend(i)),col(i));
    end
    title('CO2 Cut In The P1');
    axis tight;
%%
    figure; hold on;
    for i=1:length(varargin)
        plot(time{i}(1:stend(i)),CO2_mix_Vol{i}(1:stend(i)),col(i));
    end
    title('mixed Injected CO2 Volume, m3');
    axis tight;
%%    
    figure; hold on;
    for i=1:length(varargin)
        plot(time{i}(1:stend(i)),ASE{i}(1:stend(i)),col(i));
    end
    title('Areal Sweep Efficiency');
    axis tight;    
%%    
    figure; hold on;
    for i=1:length(varargin)
       plot(time{i}(1:stend(i)),VSE{i}(1:stend(i)),col(i)); 
    end
    title('Vertical Sweep Efficiency');
    axis tight;         
%%    
    figure;hold on;
    for i=1:length(varargin)
        plot(time{i}(1:stend(i)),cut2{i}(1:stend(i)),col(i));
    end
    title('CO2 Cut In The P2');
    axis tight;
%%
    figure; hold on;
    for i=1:length(varargin)
        plot(time{i}(1:stend(i)),FPR{i}(1:stend(i))/barsa,col(i));
    end
    title('Field Pressure, barsa');
    axis tight;
%%    
    figure; hold on;
    for i=1:length(varargin)
        plot(time{i}(1:stend(i)),CO2_Vol_tot{i}(1:stend(i)),col(i));
    end
    title('Total Injected CO2 Volume, m3');
    axis tight;
%%    
    figure; hold on;
    for i=1:length(varargin)
        plot(time{i}(1:stend(i)),CO2_mix_Vol{i}(1:stend(i))./...
            CO2_Vol_tot{i}(1:stend(i)),col(i));
    end
    title('Mixed Injected CO2 Volume Fraction, m3');
    axis tight;
%%    
    figure; hold on;
    for i=1:length(varargin)
        plot(time{i}(1:stend(i)),injRate{i}(1:stend(i))*year,col(i));
    end
    title('Injection Rate, m3/year');
    axis tight;
 %%   
    figure; hold on;
    for i=1:length(varargin)   
        plot(time{i}(1:stend(i)),P1Rate{i}(1:stend(i))*year,col(i));
    end
    title('P1 Rate, m3/year');
    axis tight;
 %%   
    figure; hold on;
    for i=1:length(varargin)   
        plot(time{i}(1:stend(i)),P2Rate{i}(1:stend(i))*year,col(i));
    end
    title('P2 Rate, m3/year');
    axis tight;
%%
    figure; hold on;
    for i=1:length(varargin)      
        plot(time{i}(1:stend(i)),injBhp{i}(1:stend(i))/barsa,col(i));
    end
    title('Injector BHP, barsa');
    axis tight;
 %%   
    figure; hold on;
    for i=1:length(varargin)      
        plot(time{i}(1:stend(i)),P1Bhp{i}(1:stend(i))/barsa,col(i));
    end
    title('P1 BHP, barsa');
    axis tight;
%%
    figure; hold on;
    for i=1:length(varargin)      
        plot(time{i}(1:stend(i)),P2Bhp{i}(1:stend(i))/barsa,col(i));
    end
    title('P2 BHP, barsa');
    axis tight;
%%    
    for i=1:length(varargin)
        Scenario = ['# ' num2str(varargin{i}) ': ' col(i)]
    end
end