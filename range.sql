 
 -- to use gist on 1 dimensional data, the btree_gist extension must be enabled.
 create extension if not exists btree_gist;

 create table if not exists ranges(
   id bigserial primary key,
   currency text,
   validity daterange,

   exclude using gist(currency with =,  validity with &&)
 )

--  alter table ranges add constraint exclusion_cstrnt exclude using gist(currency with =,  validity with &&);

 insert into ranges(currency, validity) values('USD', '[2018-01-01, 2018-01-31]');

-- overlap query
select * from ranges where validity && '[2018-02-01, 2018-02-28]';

-- contains  query
select * from ranges where validity @> '2018-02-15'::timestamptz;