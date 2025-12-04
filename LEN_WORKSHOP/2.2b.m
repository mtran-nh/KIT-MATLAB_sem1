clearvars;
clc;
close all;

files = {'1stlight.csv', '2ndlight.csv', '3rdlight.csv'}
colors = {'r', 'b', 'g'}

figure

for n = 1:length(files)
    data = readmatrix(files{k});
    R = data.R;
    U_Mess = data.U_Mess;
    U_R = U_Mess .* 2;
    I = U_R ./ R;
    plot(U_R, I, 'Color', colors{n}, 'LineWidth', 2);
end

xlabel('U_R (V)');
ylabel('I (A)');
title('U-I-Kennlinien für 3 Lichtquellen');
legend('Lichtquelle 1', 'Lichtquelle 2', 'Lichtquelle 3');