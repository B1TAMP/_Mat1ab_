
%%Ackremannova metoda polohy pólů - Ackermann pole placement method

clc, clear
A = [0  1; -2  -3]
B = [0; 1]

%požadované póly - desired poles for closed loop

poles_des_cl = [-2 -5]

% matice K - get K gain 

K = acker(A,B, poles_des_cl)

% Kontrola výsledku - check the result - eigen values

A_cl = A - B*K
eig(A_cl)