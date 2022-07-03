-- FORMAT

-- select 'The ' || name as sentence, name from races;
-- instead of using || to concatenate strings, use format because it's cleaner
select format('The %s', name) as sentence, name from races;