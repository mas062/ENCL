function [hast] = isZip(scnTmp)
global hast;
hast =[];
h =@(x) task(x);
allCases(scnTmp,h);
end
function [] = task(x)
global hast;
zipbN = [pthbSCN(x) x '_RST.tar.gz'];
hast(1+end) = exist(zipbN,'file');
if ~hast(end), display(x); end
end