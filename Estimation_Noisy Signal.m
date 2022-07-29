%% Monocomponent Signal with added noise

% This section is similar to the simulation for monocomponent signal but
% here, some random noise has additionally been added to the signal so that
% the tolerance of the algorithm against noise can be tested

syms t;
fk = 5; % actual component frequency
T = 1/fk;
xt = k*exp(1j * 2*pi * fk * t);

r1 = randn(1,1); % noise variable
k = 100; % initial arbitrary estimates
fk_est = 1;
est_matrix = fk - fk_est;

for q = 1:25 % Iterate while updating the frequency and amplitude estimates 
    
    n_init = fk - fk_est;
    
    const = 2*pi*n_init*T;
    
    a = k*(sin(const)) / (const) + r1;
    b = 3*k*((sin(const)/((2*pi*n_init)^2 * (T^3))) - (cos(const)/(const*T))) + r1;
    
    n_est = b / (2*pi*a);
    fk_est = fk_est + n_est;
    est_matrix = [est_matrix, fk - fk_est];
end

figure; % plot the frequency mismatch errors against the number of iterations
plot(1:numel(est_matrix), est_matrix); grid on; title("Iterative estimation with added noise"); xlabel("Number of Iterations"); ylabel("Frequency Estimation error");




