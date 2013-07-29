function [unt] = propUnit(prop)
%PROPUNIT Property Unit
%   [unt] = propUnit(prop) produces unit string ttl for property prop. This
%   can be used for plot means.
%
%   See also crossAll, propTtl.

%%
switch prop,
    case 'LWFlx',
        unt = 'm3/day';
    case 'LOFlx',
        unt = 'm3/day';
    case 'RWFlx',
        unt = 'm3/day';
    case 'ROFlx',
        unt = 'm3/day';
    case 'DWFlx',
        unt = 'm3/day';
    case 'DOFlx',
        unt = 'm3/day';
    case 'OL2R',
        unt = '';
    case 'WL2R',
        unt = '';
    case 'L2R',
        unt = '';
    case 'totMobCo2',
        unt = 'm3';
    case 'totResCo2',
        unt = 'm3';
    case 'largestPlume',
        unt = 'm3';
    case 'meanPlume',
        unt = 'm3';
    case 'medianPlume',
        unt = 'm3';
    case 'stdPlume',
        unt = 'm3';
    case 'FPR',
        unt = 'bar';
    case 'WBHP',
        unt = 'bar';
    case 'WCIR',
        unt = 'm^3/day';
    case 'plumeNum',
        unt = '';
    case 'init.PORV.values',
        unt = 'm^3';
    case 'init.PORO.values',
        unt ='';
    case 'init.PERMX.values',
        unt ='mDarcy';
    case 'init.PERMY.values',
        unt ='mDarcy';
    case 'init.PERMZ.values',
        unt ='mDarcy';
    case 'init.TRANX.values',
        unt ='';
    case 'init.TRANY.values',
        unt ='';
    case 'init.TRANZ.values',
        unt ='';
    case 'leakageRisk',
        unt ='risk measure';        
    case 'pv',
        unt = '-';        
    case 'dpv',
        unt = '-';        
    case 'disdp',
        unt = 'm';        
    case 'disInd',
        unt = '';        
    case 'dpInBdry',
        unt = 'Boolean';        
    case 'WRPD',
        unt = 'bar';        
    case 'tinc',
        unt = 'year';        
    case 'FPR2',
	unt = 'bar';
    otherwise
        unt = [];
        display('Not a valid property name!');
        return
end
end

