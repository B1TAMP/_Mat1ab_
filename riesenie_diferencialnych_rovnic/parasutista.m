clc
clear 
close all
%% Parašutista (2/1)
% Převeďte níže uvedené rovnice na soustavu rovnic prvního řádu 
% mÿ = (1/2)ρSCᴅv² - mg
%
% Parametry:
% m = 102           [kg]
% ρ = 1.2045        [kgm⁻³]
% S = 15.7          [m²]
% Cᴅ = 1.75         [-]
% g = 9.81          [ms⁻²]
%
% Simulační čas:
% t = (0; 20)       [s]
%
% Počáteční podmínky:
% y₀ = 4000         [m]
% ẏ₀ = -53          [ms⁻¹]

tmin   =  0;
tmax = 20;
x0 = [4000 -53];
dt = 0.1;
h = dt;
n = (tmax - tmin)/dt;
t(1) = 0;

function dX =  odefun(t,X ) 
     x = X(1);
     y = X(2);  

 m = 102;
S  = 15.7 ;
R  = 1.2045;
Cd = 1.75;
g = 9.81;

    dx = y;
    dy = (0.5*R*S*Cd)/m * y^2 - g;

   dX = [dx; dy];

end

x_RK = zeros(length(x0), n);
x_RK(:,1) = x0;

for i = 1:n-1
    a1 = odefun(t(i), x_RK(:,i));
    a2 = odefun(t(i)+dt/2, x_RK(:,i)+dt/2*a1);
    

    a3 = odefun(t(i)+h/2, x_RK(:,i)+h/2*a2);
    a4 = odefun(t(i)+h, x_RK(:,i)+h*a3);

    x_RK(:,i+1) = x_RK(:,i) + (h/6)*(a1 + 2*a2 + 2*a3 + a4);
    t(i+1) = t(i) + dt;
end
[t_ode,x_ode] = ode45(@odefun, [tmin tmax], x0);

subplot(3,1,1);
plot(t, x_RK(1,:), 'b-', 'LineWidth', 2); 
hold on
plot(t_ode, x_ode(:,1), 'r--', 'LineWidth', 2);


subplot(3,1,2);
plot(t, x_RK(2,:), 'b-', 'LineWidth', 2); 
hold on
plot(t_ode, x_ode(:,2), 'r--', 'LineWidth', 2);
grid on

%%
 m = 102;
S  = 15.7 ;
R  = 1.2045;
Cd = 1.75;
g = 9.81;



v = x_RK(2,:);


Fd = 0.5 *R * S * Cd .* (v.^2);

P = - Fd .* v;  

w  = cumtrapz(P,t);

subplot(3,1,3);
plot(t,w); 
hold on

