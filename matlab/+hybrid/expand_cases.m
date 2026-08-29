function values = expand_cases(values, case_count, field_name)
% Expand case values.

values = values(:).';
if isscalar(values)
    values = repmat(values, 1, case_count);
elseif numel(values) ~= case_count
    error('hybrid:InvalidCaseCount', ...
        '%s must be scalar or contain %d values.', field_name, case_count);
end
end
