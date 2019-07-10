select count(*)
from tb_chemical_space
where not (spaces@>array['ATC'] or
spaces@>array['DRUGS'] or
spaces@>array['COSMETICS'] or 
spaces@>array['FAERS'])


--create table molfiles2 as 
--select molfile 
--from tb_chemical_space