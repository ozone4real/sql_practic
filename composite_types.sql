begin;

create type rate_t as (
  currency text,
  validity daterange,
  value numeric
);

-- create a table from a composite type

create table rate of rate_t
(
  exclude using gist (currency with =, validity with &&)
);

insert into rate(currency, validity, value) values ('USD', '["now()", "now()"]', 100000);
commit;