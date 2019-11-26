clear all
close all
clc
daqreset

%% Parámetros de adquisición
fs = 44100;     % frecuencia de muestreo
dur = 30;       % duración
prw = fs/2;     % datos p/previsualización
%% Busca los dispositivos de Adqusición de Datos disponibles
d = daq.getDevices
%% Selecciona el Micrófono (Entrada Analógica)
%cambiar el número por el que corresponda
dev = d(2)

%% Crea una Sesión de Audio
s = daq.createSession('directsound');
%Prepara la entrada analógica 
%agregando un canal de audio
addAudioInputChannel(s, dev.ID, 1:2);


%Configura parámetros definidos previamente
set(s, 'Rate', fs);
set(s, 'DurationInSeconds', dur);
set(s, 'NotifyWhenDataAvailableExceeds', prw);

%% Agrega un "Listener" para graficar continuamente
% La función "grafica" debe estar en el mismo directorio
%Listener = addlistener(s, 'DataAvailable', @grafica);   
Listener = addlistener(s, 'DataAvailable', @analizador);  

%% Comienza la adquisición 
startBackground(s)
wait(s)

%%  
% deshabilita la sesión DAQ
release(s)
delete(Listener)
disp('Fin de la adquisición')
commandwindow

