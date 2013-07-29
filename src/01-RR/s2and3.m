fn=[];
for f = 1:1,
    for p = 1:2, 
        for a =[2,1,3], 
            for l = 1:3
                for b = 1:3
                    fn{end+1} = ['R_C' num2str(f-1) num2str(l)...
                         num2str(b) num2str(a) num2str(p)];
                end
            end
        end
    end
end

for cn = 10:54
    cmd = ['mv ' num2str(cn) '.* ' fn{cn} '.*'];
    system(cmd);
end
for cn = 10:54
    cmd = ['mv ' fn{cn} '.grdecl ' fn{cn} '_SC001.grdecl '];
    system(cmd);
end