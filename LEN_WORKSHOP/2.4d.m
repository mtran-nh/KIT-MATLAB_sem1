clearvars;
clc;
close all;

C = 0.22; %faraday
R = 500; %ohm, nur fuer Entladung

data = readtable('Kondensator_01.csv');
t_total = data.time;
U_total = data.channel2;

%switch point at U_max cuz charge first till U_max
[U_max, idx_switch] = max(U_total);

%ladungsvorgang solarzelle laedt Kondensator
t_ladung = t_total(1:idx_switch);
%U = UMess *2
U_ladung = U_total(1:idx_switch) * 2;

%Entladung ueber R=500ohm
t_entladung_raw = t_total(idx_switch:end);
U_entladung = U_total(idx_switch:end) * 2; 

%BSP 
%Absolute Zeit
%t_entladung = [10.5, 10.51, 10.52, 10.53, ...]
%Relative Zeit ab Start
%t_entladung = [0.00, 0.01, 0.02, 0.03, ...]

t_entladung = t_entladung_raw - t_entladung_raw(1);

%Engergie beim Laden

%Differenz berechnen (Ableitung)
dt_ladung = diff(t_ladung);
dU_ladung = diff(U_ladung);

%Keine Division durch 0
dt_zero = find(dt_ladung == 0);
if ~isempty(dt_zero)
    fprintf('%d mal dt = 0 gefunden\n', length(dt_zero));
    min_dt = min(dt_ladung(dt_ladung > 0));
    dt_ladung(dt_ladung == 0) = min_dt;
end

% Strom durch kondensator: I_C = C * dU/dt
I_C_ladung = C * (dU_ladung ./ dt_ladung);

P_ladung = (U_ladung(2:end) .* I_C_ladung);
%E_ladung = trapz(t_ladung(2:end), P_ladung);
E_ladung = 0.5 * C * (max(U_ladung)^2);
fprintf("E_ladung: %.2f(J) \n", E_ladung);

%Energie fuer entladen
P_entladung = (U_entladung .^ 2) ./ R;
E_entladung = trapz(t_entladung, P_entladung);
fprintf("E_entladung: %.2f(J) \n", E_entladung);

%Wirkungsgrad
if E_ladung > 0
    grad = (E_entladung ./ E_ladung) .* 100;
    fprintf('Wirkungsgrad: %.2f%%\n', grad);
else
    error('E_ladung <= 0');
end

%Graphik
figure;

%Spannung beim Laden und Entladen
subplot(2, 1, 1);
plot(t_ladung * 1e6, U_ladung, 'b-', 'LineWidth', 1.5);
hold on;
plot(t_entladung * 1e6, U_entladung, 'r-', 'LineWidth', 1.5);
xlabel('Zeit [μs]');
ylabel('Spannung [V]');
legend('Laden', 'Entladen', 'Location', 'best');

grid on;

%Leistung
subplot(2, 1, 2);
plot(t_ladung(2:end), P_ladung * 1e6, '-b', 'LineWidth', 1);
hold on;
plot(t_entladung, P_entladung * 1e6, '-r', 'LineWidth', 1);
xlabel('Zeit [s]');
ylabel('Leistung [μW]');
legend('Laden', 'Entladen', 'Location', 'best');
title('Leistung');

legend('Laden', 'Entladen', 'Location', 'best');
grid on;
