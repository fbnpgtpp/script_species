-- INSERT INTO table_name (column1, column2, column3, ...)
-- VALUES (value1, value2, value3, ...);

-- UPDATE table_name
-- SET column1 = value1, column2 = value2, ...
-- WHERE condition;


-- INSERT PROJECT
INSERT INTO public.projects (internalid, regionid, projectname,projectcountry)
VALUES (104, 5, "Mexico_Veracruz","mexico");

-- INSERT TRANSLATIONS
INSERT INTO public.translations (id, languagecode, translationlabel)
VALUES 
(241,'mx','Candelillo'),
(40,'mx','Cedro'),
(991,'mx','Chalahuite'),
(992,'mx','Cuapinole'),
(993,'mx','Frijolillo'),
(141,'mx','Guaje'),
(807,'mx','Xochicuauitl'),
(994,'mx','Canilla de venado'),
(995,'mx','Guarumbo'),
(996,'mx','Habín'),
(997,'mx','Ixpepe'),
(998,'mx','Jinicuil'),
(999,'mx','Jonote'),
(1000,'mx','Nacaxtle'),
(1001,'mx','Ramón'),
(1002,'mx','Sangregado'),
(1003,'mx','Tepeguaje'),
(1004,'mx','Zapote negro');

-- UPDATE TRANSLATIONS

-- INSERT SPECIES
INSERT INTO public.species (id, vulgarname, latinname, speciesfamily, code, translationid, mainspeciesid, treecategid)
VALUES 
(1103,'Cupania dentata','Cupania dentata','','cupania_dentata',994,1103,0),
(1104,'Cecopia obtusifolia','Cecopia obtusifolia','','cecopia_obtusifolia',995,1104,0),
(1105,'Lonchocarpus guatemalensis','Lonchocarpus guatemalensis','','lonchocarpus_guatemalensis',996,1105,0),
(1106,'Trema micrantha','Trema micrantha','','trema_micrantha',997,1106,0),
(1107,'Inga jinicuil','Inga jinicuil','','inga_jinicuil',998,1107,0),
(1108,'Heliocarpus apendiculatus','Heliocarpus apendiculatus','','heliocarpus_apendiculatus',999,1108,0),
(1109,'Enterolobium cyclocarpum','Enterolobium cyclocarpum','','enterolobium_cyclocarpum',1000,1109,0),
(1110,'Brosimum alicastrum','Brosimum alicastrum','','brosimum_alicastrum',1001,1110,0),
(1111,'Croton draco','Croton draco','','croton_draco',1002,1111,0),
(1112,'Lysiloma acapulcense','Lysiloma acapulcense','','lysiloma_acapulcense',1003,1112,0),
(1113,'Diospyros nigra','Diospyros nigra','','diospyros_nigra',1004,1113,0);

-- UPDATE SPECIES

UPDATE public.species
SET translationid =  '991'
WHERE id = 344;

UPDATE public.species
SET translationid =  '992'
WHERE id = 330;

UPDATE public.species
SET translationid =  '993'
WHERE id = 185;

-- INSERT PROJECTS SPECIES
INSERT INTO public.projectspecies (projectid, speciesid)
VALUES 
(104,644),
(104,143),
(104,344),
(104,330),
(104,185),
(104,381),
(104,193),
(104,1103),
(104,1104),
(104,1105),
(104,1106),
(104,1107),
(104,1108),
(104,1109),
(104,1110),
(104,1111),
(104,1112),
(104,1113);