-- The proper way to implement pagination is to use index lookups,
-- and if you have multiple columns in your ordering clause, you can do that with the row() construct.
-- Never use offset in a query for pagination if you care about performance. 
-- Use fetch instead. Offset adds a performance overhead to queries

select * from races order by raceid fetch first 5 rows only;
select * from races where raceid > 5 order by raceid fetch first 5 rows only;

select * from races order by year, date fetch first 5 rows only;
select * from races where row(year, date) > (1950, '1950-06-18') order by year fetch first 5 rows only