function merged = merge_structs(base, overrides)
% Merge nested structs.

merged = base;
if isempty(overrides)
    return;
end
if ~isstruct(base) || ~isscalar(base) || ~isstruct(overrides) || ~isscalar(overrides)
    error('hybrid:InvalidStructMerge', ...
        'Both inputs to merge_structs must be scalar structures.');
end

names = fieldnames(overrides);
for index = 1:numel(names)
    name = names{index};
    value = overrides.(name);
    if isfield(merged, name) && isstruct(merged.(name)) && ...
            isscalar(merged.(name)) && isstruct(value) && isscalar(value)
        merged.(name) = hybrid.merge_structs(merged.(name), value);
    else
        merged.(name) = value;
    end
end
end
