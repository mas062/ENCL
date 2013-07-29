function [ Scr ] = SrCO2( scnTmp )
%SRCO2 Co2 Maximum Residual Saturation
%   SrCO2(scnTmp) returns the maximum residual saturation of CO_2 based on
%   the SCAL tables in the scenario template scnTmp.
%
%   See also mkRP.

%%
switch scnTmp,
    case {
    'SCN04','SCN06','SCN07','SCN08','SCN09',...
    'SCN99','SCN98','SCN97','SCN96','SCN95',...
    'SCN94','SCN93','SCN92','SCN91'...
    'SCN89','SCN88','SCN87','SCN86','SCN85',...
    'SCN84','SCN83','SCN82','SCN81'...
    
    }
        Scr = 0.2;
end
%
end

