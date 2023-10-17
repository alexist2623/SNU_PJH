y = readvars('DATA.xlsx','Range','B27:B32');
x = readvars('DATA.xlsx','Range','A27:A32');
yposerr = readvars('DATA.xlsx','Range','C27:C32');
ynegerr = yposerr;

V_liq = 0.032;
x = (x./34.0147)./(0.001.*(x./(1.11) + (100-x)));
y = (1./2).*y;
y = y./V_liq;
yposerr = yposerr./V_liq;

y = 1./y
x = 1./x

yposerr = yposerr.*y.*y;
ynegerr = yposerr;

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

xposerr = ones(length(x),1).*0.1;
xnegerr = xposerr;

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

title('1/v vs 1/[S] with 0.5%')
xlabel('1/[H_{2}O(l)] [1/M]')
ylabel('1/v [s/M]')
legend('Data', 'Fitting Curve', '95% Confidence Line', 'Location','NorthEast')
xlim([min(x_fit), max(x_fit)])
txt = {['y = (' sprintf('%.2e',fitresult.p1) '\pm' sprintf('%.2e', Sd_p1 ) ') * x + (' sprintf('%.2e',fitresult.p2) '\pm' sprintf('%.2e', Sd_p2 ) ')'],...
    ['R^2 = ' num2str(Rsq)]};
text(x_fit(1,1).*3,y_fit_draw(1,1).*(0),txt)
fitresult.p1./fitresult.p2
1./fitresult.p2