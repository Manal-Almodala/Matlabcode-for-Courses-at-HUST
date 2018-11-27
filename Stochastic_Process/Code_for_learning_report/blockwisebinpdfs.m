% METROPOLIS-HASTINGS二维正态分布抽样
rand('seed' ,12345);
D = 2; % # 维数
nBurnIn = 100;
 
% 二维正态分布（目标）
p = inline('mvnpdf(x,[0 0],[1 0.8;0.8 1])','x');
 
%建议分布proposal为标准正态分布
q = inline('mvnpdf(x,mu)','x','mu')
 
nSamples = 5000;
minn = [-3 -3];
maxx = [3 3];
 
% 初始化抽样
t = 1;
x = zeros(nSamples,2);
x(1,:) = randn(1,D);
 
%运行抽样
while t < nSamples
    t = t + 1;
 
    % 建议状态
    xStar = mvnrnd(x(t-1,:),eye(D));
 
    % 矫正因子(直接可以取 1)
    c = q(x(t-1,:),xStar)/q(xStar,x(t-1,:));
 
    % 计算接受率
    alpha = min([1, p(xStar)/p(x(t-1,:))]);
 
    % 拒绝或者接受
    u = rand;
    if u < alpha
        x(t,:) = xStar;
    else
        x(t,:) = x(t-1,:);
    end
end
 
% 展示
nBins = 20;
bins1 = linspace(minn(1), maxx(1), nBins);
bins2 = linspace(minn(2), maxx(2), nBins);
 
% 展示样本分布
ax = subplot(121);
bins1 = linspace(minn(1), maxx(1), nBins);
bins2 = linspace(minn(2), maxx(2), nBins);
sampX = hist3(x, 'Edges', {bins1, bins2});
hist3(x, 'Edges', {bins1, bins2});
view(-15,40)
 
% 根据高度给柱状图上色
colormap hot
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
xlabel('x_1'); ylabel('x_2'); zlabel('频率');
axis square
set(ax,'xTick',[minn(1),0,maxx(1)]);
set(ax,'yTick',[minn(2),0,maxx(2)]);
title('样本分布');
 
% 展示解析密度
ax = subplot(122);
[x1 ,x2] = meshgrid(bins1,bins2);
probX = p([x1(:), x2(:)]);
probX = reshape(probX ,nBins, nBins);
surf(probX); axis xy
view(-15,40)
xlabel('x_1'); ylabel('x_2'); zlabel('p({\bfx})');
colormap hot
axis square
set(ax,'xTick',[1,round(nBins/2),nBins]);
set(ax,'xTickLabel',[minn(1),0,maxx(1)]);
set(ax,'yTick',[1,round(nBins/2),nBins]);
set(ax,'yTickLabel',[minn(2),0,maxx(2)]);
title('解析分布')