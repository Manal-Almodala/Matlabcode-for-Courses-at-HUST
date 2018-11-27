function [X t]= GuassSeidel(D,L,U,b)
A=-(D+L)^(-1)*U;B=(D+L)^(-1)*b;
n=length(b);X0=zeros(n,1); r0=B;
t=0;
while norm(r0)>=10^(-12)
    X1=A*X0+B;
    r0=X1-X0;
    X0=X1;
    t=t+1;
end
X=X0;
end

