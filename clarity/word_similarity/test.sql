--create extension  pg_trgm;

select distinct on (x2."inchikey", x3."synonym", x2."synonym", word_similarity_original(x2."synonym",'perg'), length(x2."synonym"), x2."is_main_name") x2."inchikey", 
x3."synonym", x2."synonym", word_similarity_original(x2."synonym",'perg'), length(x2."synonym"), x2."is_main_name" 

from "tb_molecule_thesaurus" x2, "tb_molecule_thesaurus" x3 
where ((word_similarity_original(x2."synonym",'perg') > 0.6) and (x2."spaces" @> '{DRUGS}')) and (((x3."is_main_name" = true) and (x3."inchikey" = x2."inchikey")) 
and (x3."spaces" @> '{DRUGS}')) order by word_similarity_original(x2."synonym",'perg') desc, length(x2."synonym"), x2."synonym" limit 5	


select x2.synonym,word_similarity_revised(x2."synonym",'perg'), similarity(x2."synonym",'perg'), word_similarity(x2."synonym",'perg') ,strict_word_similarity(x2."synonym",'perg') 
from "tb_molecule_thesaurus" x2, "tb_molecule_thesaurus" x3 
where ((word_similarity_revised(x2."synonym",'perg') > 0.3) 

and 
(x2."spaces" @> '{DRUGS}')) and (((x3."is_main_name" = true) and (x3."inchikey" = x2."inchikey")) 
and (x3."spaces" @> '{DRUGS}')) order by word_similarity_revised(x2."synonym",'perg') desc, length(x2."synonym"), x2."synonym" 



select show_substring_limit()




CREATE OR REPLACE FUNCTION public.substring_similarity_revised(string_a text, string_b text)
 RETURNS real
 LANGUAGE plpgsql
AS $function$
DECLARE
  a_trigrams TEXT[];
  b_trigrams TEXT[];
  a_tri_len INTEGER;
  b_tri_len INTEGER;
  common_trigrams TEXT[];
  max_common INTEGER;
BEGIN
  a_trigrams = SHOW_TRGM(string_a);
  b_trigrams = SHOW_TRGM(string_b);
  a_tri_len = ARRAY_LENGTH(a_trigrams, 1);
  b_tri_len = ARRAY_LENGTH(b_trigrams, 1);
  IF (NOT (a_tri_len > 0) OR NOT (b_tri_len > 0)) THEN
    IF (string_a = string_b) THEN
      RETURN 1;
    ELSE
      RETURN 0;
    END IF;
  END IF;
  common_trigrams := ARRAY(SELECT UNNEST(a_trigrams) INTERSECT SELECT UNNEST(b_trigrams));
  max_common = LEAST(a_tri_len, b_tri_len);
  RETURN COALESCE(ARRAY_LENGTH(common_trigrams, 1), 0)::FLOAT4 / max_common::FLOAT4;
END;
$function$
;

 
 CREATE OR REPLACE FUNCTION public.word_similarity_revised(string_a text, string_b text)
 RETURNS real
 LANGUAGE plpgsql
AS $function$
DECLARE
  base_score FLOAT4;
BEGIN
  base_score := substring_similarity(string_a, string_b);
  -- a good standard similarity score can raise the base_score
  RETURN base_score + ((1.0 - base_score) * SIMILARITY(string_a, string_b));
END;
$function$
;

select show_limit()
