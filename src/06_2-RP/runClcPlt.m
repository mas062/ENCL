function [ ] = runClcPlt(scn)
%RUNCLCPLT Run Cases Caluculate Plot
%   runClcPlt(cn) does the plot vectors calculations for the 
%   already run cases of scenario scn. 
%

%%
cmd = ['cp ' enclDir 'LOG/' scn '_runs.lst ' ...
    enclDir 'LOG/' scn '_2bclc.lst'];system(cmd);
%
runLog = [enclDir 'LOG/' scn '_2bclc.lst'];
clcLog = [enclDir 'LOG/' scn '_clc.lst'];
fid = fopen(runLog,'rt');
%
while ~feof(fid),
    lin = fgetl(fid);
    if ~isempty(lin),
        cs = textscan(lin,'%s');
        cs = char(cs{1});
        if isCase(cs),
            doClc = true;
            c = 'dummy';
            fld = fopen(clcLog,'rt');
            while ~feof(fld),
                l = fgetl(fld);
                if ~isempty(l),
                    t = textscan(l,'%s');
                    c = char(t{1});
                end
                doClc = doClc * ~strcmp(cs,c);
            end
            fclose(fld);
            if doClc, 
                clcPlt(cs);
                rmbRst(cs);
            end
        end
    end
end
%
fclose(fid);
%
end

