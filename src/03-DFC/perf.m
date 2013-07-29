function [conCell] = perf(Grd,PV,K,thr,ind)
%PERF Perforation Design
%   perf(G,Phi,Kx,Ky,Kz,ind,nc) takes the property vectors, the
%   box index limit and the number of required connection cells. Then it
%   finds the best option for a vertical well perforation returned in
%   conCell vector.
%
%   See also mkCase.

%%
% n = 2;
% Grd = cartGrid([n,n,n]);
% PV = rand(n,n,n);
% Kx = rand(n,n,n); 
% Ky = rand(n,n,n);
% Kz = rand(n,n,n);
%ind = [1,n,1,n,1,n];
Kx = K{1};
Ky = K{2};
Kz = K{3};
Kxyz = (Kx.*Ky.*Kz).^(1/3);
thrPV =thr{1};
thrKx =thr{2};
thrKy =thr{3};
thrKz =thr{4};
%
PVm = max(max(max(PV)));
Kxm = max(max(max(Kx)));
Kym = max(max(max(Ky)));
Kzm = max(max(max(Kz)));
box = boxIndFltr(Grd,ind{1},ind{2},ind{3},ind{4},ind{5},ind{6});
PVCell = valFltr(PV,thrPV,PVm);
KxCell = valFltr(Kx,thrKx,Kxm);
KyCell = valFltr(Ky,thrKy,Kym);
KzCell = valFltr(Kz,thrKz,Kzm);
channels = fltrAnd(PVCell,KxCell,KyCell,KzCell);
%
clstr = connectedCells(Grd,channels);
st = cellfun(@(v) length(v), clstr, 'UniformOutput', false);               
chnind = find([st{:}]==max([st{:}]));
chnl = clstr{chnind};
conCell =  find(chnl==max(chnl));
end
