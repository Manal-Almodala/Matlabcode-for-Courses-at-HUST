% METROPOLIS-HASTINGS bayes后验分布抽样 by fz
clc,clear
rand('seed',12345)
 
% 先验分布的尺度参数
B = 1;
 
% 定义极大似然函数
likelihood = inline('(B.^A/gamma(A)).*y.^(A-1).*exp(-(B.*y))','y','A','B');
 
% 计算并展示Gamma分布即图1
yy = linspace(0,10,100);
AA = linspace(0.1,5,100);
likeSurf = zeros(numel(yy),numel(AA));
for iA = 1:numel(AA); likeSurf(:,iA)=likelihood(yy(:),AA(iA),B); end;
 
figure;
surf(likeSurf); ylabel('p(y|A)'); xlabel('A'); colormap hot
 
% 展示A=2，B=1时的密度曲线
hold on; ly = plot3(ones(1,numel(AA))*40,1:100,likeSurf(:,40),'g','linewidth',3)
xlim([0 100]); ylim([0 100]);  axis normal
set(gca,'XTick',[0,100]); set(gca,'XTickLabel',[0 5]);
set(gca,'YTick',[0,100]); set(gca,'YTickLabel',[0 10]);
view(65,25)
legend(ly,'p(y|A=2)','Location','Northeast');
hold off;
title('A参数下的Gamma分布p(y|A)');

% 定义形状参数A的先验分布
prior = inline('sin(pi*A).^2','A');
 
% 定义后验分布
p = inline('(B.^A/gamma(A)).*y.^(A-1).*exp(-(B.*y)).*sin(pi*A).^2','y','A','B');
 
% 计算并展示后验分布
postSurf = zeros(size(likeSurf));
for iA = 1:numel(AA); postSurf(:,iA)=p(yy(:),AA(iA),B); end;
 
figure
surf(postSurf); ylabel('y'); xlabel('A'); colormap hot
 
% 展示A
hold on; pA = plot3(1:100,ones(1,numel(AA))*100,prior(AA),'b','linewidth',3)
 
% 抽样 p(A | y = 1.5)
y = 1.5;
target = postSurf(16,:);
 
% 展示后验分布
psA = plot3(1:100, ones(1,numel(AA))*16,postSurf(16,:),'m','linewidth',3)
xlim([0 100]); ylim([0 100]);  axis normal
set(gca,'XTick',[0,100]); set(gca,'XTickLabel',[0 5]);
set(gca,'YTick',[0,100]); set(gca,'YTickLabel',[0 10]);
view(65,25)
legend([pA,psA],{'p(A)','p(A|y = 1.5)'},'Location','Northeast');
hold off
title('后验分布密度曲面（与p(A|y)成比例）');
 
% 初始话Metropolis—Hastings算法
% 定义建议分布proposal distribution
q = inline('exppdf(x,mu)','x','mu');
 
% 建议分布的参数设置
mu = 5;
 
% 展示目标分布以及建议分布
figure; hold on;
th = plot(AA,target,'m','Linewidth',2);
qh = plot(AA,q(AA,mu),'k','Linewidth',2)
legend([th,qh],{'目标后验分布target, p(A)','建议分布Proposal, q(A)'});
xlabel('A');
 
% 一些限制条件：取值范围及样本容量
nSamples = 5000;
burnIn = 500;
minn = 0.1; maxx = 5;
 
% 初始化样本
x = zeros(1 ,nSamples);
x(1) = mu;
t = 1;
 
% 跑动算法 METROPOLIS-HASTINGS 
while t < nSamples
    t = t+1;
 
    % 建议状态
    xStar = exprnd(mu);
 
    % 矫正因子
    c = q(x(t-1),mu)/q(xStar,mu);
 
    % 接受率
    alpha = min([1, p(y,xStar,B)/p(y,x(t-1),B)*c]);
 
    % 拒绝或接受
    u = rand;
    if u < alpha
        x(t) = xStar;
    else
        x(t) = x(t-1);
    end
end
 
% 展示MARKOV链的道路
figure;
subplot(211);
stairs(x(1:t),1:t, 'k');
hold on;
hb = plot([0 maxx/2],[burnIn burnIn],'g--','Linewidth',2)
ylabel('t'); xlabel('样本, A');
set(gca , 'YDir', 'reverse');
ylim([0 t])
axis tight;
xlim([0 maxx]);
title('Markov链道路图');
legend(hb,'Burnin');
 
% 展示样本
subplot(212);
nBins = 100;
sampleBins = linspace(minn,maxx,nBins);
counts = hist(x(burnIn:end), sampleBins);
bar(sampleBins, counts/sum(counts), 'k');
xlabel('样本, A' ); ylabel( 'p(A | y=1.5)' );
title('样本');
xlim([0 10])
 
% 展示目标分布
hold on;
plot(AA, target/sum(target) , 'm-', 'LineWidth', 2);
legend('样本分布',sprintf('目标后验分布'))
axis tight