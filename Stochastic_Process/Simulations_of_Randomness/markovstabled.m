    p=[0.3 0.7 0
     0  4/5 1/5 
    1/3 2/3 0];
x(1)=1;     %��ʼ״̬Ϊ 1
n=20000;
for k=1:n
    for i=1:3
        if x(k)==i
            a=rand(1);
            if a<p(i,1) x(k+1)=1; %���ݲ�����������ķ�Χ���ж���һ��״̬
            elseif a>=p(i,1) &a<(p(i,1)+p(i,2)) x(k+1)=2;
            elseif a>=(p(i,1)+p(i,2)) x(k+1)=3;
            end
        end
    end
end
y=[0 0 0];
for i=1:n
    for k=1:3
        if x(i)==k 
            y(k)=y(k)+1;    %����Ƶ���Ƴ�����
        end
    end
end
pi=y/n
