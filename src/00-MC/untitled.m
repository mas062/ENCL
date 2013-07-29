dd = dir;
for i = 4:length(dd),
    fN = dd(i).name;
    [p,f, s] = fileparts(fN)
    cmd = ['mv ' fN ' C01122_SC001_SCN04'   s];
    system(cmd);
end