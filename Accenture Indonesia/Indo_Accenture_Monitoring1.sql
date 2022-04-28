/*
 * 
 * Preregistry (IMPORTANT : DON'T FORGET TO CHANGE LANGUAGE CODE)
 * 
 */                   
    
--Survey species delivered
with cte as(
	--line 1 (OK)
	select sp.id as speciesid, 2 as  roworder, 
	'calculate' as type_,
	concat(code,'_nb_delivered_trees') as name_,
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
	replace(concat('coalesce(pulldata(''pulldata_farmer_monitoring1'', ''',code,'_nb_trees_delivered'', ''farmer_code'', %DOL{farmer_code_select}), 0)'),'%DOL','$') as calculation
	from species sp
inner join projectspecies ps on ps.speciesid = sp.id
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 99)
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

	-- Survey Block [SPECIES SELECTION]           
                   
with cte as(
	--ligne 2 (OK)
	select sp.id as speciesid, 2 as  roworder, 
	'begin_group' as type_,
	code as name_,
	replace(concat(coalesce(tren.translationlabel, sp.latinname), ' (Delivered at the farmer for all parcels : %DOL{',code,'_nb_delivered_trees} trees)'),'%DOL','$') as labelen,
	replace(concat(coalesce(tr.translationlabel, sp.latinname), ' (Delivered at the farmer for all parcels : %DOL{',code,'_nb_delivered_trees} trees)'),'%DOL','$') as labelin,
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
	from species sp
inner join projectspecies ps on ps.speciesid = sp.id
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 99
	union all
	--ligne 3 (OK)
	select sp.id as speciesid, 3 as  roworder, 
	'integer' as type_,
	concat(code,'_nb_living_trees_monitoring1') as name_,
	concat(coalesce(tren.translationlabel, sp.latinname) , ' - <span style="color:red">Living</span> trees at monitoring 1 :') as labelen,
	concat(coalesce(tr.translationlabel, sp.latinname) , ' - Phon <span style="color:red">hidup</span> di pemantauan 1 :') as labelin, --CHANGE OR DELETE TRANSLATION
	'' as hinten,
	'' as hintin,
	'TRUE' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'.>=0'as constrainte,
	'It cannot be a negative number.' as constraintmess,
	'Itu tidak boleh berupa angka negatif.' as constraintmessother, --CHANGE OR DELETE TRANSLATION
	'0' as default,
	'' as calculation
	from species sp
inner join projectspecies ps on ps.speciesid = sp.id
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 99
	union all
	--ligne 4 (OK)
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
	from species sp
inner join projectspecies ps on ps.speciesid = sp.id
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 99)
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

--Block survey total_living_trees_monitoring1 parcel
with cte as(
	select 9999991 as speciesid, 2 as  roworder, 
	'calculate' as type_,
	'total_living_trees_monitoring1' as name_,
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
		concat(code,'_nb_living_trees_monitoring1'),
		'},0)'), ' + ')),'%DOL','$')
		FROM   species sp
		inner join projectspecies ps on ps.speciesid = sp.id
		left join translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
		left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
		where ps.projectid = 99) as calculation)
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
	concat(code,'_nb_living_trees_monitoring1_out') as name_,
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
	replace(concat('if(selected(%DOL{species}, ''',code,''') and %DOL{',code,'_nb_living_trees_monitoring1} != '''', %DOL{',code,'_nb_living_trees_monitoring1}, 0)'),'%DOL','$') as calculation
	from species sp
inner join projectspecies ps on ps.speciesid = sp.id
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 99
	union all
	--line 2 (OK)
	select 9999991 as speciesid, 2 as  roworder, 
	'calculate' as type_,
	'total_living_trees_monitoring1_out' as name_,
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
		concat(code,'_nb_living_trees_monitoring1_out'),
		'},0)'), ' + ')),'%DOL','$')
		FROM   species sp
		inner join projectspecies ps on ps.speciesid = sp.id
		left join translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
		left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
		where ps.projectid = 99) as calculation)
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
	from species sp
inner join projectspecies ps on ps.speciesid = sp.id
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 99
order by coalesce(tr.translationlabel, sp.latinname) ;
	
	-- Recap block	

