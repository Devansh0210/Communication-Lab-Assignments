% ----- Task-4 ------

[audio, afs] = audioread('sample_a.wav');
audio = audio(:, 1)';
audio = decimate(audio, 5); 
afs = afs/5;
N = length(audio);
freq = linspace(-afs/2, afs/2, N);
t_ch = 1;
t = -t_ch:1/afs:t_ch-1/afs;

% ------------
B = 1.5e3; % Bandwidth of Channel
sigma = 0.1; % sqrt(variance) of noise(AWGN)
% ------------

h = 2*B*sinc(2*B*t); % Channel Response

Y_f = fftshift(abs(fft(audio)));

figure(1);
subplot(4, 1, 4);
plot(freq, Y_f);
title('Audio Signal Spectrum', 'Interpreter', 'latex');
xlabel('Frequency', 'Interpreter', 'latex');
ylabel('Amplitude', 'Interpreter', 'latex');

% Y_t = conv(audio, h, 'same');
% Y_f = fftshift(abs(fft(Y_t)))';
% figure;
% plot(freq, Y_f);

% ---- Transmitting -----
sig_tx = [];

for k=1:30
    if k*afs <= N
        x = audio((k-1)*afs+1:k*afs);
    else
        x = audio((k-1)*afs+1:end);
    end
    n_t = randn(1, afs)*sigma;
    y = conv(x, h, 'same')/afs + n_t;
    sig_tx = [sig_tx y];
    f = linspace(-afs/2, afs/2, afs);
    y_f = fftshift(abs(fft(y)))/afs;
    sig_fft = fftshift(abs(fft(sig_tx)))/afs;
    sig_freq = linspace(-afs/2, afs/2, k*afs);
    
    subplot(4, 1, 2);
    plot(f, y_f);
    title('FFT($m(t)$)', 'Interpreter', 'latex');
    xlabel('Frequency', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');
    
    subplot(4, 1, 3);
    plot(sig_freq, sig_fft);
    title('FFT($m(t)$) whole signal', 'Interpreter', 'latex');
    xlabel('Frequency', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');
    subplot(4, 1, 1);
    plot(sig_tx);
    title('$m(t)$', 'Interpreter', 'latex');
    xlabel('Time', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');
    xlim([0 N]);
    pause(1);
end