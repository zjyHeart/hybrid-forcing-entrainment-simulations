function [phi, mean_coherence, mean_lab_frequency] = integrate_batch( ...
    phi, omega, parameters, time_step, total_steps, tail_steps, collect_frequency)
% Solve the oscillator equations and average the tail.

if tail_steps < 1 || tail_steps > total_steps
    error('hybrid:InvalidTail', ...
        'tail_steps must be between 1 and total_steps.');
end

for step = 1:(total_steps - tail_steps)
    phi = rk4_step(phi, omega, parameters, time_step);
end

coherence_sum = zeros(1, size(phi, 2), 'like', phi);
frequency_sum = zeros(1, size(phi, 2), 'like', phi);

for step = 1:tail_steps
    order_parameter = mean(exp(1i .* phi), 1);
    coherence_sum = coherence_sum + abs(order_parameter);

    if collect_frequency
        derivative = rotating_frame_rhs(phi, omega, parameters);
        frequency_sum = frequency_sum + parameters.Omega + mean(derivative, 1);
    end

    phi = rk4_step(phi, omega, parameters, time_step);
end

mean_coherence = coherence_sum ./ tail_steps;
if collect_frequency
    mean_lab_frequency = frequency_sum ./ tail_steps;
else
    mean_lab_frequency = [];
end
end


function phi_next = rk4_step(phi, omega, parameters, time_step)
% Advance the complete model by one RK4 step.

k1 = rotating_frame_rhs(phi, omega, parameters);
k2 = rotating_frame_rhs(phi + 0.5 .* time_step .* k1, omega, parameters);
k3 = rotating_frame_rhs(phi + 0.5 .* time_step .* k2, omega, parameters);
k4 = rotating_frame_rhs(phi + time_step .* k3, omega, parameters);

phi_next = phi + (time_step ./ 6) .* (k1 + 2 .* k2 + 2 .* k3 + k4);
phi_next = mod(phi_next + pi, 2 .* pi) - pi;
end


function derivative = rotating_frame_rhs(phi, omega, parameters)
% Evaluate the rotating-frame differential equation.

order_parameter = mean(exp(1i .* phi), 1);
coherence = abs(order_parameter);
mean_phase = angle(order_parameter);

detuning = omega - parameters.Omega;
coupling = parameters.K .* coherence .* sin(mean_phase - phi);
forcing_amplitude = parameters.A0 .* ( ...
    (1 - parameters.rho) + parameters.rho .* coherence .^ parameters.gamma);
hybrid_forcing = -parameters.L .* forcing_amplitude .* sin(phi);

derivative = detuning + coupling + hybrid_forcing;
end