with cte as(
	--ligne 1
	select sp.id as speciesid, 1 as  roworder, 
	'note' as type_,
	concat('recap_',code,'_total_nb_delivered_note') as name_,
	replace(concat(coalesce(tren.translationlabel, sp.latinname),' - Total number of delivered trees : %DOL{',code,'_nb_delivered_trees} trees'),'%DOL','$') as labelen,
	replace(concat(coalesce(tr.translationlabel, sp.latinname),' - Jumlah total pohon yang dikirim : %DOL{',code,'_nb_delivered_trees} pohon'),'%DOL','$') as labelin, --CHANGE OR DELETE TRANSLATION
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	replace(concat('%DOL{',code,'_nb_delivered_trees}> 0'),'%DOL','$') as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	from species sp
inner join projectspecies ps on ps.speciesid = sp.id
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 99
	union all
	--ligne 2
	select sp.id as speciesid, 2 as  roworder, 
	'calculate' as type_,
	concat('recap_',code,'_total_nb_living') as name_,
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
	concat(code,'_nb_living_trees_monitoring1_out'),
	'})'),'%DOL','$') as calculation
	from species sp
inner join projectspecies ps on ps.speciesid = sp.id
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 99
	union all
	--ligne 3 (OK)
	select sp.id as speciesid, 3 as  roworder, 
	'note' as type_,
	concat('recap_',code,'_total_nb_living_note') as name_,
	replace(concat(coalesce(tren.translationlabel, sp.latinname),' - Total number of living trees : %DOL{recap_',code,'_total_nb_living_note} trees'),'%DOL','$') as labelen,
	replace(concat(coalesce(tr.translationlabel, sp.latinname),' - Jumlah total pohon hidup : %DOL{recap_',code,'_total_nb_living_note} pohon'),'%DOL','$')as labelin, --CHANGE OR DELETE TRANSLATION
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	replace(concat('sum(%DOL{',code,'_nb_living_trees_monitoring1_out}) > 0'),'%DOL','$') as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	from species sp
inner join projectspecies ps on ps.speciesid = sp.id
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 99
	union all
	--ligne 4 (OK)
	select sp.id as speciesid, 4 as  roworder, 
	'calculate' as type_,
	concat('recap_loss_rate_delivered_monitoring1_',code) as name_,
	'' as labelen,
	'' as labelin, --CHANGE OR DELETE TRANSLATION
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
	replace(concat('round(1-(%DOL{recap_',code,'_total_nb_living} div %DOL{',code,'_nb_delivered_trees})*100, 2)'),'%DOL','$') as calculation
	from species sp
inner join projectspecies ps on ps.speciesid = sp.id
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 99
	union all
	--ligne 5 (OK)
	select sp.id as speciesid, 5 as  roworder, 
	'note' as type_,
	concat('recap_loss_rate_delivered_monitoring1_',code,'_note') as name_,
	replace(concat(coalesce(tren.translationlabel, sp.latinname),' - Total number of living trees : %DOL{recap_',code,'_total_nb_living_note} trees'),'%DOL','$') as labelen,
	replace(concat(coalesce(tr.translationlabel, sp.latinname),' - Jumlah total pohon hidup : %DOL{recap_',code,'_total_nb_living_note} pohon'),'%DOL','$') as labelin, --CHANGE OR DELETE TRANSLATION
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	replace(concat('%DOL{farmer_code_select} != ''other'' and %DOL{recap_',code,'_total_nb_living} >0 and %DOL{',code,'_nb_delivered_trees} > 0'),'%DOL','$') as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	from species sp
inner join projectspecies ps on ps.speciesid = sp.id
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 99
	union all
	--ligne 6 (OK)
	select sp.id as speciesid, 6 as  roworder, 
	'text' as type_,
	concat('recap_',code,'_comments') as name_,
	concat('Comments about ',coalesce(tren.translationlabel, sp.latinname)) as labelen,
	concat('komentar tentang ',coalesce(tr.translationlabel, sp.latinname)) as labelin, --CHANGE OR DELETE TRANSLATION
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	replace(concat('sum(%DOL{',code,'_nb_living_trees_monitoring1_out}) > 0'),'%DOL','$') as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	from species sp
inner join projectspecies ps on ps.speciesid = sp.id
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 99)
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
order by speciesid asc, roworder asc;