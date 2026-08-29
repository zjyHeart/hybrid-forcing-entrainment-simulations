function derivative = rhs(phi, omega, parameters)
% Compute rotating-frame dynamics.
% Columns are independent cases.

order_parameter = mean(exp(1i .* phi), 1);
coherence = abs(order_parameter);
mean_phase = angle(order_parameter);

hybrid_gain = parameters.A0 .* ( ...
    (1 - parameters.rho) + parameters.rho .* coherence .^ parameters.gamma);
detuning = omega - parameters.Omega;
interaction = parameters.K .* coherence .* sin(mean_phase - phi);
forcing = -parameters.L .* hybrid_gain .* sin(phi);

derivative = detuning + interaction + forcing;
end
