npoints = 5000;
dt = 1;
bm = cumsum([zeros(1, 3); dt^0.5*randn(npoints-1, 3)]);
figure(1);
plot3(bm(:, 1), bm(:, 2), bm(:, 3), 'k');
pcol = (bm-repmat(min(bm), npoints, 1))./ ...
         repmat(max(bm)-min(bm), npoints, 1);
hold on;
scatter3(bm(:, 1), bm(:, 2), bm(:, 3), ...
         10, pcol, 'filled');
grid on;
hold off;
