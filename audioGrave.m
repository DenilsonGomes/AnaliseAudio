% Autor: Denilson Gomes Vaz da Silva
% Departamento de Engenharia de Computação
% Script para exemplificar filtro passa-baixa e passa-alta
% Aplicando-os em audios: Grave e Agudo
% Breakpoints para acompanhar Plotagens e Reproduções
% linhas[27,35,43,51,58,67,75]

clear
close all
clc

%Audio grave (Homenagem a Vitas)
[y,Fs]= audioread('botao.wav'); %Carrega o audio
y = y(:,1);
y = y(1:5:end);
Fs = Fs/5;

plot(y) %Plota o sinal
% tempo_vec = (1:length(y)); %tempo
title('Sinal no tempo') %Titulo
ylabel('Amplitude do Sinal') %legenda
xlabel('Tempo discreto') %legenda

sound(y,Fs) %reproduz o audio

% Transformada de Fourier
Yw = fftshift(fft(y)); %TF centrada no zero
freq_vec = linspace(-pi,pi,length(y)); %Frequencias
figure,plot(freq_vec,abs(Yw),'b') %Plota a TF do sinal
title('Transformada de Fourier do Sinal') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

%Filtro Passa-Baixa
wc1 = 0.15*pi; %Frquencia de corte
[B,A] = butter(20, wc1/pi);
[H,W] = freqz(B,A,length(y));
figure,plot(W,abs(H)) %Plota filtro Passa-Baixa
title('Transformada de Fourier do Filtro') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

y_filt = filter(B,A,y); %Sinal filtrado
figure,plot(real(y_filt)) %Plota o sinal filtrado
title('Sinal Filtrado no tempo') %Titulo
ylabel('Amplitude do Sinal Filtrado') %legenda
xlabel('Tempo discreto') %legenda

sound(real(2*y_filt),Fs) %reproduz o audio filtrado (passa-baixa) w<wc1

Yw_filt = fftshift(fft(y_filt)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(Yw_filt)); %Frequencias
figure,plot(freq_vec,abs(Yw_filt)) %Plota TF do sinal filtrado
title('Transformada de Foutier do Sinal Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda
% Filtro Passa-Alta
wc1 = 0.6*pi; %Frequencia de corte
[B,A] = butter(20, wc1/pi, 'high'); %Coeficientes do filtro
[H,W] = freqz(B,A,length(y));
figure,plot(W,abs(H)) %Plota o modulo do filtro Passa-Alta
title('Transformada de Fourier do Filtro') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda

%Filtrar o sinal
y_filt = filter(B,A,y); %Filtra o sinal
figure,plot(y_filt) %Plota o sinal filtrado
title('Sinal Filtrado') %Titulo
ylabel('Amplitude do Sinal Filtrado') %legenda
xlabel('Tempo discreto') %legenda

sound(real(2*y_filt),Fs) %reproduz o audio filtrado (passa-alta) w>wc1

Yw_filt = fftshift(fft(y_filt)); %TF centrada no zero do sinal filtrado
freq_vec = linspace(-pi,pi,length(Yw_filt)); %Frequencias
figure,plot(freq_vec,abs(Yw_filt)) %Plota TF do sinal filtrado
title('Transformada de Foutier do Sinal Filtrado') %Titulo
ylabel('Espectro de magnitude') %legenda
xlabel('Frequencia em Rad/s') %legenda