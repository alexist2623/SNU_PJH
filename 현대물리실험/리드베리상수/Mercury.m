y = readvars('Mercury.xlsx','Range','B1:B787');
x = readvars('Mercury.xlsx','Range','A1:A787');
x = 3.*(1e8)./x;
y = y - mean(y(655:787));

x_1 = x(620:654)';
y_1 = y(620:654)';

x_2 = x(582:607)';
y_2 = y(582:607)';

x_3 = x(518:539)';
y_3 = y(518:539)';

x_4 = x(499:519)';
y_4 = y(499:519)';

x_5 = x(353:394)';
y_5 = y(353:394)';

x_6 = x(255:283)';
y_6 = y(255:283)';

x_7 = x(209:245)';
y_7 = y(209:245)';

x_8 = x(53:111)';
y_8 = y(53:111)';

x_9 = x(17:53)';
y_9 = y(17:53)';

f1 = fit(x_1.',y_1.','gauss1')
f2 = fit(x_2.',y_2.','gauss1')
f3 = fit(x_3.',y_3.','gauss1')
f4 = fit(x_4.',y_4.','gauss1')
f5 = fit(x_5.',y_5.','gauss1')
f6 = fit(x_6.',y_6.','gauss1')
f7 = fit(x_7.',y_7.','gauss1')
f8 = fit(x_8.',y_8.','gauss1')
f9 = fit(x_9.',y_9.','gauss1')

x_1 = [min(x_1):(max(x_1) - min(x_1))./300:max(x_1)];
y_1 = f1.a1.*exp(-((x_1-f1.b1)./f1.c1).^2);
x_2 = [min(x_2):(max(x_2) - min(x_2))./300:max(x_2)];
y_2 = f2.a1.*exp(-((x_2-f2.b1)./f2.c1).^2);
x_3 = [min(x_3):(max(x_3) - min(x_3))./300:max(x_3)];
y_3 = f3.a1.*exp(-((x_3-f3.b1)./f3.c1).^2);
x_4 = [min(x_4):(max(x_4) - min(x_4))./300:max(x_4)];
y_4 = f4.a1.*exp(-((x_4-f4.b1)./f4.c1).^2);
x_5 = [min(x_5):(max(x_5) - min(x_5))./300:max(x_5)];
y_5 = f5.a1.*exp(-((x_5-f5.b1)./f5.c1).^2);
x_6 = [min(x_6):(max(x_6) - min(x_6))./300:max(x_6)];
y_6 = f6.a1.*exp(-((x_6-f6.b1)./f6.c1).^2);
x_7 = [min(x_7):(max(x_7) - min(x_7))./300:max(x_7)];
y_7 = f7.a1.*exp(-((x_7-f7.b1)./f7.c1).^2);
x_8 = [min(x_8):(max(x_8) - min(x_8))./300:max(x_8)];
y_8 = f8.a1.*exp(-((x_8-f8.b1)./f8.c1).^2);
x_9 = [min(x_9):(max(x_9) - min(x_9))./300:max(x_9)];
y_9 = f9.a1.*exp(-((x_9-f9.b1)./f9.c1).^2);

plot(x,y)
hold on;
plot(x_1,y_1,'r--','LineWidth',1)
plot(x_2,y_2,'r--','LineWidth',1)
plot(x_3,y_3,'r--','LineWidth',1)
plot(x_4,y_4,'r--','LineWidth',1)
plot(x_5,y_5,'r--','LineWidth',1)
plot(x_6,y_6,'r--','LineWidth',1)
plot(x_7,y_7,'r--','LineWidth',1)
plot(x_8,y_8,'r--','LineWidth',1)
plot(x_9,y_9,'r--','LineWidth',1)
xlim([min(x) max(x)])
ylim([min(y) max(y_7).*1.02])
xlabel('frequency[kHz]')
ylabel('normalized power[W/W]')

