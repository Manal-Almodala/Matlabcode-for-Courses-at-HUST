%主程序，
%% 迭代格式的标准化
clc,clear
N=64;
%给划分排序
p=zeros(N-1,N-1);
for i=1:(N-1)
    for j=1:(N-1)
        if i+j<=N
            p(N-i,j)=(i+j-1)*(i+j-2)/2+i;
        else
            p(N-i,j)=(N-1)^2-(N-1-i+(2*N-(i+j)-1)*(2*N-(i+j)-2)/2);
        end
    end
end
p2=zeros(N-1,N-1);
for i=1:N-1
    p2(i,:)=p(N-i,:);
end
A=zeros((N-1)^2,(N-1)^2);
b=zeros((N-1)^2,1);
%构造A与b
for i=1:N-1
    for j=1:N-1
        b(p2(i,j))=f(j/N,i/N)/(N^2);
        A(p2(i,j),p2(i,j))=-4;
        if i>1
        A(p2(i,j),p2(i-1,j))=1;
        end
        if j>1
        A(p2(i,j),p2(i,j-1))=1;
        end
        if i<N-1
        A(p2(i,j),p2(i+1,j))=1;
        end
        if j<N-1
        A(p2(i,j),p2(i,j+1))=1;
        end
    end
end
%构造L,D,U
L=zeros((N-1)^2,(N-1)^2);
D=zeros((N-1)^2,(N-1)^2);
U=zeros((N-1)^2,(N-1)^2);
for i=1:(N-1)^2
    for j=1:(N-1)^2
        if i>j
            L(i,j)=A(i,j);
        else if i==j
                D(i,j)=A(i,j);
            else
                U(i,j)=A(i,j);
            end
        end
    end
end
%构造ADI所需的A1，A2,b1
A1=zeros((N-1)^2,(N-1)^2);
A2=zeros((N-1)^2,(N-1)^2);
h1=-N^2;h2=2*N^2;
for i=1:N-1
    for j=1:N-1
        A1(p2(i,j),p2(i,j))=h2;
        A2(p2(i,j),p2(i,j))=h2;
        if i>1
        A2(p2(i,j),p2(i-1,j))=h1;
        end
        if j>1
        A1(p2(i,j),p2(i,j-1))=h1;
        end
        if i<N-1
        A2(p2(i,j),p2(i+1,j))=h1;
        end
        if j<N-1
        A1(p2(i,j),p2(i,j+1))=h1;
        end
    end
end
b1=-b*(N^2);
%精确解
Z=zeros(N+1,N+1);
for i=1:(N+1)
    for j=1:(N+1)
        Z(i,j)=z((j-1)/N,(i-1)/N); 
    end
end
%% 迭代求解
[X1 T1]=Jacobian(D,L,U,b);
[X2 T2]=GuassSeidel(D,L,U,b);
[X3 T3]= bestJOR(D,L,U,b);
[X4 T4]= bestSOR(D,L,U,b);
[X5 T5]= bestADI(A1,A2,b1);
[X6 T6]= congrad(A,b);
%导出共轭梯度法的解（矩阵版本）
U=zeros(N-1,N-1);
for i=1:N-1
    for j=1:N-1
        U(i,j)=X6(p2(i,j));
    end
end
U=[zeros(N-1,1) U zeros(N-1,1)];
U=[zeros(1,N+1);U;zeros(1,N+1)];
%% 画图及制表
%共轭梯度法的解曲面
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
%共轭梯度法的误差曲面
figure(2)
err=abs(U-Z);
surf(X,Y,err)
shading faceted
xlabel('X')
ylabel('Y')
zlabel('eij')
title('共轭梯度法的误差曲面')
%各迭代法的迭代步数，即Ti
T1,T2,T3,T4,T5,T6         