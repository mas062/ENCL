function [ ] = histFltrAgr7( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
figPth = 'C:\Users\meisama\Documents\PhD\aPC\PICs\RA_Pics\';

load('C:\Users\meisama\Documents\PhD\aPC\7\fltrAgr_7.mat')
h = figure();
clf;
nh=100;
scl = 90;
hist(Agr*scl,nh);
ho = findobj(gca,'Type','patch');
set(ho,'FaceColor','k','EdgeColor','w');
set(gca,'FontSize',20);
Yr = get(gca,'YTick');
axis([0 scl Yr(1) Yr(end)]);
xlabel('Parameter value');
ylabel('Frequency');
fnM=[figPth 'hist_AgrFltr_7'];
saveas(h,[fnM '.eps'],'epsc');
saveas(h,[fnM '.fig'],'fig');
system(['epstopdf ' fnM '.eps']);


end

