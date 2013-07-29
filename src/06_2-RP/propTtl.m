function [ttl] = propTtl(prop)
%PROPTTL Property Title
%   [ttl] = propTtl(prop) produces title string ttl for property prop. This
%   can be used for plot means.
%
%   See also crossAll.

%%
switch prop,
    case 'LWFlx',
        ttl = 'Left Boundary Water FLux';
    case 'LOFlx',
        ttl = 'Left Boundary CO_2 FLux';
    case 'RWFlx',
        ttl = 'Right Boundary Water FLux';
    case 'ROFlx',
        ttl = 'Right Boundary CO_2 FLux';
    case 'DWFlx',
        ttl = 'Down Boundary Water FLux';
    case 'DOFlx',
        ttl = 'Down Boundary CO_2 FLux';
    case 'OL2R',
        ttl = 'Left To Right CO_2 FLux';
    case 'WL2R',
        ttl = 'Left To Right Water FLux';
    case 'L2R',
        ttl = 'Left To Right Total FLux';
    case 'totMobCo2',
        ttl = 'Total Mobile CO_2 Volume';
    case 'totResCo2',
        ttl = 'Total Residual CO_2 Volume';
    case 'largestPlume',
        ttl = 'Largest CO_2 Plume Volume';
    case 'meanPlume',
        ttl = 'Average CO_2 Plume Volume';
    case 'medianPlume',
        ttl = 'Median CO_2 Plume Volume';
    case 'stdPlume',
        ttl = 'Standard Deviation CO_2 Plume Volume';
    case 'FPR',
        ttl = 'Average Field Pressure';
    case 'WBHP',
        ttl = 'Injector Bottom Hole Pressure';
    case 'WCIR',
        ttl = 'CO_2 Injection Rate';    
    case 'plumeNum',
        ttl = 'Total Number Of CO_2 Plumes';
    case 'init.PORV.values',
        ttl = 'Pore Volume';
    case 'init.PORO.values',
        ttl = 'Porosity';
    case 'init.PERMX.values',
        ttl = 'PermX';
    case 'init.PERMY.values',
        ttl = 'PermY';
    case 'init.PERMZ.values',
        ttl = 'PermZ';
    case 'init.TRANX.values',
        ttl = 'Transmissibility in X direction';
    case 'init.TRANY.values',
        ttl = 'Transmissibility in Y direction';
    case 'init.TRANZ.values',
        ttl = 'Transmissibility in Z direction';
    case 'leakageRisk',
        ttl = 'Risk Of Leakage';        
    case 'pv',
%        ttl = 'Pressurized Volume Fraction';        
        ttl = 'Volume Fraction';        
    case 'dpv',
%        ttl = 'Build-up Fraction';        
        ttl = 'Volume Fraction';        
    case 'disdp',
%        ttl = 'Farthest Pulse';        
        ttl = 'Distance';        
    case 'disInd',
        ttl = 'Farthest Index';        
        ttl = 'Distance';                
    case 'dpInBdry',
        ttl = 'Pulse in Boundary';        
    case 'WRPD',
%        ttl = 'Average Well Drop';        
        ttl = 'Pressure';        
    case 'tinc',
%        ttl = 'Objective Time';        
        ttl = 'Time';        
    case 'FPR2',
%	ttl = 'Aquifer Average Pressure';
        ttl = 'Pressure';        
    otherwise
        ttl =[];
        display('Not a valid property name!');
        return
end
end

