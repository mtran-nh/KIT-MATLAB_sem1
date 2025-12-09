clearvars;
clear;
clc;

% Messung ohne Kondensator
data_noC = readtable('Ub2_5_ohne_kondensator.csv');

% Messung mit Kondensator
data_mitC = readtable('2.5Mit_kondensator.csv');

zeit_noC = data_noC.time;
U_noC = data_noC.channel2 .* 2;

zeit_mitC = data_mitC.time;
U_mitC = data_mitC.channel2 .* 2;

t0 = min([zeit_noC(1), zeit_mitC(1)]);
zeit_noC = zeit_noC - t0;
zeit_mitC = zeit_mitC - t0;

figure;
hold on;
grid on;
plot(zeit_noC, U_noC, 'b-', 'LineWidth', 1.5);
plot(zeit_mitC, U_mitC, 'r-', 'LineWidth', 1.5);

xlabel('Zeit [s]');
ylabel('Spannung über R [V]');
title('Vergleich der Lastspannung: ohne vs. mit Speicherkondensator');
legend('Ohne Kondensator', 'Mit Kondensator');