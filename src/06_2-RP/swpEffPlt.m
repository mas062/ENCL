function [] = swpEffPlt (dr,mn,mx,varargin)
%% Plot Results for HG_SCN_2 
%  The aim is to make draft starting work for making the reporting
%  template.
% rN1: Root name and path address of case 1
% rN2: Root name and path address of case 2
% dr : direction of slices, one of {'i','j','k'} elements.
% mn and mx: minimum and maximum of CO_2 saturation to define the plume.


%% Load Data from Eclipse Output
%
rN=[];S=[];stp=[];G=[];
for i=1:length(varargin)
        rN{1+end} = [rpth(char(varargin(i))) char(varargin(i))];
%
        fN_MAT = [char(rN{end}), '.mat'];
        if ~exist(fN_MAT,'file')
            convEclData(char(varargin(i)));
        end
        load(fN_MAT);
        S{end+1} = SCO_2;
        G{end+1} = Grd;
%
        stp = steps(char(varargin(i)));
        if (i>1) && (numel(stp)>numel(steps(char(rN{end-1}(end-18:end)))))
            stp = steps(char(rN{end-1}(end-18:end)));
        end
        
end

%%
sfreq = floor(0.1*stp.no(end));
%

for i=1+sfreq:sfreq:length(stp.no)
SWE=[];Nm=[];
    for j =1:length(varargin)
        SWE{end+1} = sliceSwpEff(G{j},S{j}{i},mn,mx,dr,1);
        [N X]=hist(SWE{end});
        Nm(end+1) = max(N);
    end
%    
    ceiling = max(Nm);
%    stopped here, need to make a function for subplot 211...
    figure;
    for j=1:length(varargin)
        subplot(sbPltInd(length(varargin),j));
        hist(SWE{j},10);
        v1 = SWE{j}(find(~isnan(SWE{j})));
        mv1 = mean(v1);
        dv1 = median(v1);
        caseTitle = [char(varargin(j)) ': ' dr...
            ' slices, Time: ' num2str(stp.time(i)*day/year) '  Years'];
        title(strrep(caseTitle,'_','\_'));
        xlabel(['mean = ' num2str(mv1) '; median = ' num2str(dv1)]);
        axis([0 1 0 ceiling]);
        hold off 
    end
end
end