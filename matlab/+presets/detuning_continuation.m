function config = detuning_continuation(mode)
% Set detuning scans.

common.distribution_parameters.Delta = 0.1;
common.K = 0;
common.family.parameter = 'rho';
common.family.values = [0 0.8 1];

quick.Omega = [-1 0 1];
quick.Lgrid = [0 0.5 1];

full.Omega = linspace(-5, 5, 401);
full.Lgrid = linspace(0, 10, 401);
full.TT = 500;
full.dt = 0.05;
full.tail_steps = 2000;

config = hybrid.compose_config(mode, common, quick, full);
end
