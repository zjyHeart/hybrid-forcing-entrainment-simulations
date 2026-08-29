function setup = prepare_simulation(config)
% Prepare a CPU run.

required = {'N', 'omega0', 'distribution', 'distribution_parameters', ...
    'shuffle_frequencies', 'frequency_seed', 'TT', 'dt', 'tail_steps', ...
    'seed', 'precision'};
hybrid.require_fields(config, required, 'Simulation configuration');

setup.total_steps = round(config.TT ./ config.dt);
setup.omega_cpu = hybrid.make_frequencies(config);

rng(config.seed, 'twister');
setup.initial_phase = 2 .* pi .* rand(config.N, 1);
setup.omega = cast(setup.omega_cpu, char(config.precision));
setup.time_step = cast(config.dt, char(config.precision));
end
