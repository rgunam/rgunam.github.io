function [Xamp, Xph, swin, f] = spectrum(x, fs)
% x - señal en el dominio del tiempo
% fs - frecuencia de muestreo, Hz
% Xamp - amplitud del spectro, dB
% Xph - fase del espectro, degrees
% f - vector de frecuencias, Hz
% representa x como vector columna
x = x(:);
% longitud de la señal
N = length(x);
% ventana de tiempo
win = hanning(N, 'periodic');
%win =1;
x = x.*win;
swin=x;
% calcula FFT de x
fftx = fft(x);
% Lineas espectrales
Lineas = ceil((N+1)/2);
% fft es simétrica, tomamos solo la mitad
fftx = fftx(1:Lineas);
% normalización de la ventana de tiempo
K = sum(win)/N;
% obtiene la magnitud de fft(x) y la escala,
Xamp = abs(fftx)/N/K;
% correction of the amplitude spectrum
if rem(N, 2)        % odd N excludes Nyquist point
    Xamp(2:end) = Xamp(2:end)*2;
else                % even N includes Nyquist point
    Xamp(2:end-1) = Xamp(2:end-1)*2;
end
% conversión a dB
Xamp = 20*log10(Xamp);
% fase
Xph = angle(fftx);
% convierte fase de radianes a grados
Xph = rad2deg(Xph);
% genera el vector de frecuencias 
bins=Lineas-1;
f = (0:bins)*fs/N;
end
