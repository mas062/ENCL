function [] = barIt(Z)
%BARIT Bar It
%   Draws bar chart, with different colors for negative and positive
%   values. 
%
%

%%
x = find(Z>=0);
y = find(Z<0);
X = Z(x);
Y = Z(y);
figure();
hold on;
barh(x,X,'g');
barh(y,Y,'r');
%
end