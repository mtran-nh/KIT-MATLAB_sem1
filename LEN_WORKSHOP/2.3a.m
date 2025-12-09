clearvars;
clc;
close all;

%Daten einlesen
R = 1000; %ohm
data = readtable('langzeitsmessung.csv');
time = data.time; %sekunden
U_Mess = data.channel2;
U_R = U_Mess .* 2;
P = (U_R .^ 2) ./ R; %Watt

%Spannung
figure;
subplot(2,1,1);
plot(time, U_R);
xlabel('Zeit (s)');
ylabel('Spannung (V)');
title('Spannungsverlauf über 2 Stunden U_R(t)');
grid on;
legend('U_R(t)', 'Location', 'best');

%Leistung
subplot(2,1,2);
plot(time, P);
xlabel('Zeit (s)');
ylabel('Leistung (W)');
title('Leitsungsverlauf über 2 Stunden P(t)');
grid on;
legend('P(t)', 'Location', 'best');

%Energie berechnen
E_Joule = trapz(time, P);
E_Wh = E_Joule ./ 3600;
fprintf('E = %.4f Wh\n', E_Wh);