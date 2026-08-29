function config = phase_resolved_response(mode)
% Set phase-resolved scans.

common.distribution_parameters.Delta = 0.1;
common.Omega = 4;
common.K = 0;
common.rho = 0.7;
common.store_phase = true;
common.store_frequency = true;

quick.Lgrid = [0 1];
full.Lgrid = 0:0.1:6;

config = hybrid.compose_config(mode, common, quick, full);
end
