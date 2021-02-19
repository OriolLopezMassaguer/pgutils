truncate table public.tb_user cascade;

INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (1, 'ctadmin', MD5('ctadmin'), true, true);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (2, 'user1', MD5('pass1'), true, false);

update tb_user
set md5pwd=MD5('oriol')
where username ='oriol'



INSERT INTO public.tb_user (username, md5pwd, active, admin_role) VALUES ('bet', MD5('clarity2020'), true, false);


update tb_user 
set md5pwd=MD5('mai5Daon') where username='demo'



INSERT INTO public.tb_user (username, md5pwd, active, admin_role) VALUES ('chris', MD5('Thoh5phe'), true, false);


select count(*) from tb_chemical_space tcs  
where tcs.pgp =0 or tcs.pgp=1





select count(*) from tb_chemical_space tcs  
where tcs.pgp =0 
-- son 3120119

select count(*) from tb_chemical_space tcs  
where tcs.pgp=1  
-- son 1912542

select count(*) from tb_chemical_space tcs  
where not(tcs.pgp =0 or tcs.pgp=1) 

-- son 225473

select count(*) from tb_chemical_space tcs  
where tcs.pgp <0 

--son 13368

select count(*) from tb_chemical_space tcs  
where tcs.pgp >1.0
-- son 13368
