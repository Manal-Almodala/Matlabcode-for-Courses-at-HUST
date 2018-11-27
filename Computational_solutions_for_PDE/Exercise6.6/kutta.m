function z=kutta( a , b , y0 , d , h)
%a 为时间起点 ，b 为时间终点， y0为初值， d=为方程相空间维数
A=[0 0 0; 1/2 0 0 ; -1 2 0];
c=[0 1/2 1]';
B=[1/6 2/3 1/6]; 
t0=a;
for n=a+h : h : b
t1=t0+c(1)*h; t2=t0+c(2)*h; t3=t0+c(3)*h;
Y1=y0; Y2=y0+h*kron(A(2,1),eye(d))*f(t1,Y1);
Y3=y0+h*kron(A(3,1:2),eye(d))*[f(t1,Y1);f(t2,Y2)];
y1=y0+h*kron(B(1:3),eye(d))*[f(t1,Y1);f(t2,Y2);f(t3,Y3)];
t0=t0+h; y0=y1;
end

