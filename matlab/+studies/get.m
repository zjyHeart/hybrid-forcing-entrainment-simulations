function entry = get(study_id)
% Get one study.

normalized = strrep(lower(char(study_id)), '_', '-');
entries = studies.catalog();
identifiers = {entries.id};
index = find(strcmp(identifiers, normalized), 1);
if isempty(index)
    error('studies:UnknownStudy', ...
        'Unknown study ''%s''. Available studies: %s.', ...
        char(study_id), strjoin(identifiers, ', '));
end
entry = entries(index);
end
