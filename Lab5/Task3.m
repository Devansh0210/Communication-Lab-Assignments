sigma = 0.1; % sqrt(variance) of noise(AWGN)
fs = 100;
N = 30*fs;
N1 = 10;
m_t = @(t) 2*N1*sinc(2*N1*t);
a = 0.5;


% ---- Transmitting -----
sig_tx = [];
figure;
T_int = 10;
t = -T_int/2:1/fs:T_int/2-1/fs;
for k=1:30
    n_t = randn(1, fs*T_int)*sigma;
    x = m_t(t);
    y = a*x + n_t;
    sig_tx = [sig_tx y];
    f = linspace(-fs/2, fs/2, fs*T_int);
    y_f = fftshift(abs(fft(y)))/fs;
    sig_fft = fftshift(abs(fft(sig_tx)))/fs;
    sig_freq = linspace(-fs/2, fs/2, k*fs*T_int);
    
    subplot(3, 1, 2);
    plot(f, y_f);
    xlim([-2*N1 2*N1]);
    title('FFT($m(t)$)', 'Interpreter', 'latex');
    xlabel('Frequency', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');
    subplot(3, 1, 3);
    plot(sig_freq, sig_fft);
    title('FFT($m(t)$) whole signal', 'Interpreter', 'latex');
    xlabel('Frequency', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');
    xlim([-2*N1 2*N1])
    subplot(3, 1, 1);
    plot(sig_tx);
    title('$m(t)$', 'Interpreter', 'latex');
    xlabel('Time', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');
    xlim([0 T_int*N]);
    pause(1);
end