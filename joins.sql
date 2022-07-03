-- Races in a particular quarter and their winnners
\set beginning '2017-04-01'
\set months '3'

select format('%s %s', forename, surname) winner, races.date, races.name from races
left join results
on results.raceid = races.raceid and results.position = 1
left join drivers using (driverid)
where date between :'beginning'::date and :'beginning'::date + interval '1 month' * :'months';