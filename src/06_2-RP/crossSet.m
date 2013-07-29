function [] = crossSet()
%CROSSALL Cross All
%   crossAll(scnTmp,propName) produces cross plots and histograms for 
%   property prop of all cases in end of injection and simulation time for
%   scenario scnTmp.
%
%   See also clcPlt, mkCP.

%%
global A B AA BB c prop agnstProp twoProp doReturn;
A = [];B = [];c = [];
twoProp = ~isempty(varargin);
%
prop = propName;
%
ttl = propTtl(prop);
unt = propUnit(prop);
%
if twoProp,
    agnstProp = char(varargin(1));
    AA = [];BB = [];
    agnstTtl = propTtl(agnstProp);    
end
    
%
fN = [enclDir 'PLT/PLT_' scnTmp(1:5) '/' scnTmp '_' prop ...
    '_CRS.mat'];
%
doReturn = false;
%
allCases(scnTmp,@task);
%
if doReturn, return; end;
figure();
scatterIt(A,B,c);
xlabel('End Of Injection');
ylabel('End Of Simulation');
set(gca,'XMinorGrid','on','YMinorGrid','on',...
    'XMinorTick','on','YMinorTick','on');
title([ttl ', ' unt]);
%
figure();
scatterIt(c,A,c);
xlabel('Cases');
ylabel('End Of Injection');
set(gca,'XMinorGrid','on','YMinorGrid','on',...
    'XMinorTick','on','YMinorTick','on');
set(gca,'XTick', 0:4:120);
title([ttl ', ' unt]);
%
figure();
scatterIt(c,B,c);
xlabel('Cases');
ylabel('End Of Simulation');
set(gca,'XMinorGrid','on','YMinorGrid','on', ...
    'XMinorTick','on','YMinorTick','on');
set(gca,'XTick', 0:4:120);
title([ttl ', ' unt]);
%
figure();
hist(A);
xlabel('End Of Injection');
title([ttl ', ' unt]);
%
figure();
hist(B);
xlabel('End Of Simulation');
title([ttl ', ' unt]);
%
if twoProp,
    %
    figure();
    scatterIt(nrm(A),nrm(AA),c);
    xlabel(ttl);
    ylabel(agnstTtl);
    set(gca,'XMinorGrid','on','YMinorGrid','on',...
    'XMinorTick','on','YMinorTick','on');
    title('End Of Injection');
    %
    %
    figure();
    scatterIt(nrm(B),nrm(BB),c);
    xlabel(ttl);
    ylabel(agnstTtl);
    set(gca,'XMinorGrid','on','YMinorGrid','on',...
    'XMinorTick','on','YMinorTick','on');
    title('End Of Simulation');
    %    
end
save(fN, 'c');
%
end
function [] = task(caseName)
%%
global A B AA BB c prop agnstProp twoProp doReturn;
%
fN_INIT = [pthVCT(caseName) caseName '_INIT.mat'];
fN_PLT = [pthVCT(caseName) caseName '_PLT.mat'];
fN_SMRY = [pthVCT(caseName) caseName '_SMRY.mat'];
%
int =exist(fN_INIT,'file');
plt =exist(fN_PLT,'file');
smry =exist(fN_SMRY,'file');
%
if plt && smry && int,
    %
    load(fN_INIT);
    load(fN_PLT);
    load(fN_SMRY);
    %
    smryTimeInd = find(smry.WOIR(1,:));
    smryEOI = smryTimeInd(end);
    rstEOI = find(rstT==smryT(smryEOI));
    lst = length(rstT);
    %
    P = eval(prop);
    %
    if strfind(prop,'it.'), 
        rstEOI = 1;lst = 1;
        P = std(P(1:length(P)));
    end
    %
    A(end+1) = P(rstEOI);
    B(end+1) = P(lst);
    %
    if twoProp,
        %
        P = eval(agnstProp);
        if strfind(agnstProp,'it.'),
            rstEOI = 1;lst = 1;
            P = std(P(1:length(P)));
        end
        %
        AA(end+1) = P(rstEOI);
        BB(end+1) = P(lst);
        %
    end
    %
    c(end+1) = nD2lin(nD(case2cls(caseName)));
    %
else
    %
    msg = 'No plotting vectors are available';
    display(msg);
    logIt(msg);
    %
    doReturn = true;
end
end
