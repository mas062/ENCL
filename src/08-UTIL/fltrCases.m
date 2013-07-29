function [] = fltrCases(scnTmp,task,dim,sbc)
%FLTRCASES Filtered Cases
%   fltrCases(scnTmp,task,dim,sbc) performs function handle task on the
%   filtered cases related to scenario template scnTmp. This is used to
%   make the functions on cases independent to the data structure. 
%   dim is used to filter the variations along the geological dimensions 
%   from the filtered ones. dim is a vector containing characters '0' to
%   '3' for the fixed dimentions and 'v' for those to be considered as 
%   variable.
%
%   See also allCases.

%%
% Filter the fixed dimensions
if strcmp(dim(1),'v'),fs =1:2;else fs =str2num(dim(1));end
if strcmp(dim(2),'v'),is =1:3;else is =str2num(dim(2));end
if strcmp(dim(3),'v'),js =1:3;else js =str2num(dim(3));end
if strcmp(dim(4),'v'),ks =1:3;else ks =str2num(dim(4));end
if strcmp(dim(5),'v'),ls =1:2;else ls =str2num(dim(5));end
%
for f=fs,
    for i=is,
        for j=js,
            for k=ks,
                for l=ls,
                    cls =['C' num2str(f-1) num2str(i) num2str(j)...
                         num2str(k) num2str(l)];
                    rLst = dir(clsDir(cls));
                    for lst=1:length(rLst)
                        rlz = char(rLst(lst).name);
                        if  isRlz(rlz),
                            if findstr(rlz,sbc),
                                caseName = nameCase(scnTmp,rlz);
                                task(caseName);
                            end
                        end
                    end
                end
            end
        end
    end
end
end

