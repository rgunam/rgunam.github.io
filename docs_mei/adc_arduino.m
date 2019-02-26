%Script para comunicar ARDUINO con MATLAB
%MATLAB realiza la lectura del puerto serial COMX en donde
%Arduino se encuentre conectado

%Arduino lee UN SOLO CANAL ANAL�GICO y env�a el dato por UART

 
clear all
close all
clc
 
%Propiedades a definir
serialPort = 'COM3';            % define # puerto COM 
plotTitle = '';                 % t�tulo de la gr�fica
xLabel = 'Tiempo(s)';           % x-axis label
yLabel = 'Dato';                % y-axis label
plotGrid = 'on';                % 'off' si deseamos quitar cuadr�cula en la gr�fica
min = -1;                       % establece escala eje y-min
max = 1;                        % establece escala eje y-max
scrollWidth = 20;               % ventana de tiempo
delay = .01;                     % tiempo entre muestras
 
%Define variables de funcionamiento
time = 0;               %tiempo
data = 0;               %datos adquiridos
count = 0;              %contador de control
 
%Prepara la gr�fica
plotGraph = plot(time,data,'-b','LineWidth',1);
xlabel(xLabel,'FontSize',12);  %Etiqueta eje x
ylabel(yLabel,'FontSize',12);   %Etiqueta eje y
axis 'auto y';          %autoescala en eje y
grid(plotGrid);         %pone cuadr�cula
 
%Abre el puerto serial COM
s = serial(serialPort)
disp('Si desea terminar la ejecuci�n cierre la grafica');      %Leyenda al finalizar la ejecuci�n
fopen(s);
dat = fscanf(s,'%d %d'); %Lee el dato del puerto serial en formato entero
tic %tiempo inicial
i=0; 
while ishandle(plotGraph) %Ciclo permanente mientras la ventana est� abierta
    dat = fscanf(s,'%d'); %Lee el dato del puerto serial en formato entero
    i=i+1
    if(~isempty(dat) && isfloat(dat)) %Verifica el tipo de dato     
        count = count + 1;    
        time(count) = toc;    %Extrae el tiempo acumulado
        data(count) = dat(1); %Extrae el dato      
         
        %Esta funci�n es para dar efecto de un Osciloscopio (NO MODIFICIAR)
        if(scrollWidth > 0)
        set(plotGraph,'XData',time(time > time(count)-scrollWidth),'YData',data(time > time(count)-scrollWidth));
        axis([time(count)-scrollWidth time(count) min max]);
        axis 'auto y'
        else
        set(plotGraph,'XData',time,'YData',data);
        axis([0 time(count) min max]);
        axis 'auto y'
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
        %Actualiza gr�fica
        pause(delay);
    end
end
 
%Cierra el puerto y elimina variables que ya no se utilizar�n
fclose(s);
clear count dat delay max min plotGraph plotGrid plotTitle s ...
        scrollWidth serialPort xLabel yLabel;
 
 
disp('Termino ejecuci�n...');