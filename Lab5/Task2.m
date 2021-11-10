mu = 0;
sigma = sqrt(14);

N = 1e4;
n_t = [];
p = 0;
x_th = sigma;
for k=1:N
    no = sigma*(randn()) + mu;
    if no > x_th
        p = p+1;
    end
  
    n_t = [n_t no];
end
% Simulated
p_calc = p/N;

% Thoretical
p_th = qfunc((x_th - mu)/sigma);
fprintf("Calculated Probability : %f and Thoretical Probability : %f\n", p_calc, p_th);
% ---------

figure;
hist(n_t, 50);
title('Histogram', 'Interpreter', 'latex');
hold on;
xline([mu], 'r--');
hold off;
grid on;

[n_acf, lags] = xcorr(n_t);
n_acf = n_acf;
figure;
plot(lags, n_acf);
title('ACF - $R_{xx}(\tau)$', 'Interpreter', 'latex');

nt_PSD = fftshift(abs(fft(n_acf)));
figure;
plot(nt_PSD);
title('PSD - $S_x(f)$', 'Interpreter', 'latex');