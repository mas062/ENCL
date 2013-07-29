
function [] = histAll(nd,clr)
%histAll Cummulative Distribution Function for All 
%	histAll(nd) plots the cdf of risk analysis related to all properties.
% 	
%	See also, histRA, cdfRA, sobSA, polyTune, polyGen.
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
    display(['Calculating and plotting probability histograms for ' prop{i}]);
    histRA(prop{i},nd,clr);
end 
end
