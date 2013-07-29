%% Enceladus Run Results Visualization
% In this program, different tools of visualization are made available 
% to study the run results of Enceladus model.
%% 
function [] = Visualizer(Grid,Rock,Solution) 
%% Input Variables
% We start with loading the required initial data
%
% 
    load '../02-output/Encl_Scen_1/Grid.mat';

    load '../02-output/Encl_Scen_1/Rock.mat';

    [S P] = ldrpt(lstRpt);
    
     PermD = rock.perm./(9.869233e-16);% m3 to mD
%%######################################################################     
%% Call Filters
% Here we call different filters to get the cell numbers required in
% plotCellData function.

    pro = valFltr(G,S,0.0,0.8);
    btwnWells = boxIndFltr(G,1,8,8,G.cartDims(2)-8,1,20); 
    frstHalf = boxIndFltr(G,1,G.cartDims(1),1,G.cartDims(2),1,10);
    sndHalf = invFltr(G,frstHalf);
    
    btwnPro = fltrAnd(pro,btwnWells);
    frstPro = fltrAnd(pro,frstHalf);
    sndPro = fltrAnd(pro,sndHalf);

    inj = boxIndFltr(G,5,5,G.cartDims(2)/2,G.cartDims(2)/2,1,20);
    P1 = boxIndFltr(G,4,4,8,8,1,20);
    P2 = boxIndFltr(G,4,4,G.cartDims(2)-8,G.cartDims(2)-8,1,20);
    producers = fltrOr(P1,P2);

%% Plot Filters    
%  The CO2 front movement towards producers  
    figure;
    gridViz(G,btwnPro,S,'Saturation_1','k');
    gridViz(G,producers,S,'Saturation_1','r');    
    view(92,52);
%  The CO2 front movement in the first half of the reservoir  
    figure;
    gridViz(G,frstPro,S,'Saturation_1','k');
    gridViz(G,producers,S,'Saturation_1','r');
    view(92,52);
%  The CO2 front movement in the second half of the reservoir  
    figure;
    gridViz(G,sndPro,S,'Saturation_1','k');
    gridViz(G,producers,S,'Saturation_1','r');
    view(92,52);
%%#######################################################################
end

%% Functions
%
%% Last Report Number
%
function [lstInd] = lstRpt()
    i = 0;
 within = 1;
    while ~isempty(within)
        i = i + 1;
        fn = ['../02-output/Encl_Scen_3/Encl_Scen_3.' int2str(i) '.mat'];
        within = dir(fn);
    end
    lstInd = i-1;
end
%% Load Time Dependent Simulation Results 
% Loads report saturation and pressure from file by report number.
function [Sat Press] = ldrpt(repNum)
    fn = ['../02-output/Encl_Scen_1/Encl_Scen_1.' int2str(repNum) '.mat'];load(fn);   
end