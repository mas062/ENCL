function [ Cpoints] = fndCln(nd)
%fndCln Find Collocations
%   fndCln(plnDgr) loads the input variables and finds the
%   collocation points. The polynomial degree is 2.
%
%   See also inVar.

%% Load Input Variables
pN = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
if ~exist(pN,'dir'), system(['mkdir ' pn]);end

%vN = [pN 'varN.mat'];
vN1 = [pN 'Brr_' num2str(nd) '.mat'];
vN2 = [pN 'Agr_' num2str(nd) '.mat'];
vN3 = [pN 'Fts_' num2str(nd) '.mat'];
vN4 = [pN 'Bkw_' num2str(nd) '.mat'];
%
%load(vN,'varName');
load(vN1,'Brr');
load(vN2,'Agr');
load(vN3,'Fts');
load(vN4,'Bkw');
%
%%
N= 4; %Number of Uncertanties and Design Parameters
d=2; %d-order polynomial
P=factorial(N+d)/(factorial(N)*factorial(d)); %Total number of terms

MC_Vector_SG = [Brr;Agr;Fts;Bkw];

%Computation of Arbitratry Polynomials 
plyP = [pN 'PolynomialBasis/'];
system(['mkdir ' plyP]);
for i=1:N
    PolynomialBasisFileName(i)=strcat(plyP,{'PolynomialBasis_'},...
        num2str(i),{'.mat'});    
    aPoly_Construction(MC_Vector_SG(i,:), d, PolynomialBasisFileName{i});
end

%Initialization of Collocation points
for i=1:N
    load(PolynomialBasisFileName{i},'Roots')
    Cpoints(i,:)=Roots;
end
save([pN 'Cpoints_' num2str(nd) '.mat'],'Cpoints');

end

