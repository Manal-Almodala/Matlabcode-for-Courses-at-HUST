n=10000;       %ʵ�����
sumT=0;        %n��ʵ�鱻����ʱ���ܺ�
absorb4=0;      %����ͳ�Ʊ�4���մ���
for i=1:n
    x=2;
    t=0;
    while(x~=1 && x~=4 && t<1e8)
        if(x==2)         %��״̬2����1/2�ĸ���ת��Ϊ1,3
            x=2*(rand<0.5)+1;
        elseif(x==3)     %��״̬3����1/2�ĸ���ת��Ϊ2,4
            x=2*(rand<0.5)+2;
        end
        t=t+1;
    end
    if(x==4)           %��4����
        absorb4=absorb4+1;
    end
    sumT=sumT+t;
end
    h2=absorb4/n      %ת��Ϊ����
    k2=sumT/n        %ƽ��ʱ��
