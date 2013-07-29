function [] = scnT(nd)
%SCNTMP Scenario Template
%  scnT(nd) Generates the required scenarios for the runs. This is to be
%  modified in order to add dimensions to the study.


pD = ['/Home/siv16/mas062/prjII/aPC/DATA/'];
pN  = [pD num2str(nd) '/'];
psD = [pD num2str(nd) '/ScnTmp/'];
system(['mkdir ' psD]);
%% Load Collocation Points

cpN = [pN 'Cpoints_' num2str(nd) '.mat'];load(cpN);
fs = Cpoints(3,:);
bw = Cpoints(4,:);

%
for i=1:length(fs),
    for j=1:length(bw),
        scn = strcat('SCN_',num2str(i),num2str(j),'.TMP');
        scnN = strcat(psD,scn);
        tmpsN = [pD 'scn.tmp'];
        %open files
        % to write
        [cid msg] = fopen(scnN,'wt');
        % to read
        [fid, msg] = fopen(tmpsN, 'rt');
        %
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
            if ~isempty(strmatch('$<',fkw)),
                lin = fgetl(fid);
                if ~isempty(lin),
                    kw = textscan(lin,'%s');
                    fkw = char(kw{1});
                else
                    fkw=[];
                end            
                %            
                while isempty(strmatch('>$',fkw)) && ~feof(fid),
                    if ~isempty(fkw),
                        switch fkw,
                            case 'MULTFLT',
                                fprintf(cid,'%s \n',fkw);
                                fprintf(cid,'%s \n',['''*'' '...
                                    num2str(fs(i)) ' /']);
                                fprintf(cid,'%s \n',' /');
                            case 'AQUCHWAT',
                                aq1=['1 2340.0 ''PRESSURE'' '...
                                    num2str(bw(j))  ' 2.0E9 1 /'];
                                aq2=['2 0.0 ''PRESSURE'' '...
                                    '45.0 2.0E9 1 /'];
                                fprintf(cid,'%s \n',fkw);
                                fprintf(cid,'%s \n',aq1);
                                fprintf(cid,'%s \n',aq2);
                                fprintf(cid,'%s \n',' /');
                        end
                        %
                        display(['keyword ' fkw ...
                        ' has been appended to the template ' scn]);
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
        fclose(fid);
        fclose(cid);
    end
end

end

