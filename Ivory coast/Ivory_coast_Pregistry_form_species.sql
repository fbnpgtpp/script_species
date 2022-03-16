/*
 * 
 * Preregistry (IMPORTANT : DON'T FORGET TO CHANGE LANGUAGE CODE)
 * 
 */                   
    
	-- Survey Block [SPECIES SELECTION]           
                   
with cte as(
	--ligne 1 (OK)
	select 0 as speciesid, 0 as roworder, 
	'begin_group' as type_,
	'species_selection' as name_,
	'Species selection' as labelen,
	'Sélection des espèces' as labelin,
	'' as hinten,
	'' as hintin,
	'false' as required,
	'field-list' as apearence,
	'' as choicefilter,
	replace('%DOL{species}!=''''','%DOL','$') as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	union all
	--ligne 2 (OK)
	select sp.id as speciesid, 2 as  roworder, 
	'begin_group' as type_,
	code as name_,
	coalesce(tren.translationlabel, sp.latinname) as labelen,
	coalesce(tr.translationlabel, sp.latinname) as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	replace(concat('selected(%DOL{species}, ''', code,''')'),'%DOL','$') as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	from schemav5.species sp
inner join schemav5.projectspecies ps on ps.speciesid = sp.id
left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 73
	union all
	--ligne 3 (OK)
	select sp.id as speciesid, 3 as  roworder, 
	'integer' as type_,
	concat(code,'_nb_of_trees') as name_,
	concat('**',coalesce(tren.translationlabel, sp.latinname) , ' number of trees :**') as labelen,
	concat(coalesce(tr.translationlabel, sp.latinname) , ' Nombre d''arbres') as labelin, --CHANGE OR DELETE TRANSLATION
	'' as hinten,
	'' as hintin,
	'TRUE' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	(SELECT replace(concat('.>= 0 and (%DOL{nb_of_trees_before_dispatching} - (',string_agg(concat('coalesce(${',
		concat(code,'_nb_of_trees'),
		'},0)'), ' + '),')) >= 0'),'%DOL','$')
		FROM   schemav5.species sp
		inner join schemav5.projectspecies ps on ps.speciesid = sp.id
		left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
		left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
		where ps.projectid = 73) as constrainte,
	'You''ve either enter a negative number or a number greater than the number of trees remaining. Please correct it.' as constraintmess,
	'Vous avez soit entré un nombre négatif ou bien plus grand que le nombre d''arbres restants. Veuillez corriger le nombre.' as constraintmessother, --CHANGE OR DELETE TRANSLATION
	'0' as default,
	'' as calculation
	from schemav5.species sp
inner join schemav5.projectspecies ps on ps.speciesid = sp.id
left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 73
	union all
	--ligne 4 (OK)
	select sp.id as speciesid, 4 as  roworder, 
	'calculate' as type_,
	concat(code,'_share') as name_,
	'' as labelen,
	'' as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	replace(concat('round(%DOL{',
	concat(code,'_nb_of_trees'),
	'} div %DOL{nb_of_trees_before_dispatching}*100,2)'),'%DOL','$') as calculation
	from schemav5.species  sp
inner join schemav5.projectspecies ps on ps.speciesid = sp.id
left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 73
	union all
	--ligne 5 (OK)
	select sp.id as speciesid, 5 as  roworder, 
	'note' as type_,
	concat(code,'_share_note') as name_,
	replace(concat('<span style="color:#099665">', coalesce(tren.translationlabel, sp.latinname) , ' share :</span> %DOL{',code,'_share} %'),'%DOL','$') as labelen,
	replace(concat('<span style="color:#099665">part de ', coalesce(tr.translationlabel, sp.latinname) , ' :  </span> %DOL{',code,'_share} %'),'%DOL','$') as labelin, --CHANGE OR DELETE TRANSLATION
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	from schemav5.species sp
inner join schemav5.projectspecies ps on ps.speciesid = sp.id
left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 73
	union all
	--ligne 6 (OK)
	select sp.id as speciesid, 6 as  roworder, 
	'calculate' as type_,
	concat('trees_available_after_',code) as name_,
	'' as labelen,
	'' as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	(SELECT replace(concat('%DOL{nb_of_trees_before_dispatching} - (',string_agg(concat('coalesce(${',
		concat(code,'_nb_of_trees'),
		'},0)'), ' + '),')'),'%DOL','$')
		FROM   schemav5.species sp
		inner join schemav5.projectspecies ps on ps.speciesid = sp.id
		left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
		left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
		where ps.projectid = 73) as calculation
	from schemav5.species sp
inner join schemav5.projectspecies ps on ps.speciesid = sp.id
left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 73
	union all
	--ligne 7 (OK)
	select sp.id as speciesid, 7 as  roworder, 
	'note' as type_,
	concat('trees_available_after_',code,'_note') as name_,
	replace(concat(	'<span style="color:#E6361D">Number of trees remaining :</span> %DOL{trees_available_after_', code, '} trees'), '%DOL','$') as labelen,
	replace(concat(	'<span style="color:#E6361D">Nombre d''arbres restants :</span> %DOL{trees_available_after_', code, '} arbres'), '%DOL','$') as labelin, --CHANGE OR DELETE TRANSLATION
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	from schemav5.species sp
inner join schemav5.projectspecies ps on ps.speciesid = sp.id
left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 73
	union all
	--ligne 8 (OK)
	select sp.id as speciesid, 8 as  roworder, 
	'end_group' as type_,
	'' as name_,
	'' as labelen,
	'' as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	from schemav5.species sp
inner join schemav5.projectspecies ps on ps.speciesid = sp.id
left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 73
	union all
	--ligne 9 (OK)
	select 99999996 as speciesid, 0 as  roworder, 
	'calculate' as type_,
	'remaining_trees' as name_,
	'' as labelen,
	'' as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'.=0' as constrainte,
	'You''ve distributed fewer trees than you had planned. Please, distribute every trees or modify the "number of trees to plant" in previous section.' as constraintmess,
	'Vous avez distribué moins d''arbres que prévu. Veuillez répartir tous les arbres ou modifier le "nombre d''arbres à planter" dans la section précédente.' as constraintmessother, --CHANGE OR DELETE TRANSLATION
	'' as default,
	(SELECT replace(concat('%DOL{nb_of_trees_before_dispatching} - (',string_agg(concat('coalesce(${',
		concat(code,'_nb_of_trees'),
		'},0)'), ' + '),')'),'%DOL','$')
		FROM   schemav5.species sp
		inner join schemav5.projectspecies ps on ps.speciesid = sp.id
		left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
		left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
		where ps.projectid = 73) as calculation
	union all
	--ligne 10 (OK)
	select 99999997 as speciesid, 0 as  roworder, 
	'note' as type_,
	'remaining_trees_note' as name_,
	replace('**Number of remaining trees :** %DOL{remaining_trees} trees','%DOL','$') as labelen,
	replace('**Nombre d''arbres restants :** %DOL{remaining_trees} arbres','%DOL','$') as labelin, --CHANGE OR DELETE TRANSLATION
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	union all
	--ligne 11 (OK)
	select 99999998 as speciesid, 0 as  roworder, 
	'note' as type_,
	'warning_remaining_trees' as name_,
	replace('<span style="color:red">Warning  : You''ve distributed fewer trees than you had planned! **There are still %DOL{remaining_trees} trees left.** Please, distribute every trees or modify the "number of trees to plant" in previous section.</span>','%DOL','$') as labelen,
	replace('<span style="color:red">Attention : Vous avez distribué moins d''arbres que prévu! **Il reste encore %DOL{remaining_trees} arbres. ** SVP, veuiller distribuer tous les arbres ou bien modifier le "nombre d''arbres à planter" dans la section précédente.</span>','%DOL','$') as labelin, --CHANGE OR DELETE TRANSLATION
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	replace('%DOL{remaining_trees}>0','%DOL','$') as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	union all
	--ligne 12 (OK)
	select 99999999 as speciesid, 0 as  roworder, 
	'end_group' as type_,
	'' as name_,
	'' as labelen,
	'' as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	union all
	-- ligne 13 (OK)
	select 999999990 as speciesid, 0 as  roworder, 
	'end_group' as type_,
	'' as name_,
	'' as labelen,
	'' as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	union all
	-- ligne 14 (OK)
	select 999999991 as speciesid, 0 as  roworder, 
	'begin_group' as type_,
	'parcel_recapitulation' as name_,
	'Parcel recapitulation' as labelen,
	'Recapitulation des informations de la parcelle' as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'field-list' as apearence,
	'' as choicefilter,
	replace('%DOL{species} != ''''','%DOL','$') as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	union all
	-- ligne 15 (OK)
	select 999999992 as speciesid, 0 as  roworder, 
	'calculate' as type_,
	'parcel_total_nb_of_trees' as name_,
	'' as labelen,
	'' as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	(SELECT replace(concat(string_agg(concat('coalesce(${',
		concat(code,'_nb_of_trees'),
		'},0)'), ' + ')),'%DOL','$')
		FROM   schemav5.species sp
		inner join schemav5.projectspecies ps on ps.speciesid = sp.id
		left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
		left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
		where ps.projectid = 73) as calculation
	union all
	-- ligne 16 (OK)
	select 999999993 as speciesid, 0 as  roworder, 
	'note' as type_,
	'parcel_total_nb_of_trees_note' as name_,
	replace('**Total number of trees :** : %DOL{parcel_total_nb_of_trees}','%DOL','$') as labelen,
	replace('**Nombre total d''arbres :** : %DOL{parcel_total_nb_of_trees}','%DOL','$') as labelin, --CHANGE OR DELETE TRANSLATION
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	union all
	-- ligne 17 (OK)
	select 999999994 as speciesid, 0 as  roworder, 
	'end_group' as type_,
	'' as name_,
	'' as labelen,
	'' as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation)
