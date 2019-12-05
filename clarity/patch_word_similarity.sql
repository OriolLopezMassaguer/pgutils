CREATE OR REPLACE FUNCTION public.word_similarity(string_a text, string_b text)
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


CREATE OR REPLACE FUNCTION public.word_similarity_original(text, text)
 RETURNS real
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/pg_trgm', $function$word_similarity$function$
;

CREATE OPERATOR %%% (
  leftarg = TEXT,
  rightarg = TEXT,
  procedure = is_minimally_substring_similar,
  commutator = %%%
);