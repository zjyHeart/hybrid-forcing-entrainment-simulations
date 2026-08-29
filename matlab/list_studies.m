function entries = list_studies()
% List all studies.

entries = studies.catalog();
for index = 1:numel(entries)
    fprintf('%-28s %s\n', entries(index).id, entries(index).description);
end
end
