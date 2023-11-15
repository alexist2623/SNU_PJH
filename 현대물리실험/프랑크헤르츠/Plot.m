x = [0:0.01:4];
y = x.^(3./2).*(1-0.01./((x-1).^2 + 0.01)-0.02./((x-2).^2 + 0.02)-0.03./((x-3).^2 + 0.03));

plot(x,y,LineWidth=0.8)
xlabel('voltage[V]')
ylabel('current[A]')