clc,clear
s=1:10;             %״̬
t=exprnd(4,1,10);   %���ɲ���Ϊ4��ָ���ֲ���10�������
w=cumsum(t);        %���� t���ۼӺ�
stairs(w,s,'c');    %��������ͼ�Σ���ɫʵ����
title('Poisson���̲���Ϊ4'); 