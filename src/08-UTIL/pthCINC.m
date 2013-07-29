function [cinc_path] = pthCINC(cls)
%PTHCINC Path To CINC Folder
%   [cinc_path] = pthCINC(cls) takes the class name cls and returns
%   cinc_path, the path to the folder CINC. CINC is folder of files to be
%   included in Eclipse model specific to class cls.
%
%   See also pthVAR;

cinc_path = [enclDir 'CLS/' cls '/CINC/'];

end

