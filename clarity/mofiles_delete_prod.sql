select count(*)
from tb_chemical_space
where not (spaces@>array['ATC'] or
spaces@>array['DRUGS'] or
spaces@>array['COSMETICS'] or 
spaces@>array['FAERS'])

select count(*)
from tb_chemical_space
where not (spaces@>array['ATC'] or
spaces@>array['DRUGS'] or
spaces@>array['COSMETICS'] or 
spaces@>array['FAERS']) 
and molrdkit is not null;

select count(*)
from tb_chemical_space
where not (spaces@>array['ATC'] or
spaces@>array['DRUGS'] or
spaces@>array['COSMETICS'] or 
spaces@>array['FAERS']) 
and molrdkit is not null;