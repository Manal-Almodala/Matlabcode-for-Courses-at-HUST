function z=Radau2a(a,b,y0,d,h)
A=[5/12 -1/12;3/4 1/4];
B=[3/4 1/4];c=[1/3,1]';
A1=[0 0 0;1/3 0 0;0 2/3 0]; %三阶Heun方法计算初值
B1=[1/4 0 3/4];t0=a;s=2;
Z1=[];Z2=[];Z3=[];Z4=[];
i=1;
for n=a+h:h:b
    Z1(i)=t0;Z2(i)=y0(1);Z3(i)=y0(2);
    Z4(i)=norm(y0-[exp(sin(t0*t0)) exp(cos(t0*t0))]',2);
    err1=1;err2=1;t=kron(ones(s,1),t0)+h*c;
    tc11=t0;tc12=t0+c(1)*h/3;tc13=t0+2*c(1)*h/3;
    Y11=y0;Y12=y0+h*c(1)*kron(A1(2,1),eye(d))*fa(tc11,Y11);
    Y13=y0+h*c(1)*kron(A1(3,1:2),eye(d))*[fa(tc11,Y11);fa(tc12,Y12)];
    Y10=y0+h*c(1)*kron(B1(1:3),eye(d))*[fa(tc11,Y11);fa(tc12,Y12);fa(tc13,Y13)];
    tc21=t0;tc22=t0+c(2)*h/3;tc23=t0+c(2)*h/3;
    Y21=y0;Y22=y0+h*c(2)*kron(A1(2,1),eye(d))*fa(tc21,Y21);
    Y23=y0+h*c(2)*kron(A1(3,1:2),eye(d))*[fa(tc21,Y21);fa(tc12,Y22)];
    Y20=y0+h*c(2)*kron(B1(1:3),eye(d))*[fa(tc21,Y21);fa(tc22,Y22);fa(tc23,Y23)];
    Y0=[Y10;Y20];
    while err1>=10^(-12) && err2>=10^(-12)
        F=[fa(t(1),[Y0(1);Y0(2)]);fa(t(2),[Y0(3);Y0(4)])];
        r=Y0-kron(ones(s,1),y0)-h*kron(A,eye(d))*F;
        dF=[dfa(t(1),[Y0(1);Y0(2)]) zeros(2,2);zeros(2,2) dfa(t(2),[Y0(3);Y0(4)])];
        Y1=Y0-inv(eye(s*d)-h*kron(A,eye(d))*dF)*r;
        err1=norm(Y1-Y0);err2=norm(r);Y0=Y1;
    end
    y1=y0+h*kron(B,eye(d))*[fa(t(1),[Y0(1);Y0(2)]);fa(t(2),[Y0(3);Y0(4)])];
    t0=t0+h;y0=y1;i=i+1;
end
figure(1)
plot(Z1,Z2,'b',Z1,Z3,'r');
xlabel('时间t');ylabel('数值解取值y');
legend('y1','y2','Location','Northeast');
title('RadauIIA法数值解曲线图');
figure(2)
plot(Z1,Z4);
xlabel('时间t');ylabel('误差err');
title('RadauIIA法整体误差图');
