-- WINDOW FUNCTIONS
-- difference in number of races for current decade compared to the previous one.
with decades_count as (
  select extract('year' from date_trunc('decade', date)) decade, count(*) from races group by decade order by decade
)
select count, decade, coalesce(count - lag(count) over(order by decade), 0) from decades_count;

-- with partition by, it applies the window function to the group
select name, alt, country, count(*) over(partition by country) from circuits;

-- without 'partition by', there is just one partition containing all the rows
select name, alt, country, count(*) over() from circuits;

-- with order by it applies the window function up to the current row in the order

select name, alt, country, count(*) over(partition by country order by alt) from circuits;
select name, alt, country, count(*) over(order by alt) from circuits;


-- Within a race, we can now fetch the list of competing drivers in their position order (winner 􏰁􏰂rst),
-- and also their ranking compared to other drivers from the same constructor in the race:

select format('%s %s', drivers.forename, drivers.surname), position, constructors.name,
rank() over (partition by constructorid order by position) rank,
count(*) over (partition by constructorid)
from results
join drivers using(driverid) 
join constructors using(constructorid)
where raceid = 890 ;

-- Window clauses are always considered last in a query (after the where clause)
