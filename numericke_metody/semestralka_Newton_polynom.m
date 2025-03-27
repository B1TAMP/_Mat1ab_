clc;
clear;
close all;

% Interpolační polynomy (Lagrangeův tvar, Newtonův tvar, Hermitův polynom)

%% Definice funkce:
fh = @(x) x.^3 - 4*x;

x = [1 2 3 4 5 6];   % Uzlové body
y = fh(x);           % Hodnoty funkce v uzlech

x_f = 0:0.1:7;       % Hustší rozložení bodů pro vykreslení
y_f = fh(x_f);       % Skutečné hodnoty funkce
n = length(x);       % Počet uzlů
A = zeros(n, n);     % Inicializace tabulky rozdílových kvocientů

A(:, 1) = y';        % První sloupec je hodnota funkce v uzlech

%% Výpočet rozdílových kvocientů (Newtonova dopředná tabulka):
for j = 2:n
    for i = j:n
        A(i, j) = (A(i, j-1) - A(i-1, j-1)) / (x(i) - x(i-j+1));
    end
end

coefs = diag(A);  % Koeficienty polynomu z hlavní diagonály tabulky
P = zeros(1, length(x_f));  % Inicializace interpolovaného polynomu

%% Výpočet hodnot interpolovaného polynomu:
for k = 1:length(x_f)
    newton_term = 1;
    P(k) = coefs(1);
    for j = 2:n
        newton_term = newton_term * (x_f(k) - x(j-1));
        P(k) = P(k) + coefs(j) * newton_term;
    end
end

disp('Tabulka rozdílových kvocientů:');
disp(A);

%% Graf funkce a interpolovaného polynomu:
figure(1);
hold on;
plot(x_f, y_f, 'k', 'LineWidth', 1.5); % Původní funkce
plot(x_f, P, 'r', 'LineWidth', 1.5);   % Newtonův interpolant
scatter(x, y, 100, 'g', 'filled'); % Uzlové body
legend('Původní funkce', 'Interpolant', 'Uzlové body');
title('Newtonova interpolace');
xlabel('x');
ylabel('y');
grid on;
hold off;

%% Graf chyby interpolace:
figure(2);
plot(x_f, abs(y_f - P), 'b', 'LineWidth', 1.5);
title('Chyba interpolace');
xlabel('x');
ylabel('|f(x) - P(x)|');
grid on;
