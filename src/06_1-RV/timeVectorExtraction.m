%% Time Vectors Extraction
%
function [] = timeVectorExtraction(scenNum,fr);
%
    SvsT{1} = fr;
    PvsT{1} = fr;
    Ibhp{1} = fr;
    Iq{1} = fr;
    P1bhp{1} = fr;
    P1q{1} = fr;
    P2bhp{1} = fr;
    P2q{1} = fr;
    
    %% Maximum Time Step
    % Calculate the maximum step number of the scenario
    i = 0;
    within = 1;
    while ~isempty(within)
        i = i + 1;
        fn = [enclDir '02-output/Encl_Scen_' int2str(scenNum)...
            '/Encl_Scen_' int2str(scenNum) '.' int2str(i) '.mat'];
        within = dir(fn);
    end
    stpMax = i-1;
    
    %% Load Reports
    % Load the reports and store data
    for i=1:fr:stpMax
    %
        fn = [enclDir '02-output/Encl_Scen_' int2str(scenNum) ...
            '/Encl_Scen_' int2str(scenNum) '.' int2str(i) '.mat'];
    %   
        load(fn);
    %    
        SvsT{end+1} = Sat;
        PvsT{end+1} = Press;
        Ibhp{end+1} = wsol(1).pressure; Iq{end+1} = wsol(1).flux;
        P1bhp{end+1} = wsol(2).pressure; P1q{end+1} = wsol(2).flux;
        P2bhp{end+1} = wsol(3).pressure; P2q{end+1} = wsol(3).flux;
    end
    %% Save Vectors
    % Save the extracted time vectors
    %
    fName=[enclDir '02-output/Encl_Scen_' int2str(scenNum) '/SvsT.mat'];
    save(fName,'SvsT');
    %
    fName=[enclDir '02-output/Encl_Scen_' int2str(scenNum) '/PvsT.mat'];
    save (fName, 'PvsT');
    %
    fName=[enclDir '02-output/Encl_Scen_' int2str(scenNum) '/Ibhp.mat'];
    save (fName, 'Ibhp');
    %
    fName=[enclDir '02-output/Encl_Scen_' int2str(scenNum) '/Iq.mat'];
    save (fName, 'Iq');
    %
    fName=[enclDir '02-output/Encl_Scen_' int2str(scenNum) '/P1bhp.mat'];
    save (fName, 'P1bhp');
    %
    fName=[enclDir '02-output/Encl_Scen_' int2str(scenNum) '/P1q.mat'];
    save (fName, 'P1q');
    %
    fName=[enclDir '02-output/Encl_Scen_' int2str(scenNum) '/P2bhp.mat'];
    save (fName, 'P2bhp');
    %
    fName=[enclDir '02-output/Encl_Scen_' int2str(scenNum) '/P2q.mat'];
    save (fName, 'P2q');
    %
end