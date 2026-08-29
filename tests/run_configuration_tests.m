function run_configuration_tests()
% Test full presets.

test_root = fileparts(mfilename('fullpath'));
repository_root = fileparts(test_root);
addpath(fullfile(repository_root, 'matlab'));

config = presets.hybrid_ratio_response('full');
assert(config.N == 2000 && config.Omega == 4);
assert(isequal(config.Lgrid, 0:0.05:10));
assert(config.batch_size <= 8);

config = presets.stationary_detuning_map('full');
assert(numel(config.grid.row.values) == 201);
assert(numel(config.grid.column.values) == 201);
assert(isequal(config.grid.slice.values, [0.5 1.5 2.5 3.5]));

config = presets.detuning_continuation('full');
assert(numel(config.Omega) == 401 && numel(config.Lgrid) == 401);
assert(isequal(config.family.values, [0 0.8 1]));

config = presets.stationary_hybrid_map('full');
assert(isequal(config.grid.slice.values, [3 4 5]));

config = presets.transition_boundaries('full');
assert(config.Omega == 4 && numel(config.rho) == 101);

config = presets.phase_resolved_response('full');
assert(config.store_phase && config.store_frequency);

config = presets.coupling_response('full');
assert(isequal(config.K, [-1 0 1]) && config.rho == 0.8);

config = presets.frequency_locking('full');
assert(numel(config.K) == 401 && numel(config.Lgrid) == 401);
assert(config.store_frequency && ~config.run_backward);

config = presets.distribution_robustness('full');
assert(config.gaussian.distribution_parameters.sigma == 0.30);
assert(config.bimodal.distribution_parameters.mu == 0.25);
assert(config.bimodal.distribution_parameters.sigma == 0.20);

fprintf('All full-resolution configuration tests passed.\n');
end
