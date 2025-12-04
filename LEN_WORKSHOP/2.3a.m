R = 1000;
data = readtable('table.csv');
time = data.time;
U_Mess = data.U_Mess;
U_R = U_Mess .* 2;
P = (U_R .^ 2) ./ R;

figure;
suplot(2,1,1);
plot(time, U_R);
xlabel('Zeit (s)');
ylabel('Spannung (V)');
title('Spannungsverlauf über 2 Stunden U_R(t)');
grid on;

subplot(2,1,2);
plot(time, P);
xlabel('Zeit (s)');
ylabel('Power (W)');
title('Leitsungsverlauf über 2 Stunden P(t)');
grid on;

E_Joule = trapz(t, P);
E_Wh = E_Joule ./ 3600;
