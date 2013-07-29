function [] = prsClcPlt(caseName)
%PRSCLCPLT Pressure Calculate Plot Vectors
%   prsClcPlt(caseName) calculates plot vectors for the run pressure results 
%   of caseName. These vectors will be saved in mat files for the case.
%
%   See also mkCP, clcPlt.
%
msg = ['Started calulating plot vectors for case ' caseName '...'];
display(msg);
logIt(msg);
% 
%% Load Information
[Grd,init,smry,rst] = loadData(caseName);

%% Calculations
%
nx = 40; ny = 120; nz = 20;
nact = Grd.cells.num;
%
scnTmp = case2scn(caseName);
%
msg = ['Started pressure plot calculations for case ' caseName '...'];
display(msg);
logIt(msg);
% 

%
% _/\_/\__/\_/\__/\_/\__/\_/\__
% Pressure Responses     ||||||||||||||||||||||||||||||||||||||||>
% ==============================
%
msg = ['Pressures...'];
display(msg);
logIt(msg);
% 
%--------%
% Well bottom hole pressure       
%--------%
WBHP = smry.WBHP(1,:);  
%--------%        
WPR =WBHP;
eoInd = max(find(WBHP>0));
np = 2;
% P review volume
%--------%
pthd = 300;
mxp = 1000;
prs = rst.PRESSURE{np};
nph = numel(valFltr(prs,pthd,mxp));
pv = (nph/nact); 
% Field average pressure       
%--------%


FPR = smry.RPR(1,:);  
FPR2 = FPR(np);

% DP review volume
%--------%
dpthd = 10;% bar
mxdp = 1000;% bar
dp = rst.PRESSURE{np}-rst.PRESSURE{1};
cellDP = valFltr(dp,dpthd,mxdp);
ndph = numel(cellDP);
dpv = (ndph/nact); 
% farthest from injection
injInd = find(Grd.cells.indexMap==91966);
xyz = Grd.cells.centroids;
injPnt = xyz(injInd,:);
met = xyz-repmat(injPnt,size(xyz,1),1);
sqMet = met.^2;
sumSq = sum(sqMet,2);
disFromInj = (sumSq).^0.5;
[disdp,disInd] = max(disFromInj(cellDP));

% Reached the boundary
fip = init.FIPNUM.values;
dpInBdry = ~isempty(find(fip(cellDP)~=1));
% Average well drop pressure
%--------%
WPR(eoInd:end) = WPR(eoInd); 
WRPD =mean(WPR-FPR);

% Time to inject a certain CO2 volume
%--------% 
totInj = 40000000;
rin = 0.25;
vco2 = rin*totInj;
 dt =[0 smry.YEARS(2:end)-smry.YEARS(1:end-1)]*year/day;
WCIT = cumsum(smry.WVIR.*dt);
tinc =smry.YEARS(max(find(WCIT<=vco2)));

%--------%
%% Save Vectors
%
msg = ['Save Vectors'];
display(msg);
logIt(msg);
% 
%
pltMat = [pthVCT(caseName) caseName '_PLT.mat'];

	save(pltMat,'FPR','FPR2','nph','ndph','pv','dpv',...
        'disdp','disInd','dpInBdry','WRPD','tinc','-append');

msg = ['Pressure plot vectors produced and appended successfully for case ' ...
    caseName '.' ];
display(msg);
logIt(msg);
% 
logLst(caseName,'clc');
%
end