WAVE1 = 3.*(1e8)./f1.b1
LW1 = f1.c1
WAVE2 = 3.*(1e8)./f2.b1
LW2 = f2.c1
WAVE3 = 3.*(1e8)./f3.b1
LW3 = f3.c1
WAVE4 = 3.*(1e8)./f4.b1
LW4 = f4.c1
WAVE5 = 3.*(1e8)./f5.b1
LW5 = f5.c1
WAVE6 = 3.*(1e8)./f6.b1
LW6 = f6.c1
WAVE7 = 3.*(1e8)./f7.b1
LW7 = f7.c1
WAVE8 = 3.*(1e8)./f8.b1
LW8 = f8.c1
WAVE9 = 3.*(1e8)./f9.b1
LW9 = f9.c1

LW1.*f1.a1
LW2.*f2.a1
LW3.*f3.a1
LW4.*f4.a1
LW5.*f5.a1
LW6.*f6.a1
LW7.*f7.a1
LW8.*f8.a1
LW9.*f9.a1

A1 = f1.a1
A2 = f2.a1
A3 = f3.a1
A4 = f4.a1
A5 = f5.a1
A6 = f6.a1
A7 = f7.a1
A8 = f8.a1
A9 = f9.a1

legend('data',strcat(num2str(round(WAVE1)),'nm fit'),strcat(num2str(round(WAVE2)),'nm fit'),strcat(num2str(round(WAVE3)),'nm fit'),strcat(num2str(round(WAVE4)),'nm fit'),strcat(num2str(round(WAVE5)),'nm fit'),strcat(num2str(round(WAVE6)),'nm fit'),strcat(num2str(round(WAVE7)),'nm fit'),strcat(num2str(round(WAVE8)),'nm fit'),strcat(num2str(round(WAVE9)),'nm fit'))

hold off

F = log([f1.b1 f2.b1 f3.b1 f4.b1 f5.b1 f6.b1 f7.b1])
A = log([f1.a1.*f1.c1 f2.a1.*f2.c1 f3.a1.*f3.c1 f4.a1.*f4.c1 f5.a1.*f5.c1 f6.a1.*f6.c1 f7.a1.*f7.c1])

y = A'
x = F'
fitresult = fit(x,y,'poly1');
y_fit = fitresult.p1 * x + fitresult.p2;
x_fit = [min(x).*0.99:(max(x)-min(x))/160:max(x).*1.01]';
confident = predint(fitresult,x_fit,0.95,'observation','on');
ci = confint(fitresult,0.95)
%confident = predint(fitresult,x,0.95,'functional','on');
S_xx = sum((x - mean(x)).^2);
S_yy = sum((y - mean(y)).^2);
Sigma_sq = sum((y - y_fit).^2);
Var_p2 = Sigma_sq./ length(x) + mean(x).*mean(x).*Sigma_sq./S_xx
Var_p1 = Sigma_sq./S_xx
Sd_p2 = sqrt(Var_p2)
Sd_p1 = sqrt(Var_p1)
Rsq = 1 - sum((y - y_fit).^2)/sum((y - mean(y)).^2)

xposerr = x.*0.01;
xnegerr = xposerr;
yposerr = y.*0.1;
ynegerr = yposerr;
errorbar(x,y,ynegerr,yposerr,xnegerr,xposerr,'ks')
hold on

y_fit_draw = fitresult.p1 * x_fit + fitresult.p2;
plot(x_fit,y_fit_draw,"b--",'LineWidth',1.2)
plot(x_fit,confident,"r--",'LineWidth',0.8)

x_ = [x_fit', fliplr(x_fit')];
y_ = [confident(:,2)', fliplr(confident(:,1)')];
h1 = fill(x_,y_,'r');
set(h1,'facealpha',0.2,'edgecolor','none');

hold off

title('Mercury frequency vs peak amplitude * linewidth')
xlabel('log f ')
ylabel('log A')
legend('Data', 'Fitting Curve', '95% Confidence Line', 'Location','NorthEast')
xlim([min(x_fit), max(x_fit)])
txt = {['y = (' sprintf('%.2e',fitresult.p1) '\pm' sprintf('%.2e', Sd_p1 ) ') * x + (' sprintf('%.2e',fitresult.p2) '\pm' sprintf('%.2e', Sd_p2 ) ')'],...
    ['R^2 = ' num2str(Rsq)]};
text(x_fit(1,1).*1.005,y_fit_draw(1,1),txt)
(fitresult.p1-1.097e7)./1.097e7
Sd_p1