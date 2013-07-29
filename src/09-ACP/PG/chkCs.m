function [] = chkCs(prop,cs,figN)
%CHKCS Check Case
%  chkCs(prop,cs,figN) checks polynomial approximation of response prop for cs.
% 
%   See also polyCase, polyTune, polyGen, rspVct, clcAcpPlt.
%%
nds = cs(end-1);
pltF = [pthVCT(cs) cs '_PLT.mat'];

[rsp,tc] = polyCase(prop,cs);

load([pthVCT(cs) cs '_PLT.mat'],prop,'rstT','smryT');
rse=eval(prop);
rsz = (length(rse)== length(rstT));
if rsz,
	tecl = rstT;
else
	tecl = smryT;
end

if length(tecl)~=length(rse), 
	load(rstF);
	rse = eval(['rst.' prop]);
	clear rst;
end

h=figure(1);

clf;

fe = plot(tecl,rse,'b*');
set(fe,'LineWidth',3);
hold on
fp = plot(tc,rsp,'r','LineWidth',3);
set(fp,'MarkerSize',6);
set(gca,'FontSize',20);
lg= legend('Reference simulation','Polynomial approximation');
set(lg,'FontSize',13);
pthCmpr = '~/prjII/aPC/PICs/CMP_Pics/';
fNm = [pthCmpr 'cmr_' prop '_' nds '_' figN];
saveas(h,[ fNm '.eps'],'epsc');
saveas(h,[fNm '.fig'],'fig');
system(['epstopdf ' fNm '.eps']);
end
