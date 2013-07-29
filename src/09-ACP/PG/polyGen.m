function [] = polyGen(nd)
%POLYGEN Polynomial Generator
%   polyGen() generates the polynomial bases to be used for sensitivity and risk  analysis.

%% Load Input Variables
pN = ['/Home/siv16/mas062/prjII/aPC/DATA/' num2str(nd) '/'];
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
MC_Vector_SG = [Brr;Agr;Fts;Bkw];

N= size(MC_Vector_SG,1); %Number of Uncertanties and Design Parameters
d=2; %d-order polynomial
P=factorial(N+d)/(factorial(N)*factorial(d)); %Total number of terms

%Loading Arbitratry Polynomials and Collocation Points 
plyP = [pN 'PolynomialBasis/'];
for i=1:N
    PolynomialBasisFileName(i)=strcat(plyP,{'PolynomialBasis_'},...
        num2str(i),{'.mat'});    
    load(PolynomialBasisFileName{i},'Roots')
    Cpoints(i,:)=Roots;
end

%---------- Digital set of Collocation points combination  / Work with N=5 !!!
%DigitalUniqueCombinations=allcomb(1:d+1,1:d+1,1:d+1,1:d+1,1:d+1);
DigitalUniqueCombinations=allcomb(1:d+1,1:d+1,1:d+1,1:d+1);
%DigitalUniqueCombinations=allcomb(1:d+1,1:d+1,1:d+1);
%DigitalUniqueCotmbinations=allcomb(1:d+1,1:d+1);
for i=1:1:length(DigitalUniqueCombinations) 
    DigitalPointsWeight(i)=sum(DigitalUniqueCombinations(i,:));                 
end
%Sorting of Posible Digital Points Weight
[SortDigitalPointsWeight, index_SDPW]=sort(DigitalPointsWeight);
SortDigitalUniqueCombinations=DigitalUniqueCombinations(index_SDPW,:);
%Ranking relatively mean
for j=1:N    
    temp(j,:)=abs(Cpoints(j,:)-mean(MC_Vector_SG(j,:)));
end
[temp_sort, index_CP]=sort(temp,2);
for j=1:N    
    SortCpoints(j,:)=Cpoints(j,index_CP(j,:));
end
%Mapping of Digital Combination to Cpoint Combination
for i=1:1:length(SortDigitalUniqueCombinations) 
    for j=1:N,
        SortUniqueCombinations(i,j)=SortCpoints(j,SortDigitalUniqueCombinations(i,j));
    end
end
CollocationPointsBase=SortUniqueCombinations(1:P,:);


%----------Hermite Degree Computation
PosibleDegree=0:1:length(Cpoints(1,:))-1;
for i=2:1:N
    PosibleDegree=[PosibleDegree,0:1:length(Cpoints(i,:))-1];    
end
UniqueDegreeCombinations=unique(nchoosek(PosibleDegree,N),'rows');
%Posible Degree Weight Computation
for i=1:1:length(UniqueDegreeCombinations) 
    DegreeWeight(i)=0;
    for j=1:1:N
        DegreeWeight(i)=DegreeWeight(i)+UniqueDegreeCombinations(i,j);
    end
end
%Sorting of Posible Degree Weight
[SortDegreeWeight, i]=sort(DegreeWeight);
SortDegreeCombinations=UniqueDegreeCombinations(i,:);
%Set of MultiDim Collocation Points 
PolynomialDegree=SortDegreeCombinations(1:P,:);



%Z Initialization: space-independet matrix P*P (of Hermite polynomes)
for i= 1:1:P;        
    for j= 1:1:P;   
        Z(i,j)=1;
        for ii=1:1:N; 
            load(PolynomialBasisFileName{ii},'Polynomial');
            Z(i,j)=Z(i,j)*polyval(Polynomial(1+PolynomialDegree(j,ii),length(Polynomial):-1:1),CollocationPointsBase(i,ii));            
        end        
    end
end
polyFile = [pN 'polynomial.mat'];
save(polyFile);
end
