x=[0:0.01:1];
y=[0:0.01:1];
[X,Y] = meshgrid(x,y);
sigma = 0.01;
S = exp(-((sin(10*X)-0.5).^2+(sin(10*Y)-0.5).^2)/sigma)/(2*pi*sigma^2);
surf(X,Y,S);
