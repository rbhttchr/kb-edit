-- 8) ///////////////////////////////////////////////////////////////
--    remake indiv_dist.trarray field

-- 6-16 DONE ALREADY, #3
-- add records to indiv_dist for new indiv records [run 02May2016, added 14 recods]
-- insert into indiv_dist(indiv_id,odnb_id)
--  select indiv_id, odnb from indiv i where i.indiv_id not in
-- (select indiv_id from indiv_dist);

-- then fill in fields for new records
-- insert tragedy and trarray fields in indiv_dist (run time 2.5 sec)
-- test: copy indiv_dist to 'temp' schema, clone it back into 'public' --
-- alter table indiv_dist set schema temp;
-- select * into indiv_dist from temp.indiv_dist;
-- [run 02May2016, seems okay; 01Jun2016]
----------

UPDATE indiv_dist SET trarray =
  '['||(
  CASE
  when LOWER(deathtext) LIKE '%wounds%' OR LOWER(deathtext) LIKE '%battle%' OR LOWER(deathtext) LIKE '%killed in action%' OR LOWER(deathtext) LIKE '%cwgc.org%' then 1
  when LOWER(deathtext) LIKE '%hanged%' OR LOWER(deathtext) LIKE '%shot%' OR LOWER(deathtext) LIKE '%executed%' OR LOWER(deathtext) LIKE '%beheaded%' OR LOWER(deathtext) LIKE '%tower hill%' OR LOWER(deathtext) LIKE '%tyburn%' then 1
  when LOWER(deathtext) LIKE '%murdered%' OR LOWER(deathtext) LIKE '%stabbed%' OR LOWER(deathtext) LIKE '%suicide%' OR LOWER(deathtext) LIKE '%killed herself%' OR LOWER(deathtext) LIKE '%killed himself%' then 1
  else diedyoung
  END
  )||
  ','||tragic.trarray||','||
  (
  CASE
  when LOWER(eventext) LIKE '%insane%' OR LOWER(eventext) LIKE '%breakdown%' OR LOWER(eventext) LIKE '%lunatic%' then 1
  else 0
  END
  )||']',

  tragedy = total +
  (
  CASE
  when LOWER(deathtext) LIKE '%wounds%' OR LOWER(deathtext) LIKE '%battle%' OR LOWER(deathtext) LIKE '%killed in action%' OR LOWER(deathtext) LIKE '%cwgc.org%' then 1
  when LOWER(deathtext) LIKE '%hanged%' OR LOWER(deathtext) LIKE '%shot%' OR LOWER(deathtext) LIKE '%executed%' OR LOWER(deathtext) LIKE '%beheaded%' OR LOWER(deathtext) LIKE '%tower hill%' OR LOWER(deathtext) LIKE '%tyburn%' then 1
  when LOWER(deathtext) LIKE '%murdered%' OR LOWER(deathtext) LIKE '%stabbed%' OR LOWER(deathtext) LIKE '%suicide%' OR LOWER(deathtext) LIKE '%killed herself%' OR LOWER(deathtext) LIKE '%killed himself%' then 1
  else diedyoung
  END
  )
  +
  (
  CASE
  when LOWER(eventext) LIKE '%insane%' OR LOWER(eventext) LIKE '%breakdown%' OR LOWER(eventext) LIKE '%lunatic%' then 1
  else 0
  END
  )

  FROM tragic, trag_text
  WHERE trag_text.indiv_id = tragic.indiv_id
  AND tragic.indiv_id = indiv_dist.indiv_id;


-- 8a) ///////////////////////////////////////////////////////////////
-- requires updated extfamily
-- DONE ALREADY, IN #6
-- put number of children, marriages into indiv_dist
-- update indiv_dist id set
--   children = coalesce(array_length(ef.children,1),0),
--   marriage = coalesce(array_length(ef.spouses,1),0)
--   from extfamily ef
--   where ef.indiv_id = id.indiv_id;

-- 8b) ///////////////////////////////////////////////////////////////
-- odnb_wordcount
-- DONE ALREADY, IN #3
-- !!! relies on indiv.odnb value for new indiv records !!!
-- NOTE: json.odnb in code refers to indiv_dist.odnb, NOT indiv.odnb_id
-- update indiv_dist id set
-- --   odnb_id = o.odnb_id,
--   odnb_wordcount = o.words
--   from odnbers o
--   where id.odnb_id is not null
--   and o.odnb_id = id.odnb_id;
