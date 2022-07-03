-- gin index access method is suitable for data types that are made up of distinct components like arrays. Gin with the
-- trgm operator class is useful for columns that are searched for by pattern matching (LIKE, SIMILAR TO, e.t.c)

create index idx_t_hash_md5 on t_hash using gin (md5 gin_trgm_ops)

-- The default index access method is b_tree. Suitable for comparisons (>,<, =, e.t.c)
create index idx_t_hash_id on t_hash(id)

-- gist index access method is suitable for multi-dimensional (geo spatial) data types like points, boxes, e.t.c.