clc
clear 
close all


m = 2;
g = 9.81;
vo = 50;
uhol = 0.7853;
tmin = 0;
dt = 0.001;
tmax  = 7.2;


h = dt;
x0 = [0  vo*cos(uhol)  0 vo*sin(uhol)];
t = tmin:dt:tmax;
n = length(t);

x_RK = zeros(length(x0), n);
x_RK(:,1) = x0;

for i = 1:n-1
    a1 = odeFcn2(t(i), x_RK(:,i));
    a2 = odeFcn2(t(i)+h/2, x_RK(:,i)+h/2*a1);
    a3 = odeFcn2(t(i)+h/2, x_RK(:,i)+h/2*a2);
    a4 = odeFcn2(t(i)+h, x_RK(:,i)+h*a3);
    x_RK(:,i+1) = x_RK(:,i) + (h/6)*(a1 + 2*a2 + 2*a3 + a4);
end

[t_ode, x_ode] = ode45(@odeFcn2, [tmin tmax], x0);
subplot(2,1,1)
plot(t, x_RK(3,:), 'b-', 'LineWidth', 2); hold on
plot(t_ode, x_ode(:,3), 'r--', 'LineWidth', 2);
grid on
xlabel('t')
ylabel('x(t)')


function dX = odeFcn2(t,X)
   A = [0 1 0 0; 
     0 0 0 0; 
     0 0 0 1; 
     0 0 0 0];
B = [0; 0; 0; -9.81];
dX = A*X + B;
end
subplot(2,1,2)
ek = 0.5*m*(x_RK(2,:).^2+x_RK(4,:).^2)
plot(t,ek)

vzdalenost = x_RK(1,end);