function [phi, mean_coherence, mean_lab_frequency] = integrate_batch( ...
    phi, omega, parameters, time_step, total_steps, tail_steps, collect_frequency)
% Integrate and average the tail.

if tail_steps < 1 || tail_steps > total_steps
    error('hybrid:InvalidTail', ...
        'tail_steps must be between 1 and total_steps.');
end

for step = 1:(total_steps - tail_steps)
    phi = hybrid.rk4_step(phi, omega, parameters, time_step);
end

coherence_sum = zeros(1, size(phi, 2), 'like', phi);
frequency_sum = zeros(1, size(phi, 2), 'like', phi);

for step = 1:tail_steps
    order_parameter = mean(exp(1i .* phi), 1);
    coherence_sum = coherence_sum + abs(order_parameter);

    if collect_frequency
        derivative = hybrid.rhs(phi, omega, parameters);
        frequency_sum = frequency_sum + parameters.Omega + mean(derivative, 1);
    end

    phi = hybrid.rk4_step(phi, omega, parameters, time_step);
end

mean_coherence = coherence_sum ./ tail_steps;
if collect_frequency
    mean_lab_frequency = frequency_sum ./ tail_steps;
else
    mean_lab_frequency = [];
end
end
