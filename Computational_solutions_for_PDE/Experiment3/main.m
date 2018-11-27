clc,clear
%% 求解算法的输入参数
U=zeros(501,101);
U1=0:0.01:1;
U(1,:)=sin(2*pi()*U1);
h=0.01;tt=0.01;r=tt/(h^2);
%左端追赶法的求解矩阵
a=-r*ones(98,1);b=(1+2*r)*ones(99,1);c=-r*ones(98,1);
d=zeros(99,1);
%% 运行求解
for i=2:501
%构造追赶法右端向量
    for j=2:100
        d(j-1)=f(U(i-1,j),U(i-1,j+1));
    end
 %求U（i，：）
 U(i,2:100)=chase(a,b,c,d);
end
%% 画出解曲图
x=0:0.01:1;
t=0:0.01:5;
[X T]=meshgrid(x,t);
figure(1)
surf(X,T,U)
shading faceted
xlabel('X')
ylabel('T')
zlabel('Uij')
title('Burger方程的数值解曲面')
