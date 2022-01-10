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
	'' as labelin,
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
	species_code as name_,
	coalesce(tren.translationlabel, sp.nom_latin) as labelen,
	coalesce(tr.translationlabel, sp.nom_latin) as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	replace(concat('selected(%DOL{species}, ''', species_code,''')'),'%DOL','$') as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	from kobo_import.species sp
inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
where ps.projectid = 98
	union all
	--ligne 3 (OK)
	select sp.id as speciesid, 3 as  roworder, 
	'integer' as type_,
	concat(species_code,'_nb_of_trees') as name_,
	concat('**',coalesce(tren.translationlabel, sp.nom_latin) , ' number of trees :**') as labelen,
	concat(coalesce(tr.translationlabel, sp.nom_latin) , ' jumlah pohon') as labelin, --CHANGE OR DELETE TRANSLATION
	'' as hinten,
	'' as hintin,
	'TRUE' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	(SELECT replace(concat('.>= 0 and (%DOL{nb_of_trees_before_dispatching} - (',string_agg(concat('coalesce(${',
		concat(species_code,'_nb_of_trees'),
		'},0)'), ' + '),')) >= 0'),'%DOL','$')
		FROM   kobo_import.species sp
		inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
		left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
		left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
		where ps.projectid = 98) as constrainte,
	'You''ve either enter a negative number or a number greater than the number of trees remaining. Please correct it.' as constraintmess,
	'Anda telah memasukkan angka negatif atau angka yang lebih besar dari jumlah pohon yang tersisa. Harap perbaiki.' as constraintmessother, --CHANGE OR DELETE TRANSLATION
	'0' as default,
	'' as calculation
	from kobo_import.species sp
inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
where ps.projectid = 98
	union all
	--ligne 4 (OK)
	select sp.id as speciesid, 4 as  roworder, 
	'calculate' as type_,
	concat(species_code,'_share') as name_,
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
	concat(species_code,'_nb_of_trees'),
	'} div %DOL{nb_of_trees_before_dispatching}*100,2)'),'%DOL','$') as calculation
	from kobo_import.species  sp
inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
where ps.projectid = 98
	union all
	--ligne 5 (OK)
	select sp.id as speciesid, 5 as  roworder, 
	'note' as type_,
	concat(species_code,'_share_note') as name_,
	replace(concat('<span style="color:#099665">', coalesce(tren.translationlabel, sp.nom_latin) , ' share :</span> %DOL{',species_code,'_share} %'),'%DOL','$') as labelen,
	replace(concat('<span style="color:#099665">', coalesce(tr.translationlabel, sp.nom_latin) , ' bagian :</span> %DOL{',species_code,'_share} %'),'%DOL','$') as labelin, --CHANGE OR DELETE TRANSLATION
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
	from kobo_import.species  sp
inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
where ps.projectid = 98
	union all
	--ligne 6 (OK)
	select sp.id as speciesid, 6 as  roworder, 
	'calculate' as type_,
	concat('trees_available_after_',species_code) as name_,
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
		concat(species_code,'_nb_of_trees'),
		'},0)'), ' + '),')'),'%DOL','$')
		FROM   kobo_import.species sp
		inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
		left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
		left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
		where ps.projectid = 98) as calculation
	from kobo_import.species sp
inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
where ps.projectid = 98
	union all
	--ligne 7 (OK)
	select sp.id as speciesid, 7 as  roworder, 
	'note' as type_,
	concat('trees_available_after_',species_code,'_note') as name_,
	replace(concat(	'<span style="color:#E6361D">Number of trees remaining :</span> %DOL{trees_available_after_', species_code, '} trees'), '%DOL','$') as labelen,
	replace(concat(	'<span style="color:#E6361D">jumlah pohon yang tersisa :</span> %DOL{trees_available_after_', species_code, '} pohon'), '%DOL','$') as labelin, --CHANGE OR DELETE TRANSLATION
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
	from kobo_import.species sp
inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
where ps.projectid = 98
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
	from kobo_import.species sp
inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
where ps.projectid = 98
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
	'Anda telah mendistribusikan lebih sedikit pohon daripada yang Anda rencanakan. Tolong, bagikan setiap pohon atau ubah "jumlah pohon yang akan ditanam" di bagian sebelumnya.' as constraintmessother, --CHANGE OR DELETE TRANSLATION
	'' as default,
	(SELECT replace(concat('%DOL{nb_of_trees_before_dispatching} - (',string_agg(concat('coalesce(${',
		concat(species_code,'_nb_of_trees'),
		'},0)'), ' + '),')'),'%DOL','$')
		FROM   kobo_import.species sp
		inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
		left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
		left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
		where ps.projectid = 98) as calculation
	union all
	--ligne 10 (OK)
	select 99999997 as speciesid, 0 as  roworder, 
	'note' as type_,
	'remaining_trees_note' as name_,
	replace('**Number of remaining trees :** %DOL{remaining_trees} trees','%DOL','$') as labelen,
	replace('**Jumlah pohon yang tersisa :** %DOL{remaining_trees} pohon','%DOL','$') as labelin, --CHANGE OR DELETE TRANSLATION
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
	replace('<span style="color:red">Peringatan : Anda telah mendistribusikan lebih sedikit pohon daripada yang Anda rencanakan! **Masih ada %DOL{remaining_trees} pohon yang tersisa.** Harap bagikan setiap pohon atau ubah "jumlah pohon yang akan ditanam" di bagian sebelumnya.</span>','%DOL','$') as labelin, --CHANGE OR DELETE TRANSLATION
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
	'' as labelin,
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
		concat(species_code,'_nb_of_trees'),
		'},0)'), ' + ')),'%DOL','$')
		FROM   kobo_import.species sp
		inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
		left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
		left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
		where ps.projectid = 98) as calculation
	union all
	-- ligne 16 (OK)
	select 999999993 as speciesid, 0 as  roworder, 
	'note' as type_,
	'parcel_total_nb_of_trees_note' as name_,
	replace('**Total number of trees :** : %DOL{parcel_total_nb_of_trees}','%DOL','$') as labelen,
	replace('**Jumlah total pohon :** : %DOL{parcel_total_nb_of_trees}','%DOL','$') as labelin, --CHANGE OR DELETE TRANSLATION
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
	select sp.id as speciesid, 2 as  roworder, 
	'calculate' as type_,
	concat(species_code,'_nb_of_trees_out') as name_,
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
	replace(concat('if(selected(%DOL{parcel_relevant_for_planting_yn},''yes'') and selected(%DOL{species}, ''',species_code,''') and %DOL{',species_code,'_nb_of_trees} != '''', %DOL{',species_code,'_nb_of_trees}, 0)'),'%DOL','$') as calculation
	from kobo_import.species sp
inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
where ps.projectid = 98
	union all
	--line 2
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
	--line 3
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
		concat(species_code,'_nb_of_trees_out'),
		'},0)'), ' + ')),'%DOL','$')
		FROM   kobo_import.species sp
		inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
		left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
		left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
		where ps.projectid = 98) as calculation)
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
                   
select 'species', species_code as name_,
	coalesce(tren.translationlabel, sp.nom_latin) as labelen,
	coalesce(tr.translationlabel, sp.nom_latin) as labelin
	from kobo_import.species sp
inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
where ps.projectid = 98
order by coalesce(tr.translationlabel, sp.nom_latin) ;
	
	-- Recap block	

with cte as(
	--ligne 1
	select 0 as speciesid, 1 as  roworder, 
	'note' as type_,
	'species_recap' as name_,
	'**Total number of trees per species :**' as labelen,
	'**Jumlah total pohon per spesies :**' as labelin,
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
	concat(species_code,'_total_nb') as name_,
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
	concat(species_code,'_nb_of_trees_out'),
	'})'),'%DOL','$') as calculation
	from kobo_import.species sp
inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
where ps.projectid = 98
	union all
	--ligne 3
	select sp.id as speciesid, 3 as  roworder, 
	'note' as type_,
	concat(species_code,'_nb_of_trees_info') as name_,
	concat(coalesce(tren.translationlabel, sp.nom_latin) , ' Total number of trees : <span style="color:red">${',species_code,'_total_nb} trees</span>') as labelen,
	concat(coalesce(tr.translationlabel, sp.nom_latin) , ' Jumlah total pohon : <span style="color:red">${',species_code,'_total_nb} pohon</span>') as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	replace(concat('%DOL{',species_code,'_total_nb} > 0'),'%DOL','$') as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	from kobo_import.species sp
inner join kobo_import.projectspecies ps on ps.speciesid = sp.id
left join kobo_import.translations tr on tr.id = sp.translationid and tr.languecode = 'in'
left join kobo_import.translations tren on tren.id = sp.translationid and tren.languecode = 'en'
where ps.projectid = 98)
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

