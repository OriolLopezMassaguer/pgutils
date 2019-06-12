truncate table public.tb_user cascade;

INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (1, 'CTdev', MD5('WeRLegionExpectUs'), true, true);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (2, 'demoOperator', MD5('getReadyForTheShow'), true, false);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (3,'oriol',MD5('aeshei2a'),true,false);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (4,'montse',MD5('foo6ajoo'),true,false);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (5,'bet',MD5('sah4lai8'),false,false);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (6,'mccarras',MD5('aixeeku5'),false,false);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (7,'joaquim',MD5('coogu0zi'),false,false);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (8,'ricard',MD5('eewuwei8'),false,false);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (9,'xavi',MD5('yu0kaeru'),false,false);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (10,'jordi',MD5('ieshaes0'),true,false);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (11,'chris',MD5('aelah7bo'),true,false);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (12,'niki',MD5('neir7dah'),true,false);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (13, 'demo',MD5('aicei9uw'),true,false);




-- CTdev | WeRLegionExpectUs
-- demoOperator | getReadyForTheShow
--aeshei2a
--foo6ajoo
--sah4lai8
--aixeeku5
--coogu0zi
--eewuwei8
--yu0kaeru
--ieshaes0
--aelah7bo
--neir7dah
--aicei9uw