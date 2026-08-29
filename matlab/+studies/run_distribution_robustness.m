function result = run_distribution_robustness(config)
% Compare distributions.

result.config = config;
result.gaussian = hybrid.simulate_hysteresis_scan(config.gaussian);
result.bimodal = hybrid.simulate_hysteresis_scan(config.bimodal);
end
