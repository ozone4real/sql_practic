-- in sql null value means 'I don't know what this is' rather than 'no value'
-- anything compared with null would result in null rather than a boolean value.

select null = true, null = null, null = false;

select a::text, b::text, (a=b)::text as "a=b", format('%s = %s',
coalesce(a::text, 'null'),
coalesce(b::text, 'null')) as op, format('is %s',
coalesce((a=b)::text, 'null')) as result
from
(values(true), (false), (null)) v1(a)
cross join
(values(true), (false), (null)) v2(b);

--  if you want true null comparison that would return boolean values use 'is distinct from' or 'is not distinct from'

select
a::text as left, b::text as right,
(a = b)::text as "=",
(a <> b)::text as "<>",
(a is distinct from b)::text as "is distinct",
(a is not distinct from b)::text as "is not distinct from"
from
(values(true),(false),(null)) t1(a) cross join (values(true),(false),(null)) t2(b);

-- use 'is null' if you want to filter not values instead of '= null'

-- WRONG: this would return the wrong result
select a, b
from (values(true), (false), (null)) v1(a)
cross join
(values(true), (false), (null)) v2(b) where a = null;

-- CORRECT: this would return the correct result

select a, b
from (values(true), (false), (null)) v1(a)
cross join
(values(true), (false), (null)) v2(b) where a is null;
