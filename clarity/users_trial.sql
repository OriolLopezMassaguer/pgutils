INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (4, 'eelbekai', MD5('Aivee9ai'), true, false);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (5, 'kcusack', MD5('aeQuaiw4'), true, false);

INSERT INTO public.tb_user ( username, md5pwd, active, admin_role) VALUES  ('michael.hoemann', MD5('DDRv56a1'), true, false);
INSERT INTO public.tb_user ( username, md5pwd, active, admin_role) VALUES  ('michael.friedman', MD5('DDRv56a2'), true, false);
INSERT INTO public.tb_user ( username, md5pwd, active, admin_role) VALUES  ('eric.breinlinger', MD5('DDRv56a3'), true, false);
INSERT INTO public.tb_user ( username, md5pwd, active, admin_role) VALUES  ('jeremy.edmunds', MD5('DDRv56a4'), true, false);
INSERT INTO public.tb_user ( username, md5pwd, active, admin_role) VALUES  ('dawn.george', MD5('DDRv56a5'), true, false);
INSERT INTO public.tb_user ( username, md5pwd, active, admin_role) VALUES  ('matthew.katcher', MD5('DDRv56a6'), true, false);
INSERT INTO public.tb_user ( username, md5pwd, active, admin_role) VALUES  ('kristine.frank', MD5('DDRv56a7'), true, false);
INSERT INTO public.tb_user ( username, md5pwd, active, admin_role) VALUES  ('bruce.leroy', MD5('DDRv56a8'), true, false);
INSERT INTO public.tb_user ( username, md5pwd, active, admin_role) VALUES  ('michael.foley', MD5('DDRv56a9'), true, false);
INSERT INTO public.tb_user ( username, md5pwd, active, admin_role) VALUES  ('mrao', MD5('DDRv56a10'), true, false);


michael.hoemann	DDRv56a1
michael.friedman	DDRv56a2
eric.breinlinger	DDRv56a3
jeremy.edmunds	DDRv56a4
dawn.george	DDRv56a5
matthew.katcher	DDRv56a6
kristine.frank	DDRv56a7
bruce.leroy	DDRv56a8
michael.foley	DDRv56a9


SELECT last_value FROM tb_user_tb_user_id_seq;

ALTER SEQUENCE tb_user_tb_user_id_seq restart with 6
delete from tb_user 
where tb_user_id=6


INSERT INTO public.tb_user ( username, md5pwd, active, admin_role) VALUES  ('oriol', MD5('oriol'), true, true);