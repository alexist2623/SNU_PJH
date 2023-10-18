y = [1./657.97, 1./485.58, 1./436.30, 1./408.20]';
y = y.*(1e9);
x = [(-1./9+1./4),(-1./16+1./4),(-1./25+1./4),(-1./36+1./4)]';

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

xposerr = ones(length(x),1).*0;
xnegerr = xposerr;
yposerr = ones(length(y),1)./y./y.*(1e9);
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

title('Hydrogen')
xlabel('1/n^{2}-1/m^{2} [no unit]')
ylabel('1/\lambda [1/m]')
legend('Data', 'Fitting Curve', '95% Confidence Line', 'Location','NorthEast')
xlim([min(x_fit), max(x_fit)])
txt = {['y = (' sprintf('%.2e',fitresult.p1) '\pm' sprintf('%.2e', Sd_p1 ) ') * x + (' sprintf('%.2e',fitresult.p2) '\pm' sprintf('%.2e', Sd_p2 ) ')'],...
    ['R^2 = ' num2str(Rsq)]};
text(x_fit(1,1).*1.3,y_fit_draw(1,1).*(1.0),txt)
(fitresult.p1-1.097e7)./1.097e7
Sd_p1