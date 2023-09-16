y = [0.013; 0.013; 0.045]
x = [ 0.05916.*log10(0.1./0.01); 0.05916.*log10(0.1./0.01); 0.05916.*log10(0.1./0.001)]

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

xposerr = x.*0.01;
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

title('Cu Zn Reaction')
xlabel('-0.05916 log Q')
ylabel('E^{cell} [V]')
legend('Data', 'Fitting Curve', '95% Confidence Line', 'Location','NorthEast')
xlim([min(x_fit), max(x_fit)])
txt = {['E^{cell} = (' num2str(fitresult.p1) '\pm' num2str( Sd_p1 ) ') * 0.05916 log Q + (' num2str(fitresult.p2) '\pm' num2str( Sd_p2 ) ')'],...
    ['R^2 = ' num2str(Rsq)]};
text(x_fit(1,1).*1.13,y_fit_draw(1,1).*1.1,txt)
n = 1./fitresult.p1
nerr = Sd_p1./(fitresult.p1.*fitresult.p1)
E = fitresult.p2
Eerr = Sd_p2