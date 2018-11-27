clc,clear
%����ϵ������Ĺ���
h=0.1;
u=zeros(10,1);%Ŀ��ϵ��
%�Ҷ�����
d=zeros(10,1);
for j=1:9
    d(j)=(4/h*sin(j*h*pi()/2))-2/h*(sin((j+1)*h*pi()/2)+sin((j-1)*h*pi()/2));
end
d(10)=2/h*(1-sin((1-h)*pi()/2));
%����׷�Ϸ�ϵ������
a=ones(9,1);
b=ones(10,1);
c=ones(9,1);
a=(-1/h+pi()^2*h/24)*a;
c=(-1/h+pi()^2*h/24)*c;
b=(2/h+pi()^2*h/6)*b;
b(10)=1/h+pi()^2*h/12;
%����׷�Ϸ���Ⲣչʾ����
u=chase(a,b,c,d);
x1=0:0.01:1;
y1=sin(pi()/2*x1);
y2=zeros(101,1);
for i=1:9
    for j=0:1:10
        y2(10*i+j+1)=u(i+1)/h*j*0.01+u(i)*(1-1/h*j*0.01);
    end
end
for j=0:10
    y2(j+1)=u(1)/h*j*0.01;
end
figure(1)
plot(x1,y2,'r*-',x1,y1,'k-');
xlabel('x' ); ylabel( 'y' );
legend('����Ԫ��','���');
title('������ͼ');
%�����ֲ����ͼ
figure(2)
r=abs(y1-y2');
plot(x1,r,'k-');
xlabel('x' ); ylabel( 'err' );
title('�ֲ����ͼ');
%% 
%���������
%�������ڻ�����
A1=zeros(10,10);
for i=1:10
    if i>1 && i<10
    A1(i,i)=2/3*h;
    A1(i,i+1)=1/6*h;
    A1(i,i-1)=1/6*h;
    else
        if i==1
           A1(i,i)=2/3*h;
           A1(i,i+1)=1/6*h;
        else
            A1(i,i-1)=1/6*h;
            A1(i,i)=1/3*h;
        end
    end
end
A1(10,10)=1/3*h;
%�������ĵ����ڻ�����
A2=zeros(10,10);
for i=1:10
  if i>1 && i<10
    A2(i,i)=2/h;
    A2(i,i+1)=-1/h;
    A2(i,i-1)=-1/h;
  else
        if i==1
           A2(i,i)=2/h;
           A2(i,i+1)=-1/h;
        else
            A2(i,i-1)=-1/h;
            A2(i,i)=1/h;
        end
  end
end
A2(10,10)=1/h;
%�������������ڻ�����
A3=2/(pi()^2)*d;
%�ڻ��ĵ��������ĵ������ڻ�����
A4=zeros(10,1);
for i=1:9
    A4(i)=1/h*(2*sin(pi()*i*h/2)-sin(pi()*(i-1)*h/2)-sin(pi()*(i+1)*h/2));
end
A4(10)=1/h*(1-sin((1-h)*pi()/2));
%% ������� 
%���L2
B1=zeros(10,10);
for i=1:10
    for j=1:10
        B1(i,j)=A1(i,j)*u(i)*u(j);
    end
end
B2=u.*A3;
r1=(1/2-2*sum(B2(:))+sum(B1(:)))^0.5
%���H1
B3=zeros(10,10);
for i=1:10
    for j=1:10
        B3(i,j)=A2(i,j)*u(i)*u(j);
    end
end
B4=u.*A4;
r2=(pi()^2/8-2*sum(B4(:))+sum(B3(:)))^0.5;
r2=r2+r1