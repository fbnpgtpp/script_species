-- INSERT INTO table_name (column1, column2, column3, ...)
-- VALUES (value1, value2, value3, ...);

-- UPDATE table_name
-- SET column1 = value1, column2 = value2, ...
-- WHERE condition;


-- INSERT PROJECT


-- INSERT TRANSLATIONS
INSERT INTO schemav5.translations (id, languagecode, translationlabel)
VALUES 
(239,'fr','tiama'),
(104,'fr','gliricida'),
(140,'fr','kplê'),
(122,'fr','iroko (sauvageon)'),
(10,'fr','akpi'),
(98,'fr','framiré'),
(97,'fr','fraké'),
(151,'fr','makore'),
(831,'fr','Illomba'),(831,'en','Illomba'),
(1005,'fr','Heritiera utilis'),
(1006,'fr','Hallea ciliata'),
(1007,'fr','Bitter kola'),
(1008,'fr','long pepper'),
(1009,'fr','Kyaya spp'),
(1005,'en','Heritiera utilis'),
(1006,'en','Hallea ciliata'),
(1007,'en','Bitter kola'),
(1008,'en','long pepper'),
(1009,'en','Kyaya spp');

-- UPDATE TRANSLATIONS
UPDATE schemav5.translations
SET translationlabel =  'Niangon'
WHERE id = 1005 and languagecode = 'fr';

UPDATE schemav5.translations
SET translationlabel =  'Bahia'
WHERE id = 1006 and languagecode = 'fr';

UPDATE schemav5.translations
SET translationlabel =  'petit cola'
WHERE id = 1007 and languagecode = 'fr';

UPDATE schemav5.translations
SET translationlabel =  'Poivre long'
WHERE id = 1008 and languagecode = 'fr';

UPDATE schemav5.translations
SET translationlabel =  'Acajou'
WHERE id = 1009 and languagecode = 'fr';

-- INSERT SPECIES
INSERT INTO schemav5.species (id, vulgarname, latinname, speciesfamily, code, translationid, mainspeciesid, treecategid)
VALUES 
(1114,'Heritiera utilis','Heritiera utilis','','heritiera_utilis',1005,1114,0),
(1115,'Hallea ciliata','Hallea ciliata','','hallea_ciliata',1006,1115,0),
(1116,'Garcinia kola','Garcinia kola','','garcinia_kola',1007,1116,0),
(1117,'Xylopla dethiopica','Xylopla dethiopica','','xylopla_dethiopica',1008,1117,0),
(1118,'Kyaya spp','Kyaya spp','','kyaya_spp',1009,1118,0);

-- UPDATE SPECIES
UPDATE schemav5.translations
SET translationlabel =  'Bur flower'
WHERE id = 123 and languagecode = 'en';

-- INSERT PROJECTS SPECIES
INSERT INTO schemav5.projectspecies (projectid, speciesid)
VALUES 
(73,809),
(73,1114),
(73,1115),
(73,1116),
(73,1117),
(73,1118);

-- DELETE PROJECTS SPECIES
DELETE FROM schemav5.projectspecies
WHERE projectid = 73 and speciesid = 8;
DELETE FROM schemav5.projectspecies
WHERE projectid = 73 and speciesid = 137;
DELETE FROM schemav5.projectspecies
WHERE projectid = 73 and speciesid = 146;
DELETE FROM schemav5.projectspecies
WHERE projectid = 73 and speciesid = 186;
DELETE FROM schemav5.projectspecies
WHERE projectid = 73 and speciesid = 312;
DELETE FROM schemav5.projectspecies
WHERE projectid = 73 and speciesid = 473;
DELETE FROM schemav5.projectspecies
WHERE projectid = 73 and speciesid = 502;

--VOIR ESPECES DU PROJET AVEC TRAD--
select projectid, speciesid, b.id, nom_vulgaire, species_code, translationid, c.id, languecode, translationlabel
from kobo_import.projectspecies as a
join kobo_import.species as b  ON a.speciesid = b.id
join kobo_import.translations as c ON b.translationid = c.id
WHERE projectid = 98;