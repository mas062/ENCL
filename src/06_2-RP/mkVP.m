function [] = mkVP(scnTmp,dim)
%MKVP Make Variation Plot
%   mkVP(scnTmp,dim) plots the result comparison of cases with variational
%   paramete in the dimention dim. For example dim=1 is for fault parameter
%   which varies between 0 and 1, as for faulted and not faulted.
%
%   See also mkCP.

%%
%
global clsCol;
%
clsCol = [];
cases = [];
%
vmin = 1;
vmax = 3;
yesDo = true;
%
switch dim,
    case 1
        vmin = 0;
        vmax = 1;
        letter = 'F';
        fld = 'FLT';
    case 2
        letter = 'L';
        fld = 'LOB';
    case 3
        letter = 'B';
        fld = 'BRR';
    case 4
        letter = 'A';        
        fld = 'AGR';
    case 5
        vmin = 1;
        vmax = 2;
        letter = 'P';
        fld = 'PRG';
    otherwise
        yesDo = false;
        display('Not valid dimension, nothing will be done by mkRV :-)');
end
if yesDo,
    %
    allCases(scnTmp,@task);
    %
    redClsCol = cellfun(@(x) shrnk(x,dim), clsCol, 'UniformOutput',false);
    %
    grps = unique(redClsCol);
    %
    for g=1:length(grps),
        rg = grps{g};
        lg = rg;
        lg(dim+1) = letter;
        cases = [];
        for i=vmin:vmax,
            rg(dim+1) =num2str(i);
            cases{1+end} = rg;
        end
        %
        mkCP(lg, fld , cases{:});
        %
    end
end    
end
%%
function [] = task(cs)
%
global clsCol;
clsCol = [clsCol;{cs}];
%
end
%%
function [csh] = shrnk(cs,dim)
%
csh = cs;
csh(dim+1) = '0';
%
end