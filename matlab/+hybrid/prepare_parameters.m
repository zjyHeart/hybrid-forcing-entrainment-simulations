function parameters = prepare_parameters(model, case_count, precision)
% Prepare model cases.

names = {'Omega', 'K', 'A0', 'gamma', 'rho', 'L'};
hybrid.require_fields(model, names, 'Model parameters');
for index = 1:numel(names)
    name = names{index};
    values = hybrid.expand_cases(model.(name), case_count, name);
    parameters.(name) = cast(values, char(precision));
end
end
