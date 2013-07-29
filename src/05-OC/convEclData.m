function [ ] = convEclData(rN )
%CONVECLDATA Convert Eclipse Data
%   convEclData(rN) takes the case root name rN and loads, converts and
%   saves the Eclipse data outputs into a format available for plot and
%   visualization in a .mat file with the same root name in the directory
%   of run.
%
%   See also convAllEcl, rsltPlot, rsltCompare, steps, rpth.

%%
display(['Converting Eclipse output for case ' rN]);
% Static Data
%
% Grid
fN = [rpth(rN) rN];
fN_DATA = [fN '.DATA'];
G = readGRDECL(fN_DATA);
Grd = processGRDECL(G);
Grd = computeGeometry(Grd(1));
PermX = G.PERMX/darcy;
PermY = G.PERMY/darcy;
PermZ = G.PERMZ/darcy;
Poro  = G.PORO;
Rock = struct('Poro',Poro,'PermX',PermX,'PermY',PermY,'PermZ',PermZ);

% Init File
fN_INIT = [fN '.FINIT'];
if exist(fN_INIT,'file')
        init = readEclipseOutput(fN_INIT);
        MultX = init.MULTX.values; 
        MultY = init.MULTY.values; 
        MultZ = init.MULTZ.values; 
        PORV  = init.PORV.values;
        TRANX = init.TRANX.values;
        TRANY = init.TRANX.values;
        TRANZ = init.TRANX.values;        
end

% Dynamic Data

stp =steps(rN);

SCO_2 = [];Press = [];
fieldnames = {'PRESSURE','SWAT'};
EOI = 13;
EOS = length(stp.no);
dyn =[EOI, EOS]; 
for i = 1:2,
    s = '0000';
    si = num2str(stp.no(dyn(i)));
    rptN = [s(1:(length(s)-length(si))) si];
    fN_F = [fN '.F' rptN];
    if exist(fN_F,'file')
%        sol = readEclipseOutput(fN_F);
        sol = readSelectedEclipseOutput(fN_F,fieldnames);        
        SCO_2{1+end} = (1-sol.SWAT.values);
        Press{1+end} = sol.PRESSURE.values; 
    end
end

%fN_MAT = [fN '.MAT'];
save(fN, 'Grd', 'Rock','SCO_2','Press','MultX','MultY','MultZ');

end

