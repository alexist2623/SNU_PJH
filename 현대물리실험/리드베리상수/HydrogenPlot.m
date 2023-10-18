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

% 1st 5957Hz 0.94
% 2st 3801Hz 0.0228293