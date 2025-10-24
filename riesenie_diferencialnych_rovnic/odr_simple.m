clc 
clear 
close all


tmin = 0 ;
dt = 0.001;
tmax = 10;
h = dt;

function dX = odeFcn1D(t,X)
    dX = -0.5*X;
end

x0 = 1;
h1 = 1;
t1 = tmin:dt:tmax;
n1 = length(t1);

x1 = zeros(1,n1);
x1(1) = x0;

for i = 1:n1-1
    a1 = odeFcn1D(t1(i), x1(i));
    a2 = odeFcn1D(t1(i) + h1/2, x1(i) + (h1/2)*a1);
    a3 = odeFcn1D(t1(i) + h1/2, x1(i) + (h1/2)*a2);
    a4 = odeFcn1D(t1(i) + h1, x1(i) + h1*a3);
    x1(i+1) = x1(i) + (h1/6)*(a1 + 2*a2 + 2*a3 + a4);
end

[t2, x2] = ode45(@odeFcn1D, [a b], x0);

plot(t1, x1, 'b-', 'LineWidth', 2); hold on
plot(t2, x2, 'r--', 'LineWidth', 2);
grid on