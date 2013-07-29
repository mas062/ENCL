%clear all;
%General Polinomials
function P = aPoly_Construction(Data, Degree, Poly_FileName)
% Input pparameters:
% Data - data array
% Degree - maximal degree of basis
% Poly_FileName

%----- Initialization
d=Degree; %Degree of polinomial expansion
dd=d+1; %Degree of polinomial for roots defenition
L_norm=1; % Lnorm for polnomila normalization
N_hist=100; %Number of histo-bars for data visualisation    
NumberOfDataPoints=length(Data);

fprintf('\n');
fprintf('---> Construction of Arbitrary Polynomil Basis \n');

%Forward linear transformation (Avoiding of numerical problem):
MeanOfData=mean(Data);
Data=Data/MeanOfData;

%---------------------------------------------------------------------------------------------- 
%----- Moments compuatation
%----------------------------------------------------------------------------------------------
%Moments Computation for Input Data
for i=0:(2*dd+1)
    %Raw Moments
    m(i+1)=sum(Data.^i)/length(Data);
end

%---------------------------------------------------------------------------------------------- 
%----- Main Loop for Polinomial with degree up to dd
%---------------------------------------------------------------------------------------------- 

for degree=0:dd;
    %Defenition of Moments Matrix Mm
    for i=0:degree;
        for j=0:degree;                    
            if (i<degree) 
                Mm(i+1,j+1)=m(i+j+1); 
            end            
            if (i==degree) && (j<degree)
                Mm(i+1,j+1)=0;
            end
            if (i==degree) && (j==degree)
                Mm(i+1,j+1)=1;
            end        
        end
        %Numerical Optimization for Matrix Solver
        %Mm(i+1,:)=Mm(i+1,:)/Mm(i+1,i+1);
        Mm(i+1,:)=Mm(i+1,:)/max(abs(Mm(i+1,:)));
    end
    %Defenition of Right Hand side ortogonality conditions: Vc
    for i=0:degree;
        if (i<degree) 
             Vc(i+1)=0; 
        end            
        if (i==degree)
            Vc(i+1)=1;
        end
    end
      
    
    %Solution: Coefficients of Non-Normal Orthogonal Polynomial: Vp
    inv_Mm=pinv(Mm);
    Vp = inv_Mm*Vc';
    PolyCoeff_NonNorm(degree+1,1:degree+1)=Vp';   
    
    %Alternative
    %inv_Mm=pinv(Mm(1:degree,1:degree));
    %Vp(1:degree) = inv_Mm*Vc(1:degree)';
    %Vp(degree+1)=1;
    %PolyCoeff_NonNorm(degree+1,1:degree+1)=Vp';
    
    fprintf('---> Computational Error for Polynomial of degree %1i is: %5f pourcents',degree, 100*abs(sum(abs(Mm*PolyCoeff_NonNorm(degree+1,1:degree+1)'))-sum(abs(Vc)))); 
    if 100*abs(sum(abs(Mm*PolyCoeff_NonNorm(degree+1,1:degree+1)'))-sum(abs(Vc)))>0.5
        fprintf('\n---> Attention: Computational Error too hi !');    
        fprintf('\n---> Problem: Convergence of Linear Solver');  
    end
    fprintf('\n');
    

    %Original Numerical Normalization of Coefficients with Norm and Ortho-normal Basis computation
    %Matrix Sorrage Notice: Polynomial(i,j) correspont to coefficient number "j-1" of polinomil degree "i-1"
    P_norm=0;
    for i=1:NumberOfDataPoints;        
        Poly=0;
        for k=0:degree;
            Poly=Poly+PolyCoeff_NonNorm(degree+1,k+1)*Data(i)^k;     
        end
        P_norm=P_norm+Poly^2/NumberOfDataPoints;        
    end
    P_norm=sqrt(P_norm);
    for k=0:degree;
        Polynomial(degree+1,k+1)=PolyCoeff_NonNorm(degree+1,k+1)/P_norm;
    end
    
    %No norm:     
    %Polynomial(degree+1,:)=PolyCoeff_NonNorm(degree+1,:);
    
    %+++
    %PolyCoeff_NonNorm(degree+1,:)=Polynomial(degree+1,:);    
    %Normalization of Coefficients with L norm "norm": Ortho-normal Basis computation
    %Matrix Sorrage Notice: Polynomial(i,j) correspont to coefficient number "j-1" of polinomil degree "i-1" 
    %P_norm=0;
    %for j=1:degree+1;
    %    P_norm=P_norm+abs(PolyCoeff_NonNorm(degree+1,j))^L_norm;     
    %end
    %for j=1:degree+1;
    %    Polynomial(degree+1,j)=PolyCoeff_NonNorm(degree+1,j)/(P_norm^(1/L_norm));
    %end
    
end

%Backward linear transformation (To real data space)
Data=Data*MeanOfData;
for k=1:length(Polynomial);
    Polynomial(:,k)=Polynomial(:,k)/MeanOfData^(k-1);
end

%---------------------------------------------------------------------------------------------- 
%----- Roots of polinomial and Plot
%----------------------------------------------------------------------------------------------

%Roots of polynomial with degree dd=d+1
Roots=roots(fliplr(Polynomial(dd+1,:)));
P = Roots;
save(Poly_FileName);
