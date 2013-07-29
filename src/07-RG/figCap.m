function [capStr] = figCap(fig)
%FIGCAP Figure Caption
%   capStr = figCap(fig) takes the figure root name and generates the
%   relative caption text to be included in the  tex file.
%
%   See also texFig.   

%% 
%
cls = fig(6:10);
%
faulted = cls(1);
lobosity = cls(2);
barriers = cls(3);
aggradation = cls(4);
progradation = cls(5);
%
switch faulted
    case '0'
        fltStr ='no';
    case '1'
        fltStr ='yes';
    case 'F'
        fltStr ='changing';  
    otherwise 
        error('Class name in the provided case name is not valid.');
end
%
switch lobosity
    case '1'
        lobStr ='flat';
    case '2'
        lobStr ='one-lobe';
    case '3'
        lobStr ='two-lobes';
    case 'L'
        lobStr ='changing';          
    otherwise 
        error('Class name in the provided case name is not valid.');
end
%
switch barriers
    case '1'
        barStr ='low(10\%)';
    case '2'
        barStr ='medium(50\%)';
    case '3'
        barStr ='high(90\%)';
    case 'B'
        barStr ='changing';          
    otherwise 
        error('Class name in the provided case name is not valid.');
end

%
switch aggradation
    case '1'
        aggStr ='low';
    case '2'
        aggStr ='medium';
    case '3'
        aggStr ='high';
    case 'A'
        aggStr ='changing';          
    otherwise 
        error('Class name in the provided case name is not valid.');
end
%
switch progradation
    case '1'
        proStr ='90';
    case '2'
        proStr ='270';
    case '3'
        proStr ='?';
    case 'P'
        proStr ='changing';          
    otherwise 
        error('Class name in the provided case name is not valid.');
end
%
capStr = ['faulted=' fltStr '/lobosity=' lobStr '/barrier=' barStr ...
    '/aggradation=' aggStr '/progradation=' proStr];
%

end

