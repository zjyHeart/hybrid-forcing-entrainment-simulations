function result = run_transition_boundaries(config)
% Compute transition bounds.

scan = hybrid.simulate_hysteresis_scan(config);
thresholds = hybrid.estimate_jump_thresholds(scan, ...
    config.min_jump, config.min_width, config.min_rho);

result.config = config;
result.scan = scan;
result.thresholds = thresholds;
end
