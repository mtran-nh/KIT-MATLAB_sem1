U0 = 20;
Ri = 10;
Rl = linspace(0, 100, 2001)';

% Berechnung der Leistung und Wirkungsgrad
[Pl, eff] = VerbraucherLeistung(Ri, Rl, U0);
% Neue Figure erstellen
figure;
% Plot der Verbraucherleistung (linke y-Achse)
plot(Rl./Ri, Pl, 'r', 'LineWidth', 2);
xlabel('Widerstandverhaeltnis Rl/Ri');
ylabel('VerbraucherLeistung');
grid on;

% Rechte y-Achse für Wirkungsgrad
yyaxis right
% Plot des Wirkungsgrads (rechte y-Achse)
plot(Rl./Ri, eff, 'b', 'LineWidth', 2);
ylabel('Wirkungsgrad');
grid on;
% Titel der Grafik
title('Widerstandverhaeltnis vs VerbraucherLeistung und Wirkungsgrad');