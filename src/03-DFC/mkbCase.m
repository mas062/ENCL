function [] = mkbCase( scnTmp,rlz )
%MKBCASE  Make Back-up Case Function
%   mkbCase(scnTmp,rlz) takes the scenario template scnTmp and
%   realization rlz and builds the relevant Eclipse data file.
%
%   See also mkScn, mkRL, dataClass.

% Write new case file 
caseName = nameCase(scnTmp,rlz);
mkbSCN(caseName);
% Data File name
fbN_DATA = [pthbSCN(caseName) caseName '.DATA'];
[cid msg] = fopen(fbN_DATA,'wt');
% Template full name
tmpN = [enclDir 'TMP/' scnTmp(1:5)...
     '.TMP'];
[fid, msg] = fopen(tmpN, 'rt');

% Loop into template file
while ~feof(fid),
    lin = fgetl(fid);
    if lin==-1
        error('Problem in reading the template file!');
    end
    if ~isempty(lin),
        kw = textscan(lin,'%s');
        fkw = char(kw{1});
    else
        fkw=[];
    end
%    
    if ~isempty(strmatch('${',fkw)),
        lin = fgetl(fid);
        if ~isempty(lin),
            kw = textscan(lin,'%s');
            fkw = char(kw{1});
            else
                fkw=[];
        end            
%            
        while isempty(strmatch('}$',fkw)) && ~feof(fid),
            if ~isempty(fkw),
                kfN = [pthVAR(rlz) rlz '_' fkw '.INC'];
                kwPth = ['''../../VAR/' rlz '_' fkw '.INC''/'];
                if strcmp(fkw,'TITLE'),
                    mkSINC(caseName);
                    kfN = [pthbSINC(caseName) caseName '_' fkw '.INC'];
                    kwPth = ['''../SINC/' caseName '_' fkw '.INC''/'];
                end
                if exist(kfN,'file'),
                    fprintf(cid,'%s \n','INCLUDE');
                    fprintf(cid,'%s \n',kwPth);                    
                    display(['keyword ' fkw ...
                    ' has been appended for case ' caseName]);
                else
                    display(['keyword ' fkw ...
                    ' doesn''t exist for case ' caseName]);
                end
            end
            lin = fgetl(fid);
            if ~isempty(lin),
                kw = textscan(lin,'%s');
                fkw = char(kw{1});
            else
                fkw=[];
            end
        end
    else
        fprintf(cid,'%s \n',lin);
    end
end
fclose(cid);
fclose(fid);
end
