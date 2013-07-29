function []=ivHist(nd),
%IVHIST Input Variables Histograms 
%
%
%	See also inVar, fndCol.

%%
pD = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
pthSv = '/Home/siv16/mas062/prjII/aPC/PICs/IVH_Pics/';
%
nh = 100;
brN = [pD 'Brr_' num2str(nd) '.mat'];
agN = [pD 'Agr_' num2str(nd) '.mat'];
ftN = [pD 'Fts_' num2str(nd) '.mat'];
bwN = [pD 'Bkw_' num2str(nd) '.mat'];
%
load(brN);load(agN);load(ftN);load(bwN);
%
h = figure();
clf;

scl = 100;
hist(Brr*scl,nh);
ho = findobj(gca,'Type','patch');
set(ho,'FaceColor','k','EdgeColor','w');
set(gca,'FontSize',20);
Yr = get(gca,'YTick');
axis([0 scl Yr(1) Yr(end)]);
xlabel('Parameter value');
ylabel('Frequency');

saveas(h,[pthSv 'hist_Brr_' num2str(nd) '.eps'],'epsc');
saveas(h,[pthSv 'hist_Brr_' num2str(nd) '.fig'],'fig');


%
h = figure();
clf;

scl = 90;
hist(Agr*scl,nh);
ho = findobj(gca,'Type','patch');
set(ho,'FaceColor','k','EdgeColor','w');
set(gca,'FontSize',20);
Yr = get(gca,'YTick');
axis([0 scl Yr(1) Yr(end)]);
xlabel('Parameter value');
ylabel('Frequency');

saveas(h,[pthSv 'hist_Agr_' num2str(nd) '.eps'],'epsc');
saveas(h,[pthSv 'hist_Agr_' num2str(nd) '.fig'],'fig');
%
h = figure();
clf;

hist(Fts,nh);
ho = findobj(gca,'Type','patch');
set(ho,'FaceColor','k','EdgeColor','w');
set(gca,'FontSize',20);
%Yr = get(gca,'YTick');
%axis([0 scl Yr(1) Yr(end)]);
xlabel('Parameter value');
ylabel('Frequency');

saveas(h,[pthSv 'hist_Fts_' num2str(nd) '.eps'],'epsc');
saveas(h,[pthSv 'hist_Fts_' num2str(nd) '.fig'],'fig');
%
h = figure();
clf;

hist(Bkw,nh);
ho = findobj(gca,'Type','patch');
set(ho,'FaceColor','k','EdgeColor','w');
set(gca,'FontSize',20);
Yr = get(gca,'YTick');
%Xr = get(gca,'XTick');
axis([min(Bkw) max(Bkw) Yr(1) Yr(end)]);
xlabel('Parameter value');
ylabel('Frequency');

saveas(h,[pthSv 'hist_Bkw_' num2str(nd) '.eps'],'epsc');
saveas(h,[pthSv 'hist_Bkw_' num2str(nd) '.fig'],'fig');
end
