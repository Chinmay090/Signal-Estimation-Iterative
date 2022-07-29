%% Multicomponent Signal 

% This section is  similar to the monocomponent signal code.
% The same process for monocomponent signals is being applied for 3 different signals individually
% Given the target frequencies and the initial estimate, we keep on incrementing by an error function
% and recalculating all parameters until the target frequency is attained with zero deviation or error.

syms t;
fk = [5, 10, 15]; % Target frequencies for all 3 components
T = 1./fk;
xt = exp(1j * 2*pi * fk(1) * t) + exp(1j * 2*pi * fk(2) * t) + exp(1j * 2*pi * fk(3) * t); % 3-component signal

k = 100;
fk_est = ones(1, numel(fk)); % Setting the estimation matrix
est_matrix1 = fk(1) - fk_est(1); % For first component
est_matrix2 = fk(2) - fk_est(2); % For second component
est_matrix3 = fk(3) - fk_est(3); % For third component

for q = 1:15
    
    n_init = fk - fk_est; % Present value of error function
    
    const = 2*pi.*n_init.*T; % Used to calculate signal coefficients a and b
    
    a = k.*(sin(const)) ./ (const); % Calculating a
    b = 3*k.*((sin(const)./((2*pi.*n_init).^2 .* (T.^3))) - (cos(const)./(const.*T))); % Calculating b
    
    n_est = b ./ (2*pi.*a); % Error value to be added to present estimate
    fk_est = fk_est + n_est; % Incrementing the frequency estimate for use in the next iteration
    est_matrix1 = [est_matrix1, fk(1) - fk_est(1)];
    est_matrix2 = [est_matrix2, fk(2) - fk_est(2)];
    est_matrix3 = [est_matrix3, fk(3) - fk_est(3)];
end

% Plotting frequency estimation error against number of iterations separately for each component

figure;
plot(1:numel(est_matrix1), est_matrix1, 'DisplayName', '1st component'); grid on; title("Iterative estimation"); xlabel("Number of Iterations"); ylabel("Frequency Estimation error"); 
hold on;
plot(1:numel(est_matrix2), est_matrix2, 'DisplayName', '2nd component'); grid on; title("Iterative estimation"); xlabel("Number of Iterations"); ylabel("Frequency Estimation error");
hold on;
plot(1:numel(est_matrix3), est_matrix3, 'Color', 'g', 'DisplayName', '3rd component'); grid on; title("Iterative estimation"); xlabel("Number of Iterations"); ylabel("Frequency Estimation error");
hold off;
lgd = legend;
lgd.NumColumns = 1;



