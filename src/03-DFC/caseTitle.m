function [ csTtl ] = caseTitle( caseName )
%CASETITLE Case Title Construction
%   caseTitle(caseName) takes the caseName and produces the title text
%   csTtl. This can be used in reportings or in simulation model
%   constructions(e.g. following keyword TITLE in Eclipse data file).
%
%   See also ttlPblsh, dataClass.

cls = case2cls(caseName);
sbc = case2sbc(caseName);
scn = case2scn(caseName);
%
faulted = cls(2);
lobosity = cls(3);
barriers = cls(4);
aggradation = cls(5);
progradation = cls(6);
%
switch faulted
    case '0'
        fltStr ='not faulted';
    case '1'
        fltStr ='faulted';
    otherwise 
        error('Class name in the provided case name is not valid.');
end
%
switch lobosity
    case '1'
        lobStr ='flat shoreline';
    case '2'
        lobStr ='one lobe';
    case '3'
        lobStr ='two lobes';
    otherwise 
        error('Class name in the provided case name is not valid.');
end
%
switch barriers
    case '1'
        barStr ='low barriers';
    case '2'
        barStr ='medium barriers';
    case '3'
        barStr ='high barriers';
    otherwise 
        error('Class name in the provided case name is not valid.');
end

%
switch aggradation
    case '1'
        aggStr ='low aggrd';
    case '2'
        aggStr ='med aggrd';
    case '3'
        aggStr ='high aggrd';
    otherwise 
        error('Class name in the provided case name is not valid.');
end
%
switch progradation
    case '1'
        proStr ='90^ prgrd';
    case '2'
        proStr ='270^ prgrd';
    case '3'
        proStr ='?^ prgrd';
    otherwise 
        error('Class name in the provided case name is not valid.');
end
%

sbClsStr = ['sub-class ' sbc];
% switch sbc
%     case 'SC001'
%         sbClsStr = 'middle subclass';
%     otherwise 
%         error('Sub class name in the provided case name is not valid .');        
% end

%

% switch caseScenario
%     case '01'
%         scnStr = 'One flank injector, sealing side fault';
%     otherwise 
%         error('Scenario name in the provided case name is not valid .');        
% end

csTtl = ['Scen ' scn(4:end) ', ' fltStr ', ' ...
    lobStr ', ' barStr ', ' aggStr ', ' proStr ...
    ' and subclass ' sbc(3:end) '.'];
end

