clearvars;
clear;
clc;

data = readtable('filepath.csv');
t = data.Zeit - data.Zeit(1);
U = data.Spannung .* 2;

%fuer Text
R = 500; %Ohm
C = 100e-9; %Faraday
tau_theorie = R .* C; 

%fuer Messung
figure;
plot(t*1e6, U, '-b', 'LineWidth', 2);
xlabel('Zeit t [μs]');
ylabel('Kondensatorspannung U_C [V]');
title('Gemessene Entladekurve (R=500Ω, C=100nF)');
grid on;
