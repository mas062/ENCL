function [ nd ] = kpdg(n,d)
%KPDG Keep Digits
%   kpdg(n,d) keeps the d digit format of number n. For example, if n=3 and
%   d=2 then kpdg(3,2) returns '03'. This is used for naming means to keep
%   the lenght of names fixed.
%
%   See also saveFig.

%%
%
nd = [repmat(num2str(0),1,d-length(num2str(n))) num2str(n)];

end

