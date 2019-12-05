truncate table public.tb_user cascade;

INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (1, 'CTdev', MD5('WeRLegionExpectUs'), true, true);
INSERT INTO public.tb_user (tb_user_id, username, md5pwd, active, admin_role) VALUES (2, 'demoOperator', MD5('getReadyForTheShow'), true, false);


INSERT INTO public.tb_user (username,md5pwd,active,admin_role) VALUES 
('oriol',md5('oriol'),true,false)
,('montse',md5('montse'),true,false)
,('bet',md5('bet'),true,false)
,('mccarras',md5('mccarras'),true,false)
,('joaquim',md5('joaquim'),true,false)
,('ricard',md5('ricard'),true,false)
,('xavi',md5('xavi'),true,false)
,('jordi',md5('jordi'),true,false)
;
INSERT INTO public.tb_user (username,md5pwd,active,admin_role) VALUES 
('chris',md5('chris'),true,false)
,('niki',md5('niki'),true,false)
,('pablo',md5('pablo'),true,false)
;