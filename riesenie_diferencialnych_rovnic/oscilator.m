clc
clear 
close all

%% Úkol 02: Van der Pol oscilátor
% Řešte rovnici níže uvedenou rovnicí pomocí funkce ODE45:
% ẍ - μ(1 - x²)ẋ + x = 0
%
% Za podmínky:
% t = (0; 10) s
% x(0) = 0.5
% μ = 0.9
%



tmin = 0;
tmax = 10;
dt  = 0.01;
h = dt;

function dX = odeFcnNonLin(t, X)
    
    x = X(1);
    y = X(2);
    
    dx = y;
    dy = -x + 0.9*y -0.9*x^2*y;
    dX = [dx; dy];
end



x0 = [0.5; 0];
t = tmin:dt:tmax;
n = length(t);

x_RK = zeros(length(x0), n);
x_RK(:,1) = x0;

for i = 1:n-1
    a1 = odeFcnNonLin(t(i), x_RK(:,i));
    a2 = odeFcnNonLin(t(i)+h/2, x_RK(:,i)+h/2*a1);
    

a3 = odeFcnNonLin(t(i)+h/2, x_RK(:,i)+h/2*a2);
    a4 = odeFcnNonLin(t(i)+h, x_RK(:,i)+h*a3);
    x_RK(:,i+1) = x_RK(:,i) + (h/6)*(a1 + 2*a2 + 2*a3 + a4);
end

[t_ode, x_ode] = ode45(@odeFcnNonLin, [tmin tmax ], x0);

plot(t, x_RK(1,:), 'b-', 'LineWidth', 2); hold on
plot(t_ode, x_ode(:,1), 'r--', 'LineWidth', 2);

grid on