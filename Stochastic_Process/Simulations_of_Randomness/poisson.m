clc,clear
s=1:10;             %状态
t=exprnd(4,1,10);   %生成参数为4的指数分布的10个随机数
w=cumsum(t);        %给出 t的累加和
stairs(w,s,'c');    %画出阶梯图形，红色实线条
title('Poisson过程参数为4'); 