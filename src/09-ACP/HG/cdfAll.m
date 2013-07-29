
function [] = cdfAll(nd)
%CDFAll Cummulative Distribution Function for All 
%	cdfAll(nd) plots the cdf of risk analysis related to all properties.
% 	
%	See also, cdfRA, sobSA, polyTune, polyGen.
%

%%
prop = { 'FPR'...
                        'totMobCo2'...
                        'totResCo2'...
                        'largestPlume'...
                        'meanPlume'...
                        'WBHP'...
                        'plumeNum'...
                        'leakageRisk'...
                        };  
                    
for i = 1:length(prop),
    display(['Calculating and plotting cdf for ' prop{i}]);
    cdfRA(prop{i},nd);
end 
end