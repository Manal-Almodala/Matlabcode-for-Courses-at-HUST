clc,clear
%% 输入参数准备
a=0;b=10;y0=[1 exp(1)]';d=2;h=0.01;
%% Radau2
Radau2a(a,b,y0,d,h);
%% adams
adams(a,b,y0,d,h);