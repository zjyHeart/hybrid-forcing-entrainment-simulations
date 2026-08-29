function result = run_frequency_locking(config)
% Compute frequency locking.

scan = hybrid.simulate_hysteresis_scan(config);
result.config = config;
result.K = scan.K_cases;
result.L = scan.Lgrid;
result.R = scan.R_forward.';
result.mean_frequency = scan.frequency_forward.';
result.frequency_error = abs(result.mean_frequency - scan.Omega_cases.');
result.execution_device = 'cpu';
end
