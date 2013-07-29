function [rinc_path] = pthRINC(rlz)
%PTHRINC Path To RINC Folder
%   [rinc_path] = pthRINC(rlz) takes the realization name rlz and returns
%   rinc_path, the path to the folder RINC. RINC is folder of files to be
%   included in Eclipse model specific to realization rlz.
%
%   See also pthCINC;
cls = rlz2cls(rlz);
rinc_path = [enclDir 'CLS/' cls '/' rlz '/RINC/'];

end

