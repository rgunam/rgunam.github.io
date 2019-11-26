clear all
close all
clc
daqreset

%% Par�metros de adquisici�n
fs = 44100;     % frecuencia de muestreo
dur = 30;       % duraci�n
prw = fs/2;     % datos p/previsualizaci�n
%% Busca los dispositivos de Adqusici�n de Datos disponibles
d = daq.getDevices
%% Selecciona el Micr�fono (Entrada Anal�gica)
%cambiar el n�mero por el que corresponda
dev = d(2)

%% Crea una Sesi�n de Audio
s = daq.createSession('directsound');
%Prepara la entrada anal�gica 
%agregando un canal de audio
addAudioInputChannel(s, dev.ID, 1:2);


%Configura par�metros definidos previamente
set(s, 'Rate', fs);
set(s, 'DurationInSeconds', dur);
set(s, 'NotifyWhenDataAvailableExceeds', prw);

%% Agrega un "Listener" para graficar continuamente
% La funci�n "grafica" debe estar en el mismo directorio
%Listener = addlistener(s, 'DataAvailable', @grafica);   
Listener = addlistener(s, 'DataAvailable', @analizador);  

%% Comienza la adquisici�n 
startBackground(s)
wait(s)

%%  
% deshabilita la sesi�n DAQ
release(s)
delete(Listener)
disp('Fin de la adquisici�n')
commandwindow

