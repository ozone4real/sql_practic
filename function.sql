create or replace function get_all_races(in id bigint)
  returns table (name text, year bigint, circuit text)
  as $$
    select races.name, year, circuits.name from races inner join circuits using(circuitid) where circuitid = id
  $$
  language sql;

create or replace function get_all_drivers(in pattern text, out name text, out nationality text)
  returns setof record