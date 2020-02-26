clear all
close all
clc

N=1000; %N�mero de muestras

A=1; %amplitud de la se�al de ruido

y=A*randn(N,1); %genera una secuencia de N n�meros aleatorios 
                  %con distribuci�n normal

%gr�fica de la secuencia
figure
plot(y)

%An�lisis de la secuencia aleatoria con la funci�n fitdist
%devuelve los valores de la PDF que se ajustan a la secuencia
%de datos aleatorios
params=fitdist(y,'Normal');

%Imprime el valor medio
sprintf('El valor medio es %d:',params.mu)

%Imprime la desviaci�n est�ndat
sprintf('La desviaci�n est�ndar es %d:',params.sigma)

%Generaci�n del histograma de la secuencia de n�meros aleatorio
bins=10; %Divisiones del n�mero total de muestras: N/bins

%gr�fica del histograma y la PDF juntas
figure
pd=histfit(y,bins,'Normal');