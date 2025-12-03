% Zeitvektor von 0 bis 1 ms mit 2001 Abtastwerten
t = linspace(0, 0.001, 2001)';

% Erzeuge drei Sinus-Eingangsspannungen mit verschiedenen Frequenzen
% Jede Spannung oszilliert zwischen 0V und 5
U1 = 2.5 + 2.5 * sin(2 * pi * 1000 * t);
U2 = 2.5 + 2.5 * sin(2 * pi * 2000 * t);  
U3 = 2.5 + 2.5 * sin(2 * pi * 3000 * t);

% Kombiniere Eingangsspannungen in einer Matrix (2001x3)
Ui = [U1, U2, U3];
% Widerstandsvektor: R1=10kΩ, R2=15kΩ, R3=20kΩ, RN=5kΩ
R = [10000; 15000; 20000; 5000];
% Berechne Ausgangsspannung mit der invertAddierer Funktion
Ua = invertAddierer(Ui, R);
% Erstelle Figure mit zwei Subplots
figure;
% OBERER PLOT: Eingangsspannungen
subplot(2, 1, 1);
hold on;
plot(t * 1000, U1, 'r', 'LineWidth', 1.5);
plot(t * 1000, U2, 'g', 'LineWidth', 1.5); 
plot(t * 1000, U3, 'b', 'LineWidth', 1.5);
hold off;
xlabel('Zeit [ms]');
ylabel('Spannung [V]');
title('Eingangsspannungen des invertierenden Addierers');
grid on;

% UNTERER PLOT: Ausgangsspannung
subplot(2, 1, 2);
plot(t * 1000, Ua, 'k', 'LineWidth', 2);
xlabel('Zeit [ms]');
ylabel('Spannung [V]');
title('Ausgangsspannung des invertierenden Addierers');
grid on;
