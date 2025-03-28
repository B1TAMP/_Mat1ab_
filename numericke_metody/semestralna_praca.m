clc
clear
close all

%% zadane suradnice bodov 
    x = [0 1 2 3 4];
    y = [1.5 2.5 3.5 5.0 7.5];

%% metoda najmensich stvorcov pomocou lineraizace - 1
    % metodou najmensich stvorcov chceme nimi prelozit krivku y = Ce^(Ax)
    % rovnicu upravime do tvaru do:          ln y = Ax + ln C
    % vysledny vzath    Y = AX + B
%% substitucia Y = ln y   X = x 
    Y = log(y);
    X = x;
%% vytvorenie navrhovej matice 

    n = length(x);   % pocet bodov nam bude sluzit na vyvorenie matice A     
    NM = zeros(n,2); % incializacia navrhovej matice NM     
    
    NM(:,1) = 1;    % Phi_1 vyhodnotenie prvej funkcie vo vsetkych bodoch dosadenej do navrhovej matice A
    NM(:,2) = x;    % Phi 2 vyhodnotenie druhej funkcie vo vsetkych bodoch dosadenej do navrhovej matice A
%% vypocet  C A
    G = (transpose(NM) * NM) \ (transpose(NM) * Y');  
    B = G(1); 
    A = G(2);
    
    C  = exp(B); % vypocet C zo substitucie B = ln C 
%% nelinealna metoda najmensich stvorcov - 2

    % vyuzijemem funkciu fminsearch ktora nam pomoze najst minimum
    % zadany vyraz si vieme upravit ako:    
    %                   suma (Ce^(xi*A) - yi)^2   kde i  = 1:n 
    % C a A je to co hladame a teda budu nase parametre p(1) a p(2)    
    SUM = @(p) sum((p(1) * exp(p(2) * x) - y).^2);
    p0 = [1, 0]; % Počiatočný odhad [C, A] nutny pre funkciu firmsearch
    p_opt = fminsearch(SUM,p0);

%% porovnanie jednotlivych metod - 3
     % vypocet suctu stvorcov pre linearnu metodu
     SUM_L = sum((C * exp(A * x) - y).^2);
    
     %  vypocet suctu stvorcov pre nelinearnu metodu
     SUM_NL = sum((p_opt(1) * exp(p_opt(2) * x) - y).^2);

%% vyvtorenie intervalu pre plot 
    
    t  = min(x):0.1:max(x); % interval grafu 
    y_fl = C * exp(A*t); % vypocet funkcnych hodnot pre metodu s vyuzitim linerizace
    y_fn = p_opt(1) * exp(p_opt(2)*t); % vypocet funkcnych hodnot pre metodu s vyuzitim nelinearnej MNS

%% plot
    figure;
    hold on;
    % vykreslenie zadanych bodov a jednotlivych krivek
    scatter(x, y, 'ro', 'DisplayName', 'Zadane body'); % vykreslenie zadanych bodov 
    plot(t, y_fl, 'b-','DisplayName', 'Lineárna metóda');  % vykreslenie krivky ziskanej pomocou linearizace 
    plot(t, y_fn, 'g-', 'DisplayName', 'Nelineárna metóda');  % vykreslenie krivky ziskanej pomocou nelinearnej MNS 
    
    % upravenie grafu pridani popiskov osi X a Y a legendy
    xlabel('x');ylabel('y');
    title('Porovnanie metód');
    legend('Location', 'NorthWest');
    grid on; hold off;
    
    % Výpis výsledkov
    fprintf('Linearizacia:\n')
    fprintf('  Najdene parametre: A = %.4f, C = %.4f\n', A, C);
    fprintf('  Rovnica: y = %.4f * e^(%.4f * x)\n', C, A);
    fprintf('Nelinearna MNS: \n')
    fprintf('  Najdene parametre: A = %.4f, C = %.4f\n', p_opt(2), p_opt(1));
    fprintf('  Rovnica: y = %.4f * e^(%.4f * x)\n',  p_opt(1), p_opt(2));

    fprintf('Sucet stvorcov odchylok:\n');
    fprintf('  Linearna metoda: %.6f\n', SUM_L);
    fprintf('  Nelinearna metoda: %.6f\n', SUM_NL);