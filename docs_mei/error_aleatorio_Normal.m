clear all
close all
clc

N=1000; %Número de muestras

A=1; %amplitud de la señal de ruido

y=A*randn(N,1); %genera una secuencia de N números aleatorios 
                  %con distribución normal

%gráfica de la secuencia
figure
plot(y)

%Análisis de la secuencia aleatoria con la función fitdist
%devuelve los valores de la PDF que se ajustan a la secuencia
%de datos aleatorios
params=fitdist(y,'Normal');

%Imprime el valor medio
sprintf('El valor medio es %d:',params.mu)

%Imprime la desviación estándat
sprintf('La desviación estándar es %d:',params.sigma)

%Generación del histograma de la secuencia de números aleatorio
bins=10; %Divisiones del número total de muestras: N/bins

%gráfica del histograma y la PDF juntas
figure
pd=histfit(y,bins,'Normal');