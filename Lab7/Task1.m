%% Task-1

N = 25;
fc = 100;
A = 2;
A1 = 10;
fs = 10*fc;

T = 10;

t = 0:1/fs:1;

figure(1);
figure(2);

figs = [figure(1), figure(2)];   %as many as needed
nfig = length(figs);
frac = 1/nfig;
for K = 1 : nfig
  old_pos = get(figs(K), 'Position');
  set(figs(K), 'Position', [old_pos(1) + (-1)^K*(old_pos(3)/2 + 10), old_pos(2), old_pos(3), old_pos(4)]);
end

hold on;
spect = @(t) fftshift(abs(fft(t)))/fs;
freq = linspace(-fs/2, fs/2, length(t));

for k=1:T
    car = cos(2*pi*fc*t);
    car_sin = sin(2*pi*fc*t);
    m1_t = randi(10, 1)*cos(2*pi*N*(t));
    m_dsb_sc = m1_t.*(A*car);
    m_am = (A1+m1_t).*car;
    m1_h = imag(hilbert(m1_t));
    
    m1_lsb = m1_t.*car + m1_h.*car_sin;
    m1_usb = m1_t.*car - m1_h.*car_sin;
    
    figure(1);
    subplot(4, 1, 1);
    plot(t, m_dsb_sc);
    xlim([0 T]);
    xlabel('Time(s)', 'Interpreter', 'latex');
    ylabel('Amplitude(V)', 'Interpreter', 'latex');
    title('$$\varphi_{DSB-SC}(t)$$', 'Interpreter', 'latex');
    grid on;
    hold on;

    subplot(4, 1, 2);
    plot(t, m_am);
    grid on;
    xlim([0 T]);
    xlabel('Time(s)', 'Interpreter', 'latex');
    ylabel('Amplitude(V)', 'Interpreter', 'latex');
    title('$$\varphi_{AM}(t)$$', 'Interpreter', 'latex');

    hold on;
    
    subplot(4,1,3);
    plot(t, m1_lsb);
    grid on;
    xlim([0 T]);
    xlabel('Time(s)', 'Interpreter', 'latex');
    ylabel('Amplitude(V)', 'Interpreter', 'latex');
    title('$$\varphi_{LSB}(t)$$', 'Interpreter', 'latex');
    
    hold on;
    
    subplot(4,1,4);
    plot(t, m1_lsb);
    grid on;
    xlim([0 T]);
    xlabel('Time(s)', 'Interpreter', 'latex');
    ylabel('Amplitude(V)', 'Interpreter', 'latex');
    title('$$\varphi_{USB}(t)$$', 'Interpreter', 'latex');

    hold on;
    
    figure(2);
    
    subplot(4, 1, 1);
    plot(freq, spect(m_dsb_sc));
    xlim([-200 200]);
    title('$\Phi_{DSB-SC}(f)$', 'Interpreter', 'latex');
    xlabel('Frequency(Hz)', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');
    grid on;
    
    subplot(4, 1, 2);
    plot(freq, spect(m_am));
    xlim([-200 200]);
    title('$\Phi_{AM}(f)$', 'Interpreter', 'latex');
    xlabel('Frequency(Hz)', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');
    grid on;
    
    subplot(4, 1, 3);
    plot(freq, spect(m1_lsb));
    xlim([-200 200]);
    title('$\Phi_{LSB}(f)$', 'Interpreter', 'latex');
    xlabel('Frequency(Hz)', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');
    grid on;
    
    subplot(4, 1, 4);
    plot(freq, spect(m1_usb));
    xlim([-200 200]);
    title('$\Phi_{USB}(f)$', 'Interpreter', 'latex');
    xlabel('Frequency(Hz)', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');
    grid on;
    
    t = t + 1;
    pause(1)

end

hold off;