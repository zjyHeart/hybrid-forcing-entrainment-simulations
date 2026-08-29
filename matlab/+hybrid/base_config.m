function config = base_config(mode)
% Shared defaults.

mode = lower(char(mode));
if ~ismember(mode, {'quick', 'full'})
    error('hybrid:InvalidMode', 'Mode must be ''quick'' or ''full''.');
end

config.mode = mode;
config.N = 2000;
config.omega0 = 0;
config.distribution = 'lorentzian';
config.distribution_parameters = struct();
config.shuffle_frequencies = false;
config.frequency_seed = 1;

config.Omega = 0;
config.K = 0;
config.A0 = 1;
config.gamma = 1;
config.rho = 0;
config.L = 0;

config.TT = 800;
config.dt = 0.01;
config.tail_steps = 1600;
config.seed = 1;
config.precision = 'single';
config.batch_size = 8;

config.store_phase = false;
config.store_frequency = false;
config.run_backward = true;

if strcmp(mode, 'quick')
    config.N = 24;
    config.TT = 0.2;
    config.dt = 0.02;
    config.tail_steps = 3;
    config.precision = 'double';
    config.batch_size = 4;
end
end
