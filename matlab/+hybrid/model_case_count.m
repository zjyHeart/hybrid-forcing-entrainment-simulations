function case_count = model_case_count(model)
% Count model cases.

names = {'Omega', 'K', 'A0', 'gamma', 'rho', 'L'};
hybrid.require_fields(model, names, 'Model parameters');
counts = cellfun(@(name) numel(model.(name)), names);
case_count = max(counts);
end
