INSERT INTO public.tb_user (tb_user_id,username, md5pwd, active, admin_role) 
VALUES 
	(3,'oriol', MD5('oriol'), true, false),
	(4,'montse', MD5('montse'), true, false),
	(5,'bet', MD5('bet'), true, false),
	(6,'mccarras', MD5('mccarras'), true, false),
	(7,'joaquim', MD5('joaquim'), true, false),
	(8,'ricard', MD5('ricard'), true, false),
	(9,'xavi', MD5('xavi'), true, false),
	(10,'jordi', MD5('jordi'), true, false),
	(11,'chris', MD5('chris'), true, false);
	


INSERT INTO public.tb_user (tb_user_id,username, md5pwd, active, admin_role) values (12,'niki', MD5('niki'), true, false);