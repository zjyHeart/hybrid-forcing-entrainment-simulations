function config = frequency_locking(mode)
% Set the locking map.

common.distribution_parameters.Delta = 0.3;
common.Omega = 4;
common.rho = 0.8;
common.store_frequency = true;
common.run_backward = false;

quick.K = [-1 0 1];
quick.Lgrid = [0 1];

full.K = linspace(-5, 5, 401);
full.Lgrid = linspace(0, 10, 401);
full.dt = 0.05;
full.tail_steps = 3200;

config = hybrid.compose_config(mode, common, quick, full);
end
