c = 3e8;
fc = 500;
lambda = c/fc;
fs = 10*fc;
Gr = 1;
Gt = 1;
d = 2e5;
h_t = sqrt(Gr*Gt*lambda^2/4/pi/d^2);

T = 10;
A = 25;
t = -0.5:1/fs:0.5;
fig1 = figure(1);
% fig1.Position = [500 500 1.5*fig1.Position(3:4)]; 
freq = linspace(-fs/2, fs/2, length(t));
spect = @(t) fftshift(abs(fft(t)))/fs;

for k=0:T-1
    U = randi(5,1);
    m_t = 20*U*sinc(20*U*t);    
    car = A*cos(2*pi*fc*(t+k));
    m_tx = (car + car.*m_t/A)*h_t + 0.01*randn(1, length(t));
    m_rx = abs(hilbert(m_tx)/h_t) - A;
    
    subplot(2,2,1);
    plot(t+k, m_tx);
    xlim([-0.5 T-1.5]);
    xlabel('Time', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');
    title('$m_{Tx}(t)$', 'Interpreter', 'latex');
    hold on;
    
    subplot(2,2,2);
    plot(freq, spect(m_tx));
    xlabel('Frequency', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');
    title('$M_{Tx}(t)$', 'Interpreter', 'latex');
    xlim([-250 250]);
    
    subplot(2,2,3);
    plot(t+k, m_rx);
    xlim([-0.5 T-1.5]);
    xlabel('Time', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');
    title('$m_{Rx}(t)$', 'Interpreter', 'latex');
    hold on;
    
    subplot(2,2,4);
    plot(freq, spect(m_rx));
    xlabel('Frequency', 'Interpreter', 'latex');
    ylabel('Amplitude', 'Interpreter', 'latex');
    title('$M_{Rx}(t)$', 'Interpreter', 'latex');
    xlim([-250 250]);
    pause(1);
end

hold off;