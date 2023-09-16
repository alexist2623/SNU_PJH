y = readvars('DATA.xlsx','Range','E10:E16');
x = readvars('DATA.xlsx','Range','D10:D16');

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

xposerr = 2*sqrt(x)*0.1*0.01;
xnegerr = xposerr;
yposerr = sqrt(y).*0.050;
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

title('200V Elctron Radius vs Current')
xlabel('R^{2} [m^{2}]')
ylabel('1/I^{2} [A^{-2}]')
legend('Data', 'Fitting Curve', '95% Confidence Line', 'Location','NorthEast')
xlim([min(x_fit), max(x_fit)])
txt = {['1/I^{2} = (' num2str(fitresult.p1) '\pm' num2str( Sd_p1 ) ') * R^{2} + (' num2str(fitresult.p2) '\pm' num2str( Sd_p2 ) ')'],...
    ['R^2 = ' num2str(Rsq)]};
text(x_fit(10,1),y_fit_draw(240,1),txt)

e_m = 2.*fitresult.p1.*200/(7.8*7.8*1E-8)
error = 2.*Sd_p1.*200/(7.8*7.8*1E-8)