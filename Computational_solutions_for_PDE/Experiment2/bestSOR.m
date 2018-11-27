function [X t]= bestSOR(D,L,U,b)
n=length(b);
I=eye(n);
C=-D^(-1)*(L+U);
w=2/(1+(1-norm(eig(C),inf)^2)^(0.5));
A=(D+w*L)^(-1)*((1-w)*D-w*U);B=w*(D+w*L)^(-1)*b;
X0=zeros(n,1); r0=B;
t=0;
while norm(r0)>=10^(-12)
    X1=A*X0+B;
    r0=X1-X0;
    X0=X1;
    t=t+1;
end
X=X0;
end
