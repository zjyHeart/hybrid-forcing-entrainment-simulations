function phi_next = rk4_step(phi, omega, parameters, time_step)
% Advance one RK4 step.

k1 = hybrid.rhs(phi, omega, parameters);
k2 = hybrid.rhs(phi + 0.5 .* time_step .* k1, omega, parameters);
k3 = hybrid.rhs(phi + 0.5 .* time_step .* k2, omega, parameters);
k4 = hybrid.rhs(phi + time_step .* k3, omega, parameters);

phi_next = phi + (time_step ./ 6) .* (k1 + 2 .* k2 + 2 .* k3 + k4);
phi_next = mod(phi_next + pi, 2 .* pi) - pi;
end
