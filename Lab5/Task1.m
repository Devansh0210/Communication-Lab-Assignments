x = -10:0.001:10;
gauss = @(x) pdf('norm', x, 0, 1);
figure;
subplot(4, 1, 1);
plot(x, gauss(x));
title('Gaussian Distribution', 'Interpreter', 'latex');
xlabel('x', 'Interpreter', 'latex');
ylabel('$f_{X}(x)$', 'Interpreter', 'latex');
fprintf(" ---- \nTotal Probability : %f \n", integral(gauss, -inf, inf));
grid on;

uni = @(x) pdf('unif', x, -2, 2);
subplot(4, 1, 2);
plot(x, uni(x));
title('Uniform Distribution', 'Interpreter', 'latex');
xlabel('x', 'Interpreter', 'latex');
ylabel('$f_{X}(x)$', 'Interpreter', 'latex');
fprintf("Total Probability : %f \n", integral(uni, -inf, inf))
grid on;

rayl = @(x) pdf('rayl', x, 2);
subplot(4, 1, 3);
plot(x(x>0), rayl(x(x>0)));
title('Rayleigh Distribution', 'Interpreter', 'latex');
xlabel('x', 'Interpreter', 'latex');
ylabel('$f_{X}(x)$', 'Interpreter', 'latex');
fprintf("Total Probability : %f \n", integral(rayl, -inf, inf))
grid on;


expo = @(x) pdf('exp', x, 2);
subplot(4, 1, 4);
plot(x(x>0), expo(x(x>0)));
title('Exponential Distribution', 'Interpreter', 'latex');
xlabel('x', 'Interpreter', 'latex');
ylabel('$f_{X}(x)$', 'Interpreter', 'latex');
fprintf("Total Probability : %f \n ------ \n", integral(expo, -inf, inf))
grid on;
