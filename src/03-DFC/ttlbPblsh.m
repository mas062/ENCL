function [] = ttlbPblsh(varargin)
%TTLBPBLSH Back-up Title Publish Function
%   ttlbPblsh() looks for scenario templates in SCN_TMP folder and publishes
%   the relevant title include file for all the available realizations.
%
%   See also: caseTitle, dataClass.

%%
% List of scenario templates in SCN_TMP folder
dN = [enclDir 'TMP/'];
dL = dir(dN);

%
scnN = [];
for i=4:length(dL)
    if ~isempty(strfind(char(dL(i).name),'.TMP')) &&...
        isempty(strfind(char(dL(i).name),'.TMP~'))
        scnN{end+1} = char(dL(i).name);
    end
end
% If a valid scenario is specified in the varargin, that will be used.
if ~isempty(varargin),
    scn = varargin{1};
    if isScn(scn),
        scnN ={scn};
    end
end
% Publish the title include file
for s=1:length(scnN)
    for f=1:2,
        for i=1:3,
            for j=1:3,
                for k=1:3,
                    for l=1:3,
                        %
                        cls = ['C' num2str(f-1) num2str(i) ...
                            num2str(j) num2str(k) num2str(l)];
                        %
                        rbLst = dir(clsbDir(cls));
                        %
                        for r=1:length(rbLst),
                          rlz =  char(rbLst(r).name);
                          if isRlz(rlz),
                              caseName = nameCase(scnN{s},rlz);
                              csTtl = caseTitle(caseName);
                              mkbSINC(caseName);
                              tfN = [pthbSINC(caseName) caseName ...
                                  '_TITLE.INC'];
                              fid = fopen(tfN,'w');
                              fprintf(fid,'%s \n','TITLE');
                              fprintf(fid,'%s \n',csTtl);
                              fclose(fid);
                          end
                       end
                    end
                end
            end
        end
    end
end

end

