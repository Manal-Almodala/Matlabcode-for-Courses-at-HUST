clc,clear
xi=[-1,1];
t=1:1000;
x=randsample(xi,1000,true);
y=cumsum(x);
plot(t,y)
title('�Գ�����ζ�')
