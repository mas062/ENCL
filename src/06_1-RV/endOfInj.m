function [ eoiStep ] = endOfInj( caseName )
%endOfInj End Of Injection
%   endOfInj(caseName) extracts end of injection time step from the case
%   run output specified by caseName.
%
%   See also mkRV.

%%
fN = [rpth(caseName) caseName];
wellData = readEclipseResults(fN)



end

