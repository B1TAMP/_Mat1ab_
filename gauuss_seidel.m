clc
clear 
close all

%{

Iterační metody k řešení soustav lineárních rovnic (Jacobihometoda,Gauss-Seidelova metoda)


%}
%% premenne:

A = [6 -3 -1; -2 5 1; 2 -1 5];
b = [3; 0; 1];
iter  = 0;
[n,m]  = size(b);
tol = 1e-8;
max_iter = 10000;
x = zeros(n,1);

%% Gauss-Seidelova metoda
%{
while true
    x_old = x;
    for i = 1:n
        sum1 = A(i,1:i-1) *x(1:i-1);
        sum2 = A(i,i+1:n)  *x_old(i+1:n);
        x(i) = (b(i)-sum1 -sum2)/A(i,i);

    end


    
    iter = iter +1;
    if iter == max_iter || norm(x - x_old,1) <= tol
        break;
    end

end
disp(x)
%}

%% Jacobihometoda
max_iter2 = 100;
iter2 = 0;
X = zeros(n,1);
x_new = X;
    while true
            for i  = 1:n
            
                sum_1  = (A(i,:) * X )- A(i,i) * X(i);
                x_new(i) = (b(i) - sum_1)/A(i,i);


            end
            iter2 = iter2 + 1;
           
        if iter2 == max_iter2 || norm(x_new - X,1) <= tol
            break;
        end
         X = x_new;
    end
disp(x_new)


