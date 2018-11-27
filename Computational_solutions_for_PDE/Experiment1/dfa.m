function z=dfa(tl,Y)
syms x y t;
if Y(1)>10^(-3) && Y(2)>10^(-3)
    J=jacobian([2*t*x*log(y) (-2)*t*y*log(x)]',[x y]);
end
if Y(1)>10^(-3) && Y(2)<=10^(-3)
    J=jacobian([2*t*x*log(10^(-3)) (-2)*t*y*log(x)]',[x y]);
end
if Y(1)<=10^(-3) && Y(2)>10^(-3)
    J=jacobian([2*t*x*log(y) (-2)*t*y*log(10^(-3))]',[x y]);
end
if Y(1)<=10^(-3) && Y(2)<=10^(-3)
    J=jacobian([2*t*x*log(10^(-3)) (-2)*t*y*log(10^(-3))]',[x y]);
end
z=eval(subs(J,{x,y,t},{Y(1),Y(2),tl}));
