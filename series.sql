select * from generate_series((current_date - interval '30 days'), current_date, interval '1d') as date;

select * from generate_series(6, 1, -2);