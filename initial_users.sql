truncate table public.tb_user cascade;

INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (1, 'ctadmin', MD5('ctadmin'), true, true);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (2, 'user1', MD5('pass1'), true, false);




