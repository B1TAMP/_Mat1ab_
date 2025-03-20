clc
clear 
close all



%Interpolační polynomy (Lagrangeův tvar, Newtonův tvar, Hermitův polynom)

%% premenne:

pi = 3.14;
x = [0 1 2 3];
y  = sin((pi*x)/6).^2;

x_f = -1:0.1:4;
y_f = sin((pi*x_f)/6).^2;
n  = length(x);
A = zeros(n,n);

A(1:n,1) = y;

%% algoritmus vypoctu:


for j = 2:n
    for  i = j:n
        A(i,j) = (A(i,j-1) -A(i-1,j-1))/( x(i) -x(i-j+1) );
    end
end

m = 2 ; 
l = 2;
P = zeros(1,length(x_f));
coefs  = diag(A);

 


for k = 1:length(x_f)
    newton_term = 1;
     P(k) = coefs(1);
        for j = 2:n
        newton_term = newton_term * (x_f(k) - x(j-1));
        P(k) = P(k) + coefs(j) * newton_term;
        end
            
end

disp(A)
%% graf funkcie a polynomu:

plot(x_f,y_f,'k')
hold on
plot(x_f, P);
scatter(x,y,'g')
