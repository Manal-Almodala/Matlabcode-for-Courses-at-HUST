n=10000;       %实验次数
sumT=0;        %n次实验被吸收时间总和
absorb4=0;      %用来统计被4吸收次数
for i=1:n
    x=2;
    t=0;
    while(x~=1 && x~=4 && t<1e8)
        if(x==2)         %在状态2各有1/2的概率转移为1,3
            x=2*(rand<0.5)+1;
        elseif(x==3)     %在状态3各有1/2的概率转移为2,4
            x=2*(rand<0.5)+2;
        end
        t=t+1;
    end
    if(x==4)           %被4吸收
        absorb4=absorb4+1;
    end
    sumT=sumT+t;
end
    h2=absorb4/n      %转化为概率
    k2=sumT/n        %平均时间
