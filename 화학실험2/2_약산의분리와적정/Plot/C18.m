y = [0.10000000000000056,
4.03,
1.62,
0.3599999999999986,
0.06000000000000142,
0.01000000000000071,
0.05999999999999787,
0.11000000000000212,
0.05999999999999787,
0.06000000000000142,
0.06000000000000142,
0.009999999999997157,
0.030000000000000283,
0.04000000000000185,
0.01000000000000071,
0.030000000000000283,
0.06000000000000142,
-0.020000000000000427,
0.039999999999998294,
0.01000000000000071];
x = [1:1:20];

plot(x,y,'LineWidth',1.2)
xlabel('C18 이동부피[mL]')
ylabel('적정 NaOH 용액[mL]')
ylim([0, 4.05])
hold on 

xposerr = ones(length(x),1).*0.05;
xnegerr = xposerr;
yposerr = ones(length(y),1).*0.1;
ynegerr = yposerr;
errorbar(x,y,ynegerr,yposerr,xnegerr,xposerr,'ks')

hold off
sum(y)

two = y(1) + y(2) + y(3) + y(4) + y(5)