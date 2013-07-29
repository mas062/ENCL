function [csRsp,tc] = polyCase(prop,csN)
%POLYCASE Poly Case
%   [csRsp,tc] = polyCase(prop,cs) tunes the polynomial generated based on the input variables for case cs. tc is the corresponding time vector.
% 
%   See also polyTune, polyGen, rspVct, clcAcpPlt.

%%

%% Load data
nds = csN(end-1);
nd = str2num(nds);
pN = ['/Home/siv16/mas062/prjII/aPC/DATA/' nds '/'];

%Load workspace variables
propPolyFile = [pN prop '_tuneNomial.mat'];
load(propPolyFile);
pN = ['/Home/siv16/mas062/prjII/aPC/DATA/' nds '/'];

% Load detailed run results and corresponding collocation values.
[vc,tc,cl] = rspVctInt(prop,nd);
%cl = CollocationPointsBase;
%tc = [0:9];
%vc=[];
%for c=1:P, vc{end+1}=ones(size(tc))*c;end

inv_Z=pinv(Z);
C_Output =[];
for t=1:length(tc),
	for c=1:P,
		temp(c)=vc{c}(t);
   end
   C_Output(1:P,t) = inv_Z*temp';                        
end


vector_SG = cs2col(csN);
close all;


for c= 1:P;
   for v= 1:N;     
   	[PATHSTR,NAME,EXT] = fileparts(PolynomialBasisFileName{v});
		pBfN = [pN 'PolynomialBasis/' NAME EXT];	  	
   	load(pBfN,'Polynomial');
      cs_Poly(v,c)=polyval(Polynomial(1+PolynomialDegree(c,v),length(Polynomial):-1:1),vector_SG(v));
   end
end

for t=1:length(tc) 
	csRsp(t)=0;
	for c=1:P;
		multi=1;
		for v=1:N;          
		    multi=multi*cs_Poly(v,c);
		end             
		csRsp(t)=csRsp(t)+C_Output(c,t)*multi;
	end
end

end
