N = [3.7E4, 1.0E5, 3.0E5, 1.0E6, 1.0E7, 1.0E8, 1.0E9]
N = log(N)
S = [170, 148, 130, 114, 92, 80, 74]

plot(N,S,"b",'LineWidth',0.8)
xlabel('logN')
ylabel('Stree Amplitude[MPa]')
hold on
scatter(log(4E6),100,"square","r","filled")
scatter(log(6E5),120,"square","k","filled")

hold off