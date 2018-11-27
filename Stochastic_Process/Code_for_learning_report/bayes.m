% METROPOLIS-HASTINGS bayes����ֲ����� by fz
clc,clear
rand('seed',12345)
 
% ����ֲ��ĳ߶Ȳ���
B = 1;
 
% ���弫����Ȼ����
likelihood = inline('(B.^A/gamma(A)).*y.^(A-1).*exp(-(B.*y))','y','A','B');
 
% ���㲢չʾGamma�ֲ���ͼ1
yy = linspace(0,10,100);
AA = linspace(0.1,5,100);
likeSurf = zeros(numel(yy),numel(AA));
for iA = 1:numel(AA); likeSurf(:,iA)=likelihood(yy(:),AA(iA),B); end;
 
figure;
surf(likeSurf); ylabel('p(y|A)'); xlabel('A'); colormap hot
 
% չʾA=2��B=1ʱ���ܶ�����
hold on; ly = plot3(ones(1,numel(AA))*40,1:100,likeSurf(:,40),'g','linewidth',3)
xlim([0 100]); ylim([0 100]);  axis normal
set(gca,'XTick',[0,100]); set(gca,'XTickLabel',[0 5]);
set(gca,'YTick',[0,100]); set(gca,'YTickLabel',[0 10]);
view(65,25)
legend(ly,'p(y|A=2)','Location','Northeast');
hold off;
title('A�����µ�Gamma�ֲ�p(y|A)');

% ������״����A������ֲ�
prior = inline('sin(pi*A).^2','A');
 
% �������ֲ�
p = inline('(B.^A/gamma(A)).*y.^(A-1).*exp(-(B.*y)).*sin(pi*A).^2','y','A','B');
 
% ���㲢չʾ����ֲ�
postSurf = zeros(size(likeSurf));
for iA = 1:numel(AA); postSurf(:,iA)=p(yy(:),AA(iA),B); end;
 
figure
surf(postSurf); ylabel('y'); xlabel('A'); colormap hot
 
% չʾA
hold on; pA = plot3(1:100,ones(1,numel(AA))*100,prior(AA),'b','linewidth',3)
 
% ���� p(A | y = 1.5)
y = 1.5;
target = postSurf(16,:);
 
% չʾ����ֲ�
psA = plot3(1:100, ones(1,numel(AA))*16,postSurf(16,:),'m','linewidth',3)
xlim([0 100]); ylim([0 100]);  axis normal
set(gca,'XTick',[0,100]); set(gca,'XTickLabel',[0 5]);
set(gca,'YTick',[0,100]); set(gca,'YTickLabel',[0 10]);
view(65,25)
legend([pA,psA],{'p(A)','p(A|y = 1.5)'},'Location','Northeast');
hold off
title('����ֲ��ܶ����棨��p(A|y)�ɱ�����');
 
% ��ʼ��Metropolis��Hastings�㷨
% ���彨��ֲ�proposal distribution
q = inline('exppdf(x,mu)','x','mu');
 
% ����ֲ��Ĳ�������
mu = 5;
 
% չʾĿ��ֲ��Լ�����ֲ�
figure; hold on;
th = plot(AA,target,'m','Linewidth',2);
qh = plot(AA,q(AA,mu),'k','Linewidth',2)
legend([th,qh],{'Ŀ�����ֲ�target, p(A)','����ֲ�Proposal, q(A)'});
xlabel('A');
 
% һЩ����������ȡֵ��Χ����������
nSamples = 5000;
burnIn = 500;
minn = 0.1; maxx = 5;
 
% ��ʼ������
x = zeros(1 ,nSamples);
x(1) = mu;
t = 1;
 
% �ܶ��㷨 METROPOLIS-HASTINGS 
while t < nSamples
    t = t+1;
 
    % ����״̬
    xStar = exprnd(mu);
 
    % ��������
    c = q(x(t-1),mu)/q(xStar,mu);
 
    % ������
    alpha = min([1, p(y,xStar,B)/p(y,x(t-1),B)*c]);
 
    % �ܾ������
    u = rand;
    if u < alpha
        x(t) = xStar;
    else
        x(t) = x(t-1);
    end
end
 
% չʾMARKOV���ĵ�·
figure;
subplot(211);
stairs(x(1:t),1:t, 'k');
hold on;
hb = plot([0 maxx/2],[burnIn burnIn],'g--','Linewidth',2)
ylabel('t'); xlabel('����, A');
set(gca , 'YDir', 'reverse');
ylim([0 t])
axis tight;
xlim([0 maxx]);
title('Markov����·ͼ');
legend(hb,'Burnin');
 
% չʾ����
subplot(212);
nBins = 100;
sampleBins = linspace(minn,maxx,nBins);
counts = hist(x(burnIn:end), sampleBins);
bar(sampleBins, counts/sum(counts), 'k');
xlabel('����, A' ); ylabel( 'p(A | y=1.5)' );
title('����');
xlim([0 10])
 
% չʾĿ��ֲ�
hold on;
plot(AA, target/sum(target) , 'm-', 'LineWidth', 2);
legend('�����ֲ�',sprintf('Ŀ�����ֲ�'))
axis tight