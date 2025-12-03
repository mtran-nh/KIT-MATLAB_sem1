data = readtable('a.csv');
R = data.R;
U_Mess = data.U_Mess;
U_R = U_Mess .* 2;

I = U_R ./ R;

figure;
plot(U_R, I, 'LineWidth', 2);

xlabel('U_R (V)');
ylabel('I (A)');
title('U-I-Kennlinie der Solarzelle');
grid on;

P = U_R .* I;