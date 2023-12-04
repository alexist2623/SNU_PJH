y = readvars('Hydrogen.xlsx','Range','H1:H787');
x = readvars('Hydrogen.xlsx','Range','A1:A787');
x = 3.*(1e8)./x;
y = y - mean(y(453:787));

x_1 = x(356:400)';
y_1 = y(356:400)';

x_2 = x(120:164)';
y_2 = y(120:164)';

x_3 = x(61:88)';
y_3 = y(61:88)';

x_4 = x(35:44)';
y_4 = y(35:44)';

f1 = fit(x_1.',y_1.','gauss1')
f2 = fit(x_2.',y_2.','gauss1')
f3 = fit(x_3.',y_3.','gauss1')
f4 = fit(x_4.',y_4.','gauss1')

x_1 = [min(x_1):(max(x_1) - min(x_1))./300:max(x_1)];
y_1 = f1.a1.*exp(-((x_1-f1.b1)./f1.c1).^2);
x_2 = [min(x_2):(max(x_2) - min(x_2))./300:max(x_2)];
y_2 = f2.a1.*exp(-((x_2-f2.b1)./f2.c1).^2);
x_3 = [min(x_3):(max(x_3) - min(x_3))./300:max(x_3)];
y_3 = f3.a1.*exp(-((x_3-f3.b1)./f3.c1).^2);
x_4 = [min(x_4):(max(x_4) - min(x_4))./300:max(x_4)];
y_4 = f4.a1.*exp(-((x_4-f4.b1)./f4.c1).^2);

plot(x,y)
hold on;
plot(x_1,y_1,'r--','LineWidth',1)
plot(x_2,y_2,'r--','LineWidth',1)
plot(x_3,y_3,'r--','LineWidth',1)
plot(x_4,y_4,'r--','LineWidth',1)
xlim([min(x) max(x)])
ylim([min(y) max(y_1).*1.02])
xlabel('frequency[kHz]')
ylabel('normalized power[W/W]')
legend('data','656nm fit','486nm fit', '434nm fit', '410nm fit')
hold off

FREQ1 = 3.*(1e8)./f1.b1
LW1 = f1.c1
FREQ2 = 3.*(1e8)./f2.b1
LW2 = f2.c1
FREQ3 = 3.*(1e8)./f3.b1
LW3 = f3.c1
FREQ4 = 3.*(1e8)./f4.b1
LW4 = f4.c1

LW1.*f1.a1
LW2.*f2.a1
LW3.*f3.a1
LW4.*f4.a1

A1 = f1.a1
A2 = f2.a1
A3 = f3.a1
A4 = f4.a1

F = log([f1.b1 f2.b1 f3.b1 f4.b1])
A = log([f1.a1.*f1.c1 f2.a1.*f2.c1 f3.a1.*f3.c1 f4.a1.*f4.c1])

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

title('Hydrogen frequency vs peak amplitude * linewidth')
xlabel('log f ')
ylabel('log A')
legend('Data', 'Fitting Curve', '95% Confidence Line', 'Location','NorthEast')
xlim([min(x_fit), max(x_fit)])
txt = {['y = (' sprintf('%.2e',fitresult.p1) '\pm' sprintf('%.2e', Sd_p1 ) ') * x + (' sprintf('%.2e',fitresult.p2) '\pm' sprintf('%.2e', Sd_p2 ) ')'],...
    ['R^2 = ' num2str(Rsq)]};
text(x_fit(1,1).*1.005,y_fit_draw(1,1).*1.5,txt)
(fitresult.p1-1.097e7)./1.097e7
Sd_p1
% 1st 5957Hz 0.94
% 2st 3801Hz 0.0228293