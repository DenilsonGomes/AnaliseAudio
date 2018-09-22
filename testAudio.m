% Autor: Denilson Gomes Vaz da Silva
% Departamento de Engenharia de Computação
% Script para exemplificar filtro passa-baixa e passa-alta

clear
close all
clc

[y,Fs]= audioread('Gravação2.m4a'); %Carrega o audio

y = y(:,1);
y = y(1:5:end);
Fs = Fs/5;

plot(y) %Plota o sinal
tempo_vec = (1:length(y)); %tempo
ylabel('Amplitude do Sinal')
xlabel('Tempo discreto')

% Transformada de Fourier
Yw = fftshift(fft(y)); %TF
freq_vec = linspace(-pi,pi,length(y)); %Frequencias
figure,plot(freq_vec,abs(Yw),'b') %Plota a TF do sinal
ylabel('Espectro de magnitude')
xlabel('Frquencia em Rad/se')

sound(y,Fs)

wc1 = 0.15*pi; %Frquencia de corte
[B,A] = butter(20, wc1/pi);
[H,W] = freqz(B,A,length(y));
figure,plot(W,abs(H)) %Plota filtro Passa-Baixa
y_filt = filter(B,A,y);
figure,plot(real(y_filt)) %Plota o sinal filtrado
ylabel('Amplitude do Sinal Filtrado')
xlabel('Tempo discreto')

sound(real(2*y_filt),Fs)

Yw_filt = fftshift(fft(y_filt));
freq_vec = linspace(-pi,pi,length(Yw_filt));
figure,plot(freq_vec,abs(Yw_filt)) %Plota TF do sinal filtrado
ylabel('Espectro de magnitude do Sinal Filtrado')
xlabel('Frquencia em Rad/s')

% Filtro PassaBanda
wc1 = 0.44*pi; %Frquencia inicial
wc2 = 0.9*pi; %Frquencia final
[B,A] = butter(20, [wc1/pi,wc2/pi]); %Coeficientes do filtro PB
[H,W] = freqz(B,A,length(y));
figure,plot(W,abs(H)) %Plota o modulo do filtro Passa-Banda
ylabel('Modulo do Filtro') %legenda eixo y
xlabel('Frequencia') %legenda eixo x

%Filtrar o sinal
y_filt = filter(B,A,y); %Filtra o sinal com ruido
figure,plot(y_filt) %Plota o sinal filtrado
ylabel('Amplitude do Sinal Filtrado')
xlabel('Tempo')

sound(real(2*y_filt),Fs)