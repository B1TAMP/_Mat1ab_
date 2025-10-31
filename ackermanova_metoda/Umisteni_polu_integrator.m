%%
clc, clear

m = 8
b = 0.5
k = 2

A = [0 1; -k/m -b/m]
B = [0; 1/m]
C = [1 0]   %C = eye(2)
D = [0]

%augmented ss
A2 = [A [0; 0 ]; -C 0]
B2 = [B; 0]

%desired poles of closed system
 poles_des_cl = [-2+0.1i; -2-0.1i; -6]

 %place the desire poles
 K = place(A2, B2, poles_des_cl)

 %check the closed loop ----> poles = ?
 A_cl = A2 - B2*K  a
 eig(A_cl)

 %split K = [K_x, K_i]

 K_x = K(1:2)
 K_i = K(3)