select type_,
	name_,
	labelen,
	labelin,
	hinten,
	hintin,
	required,
	apearence,
	choicefilter,
	relevant,
	constrainte,
	constraintmess,
	constraintmessother,
	"default",
	calculation from cte 
order by speciesid asc,roworder asc;

--Block survey species OUT parcel
with cte as(
	--line 1 (OK)
	select sp.id as speciesid, 2 as  roworder, 
	'calculate' as type_,
	concat(code,'_nb_of_trees_out') as name_,
	'' as labelen,
	'' as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	replace(concat('if(selected(%DOL{parcel_relevant_for_planting_yn},''yes'') and selected(%DOL{species}, ''',code,''') and %DOL{',code,'_nb_of_trees} != '''', %DOL{',code,'_nb_of_trees}, 0)'),'%DOL','$') as calculation
	from schemav5.species sp
inner join schemav5.projectspecies ps on ps.speciesid = sp.id
left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 73
	union all
	--line 2 (OK)
	select 9999990 as speciesid, 2 as  roworder, 
	'calculate' as type_,
	'nb_of_trees_before_dispatching_out' as name_,
	'' as labelen,
	'' as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	replace('if(selected(%DOL{parcel_relevant_for_planting_yn},''yes'') and %DOL{nb_of_trees_before_dispatching}!='''', %DOL{nb_of_trees_before_dispatching},0)','%DOL','$') as calculation
	union all
	--line 3 (OK)
	select 9999991 as speciesid, 2 as  roworder, 
	'calculate' as type_,
	'parcel_total_nb_of_trees_out' as name_,
	'' as labelen,
	'' as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	(SELECT replace(concat(string_agg(concat('coalesce(${',
		concat(code,'_nb_of_trees_out'),
		'},0)'), ' + ')),'%DOL','$')
		FROM   schemav5.species sp
		inner join schemav5.projectspecies ps on ps.speciesid = sp.id
		left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
		left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
		where ps.projectid = 73) as calculation)
select type_,
	name_,
	labelen,
	labelin,
	hinten,
	hintin,
	required,
	apearence,
	choicefilter,
	relevant,
	constrainte,
	constraintmess,
	constraintmessother,
	"default",
	calculation from cte 
order by speciesid asc,roworder asc;


	-- choices block
                   
select 'species', code as name_,
	coalesce(tren.translationlabel, sp.latinname) as labelen,
	coalesce(tr.translationlabel, sp.latinname) as labelin
	from schemav5.species sp
inner join schemav5.projectspecies ps on ps.speciesid = sp.id
left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 73
order by coalesce(tr.translationlabel, sp.latinname) ;
	
	-- Recap block	

with cte as(
	--ligne 1
	select 0 as speciesid, 1 as  roworder, 
	'note' as type_,
	'species_recap' as name_,
	'**Total number of trees per species :**' as labelen,
	'**Nombre total d''arbres par espèce :**' as labelin, --CHANGE OR DELETE TRANSLATION
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	union all
	--ligne 2
	select sp.id as speciesid, 0 as  roworder, 
	'calculate' as type_,
	concat(code,'_total_nb') as name_,
	'' as labelen,
	'' as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	replace(concat('sum(%DOL{',
	concat(code,'_nb_of_trees_out'),
	'})'),'%DOL','$') as calculation
	from schemav5.species sp
inner join schemav5.projectspecies ps on ps.speciesid = sp.id
left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 73
	union all
	--ligne 3 (OK)
	select sp.id as speciesid, 3 as  roworder, 
	'note' as type_,
	concat(code,'_total_nb_note') as name_,
	concat(coalesce(tren.translationlabel, sp.latinname) , ' Total number of trees : <span style="color:red">${',code,'_total_nb} trees</span>') as labelen,
	concat(coalesce(tr.translationlabel, sp.latinname) , ' Nombre total d''arbres : <span style="color:red">${',code,'_total_nb} arbres</span>') as labelin, --CHANGE OR DELETE TRANSLATION
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	replace(concat('%DOL{',code,'_total_nb} > 0'),'%DOL','$') as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	from schemav5.species sp
inner join schemav5.projectspecies ps on ps.speciesid = sp.id
left join schemav5.translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join schemav5.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 73)
select type_,
	name_,
	labelEN,
	labelin,
	hinten,
	hintin,
	required,
	apearence,
	choicefilter,
	relevant,
	constrainte,
	constraintmess,
	constraintmessother,
	"default",
	calculation from cte 
order by speciesid asc,roworder asc;

