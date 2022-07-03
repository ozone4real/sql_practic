-- Note that the “first row” of each set is unpredictable unless ORDER BY is used to ensure that the desired row appears first.

-- drivers who never won a race in the whole formula one history
select distinct on (driverid) forename, surname
from results join drivers using(driverid)
where position = 1;