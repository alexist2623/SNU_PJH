y = readvars('DATA.xlsx','Range','M2:M7');
x = readvars('DATA.xlsx','Range','O2:O7');

fitresult = fit(x,y,'poly1');
y_fit = fitresult.p1 * x + fitresult.p2;
x_fit = [min(x).*0.7:(max(x)-min(x))/160:max(x).*1.2]';
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

xposerr = x.*0.1;
xnegerr = xposerr;
yposerr = ones(length(y),1).*0.002;
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

title('d_{10} diffraction')
xlabel('R_{1}/(2R^{2} + 2R(R^{2} - R_{1}^{2})^{1/2})^{1/2} [1/m]')
ylabel('1/U^{1/2} [1/J^{1/2}]')
legend('Data', 'Fitting Curve', '95% Confidence Line', 'Location','NorthEast')
xlim([min(x_fit), max(x_fit)])
txt = {['y = (' num2str(fitresult.p1) '\pm' num2str( Sd_p1 ) ') * x + (' num2str(fitresult.p2) '\pm' num2str( Sd_p2 ) ')'],...
    ['R^2 = ' num2str(Rsq)]};
text(x_fit(1,1).*1.2,y_fit_draw(1,1).*(0.9),txt)
d = fitresult.p1./(sqrt(2*(9.109E-31)*1.602E-19)/(6.626E-34))
delta =  Sd_p1./(sqrt(2*(9.109E-31)*1.602E-19)/(6.626E-34))