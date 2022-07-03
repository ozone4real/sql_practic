-- How many races are being run in each decade

select extract('year' from date_trunc('decade', date)) decade, count(*) from races group by decade order by decade;

-- -- drivers that never finished a race they participated in with bool_and 
-- -- (returns true if the statement is true for every row in the group)

-- -- Note that to avoid any ambiguity, the having clause is not allowed to reference select output aliases.

-- select drivers.driverid, forename, surname, count(*) races from drivers
-- inner join results using(driverid)
-- group by driverid having bool_and(position is null) is true;

-- -- years any driver didn't finish a race

-- with counts as (
--   select year,
--   count(*) filter(where position is null) as outs, bool_and(position is null) as never_finished
--   from drivers
--   join results using(driverid) join races using(raceid)
--   group by year, driverid
-- )
-- select year as season, sum(outs) "#times any driver didn't finish a race" from counts where never_finished
-- group by season
-- order by sum(outs) desc
-- limit 5;

-- GROUPING SETS --
-- Grouping sets are used to compute aggregates for multiple groups in parallel. 
-- In the query result, when the aggregates are computed for one group, the other group result would contain null values.

-- compute the sums of constructors' points and drivers' points in a single query:

\set season 'date ''1978-01-01'''
select drivers.surname as driver, constructors.name as constructor, sum(points) as points 
from results
join races using(raceid)
join drivers using(driverid)
join constructors using(constructorid)
where date >= :season
and date < :season + interval '1 year'
group by grouping sets((drivers.surname), (constructors.name))
having sum(points) > 20
order by
constructors.name is not null, drivers.surname is not null, points desc;

-- rollup ! --
-- The rollup clause generates permutations for each column of the grouping sets one after the other --
-- In a single round trip fetch the cumulative points for 'Prost' and 'Sena'
-- for each of the constructor championships they raced for and also return the overall total for each driver
-- and the overall total points combined

select drivers.surname as driver,
constructors.name as constructor,
sum(points) as points
from results
join races using (raceid)
join drivers using (driverid)
join constructors using (constructorid)
where drivers.surname in ('Prost', 'Senna')
group by rollup(driver, constructor)
order by driver;

-- switch group
select drivers.surname as driver,
constructors.name as constructor,
sum(points) as points
from results
join races using (raceid)
join drivers using(driverid)
join constructors using(constructorid)
where drivers.surname in ('Prost', 'Senna')
group by rollup(constructor, driver)
order by constructor;

-- Another kind of grouping sets clause shortcut is named cube,
-- which extends to all permutations available, including partial ones:

-- same as rollup but also adds the totals for the 2nd group

select drivers.surname as driver,
constructors.name as constructor,
sum(points) as points
from results
join races using (raceid)
join drivers using (driverid)
join constructors using (constructorid)
where drivers.surname in ('Prost', 'Senna')
group by cube(driver, constructor)
order by driver;
