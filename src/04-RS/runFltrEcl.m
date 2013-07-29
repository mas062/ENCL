function [] = runFltrEcl(scnTmp,dim,sbc)
%RUNFLTRECL Run Filtered Eclipse Models
%   runFltrEcl(scnTmp) Submits runs to Eclipse for filtered the generated
%   cases relevant to scnTmp scenario template. 
%
%   See also mkCase, mkEcl, runEcl, mkFltrCase, fltrCases.

%%
h =@(x) task(x);
fltrCases(scnTmp,h,dim,sbc);
%
end
function [] = task(caseName)
    if runIt(caseName), 
        runEcl(caseName);
        if runOk(caseName),
            logLst(caseName,'runs');
        end
    else
        msg = ['Run is not submitted for case ' caseName ...
            ', explore previous log reports for this case.'];
        display(msg);
        logIt(msg);
        return
    end
%     if apreIt(caseName),
%         apreRun(caseName);
%         itsApre(caseName);
%     end

%TEMPORARIL`Y ADDED
%% Zip Data
% Zip restart files
zipRst(caseName);
% Remove restarts
rmRst(caseName);

%% Make Backup
% Back up the run folder
%bkSt = bkCase(caseName);

%% Remove Zipped Data
%
%%if bkSt == 0,
%%    logLst(caseName,'bk');  
%%    rmRun(caseName);
%
%
%TEMPORARILY ADDED
%    msg = ['Zip data, make backup and remove zipped for case ' caseName ...
%                'are done.'];
%    display(msg);
%    logIt(msg);
end
end
