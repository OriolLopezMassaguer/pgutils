 
 CREATE OR REPLACE FUNCTION public.intersection(anyarray, anyarray)
 RETURNS anyarray
 LANGUAGE sql
AS $function$
SELECT ARRAY(
    SELECT $1[i]
    FROM generate_series( array_lower($1, 1), array_upper($1, 1) ) i
    WHERE ARRAY[$1[i]] && $2
);
$function$
;

 
create or replace view tb_chemical_space_visible as
select intersection(spaces,array(select space_id spaces_visible from tb_space where tb_space.is_visible)), tb_chemical_space.* 
from tb_chemical_space 
where spaces && array(select space_id spaces_visible from tb_space where tb_space.is_visible)
 