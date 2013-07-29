function [] = pltAll(scnTmp,propName,lg,varargin)
%PLTALL Plot All
%   pltAll(scnTmp,propName,lg) produces plots and histograms for 
%   property prop of all cases for scenario scnTmp. lg is to make the plots logarithmic, if valued true.
%
%   See also crossAll.

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
%
h1 = figure();
zeroIn = false;
if lg,% add a tiny number to zero values, semilog plot
	eps = 10^(floor(log10(min(A(A>0))))-1);
	if (min(A)==0),
		zeroIn = true;
		A = A + eps;
	end
end
scatterIt((ufInd(c)+1)/2,A,c,d);
xl = xlabel('Case Number');
yl = ylabel([ttl ', ' unt]);
%
set(gca,'XGrid','on','XMinorTick','on','XMinorGrid','on');
set(gca,'YGrid','on','YMinorTick','on','YMinorGrid','on');
%
axis tight;
set(gca,'XTick', 0:4:54,'PlotBoxAspectRatio', [3 1.5 1]);
set(gca,'XTickLabel', 0:4:54,'FontSize', 15);
set(xl,'FontSize',15);
set(yl,'FontSize',15);

if lg,
	flt = A;
	if zeroIn,
		flt = A(A~=eps);
	end
	mN = floor(log10(min(flt)));
	mX = ceil(log10(max(A)));
	d = (mX-mN)/5;
	yt = [10.^[mN:d:mX]];
	if zeroIn, yt = [0 yt];end
	%ytl(1,:) = ['0' repmat(' ',1,length(ytl(1,:))-1)];
	%yt(1) = 0;
	set(gca,'YTick',yt);
	set(gca, 'Yscale', 'log');
%	ytl = get(gca,'YTickLabel');
%	if zeroIn,
%		ytl(1) = ['0' repmat(' ',1,length(ytl(1))-1)];
%	end
%	set(gca,'YTickLabel',ytl);
end

h2 = figure();

if lg, 
	logHist(A,20);
else,
	hist(A,20);
end

if lg,
	flt = A;
	if zeroIn,
		flt = A(A~=eps);
	end
	mN = floor(log10(min(flt)));
	mX = ceil(log10(max(A)));
	d = (mX-mN)/5;
	xt = [10.^[mN:d:mX]];
	if zeroIn, xt = [0 xt];end	
	set(gca,'XTick',xt);
end
set(gca,'XMinorTick','on');
set(gca,'YGrid','on');
%
set(gca,'TickDir','out','TickLength',[0.02 0.05],'LineWidth',1.5);
colormap(cool);
ho = findobj(gca,'Type','patch');
set(ho,'FaceColor', [0.2,0.2,0.4],'EdgeColor','w');
%set(ho,'BinSize',0.2);
set(gca,'FontSize',18);
xlabel([ttl ', ' unt]);
ylabel('Frequency');
axis tight;
%
ti = get(gca,'TightInset');
set(gca,'Position',[ti(1) ti(2) 1-ti(3)-ti(1) 1-ti(4)-ti(2)]);
set(gca,'units','centimeters')
pos = get(gca,'Position');
ti = get(gca,'TightInset');

prsFig = '~/prjII/PRS/pics/';
saveas(h1,[prsFig 'plt_' propName '_' scnTmp],'fig');
saveas(h2,[prsFig 'plth_' propName '_' scnTmp],'fig');
saveas(h1,[prsFig 'plt_' propName '_' scnTmp],'epsc');
saveas(h2,[prsFig 'plth_' propName '_' scnTmp],'epsc');

save(fN, 'c');
system(['epstopdf ' prsFig 'plt_' propName '_' scnTmp '.eps']);
system(['epstopdf ' prsFig 'plth_' propName '_' scnTmp '.eps']);
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
int = exist(fN_INIT,'file');
plt = exist(fN_PLT,'file');
smry = exist(fN_SMRY,'file');
%
if plt && smry && int,
    %
    load(fN_INIT);
    load(fN_PLT);
    load(fN_SMRY);
    %
    P = eval(prop);
    %
    if ~isempty(P),
    	A(end+1) = P;
    else
    	A(end+1)=0;
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
