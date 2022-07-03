-- order by using case statement to order conditionally.
-- order first by position and laps then if the status is 'Power Unit' let it come first before others. 
-- select drivers.code, drivers.surname, position, laps, status from results
-- join drivers using(driverid)
-- join status using(statusid)
-- where raceid = 972
-- order by position nulls last, laps desc, 
-- case when status = 'Power Unit' then 1 else 2 end;

-- K nearest neighbours (KNN) is a technique to find the k nearest neighbours of a point in a set of points.
-- 10 nearest circuits to Paris, France which which is at longitude 2.349014 and latitude 48.864716
select name, location, country from circuits order by geo_coordinate <-> point(2.349014, 48.864716) limit 10;