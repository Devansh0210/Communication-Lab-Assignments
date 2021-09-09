B = 10;
A = 0.01;
fs = 5*B;

t_start=-10;
t_end= 10;
t = t_start:1/fs:t_end;

h_t = 2*0.1*sinc(2*B*t);

N = length(h_t);
h_f = fft(h_t, N)/fs;
h_f_abs = abs(h_f);
freq_axis = linspace(-fs/2, fs/2, N);

figure
subplot(2,1,1); 
plot(t, h_t)
title('Channel $h(t)$', 'interpreter', 'latex');
xlabel('Time(s)', 'interpreter', 'latex')
ylabel('Amplitude', 'interpreter', 'latex')
legend('$h(t)$', 'interpreter', 'latex');
grid on;

subplot(2,1,2); 
plot(freq_axis,fftshift(h_f_abs))
grid on;
xlabel('Frequency(Hz)', 'interpreter', 'latex');
ylabel('Amplitude', 'interpreter', 'latex');
legend('$H(f)$', 'interpreter', 'latex');
