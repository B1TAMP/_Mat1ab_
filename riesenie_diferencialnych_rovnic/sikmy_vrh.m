clc
clear 
close all
%% jednoduche modelovanie sikmeho vrhu 
% Rovnice pohybu:
% mẍ = 0
% mÿ = -mg
%
% Parametry:
% m = 2 [kg]
% g = 9.81 [m/s²]
% v₀ = 50 [m/s]
% γ = 45 [°]
%
% Simulační čas:
% t = [0: 0.01: 7.2]
%
% Počáteční podmínky:
% vₓ = v₀ cos(γ)
% vᵧ = v₀ sin(γ)

m  = 2;
g = 9.81;
vo = 50;
uhol = 0.785398163;
tmin = 0;
tmax=  7.2;
dt = 0.01; 
h = dt;


function dX = odeFcn(t,X)
    A = [0  1 0 0; 0 0 0 0;0 0 0 1; 0 0 0 0];
    B = [0;0;0;-9.81];
    dX = A*X+B;
end


x0 = [0 vo*cos(uhol) 0 vo*sin(uhol) ];
t = tmin:dt:tmax;
n = length(t);

x_RK = zeros(length(x0), n);
x_RK(:,1) = x0;

for i = 1:n-1
    a1 = odeFcn(t(i), x_RK(:,i));
    a2 = odeFcn(t(i)+h/2, x_RK(:,i)+h/2*a1);
    a3 = odeFcn(t(i)+h/2, x_RK(:,i)+h/2*a2);
    a4 = odeFcn(t(i)+h, x_RK(:,i)+h*a3);
    x_RK(:,i+1) = x_RK(:,i) + (h/6)*(a1 + 2*a2 + 2*a3 + a4);
end

[t_ode, x_ode] = ode45(@odeFcn, [tmin tmax], x0);

plot(t, x_RK(3,:), 'b-', 'LineWidth', 2); 
hold on
plot(t_ode, x_ode(:,3), 'r--', 'LineWidth', 2);
grid on
