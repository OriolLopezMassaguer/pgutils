-- select distinct tree_id from tb_molecule_classification

-- select distinct tree_id from tb_classification_tree

               
delete from tb_classification_tree where tree_id='CSC';

with
        csc as (select regexp_split_to_array(csc,'\.') cscarray from tb_medchem_scaffold),
        csc0 as (select distinct cscarray[1]   from csc),
        csc1 as (select distinct array_to_string(csc.cscarray[1:2],'.') as p from csc),
        csc2 as (select distinct array_to_string(csc.cscarray[1:3],'.') as p from csc),
        csc3 as (select distinct array_to_string(csc.cscarray[1:4],'.') as p from csc),
        csc4 as (select distinct array_to_string(csc.cscarray[1:5],'.') as p from csc),
        cscall as (		
                select * 
                from csc0
                union 
                select * 
                from csc1
                union 
                select * 
                from csc2
                union 
                select * 
                from csc3
                union 
                select * 
                from csc4) 
        insert into tb_classification_tree  
        select distinct 'CSC',text2ltree(cscarray),cscarray,cscarray,'TMP'
        from cscall;
        
       
UPDATE tb_classification_tree
            set color = colordict.color
            FROM (SELECT * FROM (VALUES     ('000' , '#deeed6'),
                ('001', '#442434'),
                ('002' , '#30346d'),
                ('003' ,'#4e4a4e'),
                ('004' ,'#854c30'),
                ('005' , '#346524'),
                ('006' , '#d04648'),
                ('007' , '#757161'),
                ('008' , '#597dce'),
                ('009' , '#d27d2c'),
                ('010' , '#8595a1'),
                ('011' , '#6daa2c'),
                ('013' , '#d2aa99'),
                ('014' , '#6dc2ca'),
                ('032' , '#dad45e')) AS t (csc,color)) colordict
            where tb_classification_tree.tree_id='CSC' 
            and substring(tb_classification_tree.label from 1 for 3) = colordict.csc;
            
           
UPDATE tb_classification_tree
            set color = '#deeed6'
            where tb_classification_tree.tree_id='CSC' and color='TMP';
            
           
                insert into tb_molecule_classification
                select  distinct mol.inchikey,'CSC',subltree(text2ltree(scaff.csc),0,5)
                from tb_medchem_scaffold scaff, tb_medchem_molecule mol
                where scaff.inchikeymurckoscaffold=mol.inchikeymurckoscaffold
                and mol.inchikey in (select inchikey from tb_chemical_space);           