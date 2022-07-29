%% Monocomponent Signal 

syms t;
fk = 5; % actual component frequency
T = 1/fk;
xt = exp(1j * 2*pi * fk * t);

k = 100; % arbitrary amplitude estimate
fk_est = 1; % arbitrary frequency estimate
est_matrix = fk - fk_est;

for q = 1:15 % Iterate while updating the frequency and amplitude estimates
    
    n_init = fk - fk_est; % initial frequency mismatch
    
    const = 2*pi*n_init*T;
    
    % Update the amplitudes considering a rectangular window (refer to cited PhD
    % thesis for more details)
    a = k*(sin(const)) / (const);
    b = 3*k*((sin(const)/((2*pi*n_init)^2 * (T^3))) - (cos(const)/(const*T)));
    
    n_est = b / (2*pi*a); % obtain error estimate
    fk_est = fk_est + n_est; % update the frequency estimate using the error estimate
    est_matrix = [est_matrix, fk - fk_est];
end

figure; % plot the frequency mismatch errors against the number of iterations
plot(1:numel(est_matrix), est_matrix); grid on; title("Iterative estimation"); xlabel("Number of Iterations"); ylabel("Frequency Estimation error");
