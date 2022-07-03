-- testdb

with matches as (select id, regexp_matches(tweet, '#[^ ]*', 'g') from hashtags)
select id, array_agg(regexp_matches[1]) from matches group by id;

-- array contains a value:

select * from hashtags where tags @> '{#weasa}';

-- unnest turns array to a relation
select id, unnest(tags) tag from hashtags;
select id, tag from hashtags, unnest(tags) t(tag);

select ARRAY [1, 2, 3,4];


-- PostgreSQL arrays are very powerful, and GIN indexing support makes them efficient to work with.
-- Nonetheless, it’s still not so efficient that you would replace a lookup table with an array in situations where you do a lot of lookups, though.