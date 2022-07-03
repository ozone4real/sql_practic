-- Boolean
-- /Users/ezenwaogbonna/Desktop/sql_practice/nulls.sql

-- aggregate functions bypass nulls by default

-- select animal from (
--   values(4, 'pig'),(4, 'pig'),(null, 'goat'),(4, 'goat')
-- ) test(amount, animal)
-- group by animal having bool_and(amount = 4);

-- select animal from (
--   values(4, 'pig'),(4, 'pig'),(null, 'goat'),(4, 'goat')
-- ) test(amount, animal)
-- group by animal having bool_and(amount is not distinct from 4);

-- Character and Text
-- In postgres, varchar and text are the same thing.
-- regexp_split_to_table() is very powerful and can be used to split a string into a table of strings.

select regexp_split_to_table('Ezenwa Ogbonna', '\s+') as name;


-- if you have a serial column, its real type is going to be integer,
-- and as soon as the sequence generates a number that doesn’t 􏰀􏰁t into signed 4-byte representa- tion, you’re going to have errors.
-- using bigserial as the column type will prevent this.

create table annoti (
  id serial
)

setval('annoti_id_seq', 2147483647, true);

insert into annoti default values;