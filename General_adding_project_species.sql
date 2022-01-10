-- INSERT INTO table_name (column1, column2, column3, ...)
-- VALUES (value1, value2, value3, ...);

-- UPDATE table_name
-- SET column1 = value1, column2 = value2, ...
-- WHERE condition;


-- INSERT PROJECT
INSERT INTO kobo_import.projects (id, projectname, localisationid)
VALUES (98, 'Accenture Indonesia', 27);

-- INSERT TRANSLATIONS
INSERT INTO kobo_import.translations (id, languecode, translationlabel)
VALUES 
(840, 'en', 'Candlenut'),
(76, 'in', 'Sirsak'),
(895, 'en', 'Agarwood'),
(895, 'in', 'Gaharu'),
(896, 'en', 'Areca nut'),
(896, 'in', 'Pinang'),
(897, 'en', 'Bread fruit'),
(897, 'in', 'Sukun'),
(902, 'en', 'Calliandra'),
(902, 'in', 'Kaliandra'),
(100, 'in', 'Jeruk keprok'),
(898, 'en', 'Durian kani'),
(898, 'in', 'Durian kani'),
(844, 'en', 'Durian montong'),
(899, 'en', 'Durian musang king'),
(899, 'in', 'Durian musang king'),
(900, 'en', 'White teak'),
(900, 'in', 'Jati putih'),
(141, 'in', 'Lamtoro'),
(161, 'in', 'Mindi'),
(901, 'en', 'Suren toon'),
(901, 'in', 'Suren'),
(912, 'en', 'Arabica Coffee'),
(912, 'in', 'Kopi Arabika'),
(904, 'en', 'Amboyna Pine'),
(904, 'in', 'Damar'),
(905, 'en', 'Cassia'),
(905, 'in', 'Kayu Manis Kasia'),
(34, 'en', 'Cinnamon'),
(34, 'in', 'Kayu Manis'),
(906, 'en', 'White Paperbark'),
(906, 'in', 'Kayu Putih'),
(907, 'en', 'Eucalyptus'),
(907, 'in', 'Eukaliptus'),
(908, 'en', 'Red Lip'),
(908, 'in', 'Pucuk Merah'),
(124, 'in', 'Nangka'),
(909, 'in', 'Meranti'),
(909, 'en', 'Meranti'),
(910, 'in', 'Kopi Liberika'),
(910, 'en', 'Liberica Coffee'),
(911, 'en', 'Albasia'),
(911, 'in', 'Sengon gunung');

-- UPDATE TRANSLATIONS
UPDATE kobo_import.translations
SET translationlabel =  'Bur flower'
WHERE id = 123 and languecode = 'en';

UPDATE kobo_import.translations
SET translationlabel =  'Chinaberry'
WHERE id = 161 and languecode = 'en';

UPDATE kobo_import.translations
SET translationlabel =  'Nara'
WHERE id = 221 and languecode = 'en';

UPDATE kobo_import.translations
SET translationlabel =  'Mahogany'
WHERE id = 149 and languecode = 'en';

UPDATE kobo_import.translations
SET translationlabel =  'Jati'
WHERE id = 128 and languecode = 'in';

-- INSERT SPECIES
INSERT INTO kobo_import.species (id, nom_vulgaire, nom_latin, famille, species_code, translationid)
VALUES 
(849,'aquilaria malaccensis', 'aquilaria malaccensis','', 'aquilaria_malaccensis', 895),
(850,'areca catechu', 'areca catechu','', 'areca_catechu', 896),
(851,'artocarpus altilis','artocarpus altilis','','artocarpus_altilis', 897),
(852, 'calliandra sp', 'calliandra sp','', 'calliandra_sp', 902 ),
(853,'durio zibenthinus spp3', 'durio zibenthinus spp3','', 'durio_zibenthinus_spp3', 898),
(854,'durio zibentinus king', 'durio zibentinus king','', 'durio_zibentinus_king', 899 ),
(855,'gmelina arborea', 'gmelina arborea','', 'gmelina_arborea', 900),
(856, 'syzygium aromaticum', 'syzygium aromaticum','', 'syzygium_aromaticum', 43),
(857, 'toona sureni', 'toona sureni','', 'toona_sureni', 901),
(859,'coffea arabica', 'coffea arabica','', 'coffea_arabica', 912),
(860,'agathis dammara', 'agathis dammara','', 'agathis_dammara', 904),
(861,'cinnamomum burmannii', 'cinnamomum burmannii','', 'cinnamomum_burmannii', 905),
(862,'melaleuca leucadendra', 'melaleuca leucadendra','', 'melaleuca_leucadendra', 906),
(863,'eucalyptus', 'eucalyptus','', 'eucalyptus', 907),
(864,'syzygium myrtifolium', 'syzygium myrtifolium','', 'syzygium_myrtifolium', 908),
(865,'shorea balangeran', 'shorea balangeran','', 'shorea_balangeran', 909),
(866,'coffea liberica', 'coffea liberica','', 'coffea_liberica', 910),
(867,'albizia chinesis', 'albizia chinesis','', 'albizia_chinesis', 911);

-- INSERT PROJECTS SPECIES
INSERT INTO kobo_import.projectspecies (projectid, speciesid)
VALUES 
(98,467), (98,813), (98,59), (98,66), (98,70), 
(98,849), (98,76), (98,850), (98,851), (98,852), 
(98,146), (98,170), (98,176), (98,246), (98,853), 
(98,817), (98,854), (98,301), (98,855), (98,372), 
(98,381), (98,424), (98,429), (98,812), (98,455), 
(98,468), (98,473), (98,550), (98,667), (98,856), 
(98,689), (98,857), (98,811),
(98,859),(98,860),(98,861),(98,168),(98,862),(98,863),(98,867),(98,81),(98,864),
(98,865),(98,866);

--VOIR ESPECES DU PROJET AVEC TRAD--
select projectid, speciesid, b.id, nom_vulgaire, species_code, translationid, c.id, languecode, translationlabel
from kobo_import.projectspecies as a
join kobo_import.species as b  ON a.speciesid = b.id
join kobo_import.translations as c ON b.translationid = c.id
WHERE projectid = 98;