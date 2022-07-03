with temp_table(json_t) as (
  values (
    '[[1, 2, 4, 5], [10, 3], [15, 17]]'::jsonb),
    ('[10, 2, 13, 5]'::jsonb),
    ('{"name": "ezenwa", "age": 24}'::jsonb),
    ('{"details": {"id": 5, "height": 6 }}'::jsonb)
)

-- a json object contains a key, value pair
-- select * from temp_table where json_t @> '{"name": "ezenwa"}'

-- a json array contains an element
-- select * from temp_table where json_t @> '13'

-- a json array contains multiple elements (order is insignificant)
-- select * from temp_table where json_t @> '[5, 13]'

-- a json array contains elements in nested array,
-- Wrong:
-- select * from temp_table where json_t @> '[15]'

-- Correct:
-- select * from temp_table where json_t @> '[[15]]'

-- a json object contains an object key
select * from temp_table where json_t @> '{"details": {}}'

