function result = simulate_hysteresis_scan(config)
% Run an adiabatic L scan.

required = {'Omega', 'K', 'A0', 'gamma', 'rho', 'L', 'Lgrid', ...
    'store_phase', 'store_frequency', 'run_backward'};
hybrid.require_fields(config, required, 'Continuation configuration');

case_count = hybrid.model_case_count(config);
forcing_grid = config.Lgrid(:);
forcing_count = numel(forcing_grid);
setup = hybrid.prepare_simulation(config);

omega_cases = hybrid.expand_cases(config.Omega, case_count, 'Omega');
coupling_cases = hybrid.expand_cases(config.K, case_count, 'K');
rho_cases = hybrid.expand_cases(config.rho, case_count, 'rho');

fprintf('CPU L scan: N=%d, cases=%d, L values=%d\n', ...
    config.N, case_count, forcing_count);

phi = cast(repmat(setup.initial_phase, 1, case_count), char(config.precision));
parameters = hybrid.prepare_parameters(config, case_count, config.precision);

forward_coherence = zeros(forcing_count, case_count);
forward_frequency = allocate_observable(config.store_frequency, forcing_count, case_count);
forward_phase = allocate_phase(config.store_phase, forcing_count, config.N, case_count);

for forcing_index = 1:forcing_count
    parameters.L = cast(forcing_grid(forcing_index), char(config.precision));
    [phi, coherence, frequency] = hybrid.integrate_batch( ...
        phi, setup.omega, parameters, setup.time_step, setup.total_steps, ...
        config.tail_steps, ...
        config.store_frequency);
    forward_coherence(forcing_index, :) = coherence;
    if config.store_frequency
        forward_frequency(forcing_index, :) = frequency;
    end
    if config.store_phase
        forward_phase(forcing_index, :, :) = snapshot_for_storage(phi);
    end
    report_progress('forward', forcing_index, forcing_count, forcing_grid(forcing_index));
end

backward_coherence = [];
backward_frequency = [];
backward_phase = [];
if config.run_backward
    backward_coherence = zeros(forcing_count, case_count);
    backward_frequency = allocate_observable( ...
        config.store_frequency, forcing_count, case_count);
    backward_phase = allocate_phase( ...
        config.store_phase, forcing_count, config.N, case_count);

    for forcing_index = forcing_count:-1:1
        parameters.L = cast(forcing_grid(forcing_index), char(config.precision));
        [phi, coherence, frequency] = hybrid.integrate_batch( ...
            phi, setup.omega, parameters, setup.time_step, setup.total_steps, ...
            config.tail_steps, ...
            config.store_frequency);
        backward_coherence(forcing_index, :) = coherence;
        if config.store_frequency
            backward_frequency(forcing_index, :) = frequency;
        end
        if config.store_phase
            backward_phase(forcing_index, :, :) = snapshot_for_storage(phi);
        end
        report_progress('backward', forcing_count - forcing_index + 1, ...
            forcing_count, forcing_grid(forcing_index));
    end
end

result.config = config;
result.omega = setup.omega_cpu;
result.Lgrid = forcing_grid;
result.Omega_cases = omega_cases;
result.K_cases = coupling_cases;
result.rho_cases = rho_cases;
result.R_forward = forward_coherence;
result.R_backward = backward_coherence;
result.frequency_forward = forward_frequency;
result.frequency_backward = backward_frequency;
result.phase_forward = forward_phase;
result.phase_backward = backward_phase;
result.execution_device = 'cpu';
end


function values = allocate_observable(enabled, row_count, case_count)
if enabled
    values = zeros(row_count, case_count);
else
    values = [];
end
end


function values = allocate_phase(enabled, forcing_count, oscillator_count, case_count)
if enabled
    values = zeros(forcing_count, oscillator_count, case_count, 'single');
else
    values = [];
end
end


function snapshot = snapshot_for_storage(phi)
phase_cpu = angle(exp(1i .* phi));
case_count = size(phase_cpu, 2);
snapshot = zeros(1, size(phase_cpu, 1), case_count, 'single');
for case_index = 1:case_count
    snapshot(1, :, case_index) = single(phase_cpu(:, case_index).');
end
end


function report_progress(direction, index, total, forcing)
if index == 1 || index == total || mod(index, max(1, floor(total ./ 10))) == 0
    fprintf('  %s %d/%d, L=%.4g\n', direction, index, total, forcing);
end
end
