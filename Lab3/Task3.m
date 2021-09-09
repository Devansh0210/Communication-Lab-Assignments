B = 10;
A = 0.01;
fs = 5*B;
fm = 5;


t_start=-10;
t_end= 10;
t = t_start:1/fs:t_end;

h_t = 2*0.1*sinc(2*B*t);
N = length(h_t);
h_f = fft(h_t, N)/fs;
h_f_abs = abs(h_f);
h_f = fftshift(h_f_abs);
freq_axis = linspace(-fs/2, fs/2, N);

m_t = 2*fm*sinc(2*fm*t);
m_f = fftshift(abs(fft(m_t)))/fs;

x_t = conv(h_t, m_t, 'same');
x_f = fftshift(abs(fft(x_t)))/fs;

figure;
subplot(5, 1, 1);
plot(t, m_t);
% title('Sinc Channel Effect', 'interpreter', 'latex');
xlabel('Time(s)', 'interpreter', 'latex');
ylabel('Amplitude', 'interpreter', 'latex');
legend('$m(t)$', 'interpreter', 'latex');

subplot(5, 1, 2);
plot(t, x_t);
xlabel('Time(s)', 'interpreter', 'latex');
ylabel('Amplitude', 'interpreter', 'latex');
legend('$x(t)$', 'interpreter', 'latex');

subplot(5, 1, 3);
plot(freq_axis, m_f);
xlabel('Frequency(Hz)', 'interpreter', 'latex');
ylabel('Amplitude', 'interpreter', 'latex');
legend('$|M(f)|$', 'interpreter', 'latex');

subplot(5, 1, 4);
plot(freq_axis, x_f);
xlabel('Frequency(Hz)', 'interpreter', 'latex');
ylabel('Amplitude', 'interpreter', 'latex');
legend('$|X(f)|$', 'interpreter', 'latex');

subplot(5, 1, 5);
plot(freq_axis, h_f);
xlabel('Frequency(Hz)', 'interpreter', 'latex');
ylabel('Amplitude', 'interpreter', 'latex');
legend('$|H(f)|$', 'interpreter', 'latex');