function [] = pltCrt(C_tnc,C_prv,C_dpv,C_pls)
%PLTCRT Plot Criteria
%   pltCrt() plots the pressure criteria for scenario 8 (and partly 9).
%
%   See also prsCrt, vctAll.
%
%%

%% Load criteria data
%
crtPth = '~/prjII/PRS/CRT/';
FN = [crtPth 'crt.mat'];
load(FN);
%
%% Normalise
%
dTnc = MxTnc - MnTnc;
dPrv = MxPrv - MnPrv;
dDpv = MxDpv - MnDpv;
dPls = MxPls - MnPls;
%

c_tnc = dTnc*C_tnc+MnTnc;
c_prv = dPrv*C_tnc+MnPrv;
c_dpv = dDpv*C_tnc+MnDpv;
c_pls = dPls*C_tnc+MnPls;

%%
nmid = floor((nr+1)/2);
%
V = find(tnc<=c_tnc);
if ~isempty(V),
	V = find(prv(V)<=c_prv);
	if ~isempty(V),
		V = find(dpv(V)<=c_dpv);
		if ~isempty(V),
			V = find(pls(V)<=c_pls);
			if ~isempty(V),
				A1 = tnc(V);
				A2 = prv(V);
				A3 = dpv(V);
				A4 = pls(V);
			end
		end
	end
end
%

hc = figure;
hsd = scatter3(tnc,dpv,pls,'MarkerFaceColor',[0.8 0.8 0.8]);%,'MarkerFaceColor',[0.8 0.8 0.8]);
hold on; 
scatter3(A1,A3,A4,'MarkerEdgeColor','k','MarkerFaceColor','r');

%
fn = [crtPth 'crt_sct'];
saveas(hc,[fn '.fig'],'fig');
saveas(hc,[fn '.eps'],'epsc');	
system(['epstopdf ' fn '.eps']);
	
end

