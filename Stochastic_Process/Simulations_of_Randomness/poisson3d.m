p=0.5;
n=10000;
colorstr=['b' 'r' 'g' 'y'];          
for k=1:4
  z=2.*(rand(3,n)<=p)-1; 
  x=[zeros(1,3); cumsum(z')];
      col=colorstr(k);
      plot3(x(:,1),x(:,2),x(:,3),col);
  hold on
end
grid
