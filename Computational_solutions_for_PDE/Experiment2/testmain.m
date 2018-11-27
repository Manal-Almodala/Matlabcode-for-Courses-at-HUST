%% 迭代格式的标准化
clc,clear
N=8;
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
x=zeros((N-1)^2,1);
A=zeros((N-1)^2,(N-1)^2);
b=zeros((N-1)^2,1);
%构造A与b
h1=(N/pi())^2;h2=N^2;h3=-2*(h1+h2);
for i=1:N-1
    for j=1:N-1
        b(p2(i,j))=f(pi()*j/N,i/N);
        A(p2(i,j),p2(i,j))=h3;
        if i>1
        A(p2(i,j),p2(i-1,j))=h2;
        end
        if j>1
        A(p2(i,j),p2(i,j-1))=h1;
        end
        if i<N-1
        A(p2(i,j),p2(i+1,j))=h2;
        end
        if j<N-1
        A(p2(i,j),p2(i,j+1))=h1;
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
b1=zeros((N-1)^2,1);
h1=-(N/pi())^2;h2=-2*h1;h3=-N^2;h4=-2*h3;
for i=1:N-1
    for j=1:N-1
        b1(p2(i,j))=z(j/N,(pi()*i)/N);
        A1(p2(i,j),p2(i,j))=h2;
        A2(p2(i,j),p2(i,j))=h4;
        if i>1
        A2(p2(i,j),p2(i-1,j))=h3;
        end
        if j>1
        A1(p2(i,j),p2(i,j-1))=h1;
        end
        if i<N-1
        A2(p2(i,j),p2(i+1,j))=h3;
        end
        if j<N-1
        A1(p2(i,j),p2(i,j+1))=h1;
        end
    end
end
%精确解
Z=zeros(N+1,N+1);
for i=1:(N-1)
    for j=1:(N-1)
        Z(i,j)=z(pi()*j/N,i/N); 
    end
end

%% 迭代求解
[X1 T1]=Jacobian(D,L,U,b);
[X2 T2]=GuassSeidel(D,L,U,b);
[X3 T3]= bestJOR(D,L,U,b);
[X4 T4]= bestSOR(D,L,U,b);
[X5 T5]= bestADI(A1,A2,b1);
[X6 T6]= congrad(A,b);