function config = distribution_robustness(mode)
% Set distribution scans.

common.Omega = 4;
common.K = 0;
common.rho = [0 0.8 1];
common.shuffle_frequencies = true;

quick.Lgrid = [0 1];
full.Lgrid = 0:0.1:10;

gaussian = common;
gaussian.distribution = 'gaussian';
gaussian.distribution_parameters.sigma = 0.30;

bimodal = common;
bimodal.distribution = 'bimodal';
bimodal.distribution_parameters.mu = 0.25;
bimodal.distribution_parameters.sigma = 0.20;

config.mode = lower(char(mode));
config.gaussian = hybrid.compose_config(mode, gaussian, quick, full);
config.bimodal = hybrid.compose_config(mode, bimodal, quick, full);
end
