-- INSERT INTO table_name (column1, column2, column3, ...)
-- VALUES (value1, value2, value3, ...);

-- UPDATE table_name
-- SET column1 = value1, column2 = value2, ...
-- WHERE condition;

--INSERT LOCALISATION (OK) TODO
INSERT INTO kobo_import.localisations (id, localisationname, regionid)
VALUES (56, 'Kenya', 1);

-- INSERT PROJECT TODO
INSERT INTO kobo_import.projects (id, projectname, localisationid)
VALUES (99, 'Cherara', 56);

-- INSERT TRANSLATIONS (OK) DONE
INSERT INTO kobo_import.translations (id, languecode, translationlabel)
VALUES 
(65, 'kj' , 'Ndimu'),
(242, 'kj' , 'Samutet'),
(64, 'kj' , 'masanduku'),
(913, 'en' , 'acacia tortilis'),
(914, 'en' , 'loquat'),
(915, 'en' , 'Avocado'),
(916, 'en' , 'guava'),
(917, 'en' , 'african cherry'),
(918, 'en' , 'Rhus vulgaris'),
(919, 'en' , 'red hot poker tree'),
(920, 'en' , 'Nandi flame'),
(921, 'en' , 'mitzeeri'),
(922, 'en' , 'Croton macrostrachyus'),
(923, 'en' , 'watertree'),
(924, 'en' , 'papaya'),
(925, 'en' , 'Nil tulip'),
(926, 'en' , 'olive tree'),
(927, 'en' , 'Mango tree'),
(928, 'en' , 'White sapote '),
(929, 'en' , 'Moringa oleifera'),
(930, 'en' , 'Blue Jacaranda'),
(931, 'en' , 'red calliandra'),
(932, 'en' , 'pomegranate'),
(933, 'en' , 'Neem'),
(934, 'en' , 'Podocarpous falcatus'),
(936, 'en' , 'Croton megalocarpus'),
(913, 'kj' , 'Reberwet'),
(914, 'kj' , 'Lakwat'),
(916, 'kj' , 'maperyat'),
(917, 'kj' , 'Tanguruwet'),
(918, 'kj' , 'siriat'),
(919, 'kj' , 'Chebisorwet'),
(921, 'kj' , 'Mokoiywet'),
(922, 'kj' , 'tebeswet'),
(923, 'kj' , 'Lamayat'),
(924, 'kj' , 'Paw-paw'),
(925, 'kj' , 'Mobet'),
(926, 'kj' , 'Emitiot'),
(928, 'kj' , 'White-sapote'),
(929, 'kj' , 'Moringa'),
(930, 'kj' , 'jacaranda'),
(931, 'kj' , 'calliandra'),
(933, 'kj' , 'mwarubaini'),
(934, 'kj' , 'Saptet'),
(935, 'kj' , 'apurwet');

-- UPDATE TRANSLATIONS DONE
UPDATE kobo_import.translations
SET translationlabel =  'african cordia' WHERE id = 242 and languecode = 'en';

UPDATE kobo_import.translations
SET translationlabel =  'lemon' WHERE id = 65 and languecode = 'en';

-- INSERT SPECIES DONE
INSERT INTO kobo_import.species (id, nom_vulgaire, nom_latin, famille, species_code, translationid)
VALUES 
(868,'acacia tortilis','acacia tortilis','','acacia_tortilis',913),
(869,'eriobotrya japonica','eriobotrya japonica','','eriobotrya_japonica',914),
(870,'persea africana','persea africana','','persea_africana',915),
(871,'psidium guajava','psidium guajava','','psidium_guajava',916),
(872,'prunus africana','prunus africana','','prunus_africana',917),
(873,'rhus vulgaris','rhus vulgaris','','rhus_vulgaris',918),
(874,'erythrina abbyssinica','erythrina abbyssinica','','erythrina_abbyssinica',919),
(875,'spathodea campanulata','spathodea campanulata','','spathodea_campanulata',920),
(876,'bridelia micrantha','bridelia micrantha','','bridelia_micrantha',921),
(877,'croton macrostrachyus','croton macrostrachyus','','croton_macrostrachyus',922),
(878,'syzyngium cordatum','syzyngium cordatum','','syzyngium_cordatum',923),
(879,'carica papaya','carica papaya','','carica_papaya',924),
(880,'markhamia lutea','markhamia lutea','','markhamia_lutea',925),
(881,'olea europaea','olea europaea','','olea_europaea',926),
(882,'mangifera indica','mangifera indica','','mangifera_indica',927),
(883,'casimiroa edulis','casimiroa edulis','','casimiroa_edulis',928),
(884,'moringa oleifera','moringa oleifera','','moringa_oleifera',929),
(885,'jacaranda mimosifolia','jacaranda mimosifolia','','jacaranda_mimosifolia',930),
(886,'calliandra callothyrus','calliandra callothyrus','','calliandra_callothyrus',931),
(887,'punica granatum','punica granatum','','punica_granatum',932),
(888,'azadirachta indica','azadirachta indica','','azadirachta_indica',933),
(889,'podocarpous falcatus','podocarpous falcatus','','podocarpous_falcatus',934),
(891,'croton megalocarpus','croton megalocarpus','','croton_megalocarpus',936);

-- INSERT PROJECTS SPECIES (OK) TODO
INSERT INTO kobo_import.projectspecies (projectid, speciesid)
VALUES 
(99,174),
(99,191),
(99,227),
(99,868),
(99,869),
(99,870),
(99,871),
(99,872),
(99,873),
(99,874),
(99,875),
(99,876),
(99,877),
(99,878),
(99,879),
(99,880),
(99,881),
(99,882),
(99,883),
(99,884),
(99,885),
(99,886),
(99,887),
(99,888),
(99,889),
(99,891);

--VOIR ESPECES DU PROJET AVEC TRAD--
select projectid, speciesid, b.id, nom_vulgaire, species_code, translationid, c.id, languecode, translationlabel
from kobo_import.projectspecies as a
join kobo_import.species as b  ON a.speciesid = b.id
join kobo_import.translations as c ON b.translationid = c.id
WHERE projectid = 99;