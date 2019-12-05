truncate table public.tb_user cascade;

INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (1, 'ctadmin', MD5('ctadmin'), true, true);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (2, 'user1', MD5('pass1'), true, false);

update tb_user
set md5pwd=MD5('clarity2019')
where username ='tdeboer'



INSERT INTO public.tb_user (username, md5pwd, active, admin_role) VALUES ('demo', MD5('demo'), true, false);


update tb_user 
set md5pwd=MD5('mai5Daon') where username='demo'



INSERT INTO public.tb_user (username, md5pwd, active, admin_role) VALUES ('chris', MD5('Thoh5phe'), true, false);


