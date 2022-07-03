-- drivers and constructors who got at least a point from race 972
(
  select raceid, 'driver' as type, format('%s %s', drivers.forename, drivers.surname) as name,
  driverstandings.points from driverstandings join drivers using (driverid)
  where raceid = 972 and points > 0
)
union all
(
  select raceid, 'constructor' as type, constructors.name as name, constructorstandings.points
  from constructorstandings join constructors using(constructorid) where raceid = 972 and points > 0
)
order by points desc;

-- drivers who got no points in race 972 despite getting a point in race 971

(
  select format('%s %s', drivers.forename, drivers.surname) as name from driverstandings
  join drivers using(driverid)
  where raceid = 972 and points = 0
)
except
(
  select format('%s %s', drivers.forename, drivers.surname) as name from driverstandings
  join drivers using(driverid)
  where raceid = 971 and points = 0
);

-- or

(
  select format('%s %s', drivers.forename, drivers.surname) as name from driverstandings
  join drivers using(driverid)
  where raceid = 972 and points = 0
)
intersect
(
  select format('%s %s', drivers.forename, drivers.surname) as name from driverstandings
  join drivers using(driverid)
  where raceid = 971 and points > 0
);


-- except is useful for regression tests