clc,clear
%% ����㷨���������
U=zeros(501,101);
U1=0:0.01:1;
U(1,:)=sin(2*pi()*U1);
h=0.01;tt=0.01;r=tt/(h^2);
%���׷�Ϸ���������
a=-r*ones(98,1);b=(1+2*r)*ones(99,1);c=-r*ones(98,1);
d=zeros(99,1);
%% �������
for i=2:501
%����׷�Ϸ��Ҷ�����
    for j=2:100
        d(j-1)=f(U(i-1,j),U(i-1,j+1));
    end
 %��U��i������
 U(i,2:100)=chase(a,b,c,d);
end
%% ��������ͼ
x=0:0.01:1;
t=0:0.01:5;
[X T]=meshgrid(x,t);
figure(1)
surf(X,T,U)
shading faceted
xlabel('X')
ylabel('T')
zlabel('Uij')
title('Burger���̵���ֵ������')
