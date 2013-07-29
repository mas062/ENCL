function [] = mvScn(scnF,scnT)
%MVSCN Move Scenario
%   mvScn(scnF,scnT) moves the SCN folder for all cases of scenario scnF to
%   scnT. 
%
%   See also yourself in the mirror :)
%

%%
global tilScn;
tilScn = scnT
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
    frbD = pthbSCN(csbF);
    tobD = pthbSCN(csbT);
%
    dL = dir(frbD);
    if size(dL,1)>10,
        for i = 1:size(dL),
            fName = char(dL(i).name);
            [pth rName ext] = fileparts(fName);
            nrName = strrep(rName,scnF,scnT);
            frN = [frbD rName ext];
            toN = [tobD nrName ext];
            cmd = ['yes | mv ' frN ' ' toN]; system(cmd);
        end
    %
        cmd = ['cp -r ' frbD '* ' tobD]; system(cmd);
    %
        cmd = ['rm -r ' frbD '*']; system(cmd);
    %  
    end
end


