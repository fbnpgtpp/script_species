/*
 * 
 * Pre Reg Indonesia Accenture
 * 
 */                   
    -- Survey Block   repeat species            
                   
with cte as(
	--ligne 1
	select 0 as speciesid, 0 as roworder, 
	'begin_group' as type_,
	'species_selection' as name_,
	'Species selection' as labelen,
	'Species selection' as labelin,
	'' as hinten,
	'' as hintin,
	'false' as required,
	'field-list' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	union all
	--ligne 2
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
	from public.species sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3
	union all
	--ligne 3
	select sp.id as speciesid, 3 as  roworder, 
	'integer' as type_,
	concat(code,'_nb_of_trees') as name_,
	concat(coalesce(tren.translationlabel, sp.latinname) , ' number of trees') as labelen,
	concat(coalesce(tr.translationlabel, sp.latinname) , ' jumlah pohon') as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	(SELECT replace(concat('.>= 0 and (%DOL{nb_of_trees_before_dispatching} - (',string_agg(concat('coalesce(${',
		concat(code,'_nb_of_trees'),
		'},0)'), ' + '),')) >= 0'),'%DOL','$')
		FROM   public.species sp
		inner join public.projectspecies ps on ps.speciesid = sp.id
		left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
		left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
		where ps.projectid = 3) as constrainte,
	'You''ve either enter a negative number or a number greater than the number of trees remaining. Please correct it.' as constraintmess,
	'Anda telah memasukkan angka negatif atau angka yang lebih besar dari jumlah pohon yang tersisa. Harap perbaiki.' as constraintmessother,
	'0' as default,
	'' as calculation
	from public.species sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3
	union all
	--ligne 4
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
	'0' as default,
	replace(concat('round(%DOL{',
	concat(code,'_nb_of_trees'),
	'} div %DOL{nb_of_trees_before_dispatching}*100,2)'),'%DOL','$') as calculation
	from public.species  sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3
	union all
	--ligne 5
	select sp.id as speciesid, 5 as  roworder, 
	'note' as type_,
	concat(code,'_share_note') as name_,
	replace(concat('<span style="color:#099665">', coalesce(tren.translationlabel, sp.latinname) , ' share :</span> %DOL{',code,'_share} %'),'%DOL','$') as labelen,
	replace(concat('<span style="color:#099665">', coalesce(tr.translationlabel, sp.latinname) , ' bagian :</span> %DOL{',code,'_share} %'),'%DOL','$') as labelin,
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
	from public.species  sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3
	union all
	--ligne 6
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
	'You''ve entered too many trees.' as constraintmess,
	'Anda telah memasukkan jumlah pohon yang terlalu banyak.' as constraintmessother,
	'0' as default,
	(SELECT replace(concat('%DOL{nb_of_trees_before_dispatching} - (',string_agg(concat('coalesce(${',
		concat(code,'_nb_of_trees'),
		'},0)'), ' + '),')'),'%DOL','$')
		FROM   public.species sp
		inner join public.projectspecies ps on ps.speciesid = sp.id
		left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
		left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
		where ps.projectid = 3) as calculation
	from public.species sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3
	union all
	--ligne 7
	select sp.id as speciesid, 7 as  roworder, 
	'note' as type_,
	concat('trees_available_after_',code,'_note') as name_,
	replace(concat(	'<span style="color:#E6361D">',coalesce(tren.translationlabel, sp.latinname),' Number of trees remaining :</span> %DOL{trees_available_after_', code, '} trees'), '%DOL','$') as labelen,
	replace(concat(	'<span style="color:#E6361D">',coalesce(tr.translationlabel, sp.latinname),' jumlah pohon yang tersisa :</span> %DOL{trees_available_after_', code, '} pohon'), '%DOL','$') as labelin,
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
	from public.species sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3
	union all
	--ligne 8
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
	from public.species sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3
	union all
	--ligne 9
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
	'Anda telah mendistribusikan lebih sedikit pohon daripada yang Anda rencanakan. Tolong, bagikan setiap pohon atau ubah "jumlah pohon yang akan ditanam" di bagian sebelumnya.' as constraintmessother,
	'' as default,
	(SELECT replace(concat('%DOL{nb_of_trees_before_dispatching} - (',string_agg(concat('coalesce(${',
		concat(code,'_nb_of_trees'),
		'},0)'), ' + '),')'),'%DOL','$')
		FROM   public.species sp
		inner join public.projectspecies ps on ps.speciesid = sp.id
		left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
		left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
		where ps.projectid = 3) as calculation
	union all
	--ligne 10
	select 99999997 as speciesid, 0 as  roworder, 
	'note' as type_,
	'remaining_trees_note' as name_,
	replace('**Number of remaining trees :** %DOL{remaining_trees} trees','%DOL','$') as labelen,
	replace('**Jumlah pohon yang tersisa :** %DOL{remaining_trees} pohon','%DOL','$') as labelin,
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
	--ligne 11
	select 99999998 as speciesid, 0 as  roworder, 
	'note' as type_,
	'warning_remaining_trees' as name_,
	replace('<span style="color:red">Warning  : You''ve distributed fewer trees than you had planned! **There are still %DOL{remaining_trees} trees left.** Please, distribute every trees or modify the "number of trees to plant" in previous section.</span>','%DOL','$') as labelen,
	replace('<span style="color:red">Peringatan : Anda telah mendistribusikan lebih sedikit pohon daripada yang Anda rencanakan! **Masih ada %DOL{remaining_trees} pohon yang tersisa.** Harap bagikan setiap pohon atau ubah "jumlah pohon yang akan ditanam" di bagian sebelumnya.</span>','%DOL','$') as labelin,
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
	--ligne 12
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
	-- ligne 13
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
	-- ligne 14
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
	-- ligne 15 HERE
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
		FROM   public.species sp
		inner join public.projectspecies ps on ps.speciesid = sp.id
		left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
		left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
		where ps.projectid = 3) as calculation
	union all
	-- ligne 16
	select 999999993 as speciesid, 0 as  roworder, 
	'note' as type_,
	'parcel_total_nb_of_trees_note' as name_,
	replace('**Total number of trees :** : %DOL{parcel_total_nb_of_trees}','%DOL','$') as labelen,
	replace('**Jumlah total pohon :** : %DOL{parcel_total_nb_of_trees}','%DOL','$') as labelin,
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
	-- ligne 17
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
	from public.species sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3
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
		concat(code,'_nb_of_trees_out'),
		'},0)'), ' + ')),'%DOL','$')
		FROM   public.species sp
		inner join public.projectspecies ps on ps.speciesid = sp.id
		left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
		left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
		where ps.projectid = 3) as calculation)
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
	from public.species sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3
order by coalesce(tr.translationlabel, sp.latinname) ;
	
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
	from public.species sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3
	union all
	--ligne 3
	select sp.id as speciesid, 3 as  roworder, 
	'note' as type_,
	concat(code,'_nb_of_trees_info') as name_,
	concat(coalesce(tren.translationlabel, sp.latinname) , ' Total number of trees : <span style="color:red">${',code,'_total_nb} trees</span>') as labelen,
	concat(coalesce(tr.translationlabel, sp.latinname) , ' Jumlah total pohon : <span style="color:red">${',code,'_total_nb} pohon</span>') as labelin,
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
	from public.species sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3)
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

