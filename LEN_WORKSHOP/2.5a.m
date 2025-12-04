clearvars;
clear;
clc;

% Messung ohne Kondensator
data_noC = readtable('no_C.csv');

% Messung mit Kondensator
data_mitC = readtable('mit_C.csv');

zeit_noC = data_noC.Zeit;
U_noC = data_noC.Spannung .* 2;

zeit_mitC = data_mitC.Zeit;
U_mitC = data_mitC.Spannung .* 2;

t0 = min([ziet_noC(1), zeit_mitC(1)]);
zeit_noC = zeit_noC - t0;
zeit_mitC = zeit_mitC - t0;

figure;
hold on;
grid on;
plot(zeit_noC, U_noC, 'b-', 'LineWidth', 1,5);
plot(zeit_mitC, U_mitC, 'r-', 'LineWidth', 1,5);

xlabel('Zeit [s]');
ylabel('Spannung über R [V]');
title('Vergleich der Lastspannung: ohne vs. mit Speicherkondensator');
legend('Ohne Kondensator', 'Mit Kondensator');
