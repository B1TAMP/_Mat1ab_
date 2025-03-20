clc
clear 
close all

%{
Gaussova eliminace s částečným výběrem hlavního prvku
Iterační metody k řešení soustav lineárních rovnic (Jacobihometoda,Gauss-Seidelova metoda)
 Normy matic a vektorů, podmíněnost matice
Interpolační polynomy (Lagrangeův tvar, Newtonův tvar, Hermitův polynom)
%}

%% premene:

pi = 3.14;
x = [0 1 2 3];
y  = sin((pi*x)/6).^2;
x_f = -1:0.1:4;
y_f = sin((pi*x_f)/6).^2;
n  = length(x);
A = zeros(n,2);
A(:,1) = x(:);
A(:,2) = y(:);
P = zeros(size(y_f));

%% algoritmus vypoctu:

for k = 1: length(x_f)
    sum  = 0;
    for i = 1:n
        L = 1;
            for j  = 1:n
                if(j ~= i)
                    L = L*(x_f(k) - x(j)) / (x(i)- x(j));

                end
            end
           sum = sum  + y(i)*L; 
    end
    P(k) = sum;
end
%% graf funkcie a polynomu:

plot(x_f,y_f,'r');
hold on
plot(x_f,P,'blue');
hold on
scatter(x,y,'k');