function  stp = steps( caseName )
%STPS Run Report Step Information
%   stp = steps(caseName) returns stp, the list of Eclipse report numbers 
%   and time in days outputted from Eclipse run on the case with caseName
%   root name. Only formatted Eclipse output is allowed.
%
%   See also mkRV, rpth.

%%
t = [];no = [];
fN = [rpth(caseName) caseName '.FRSSPEC'];
fid = fopen(fN);
if fid==-1 
    error(['The file ',fN,...
            ' does not exist.']);
end
while ~feof(fid)
    lin = fgetl(fid);
    if lin == -1 
        error(['The file ',fN,...
            ' is not produced properly. It might be empty.']);
    end
    ist = lin(3:6);
    if strcmp(ist,'TIME')
        lin = fgetl(fid);
        t(end+1) = str2num(lin);
        fgetl(fid);
        lin = fgetl(fid);
        data  = textscan(lin,'%f');
        no(end+1) = data{1}(1);
   end
end
stp = struct('time',t,'no',no);
fclose(fid);
end

