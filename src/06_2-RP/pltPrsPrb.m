function [] = pltPrsPrb()
%PLTPRSPRB Plot Pressure Probabilities
%   pltPrsPrb() plots the pressure accumulative probabilities for scenario 8(and partly 9).
%
%   See also prsCrt, vctAll.
%
%%

%% Load criteria data
%
crtPth = '~/prjII/PRS/CRT/';
FN = [crtPth 'crtPrb.mat'];
load(FN);
%
%% Normalise
%
dTnc = MxTnc - MnTnc;
dPrv = MxPrv - MnPrv;
dDpv = MxDpv - MnDpv;
dPls = MxPls - MnPls;
%
%x1 = (Xtnc-MnTnc)/dTnc;
%x2 = (Xprv-MnPrv)/dPrv;
%x3 = (Xdpv-MnDpv)/dDpv;
%x4 = (Xpls-MnPls)/dPls;
%%
nmid = floor((nr+1)/2);

[x11,x12] = meshgrid(Xtnc,Xprv);
[x21,x23] = meshgrid(Xtnc,Xdpv);
[x31,x34] = meshgrid(Xtnc,Xpls);
[x42,x43] = meshgrid(Xprv,Xdpv);
[x52,x54] = meshgrid(Xprv,Xpls);
[x63,x64] = meshgrid(Xdpv,Xpls);

nc = 160;
Zc = Z/nc;

for i=1:nr,
	for j=1:nr,
		z12(i,j) = Zc(i,j,end,end);
		z13(i,j) = Zc(i,end,j,end);
		z14(i,j) = Zc(i,end,end,j);
		z23(i,j) = Zc(end,i,j,end);
		z24(i,j) = Zc(end,i,end,j);
		z34(i,j) = Zc(end,end,i,j);
	end
end

% plot setting
lbFnt = 20;
tkFnt = 20;
dz = 0.2;
res = 1;
%


h1 = figure;
lighting phong;
colormap jet;
surf(x11(1:res:end,1:res:end),x12(1:res:end,1:res:end),z12(1:res:end,1:res:end));
xlabel('Injection Time, day','FontSize',lbFnt);
ylabel('Pressurised Fraction','FontSize',lbFnt);
zlabel('Probability','FontSize',lbFnt);
set(gca,'FontSize',tkFnt);
set(gca,'ZTick',[0:dz:1]);
%

h2 = figure;
lighting phong;
colormap jet;
surf(x21(1:res:end,1:res:end),x23(1:res:end,1:res:end),z13(1:res:end,1:res:end));
xlabel('Injection Time, day','FontSize',lbFnt);
ylabel('Build-up Fraction','FontSize',lbFnt);
zlabel('Probability','FontSize',lbFnt);
set(gca,'FontSize',tkFnt);
set(gca,'ZTick',[0:dz:1]);
%

h3 = figure;
lighting phong;
colormap jet;
surf(x31(1:res:end,1:res:end),x34(1:res:end,1:res:end),z14(1:res:end,1:res:end));
xlabel('Injection Time, day','FontSize',lbFnt);
ylabel('Farthest Pulse, m','FontSize',lbFnt);
zlabel('Probability','FontSize',lbFnt);
set(gca,'FontSize',tkFnt);
set(gca,'ZTick',[0:dz:1]);
%

h4 = figure;
lighting phong;
colormap jet;
surf(x42(1:res:end,1:res:end),x43(1:res:end,1:res:end),z23(1:res:end,1:res:end));
xlabel('Pressurised Fraction','FontSize',lbFnt);
ylabel('Build-up Fraction','FontSize',lbFnt);
zlabel('Probability','FontSize',lbFnt);
set(gca,'FontSize',tkFnt);
set(gca,'ZTick',[0:dz:1]);
%

h5 = figure;
lighting phong;
colormap jet;
surf(x52(1:res:end,1:res:end),x54(1:res:end,1:res:end),z24(1:res:end,1:res:end));
xlabel('Pressurised Fraction','FontSize',lbFnt);
ylabel('Farthest Pulse, m','FontSize',lbFnt);
zlabel('Probability','FontSize',lbFnt);
set(gca,'FontSize',tkFnt);
set(gca,'ZTick',[0:dz:1]);
%

h6 = figure;
lighting phong;
colormap jet;
surf(x63(1:res:end,1:res:end),x64(1:res:end,1:res:end),z34(1:res:end,1:res:end));
xlabel('Build-up Fraction','FontSize',lbFnt);
ylabel('Farthest Pulse, m','FontSize',lbFnt);
zlabel('Probability','FontSize',lbFnt);
set(gca,'FontSize',tkFnt);
set(gca,'ZTick',[0:dz:1]);
%
for i = 1:6,
	I = num2str(i);
	h = ['h' I];
	fn = [crtPth 'crtPrb_3d_' I];
	saveas(eval(h),[fn '.fig'],'fig');
	saveas(eval(h),[fn '.eps'],'epsc');	
	system(['epstopdf ' fn '.eps']);
end
end

