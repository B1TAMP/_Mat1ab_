clc
clear 
close all

%{

 Normy matic a vektorů, podmíněnost matice

%}
%% vstupne udaje pre   A(i,j) = 5/(i + (2*j) -1 );
n = 7;
A = zeros(n,n);
x = ones(n,1);

for i = 1:n
    for j = 1:n
        A(i,j) = 5/(i + (2*j) -1 );
    end
end

disp(A)

%% aproximace
b  = A*x;
x_aprox = A\b;

%% vypocet reziduum atd
error  = x - x_aprox;
error_norm = norm(error,inf);
reziduum  = b - A*x_aprox;
reziduum_norm = norm(reziduum,inf);

kappa = error_norm/reziduum_norm;

disp("reziduum: " );
disp(reziduum_norm);
disp(error_norm);
disp(kappa);
cond_A = cond(A, inf);
disp(cond_A);