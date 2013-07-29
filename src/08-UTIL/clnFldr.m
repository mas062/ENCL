function [] = clnFldr(fldr)
%CLNFLDR Clean Folder
%  clnFldr(fldr) removes all the files in the called folder fldrName and all
%  of the folders of thesame name in different cases.
%
%  See also mkScn.

%%
nc = 

for i=1:3
    for j=1:3
        for k=1:3
            for l=1:3
                for f=1:1
                    rlzDir =[enclDir 'DATA/CLS/C' num2str(f-1) num2str(i) ...
                        num2str(j) num2str(k) num2str(l)  ...
                                                '/R_C' num2str(f-1) num2str(i) ...
                        num2str(j) num2str(k) num2str(l)  ...
                        '_SC01/'];

                       % '/'];
                    cmd =['mkdir ' rlzDir ];
                    system(cmd);
                end
            end
        end
    end
end





end

