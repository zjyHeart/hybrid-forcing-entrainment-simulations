function config = stationary_detuning_map(mode)
% Set the detuning map.

common.distribution_parameters.Delta = 0.1;
common.K = 0;

quick.grid.row = axis_definition('rho', [0 0.5 1]);
quick.grid.column = axis_definition('Omega', [-1 0 1]);
quick.grid.slice = axis_definition('L', [0.5 1.5]);

full.dt = 0.05;
full.tail_steps = 3200;
full.grid.row = axis_definition('rho', linspace(0, 1, 201));
full.grid.column = axis_definition('Omega', linspace(-5, 5, 201));
full.grid.slice = axis_definition('L', [0.5 1.5 2.5 3.5]);

config = hybrid.compose_config(mode, common, quick, full);
end


function axis = axis_definition(parameter, values)
axis.parameter = parameter;
axis.values = values;
end
