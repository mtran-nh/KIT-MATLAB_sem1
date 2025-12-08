clearvars;
clc;
close all;

files = {'LED_1.csv', 'Fluo_1.csv', 'Normale_lampe_1.csv'};
colors = {'r', 'b', 'g'};

figure;
hold on;

for n = 1:length(files)
    data = readmatrix(files{n});
    R = data(:,4);
    U_Mess = data(:,3);
    U_R = U_Mess .* 2;
    I = U_R ./ R;
    P = U_R .* I;

    %MPP finden
    [P_max, idx] = max(P);
    U_MPP = U_R(idx);
    I_MPP = I(idx);

    yyaxis left;
    plot(U_R, I, '--', 'Color', colors{n}, 'LineWidth', 2);
    ylabel('I (A)');

    yyaxis right;
    plot(U_R, P, '-', 'Color', colors{n}, 'LineWidth', 2);
    ylabel('P (W)');

    plot (U_MPP, P_max, 'ko', 'MarkerSize', 8, 'LineWidth', 2);

    fprintf('MPP für %s: U = %.3f V, I = %.3f A, P = %.3f W\n', ...
            files{n}, U_MPP, I_MPP, P_max);
end

yyaxis left;
xlabel('U_R (V)');
title('U-I und P-U Kennlinien mit MPP');
legend('U-I LED', 'P-U LED', 'U-I Fluo', 'P-U Fluo', 'U-I Normal', 'P-U Normal', 'MPP');
grid on;