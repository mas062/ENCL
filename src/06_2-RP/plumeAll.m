function [] = plumeAll(scnTmp)
%PLUMEALL Plume All
%   plumeAll(scnTmp) makes cross plots and histogram on the largest CO_2
%   plume size of all cases in time.
%
%   See also clcPlt.

%%
global A B c;
A = [];B = [];c = [];
%
fN = [enclDir 'DATA/SCN_PLT/PLT_' scnTmp(1:5) '/' scnTmp '_PLT.mat'];
%
allCases(scnTmp,@task);
%
figure;
scatter(A,B);
xlabel('End Of Injection, m^3');
ylabel('End Of Simulation, m^3');
set(gca,'XMinorGrid','on','YMinorGrid','on');
title('Largest Plume Size');
%
figure();
scatter(c,A);
xlabel('Cases');
ylabel('End Of Injection, m^3');
set(gca,'XMinorGrid','on','YMinorGrid','on');
title('Largest Plume Size');
%
figure();
scatter(c,B);
xlabel('Cases');
ylabel('End Of Simulation, m^3');
set(gca,'XMinorGrid','on','YMinorGrid','on');
title('Largest Plume Size');
%
figure();
hist(A);
xlabel('End Of Injection, m^3');
title('Largest Plume Size, EOI');
%
figure();
hist(B);
xlabel('End Of Simulation, m^3');
title('Largest Plume Size, EOS');
%
save(fN, 'c');
%
end
function [] = task(caseName)
%%
global A B c;
%
fN_PLT = [pthVCT(caseName) caseName '_PLT.mat'];
fN_SMRY = [pthVCT(caseName) caseName '_SMRY.mat'];
%
plt =exist(fN_PLT,'file');
smry =exist(fN_SMRY,'file');
%
if plt && smry,
    %
    load(fN_PLT);
    load(fN_SMRY);
    %
    smryTimeInd = find(smry.WOIR(1,:));
    smryEOI = smryTimeInd(end);
    rstEOI = find(rstT==smryT(smryEOI));
    %
    A(end+1) = largestPlume(end);
    B(end+1) = largestPlume(rstEOI);
    %
    c(end+1) = nD2lin(nD(case2cls(caseName)));
    %
end
end
