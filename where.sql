/* 
Some simple rules to remember here:

- In a where clause we can combine filters, and generally we combine them with the and operator, which allows short-circuit evaluations because as soon as one of the anded conditions evaluates to false, we know for sure we can skip the current row.

- Where also supports the or operator, which is more complexto optimize for, in particular with respect to indexes.

- We have support for both not and not in, which are completely different beasts.
  Be careful about not in semantics with NULL: the following query returns no rows...
  select x
  from generate_series(1, 100) as t(x)
  where x not in (1, 2, 3, null); 

*/

-- NOT EXISTS A.K.A anti join
-- drivers that don't have a position in all their races 
select * from drivers where not exists (select 1 from results where position is not null and drivers.driverid = driverid);