clearvars;
clc;
close all;

%filename einsetzen, data exportieren
data = readtable('LED_1.csv');

U_Mess = data.channel2;
R = data.R;
U_R = U_Mess .* 2;

I = U_R ./ R;

%graph
figure;
plot(U_R, I, 'LineWidth', 2);

xlabel('U_R (V)');
ylabel('I (A)');
title('U-I-Kennlinie der Solarzelle mit LED');
grid on;

%Leistung
P = U_R .* I;
