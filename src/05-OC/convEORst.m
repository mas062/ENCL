function [] = convEORst(caseName)
%CONVEORST Convert End Of Restarts
%   convEORst(caseName) converts selected restart files for end of 
%   injection and end of simulation time.
%
%   See also conEclRst.

%%
%%
msg = ['Converting Selected Eclipse restart output for case ' caseName];
display(msg);
logIt(msg);
%
fN = [pthSCN(caseName) caseName];
%
if exist([fN '.FRSSPEC'],'file'),
    [smry rst_raw] = readEclipseResults(fN,'files_out',false);
%    
    [smryEOI,rstEOI] = eOI(smry,rst_raw);
%
    
%
    rst = struct('times',rst_raw.times, ...
                 'PRESSURE' , {{rst_raw.PRESSURE{rstEOI}};  ...
                                {rst_raw.PRESSURE{end}}},   ...
                 'SWAT'     , {{rst_raw.SWAT{rstEOI}};      ...
                                {rst_raw.SWAT{end}}});
%
    mkVCT(caseName);
    fN_MAT = [pthVCT(caseName) caseName '_EORST.mat'];
%
% Default M-File version must be set already to v7.3 from Preference
% window in command window menu.
    save(fN_MAT, 'rst');
else
    msg = ['Restart file(s) not found for ' caseName];
    display(msg);
    logIt(msg);
end


end

