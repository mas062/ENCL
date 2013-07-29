function [ ] = rstInd2plt(caseName)
%RST2PLT Restart to Plot
%   rst2plt(caseName) adds the report time index from rst vectors to the
%   plot mat file corresponding to case caseName.
%
%   See also, clcPlt.

%%
fN_PLT = [pthVCT(caseName) caseName '_PLT.mat'];
fN_RST = [pthVCT(caseName) caseName '_RST.mat'];
%
plt =exist(fN_PLT,'file');
rSt =exist(fN_RST,'file');
%
if plt && rSt,
    %
    load(fN_RST);  
    %
    ti = rst.timeindex';
    save(fN_PLT,'ti','-append');
    msg = ['Time index added to PLT successfully for ' caseName '.'];
    display(msg);
    logIt(msg);
    %
else
    %     
   msg = ['PLT/RST mat file not available for ' caseName '!'];
    display(msg);
    logIt(msg);
    %
end


end

