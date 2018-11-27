function [X t]= bestJOR(D,L,U,b )
n=length(b);
I=eye(n);
C=-D^(-1)*(L+U);
w=2/(2-max(eig(C))-min(eig(C)));
A=I-w*D^(-1)*(L+U+D);B=w*D^(-1)*b;
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

