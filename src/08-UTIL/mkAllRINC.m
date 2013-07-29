function [] = mkAllRINC(rlz)
%MKRINC Make RINC Directory
%   mkRINC(rlz) Makes the RINC directory for the realization rlz.
%
%   See also mkAllRINC, pthRINC.

%%
% Path to the listing file of realization names
dN = [enclDir 'DATA/RS/'];
lN = [dN 'realizations.lst'];

fid = fopen(lN,'rt');
while ~feof(fid),
    lin = fgetl(fid);
    if lin~=-1, 
        rlzfN = textscan(lin,'%s');
        rlzfN = char(rlzfN{1});
        [p rlz e] = fileparts(rlzfN);
        mkRINC(rlz);
    end
end
fclose(fid);

end

