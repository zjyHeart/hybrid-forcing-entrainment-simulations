function omega = make_frequencies(config)
% Sample frequencies.

distribution = lower(char(config.distribution));
oscillator_count = config.N;
center = config.omega0;
parameters = config.distribution_parameters;

switch distribution
    case 'lorentzian'
        delta = parameters.Delta;
        probability = (1:oscillator_count).' ./ (oscillator_count + 1);
        omega = center + delta .* tan(pi .* (probability - 0.5));

    case 'gaussian'
        sigma = parameters.sigma;
        probability = ((1:oscillator_count).' - 0.5) ./ oscillator_count;
        omega = center + sigma .* sqrt(2) .* erfinv(2 .* probability - 1);

    case 'bimodal'
        mode_offset = parameters.mu;
        sigma = parameters.sigma;
        left_count = floor(oscillator_count ./ 2);
        right_count = oscillator_count - left_count;
        left_probability = ((1:left_count).' - 0.5) ./ left_count;
        right_probability = ((1:right_count).' - 0.5) ./ right_count;
        left = center - mode_offset + sigma .* sqrt(2) .* ...
            erfinv(2 .* left_probability - 1);
        right = center + mode_offset + sigma .* sqrt(2) .* ...
            erfinv(2 .* right_probability - 1);
        omega = [left; right];

    otherwise
        error('hybrid:UnknownDistribution', ...
            'Unknown frequency distribution: %s.', distribution);
end

if config.shuffle_frequencies
    rng(config.frequency_seed, 'twister');
    omega = omega(randperm(oscillator_count));
end
end
