function result = simulate_independent_cases(config, case_overrides)
% Run independent cases.

if nargin < 2
    case_overrides = struct();
end
hybrid.require_fields(config, ...
    {'Omega', 'K', 'A0', 'gamma', 'rho', 'L', 'batch_size'}, ...
    'Independent-case configuration');
model = hybrid.merge_structs(struct( ...
    'Omega', config.Omega, 'K', config.K, 'A0', config.A0, ...
    'gamma', config.gamma, 'rho', config.rho, 'L', config.L), ...
    case_overrides);
case_count = hybrid.model_case_count(model);
setup = hybrid.prepare_simulation(config);
batch_size = min(config.batch_size, 8);
fprintf('CPU cases: N=%d, cases=%d, batch=%d\n', ...
    config.N, case_count, batch_size);

coherence = zeros(1, case_count);
expanded = expand_model(model, case_count);

starts = 1:batch_size:case_count;
for batch_index = 1:numel(starts)
    first = starts(batch_index);
    last = min(case_count, first + batch_size - 1);
    indices = first:last;
    current_count = numel(indices);

    phi = cast(repmat(setup.initial_phase, 1, current_count), ...
        char(config.precision));
    batch_model = subset_model(expanded, indices);
    parameters = hybrid.prepare_parameters(batch_model, current_count, ...
        config.precision);

    [~, batch_coherence] = hybrid.integrate_batch( ...
        phi, setup.omega, parameters, setup.time_step, setup.total_steps, ...
        config.tail_steps, false);
    coherence(indices) = batch_coherence;
    fprintf('  batch %d/%d, cases %d-%d\n', ...
        batch_index, numel(starts), first, last);
end

result.config = config;
result.omega = setup.omega_cpu;
result.cases = expanded;
result.R = coherence;
result.execution_device = 'cpu';
end


function expanded = expand_model(model, case_count)
names = {'Omega', 'K', 'A0', 'gamma', 'rho', 'L'};
for index = 1:numel(names)
    name = names{index};
    expanded.(name) = hybrid.expand_cases(model.(name), case_count, name);
end
end


function subset = subset_model(model, indices)
names = fieldnames(model);
for index = 1:numel(names)
    name = names{index};
    subset.(name) = model.(name)(indices);
end
end
