function [] = prsCrt()
%PRSCRT Pressure Criteria
%   prsCrt() saves the surface for number of cases meeting pressure 
%   responses criteria.
%  
%   See also pltAll, vctAll.

%% Load responses
scn = 'SCN08';
tnc = vctAll('SCN09','tinc');
prv = vctAll(scn,'pv');
dpv = vctAll(scn,'dpv');    
pls = vctAll(scn,'disdp');

%% Criteria vector
% end points
MnTnc = min(tnc);MxTnc = max(tnc);
MnPrv = min(prv);MxPrv = max(prv);
MnDpv = min(dpv);MxDpv = max(dpv);
MnPls = min(pls);MxPls = max(pls);
%resolution
nr = 10;
Xtnc = linspace(MnTnc,MxTnc,nr);
Xprv = linspace(MnPrv,MxPrv,nr);
Xdpv = linspace(MnDpv,MxDpv,nr);
Xpls = linspace(MnPls,MxPls,nr);

%% Surface function
% sort vector (extra, to be used in case needed!)
[TNC,Itnc] = sort(tnc);
[PRV,Iprv] = sort(prv);
[DPV,Idpv] = sort(dpv);
[PLS,Ipls] = sort(pls);
%
Z = zeros(nr,nr,nr,nr);
%
cnt =0;
for i4 = 1:nr,
	for i3 = 1:nr,
		for i2 = 1:nr,
			for i1 = 1:nr,
				V = find(tnc<=Xtnc(i1));
				cnt = cnt + 1;
				prog = 100*cnt/(nr^4);
				switch rem(cnt,4),
					case 0,
						tx = '|';
					case 1,
						tx = '/';
					case 2,
						tx = '--';
					case 3,
						tx = '\';
				end	
				%
				display([tx ' ' num2str(prog) ' %']);
				%
				if isempty(V),
					Z(i1,i2,i3,i4) = 0;
				else,
					V = find(prv(V)<=Xprv(i2));
					if isempty(V),
						Z(i1,i2,i3,i4) = 0;
					else, 		
						V = find(dpv(V)<=Xdpv(i3));
						if isempty(V),
							Z(i1,i2,i3,i4) = 0;
						else,
							V = find(pls(V)<=Xpls(i4));
							if isempty(V),
								Z(i1,i2,i3,i4) = 0;
							else,
								Z(i1,i2,i3,i4) = numel(V);
							end
						end
					end
				end
				%			
			end
		end
	end
end
%
FN = ['~/prjII/PRS/CRT/crtPrb.mat'];
FNB = ['~/prjII/PRS/CRT/crtPrb_' kpdg(nr,4) '.mat'];
%
save(FN);
save(FNB);
%
end
