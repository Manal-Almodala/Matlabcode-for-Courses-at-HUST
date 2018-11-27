function z=adams(a,b,y0,d,h)
t0=a;alpha=[0 -1 -1]'; beta=[-1 8 5]'/12;
A=[0 0 0;1/3 0 0;0 2/3 0];
B=[1/4 0 3/4];
c=[0 1/3 2/3]';
Z1=[];Z2=[];Z3=[];Z4=[];
i=1;
tc1=t0+c(1)*h;tc2=t0+c(2)*h;tc3=t0+c(3)*h;
Y1=y0;Y2=y0+h*kron(A(2,1),eye(d))*fa(tc1,Y1);
Y3=y0+h*kron(A(3,1:2),eye(d))*[fa(tc1,Y1);fa(tc2,Y2)];
y1=y0+h*kron(B(1:3),eye(d))*[fa(tc1,Y1);fa(tc2,Y2);fa(tc3,Y3)];
for n=a+2*h:h:b
    Z1(i)=t0;Z2(i)=y1(1);Z3(i)=y1(2);
%     Z4(i)=norm(y1-[(2*pi-t0-h)*cos(t0+h) (2*pi-t0-h)*sin(t0+h)]',2);
    Z4(i)=norm(y1-[exp(sin((t0+h)*(t0+h))) exp(cos((t0+h)*(t0+h)))]',2);
    t1=t0+h;t2=t0+2*h;tc1=t0+(1+c(1))*h;tc2=t0+(1+c(2))*h;tc3=t0+(1+c(3))*h;
    Y1=y1;Y2=y1+h*kron(A(2,1),eye(d))*fa(tc1,Y1);
    Y3=y1+h*kron(A(3,1:2),eye(d))*[fa(tc1,Y1);fa(tc2,Y2)];
    y20=y1+h*kron(B(1:3),eye(d))*[fa(tc1,Y1);fa(tc2,Y2);fa(tc3,Y3)];
    w=h*(beta(1)*fa(t0,y0)+beta(2)*fa(t1,y1))-(alpha(1)*y0+alpha(2)*y1);
    err1=1;err2=1;
    while err1>10^(-12) && err2>=10^(-12)
        r=y20-h*beta(3)*fa(t2,y20)-w;
        y21=y20-inv(eye(d)-h*beta(3)*dfa(t2,y20))*r;
        err1=norm(y21-y20);err2=norm(r);
        y20=y21;
    end
y2=y20;t0=t0+h;y0=y1;y1=y2;
i=i+1;
end
figure(3)
plot(Z1,Z2,'b',Z1,Z3,'r');
xlabel('时间t');ylabel('数值解取值y');
legend('y1','y2','Location','Northeast');
title('Adams-Monlton法数值解曲线图');
figure(4)
plot(Z1,Z4);
xlabel('时间t');ylabel('误差err');
title('Adams-Monlton法整体误差图');