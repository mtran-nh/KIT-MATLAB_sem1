clearvars;
clc;
close all;

C = 100 * e-9; %faraday
R = 500; %ohm, nur fuer Entladung

%ladungsvorgang solarzelle laedt Kondensator
ladung_data = readtable('filename.csv');
t_ladung = ladung_data.Zeit;
%U = UMess *2
U_ladung = ladung_data.Spannung .* 2;

%Entladung ueber R=500ohm
entladung_data = readtable('entladungsfile.csv');
t_entladung = entladung_data.Zeit;
U_entladung = entladung_data.Spannung .* 2; 

%BSP 
%Absolute Zeit
%t_entladung = [10.5, 10.51, 10.52, 10.53, ...]
%Relative Zeit ab Start
%t_entladung = [0.00, 0.01, 0.02, 0.03, ...]

t_entladung = t_entladung - t_entladung(1);

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

%Negative Ströme entfernen (beim Laden sollte I > 0)
neg_strom = find(I_C_ladung < 0);
if ~isempty(neg_strom)
    fprintf('%d negative Ströme beim Laden\n', length(neg_strom));
    I_C_ladung(I_C_ladung < 0) = 0;
end

P_ladung = U_ladung(2:end) .* I_C_ladung;
E_ladung = trapz(t_ladung(2:end), P_ladung);

%Energie fuer entladen
P_entladung = (U_entladung .^ 2) ./ R;
E_entladung = trapz(t_entladung, P_entladung);

%Wirkungsgrad
if E_ladung > 0
    grad = (E_entladung ./ E_ladung) .* 100;
    fprintf('Wirkungsgrad: %.2f%%\n', grad);
else
    error('E_ladung <= 0');
end

%Graphik
figure;

%Spannung beim Laden
subplot(3, 1, 1);
plot(t_ladung, U_ladung, 'b-', 'LineWidth', 1.5);
xlabel('Zeit [s]');
ylabel('Spannung [V]');
title('Ladevorgang');
grid on;

%Spannung beim Entladen
subplot(3, 1, 2);
plot(t_entladung * 1e6, U_entladung, 'r-', 'LineWidth', 1.5);
xlabel('Zeit [μs]');
ylabel('Spannung [V]');
title('Entladevorgang');
grid on;

%Leistung
subplot(3, 1, 3);
plot(t_ladung(2:end), P_ladung * 1e6, '-b', 'LineWidth', 1);
hold on;
plot(t_entladung, P_entladung * 1e6, '-r', 'LineWidth', 1);
xlabel('Zeit [s]');
ylabel('Leistung [μW]');
title('Leistung');

legend('Laden', 'Entladen', 'Location', 'best');
grid on;
