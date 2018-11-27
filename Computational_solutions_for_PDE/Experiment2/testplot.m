%画图测试
%精确解的图
N=64;
Z=zeros(N+1,N+1);
for i=1:(N+1)
    for j=1:(N+1)
        Z(i,j)=z((j-1)/N,(i-1)/N); 
    end
end
U=zeros(N-1,N-1);
for i=1:N-1
    for j=1:N-1
        U(i,j)=X5(p2(i,j));
    end
end
U=[zeros(N-1,1) U zeros(N-1,1)];
U=[zeros(1,N+1);U;zeros(1,N+1)];
x=0:1/N:1;
y=x;
[X Y]=meshgrid(x,y);
figure(1)
surf(X,Y,U)
shading faceted
xlabel('X')
ylabel('Y')
zlabel('Uij')
title('共轭梯度法的数值解曲面')
err=abs(U-Z);
figure(2)
surf(X,Y,err)
shading faceted
figure(3)
surf(X,Y,Z)
shading faceted