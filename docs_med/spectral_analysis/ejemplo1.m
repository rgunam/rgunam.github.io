clear, clc, close all
% parámetros 
fs = 44100;
T = 0.1;
N = 4096;%round(T*fs);
t = (0:N-1)/fs;
% generación de la señal
f1=1000;
f2=1500;
x1 = sin(2*pi*f1*t);
x2 = sin(2*pi*f2*t);
e = 0.01*randn(1, N); %ruido aditivo
x = x1 + x2 + e;
% análisis espectral
[Xamp,~,swin, freq] = spectrum(x, fs);
% plot
figure(1)
plot(freq/1000, Xamp, 'r') 
grid on
xlim([0 max(freq/1000)])
ylim([-120 max(Xamp)+10])
xlabel('Frequencia, kHz') 
ylabel('Magnitud, dB')
title('Amplitud del spectro de las señales') 

figure(2)
plot(x)
hold on
plot(swin)