function result = run_continuation_family(config)
% Run a continuation family.

hybrid.require_fields(config, {'family'}, 'Continuation-family configuration');
hybrid.require_fields(config.family, {'parameter', 'values'}, ...
    'Continuation family');

family = config.family;
members = cell(1, numel(family.values));
for index = 1:numel(family.values)
    member_config = config;
    member_config.(family.parameter) = family.values(index);
    members{index} = hybrid.simulate_hysteresis_scan(member_config);
end

result.config = config;
result.family = family;
result.members = members;
end
