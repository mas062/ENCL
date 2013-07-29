function [] = crossAll(scnTmp,propName,varargin)
%CROSSALL Cross All
%   crossAll(scnTmp,propName) produces cross plots and histograms for 
%   property prop of all cases in end of injection and simulation time for
%   scenario scnTmp.
%
%   See also clcPlt, mkCP.

%%
global A B AA BB c d prop agnstProp twoProp doReturn;
A = [];B = [];c = [];d = [];
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
pN = [enclDir() 'PLT/PLT_' scnTmp(1:5) '/'];
fN = [pN scnTmp '_' prop '_CRS.mat'];
cmd = ['mkdir ' pN];
if ~exist(pN,'dir'), system(cmd); end
%
doReturn = false;
%
allCases(scnTmp,@task);
%
if doReturn, 
    msg = 'No plotting vectors are available';
    display(msg);
    logIt(msg);
    return; 
end;
figure();
scatterIt(A,B,c,d);
xlabel('End Of Injection');
ylabel('End Of Simulation');
set(gca,'XMinorGrid','on','YMinorGrid','on',...
    'XMinorTick','on','YMinorTick','on');
title([ttl ', ' unt]);
%
figure();
scatterIt((ufInd(c)+1)/2,A,c,d);
xlabel('Cases');
ylabel('End Of Injection');
set(gca,'XGrid','on','YMinorGrid','on',...
    'XMinorTick','off','YMinorTick','on');
set(gca,'XTick', 0:1:54);
axis tight;
title([ttl ', ' unt]);
%
figure();
scatterIt((ufInd(c)+1)/2,B,c,d);
xlabel('Cases');
ylabel('End Of Simulation');
set(gca,'XGrid','on','YMinorGrid','on', ...
    'XMinorTick','off','YMinorTick','on');
set(gca,'XTick', 0:1:54);
axis tight;
title([ttl ', ' unt]);
%
figure();
%histCurve(A);
hist(A);
xlabel('End Of Injection');
title([ttl ', ' unt]);
%
figure();
%histCurve(B);
hist(B);
xlabel('End Of Simulation');
title([ttl ', ' unt]);
%
if twoProp,
    %
    figure();
    scatterIt(nrm(A),nrm(AA),c,d);
    xlabel(ttl);
    ylabel(agnstTtl);
    set(gca,'XMinorGrid','on','YMinorGrid','on',...
    'XMinorTick','on','YMinorTick','on');
    title('End Of Injection');
    %
    %
    figure();
    scatterIt(nrm(B),nrm(BB),c,d);
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
global A B AA BB c d prop agnstProp twoProp doReturn;
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
    P = eval(prop);
    %
    if ~exist('rstIT','var'),
        freqRst(caseName);
        load(fN_PLT);
    end
    %
    smryTimeInd = find(smry.WOIR(1,:));
    smryEOI = smryTimeInd(end);
    smryEOS = length(smry.TIME);
    [rstdif, rstEOI] = min(abs(rstIT*day/year-smryT(smryEOI)));
    rstEOS = length(P);
    %
    EOI = rstEOI;
    EOS = rstEOS;
    %
    if strfind(prop,'it.'), 
        EOI = 1; EOS = 1;
        P = std(P(1:length(P)));
    elseif ismember(prop,{'FPR','WBHP','WCIR'}),
        EOI = smryEOI;
        EOS = smryEOS;
    end
    %
    A(end+1) = P(EOI);
    B(end+1) = P(EOS);
    %
    if twoProp,
        %
        P = eval(agnstProp);
        if strfind(agnstProp,'it.'),
            EOI = 1; EOS = 1;
            P = std(P(1:length(P)));
        end
        %
        AA(end+1) = P(EOI);
        BB(end+1) = P(EOS);
        %
    end
    %
    
    c(end+1) = nD2lin(nDm(case2cls(caseName)));
    d(end+1) = str2num(caseName(10:12));
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
