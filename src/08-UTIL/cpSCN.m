function cmd = cpSCN(cs)
%CPSCN Copy SCN 
%	cpSCN(cs) copies SCN directory for case cs to /scratch/store/ 
%
%	See also pthSCN, extCase.
%
%%
ip = '129.177.32.121';
pth = pthSCN(cs);
stp = ['mas062@' ip ':/runs/DATA/BKUP/store/' cs '/'];
%
cmd = (['rsync -avz ' pth '* ' stp]);
%
end

