%--------------------------------------------------
% EXAMPLE 2: METROPOLIS-HASTINGS
% COMPONENT-WISE SAMPLING OF BIVARIATE NORMAL
rand('seed' ,12345);
 
% TARGET DISTRIBUTION
p = inline('mvnpdf(x,[0 0],[1 0.8;0.8 1])','x');
 
nSamples = 5000;
propSigma = 1;      % PROPOSAL VARIANCE
minn = [-3 -3];
maxx = [3 3];
 
% INITIALIZE COMPONENT-WISE SAMPLER
x = zeros(nSamples,2);
xCurrent(1) = randn;
xCurrent(2) = randn;
dims = 1:2; % INDICES INTO EACH DIMENSION
t = 1;
x(t,1) = xCurrent(1);
x(t,2) = xCurrent(2);
 
% RUN SAMPLER
while t < nSamples
    t = t + 1;
    for iD = 1:2 % LOOP OVER DIMENSIONS
 
        % SAMPLE PROPOSAL
        xStar = normrnd(xCurrent(:,iD), propSigma);
 
        % NOTE: CORRECTION FACTOR c=1 BECAUSE
        % N(mu,1) IS SYMMETRIC, NO NEED TO CALCULATE
 
        % CALCULATE THE ACCEPTANCE PROBABILITY
        pratio = p([xStar xCurrent(dims~=iD)])/ ...
        p([xCurrent(1) xCurrent(2)]);
        alpha = min([1, pratio]);
 
        % ACCEPT OR REJECT?
        u = rand;
        if u < alpha
            xCurrent(iD) = xStar;
        end
    end
 
    % UPDATE SAMPLES
    x(t,:) = xCurrent;
end
 
% DISPLAY
nBins = 20;
bins1 = linspace(minn(1), maxx(1), nBins);
bins2 = linspace(minn(2), maxx(2), nBins);
 
% DISPLAY SAMPLED DISTRIBUTION
figure;
ax = subplot(121);
bins1 = linspace(minn(1), maxx(1), nBins);
bins2 = linspace(minn(2), maxx(2), nBins);
sampX = hist3(x, 'Edges', {bins1, bins2});
hist3(x, 'Edges', {bins1, bins2});
view(-15,40)
 
% COLOR HISTOGRAM BARS ACCORDING TO HEIGHT
colormap hot
set(gcf,'renderer','opengl');
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
xlabel('x_1'); ylabel('x_2'); zlabel('Frequency');
axis square
set(ax,'xTick',[minn(1),0,maxx(1)]);
set(ax,'yTick',[minn(2),0,maxx(2)]);
title('Sampled Distribution');
 
% DISPLAY ANALYTIC DENSITY
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
title('Analytic Distribution')