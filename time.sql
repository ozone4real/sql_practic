-- How long is a month? Well, it depends on which month, and PostgreSQL knows that:
-- When you attach an interval to a date or timestamp in PostgreSQL then the number
-- of days in that interval adjusts to the speci􏰂􏰃c calendar entry you’ve picked.
-- Otherwise, an interval of a month is considered to be 30 days

select to_char(now(), 'Day DD, MM YY') as today;
select extract(isodow from now()) as day_of_week;
select extract(dow from now()) as day_of_week;
select extract(month from now()) as month;
select date_trunc ('year', current_date) as year;