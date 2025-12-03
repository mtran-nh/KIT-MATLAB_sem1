data = readtable('a.csv');
R = data.R;
U_Mess = data.U_Mess;
U = U_Mess .* 2;

I = U ./ R;

figure;
plot(U, I, 'LineWidth', 2);

xlabel('U (V)');
ylabel('I (A)');
title('U-I-Kennlinie der Solarzelle');
grid on;

P = U .* I;