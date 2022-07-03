\set category_id 9

with recursive descendants as (
  select * from categories where parent_id = :category_id
  union all
  select categories.* from categories inner join descendants on descendants.category_id = categories.parent_id
)

select * from descendants;

\set category_id 25

with recursive ancestors as (
  select * from categories where category_id = :category_id
  union all
  select categories.* from categories inner join ancestors on ancestors.parent_id = categories.category_id
)

select * from ancestors;

-- we can see a table of all seasons and their champion driver and
-- champion constructor: the driver/constructor who won the most points in total in the races that year.

-- with total_points as (
--   select format('%s %s', drivers.forename, drivers.surname) as driver, year, constructors.name as constructor, sum(points) as points
--   from races inner join results using(raceid) 
--   inner join drivers using (driverid)
--   inner join constructors using(constructorid)
--   group by year, driver, constructor having sum(points) > 0
-- ),
-- max_points as (
--   select max(points), year from total_points group by year
-- )

-- select distinct on (total_points.year) total_points.year, constructor, driver, max from total_points
-- inner join max_points on max_points.year = total_points.year
-- and max_points.max = total_points.points
-- order by total_points.year;


with points as (
  select year as season, driverid, constructorid, sum(points) as points from results
  join races using(raceid)
  group by grouping sets((year, driverid), (year, constructorid))
  having sum(points) > 0
  order by season, points desc
),
tops as (
  select season, max(points) filter(where driverid is null) as ctops, max(points) filter(where constructorid is null) as dtops
  from points
  group by season
  order by season, dtops, ctops
),
champs as (
  select tops.season,
  champ_driver.driverid,
  champ_driver.points,
  champ_constructor.constructorid,
  champ_constructor.points
  from tops
  join points as champ_driver 
  on champ_driver.season = tops.season
  and champ_driver.points = tops.dtops
  and champ_driver.constructorid is null
  join points as champ_constructor
  on champ_constructor.season = tops.season
  and champ_constructor.driverid is null
  and champ_constructor.points = tops.ctops
)

select season,
format('%s %s', drivers.forename, drivers.surname) as "Driver's Champion",
constructors.name as "Constructor's champion" from champs
join drivers using(driverid)
join constructors using(constructorid) order by season;