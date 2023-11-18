x = [0:0.01:4];
vr = 0.01;
y = x.^(3./2).*(1-(0.01+vr)./((x-1).^2 + 0.01)-(0.02+vr)./((x-2).^2 + 0.02)-(0.03+vr)./((x-3).^2 + 0.03));

plot(x,y,LineWidth=0.8)
xlabel('voltage[V]')
ylabel('current[A]')