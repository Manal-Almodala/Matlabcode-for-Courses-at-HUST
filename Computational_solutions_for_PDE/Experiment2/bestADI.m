function [X t]= bestADI(A1,A2,b1)
%最优ADI方法
w=(1/64)^2/(2*(sin(pi()/64)));
n=length(b1);
I=eye(n);
T=(I+w*A2)^(-1)*(I-w*A1)*(I+w*A1)^(-1)*(I-w*A2);
B=(I+w*A2)^(-1)*(I-w*A1)*(I+w*A1)^(-1)*w*b1+(I+w*A2)^(-1)*w*b1;
X0=zeros(n,1);r0=B;
t=0;
while norm(r0)>=10^(-12)
X1=T*X0+B;
r0=X1-X0;
X0=X1;
t=t+1;
end
X=X0;
end
