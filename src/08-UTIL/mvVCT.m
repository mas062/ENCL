function [] = mvVCT(scnF,scnT)
%MVVCT Move VCT
%   mvVCT(scnF,scnT) moves the SCN folder for all cases of scenario scnF to
%   scnT. 
%
%   See also mvScn.
%

%%
global tilScn;
tilScn = scnT;
h =@(x) task(x);
allCases(scnF,h);
%
end
%
function [] = task(caseName)
    global tilScn;
    scnF = case2scn(caseName);
    scnT = tilScn;
    csbF = caseName;
    csbT = strrep(csbF,scnF,scnT);
%
    frbD = pthbVCT(csbF);
    tobD = pthbVCT(csbT);
    mkbVCT(csbT);
%
    dL = dir(frbD);
    for i = 1:size(dL),
        fName = char(dL(i).name);
        [pth rName ext] = fileparts(fName);
        nrName = strrep(rName,scnF,scnT);
        frN = [frbD rName ext];
        toN = [tobD nrName ext];
        cmd = ['cp -r ' frN ' ' toN]; 
        if ~exist(toN,'file'),
            system(cmd);            
            display(['copying ' rName ' to ' nrName '...']);
        else 
            display(['skipped ' nrName '...']);
        end
    %
%         cmd = ['cp -r ' frbD '* ' tobD]; system(cmd);
    %
%         cmd = ['rm -r ' frbD '*']; system(cmd);
    %  
    end
end


