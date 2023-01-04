/*
 * 
 * Delivery Indonesia Accenture
 * 
 */                   
    -- Survey Block repeat species            

-- Species from preregistry
with cte as(
	--ligne 1
    select sp.id as speciesid, 1 as  roworder, 
	'calculate' as type_,
	concat(code,'_nb_trees_preregistred_pull') as name_,
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
	replace(concat('pulldata(''pulldata_farmer_delivery'',''',
	concat(code,'_nb_trees_preregistred'''),
	',''farmer_code'', %DOL{farmer_code_select})'),'%DOL','$') as calculation
	from public.species  sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3
	union all
    --ligne2
    select sp.id as speciesid, 2 as  roworder, 
	'calculate' as type_,
	concat(code,'_name') as name_,
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
	replace(concat('if(%DOL{',concat(code,'_nb_trees_preregistred_pull'),'}>0,''',
    concat(code,'_name'),''',''no_species'')'),'%DOL','$') as calculation
	from public.species  sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3
	union all
    --ligne 3
	select sp.id as speciesid, 3 as  roworder, 
	'begin_group' as type_,
	code as name_,
	coalesce(tren.translationlabel, sp.latinname) as labelen,
	coalesce(tr.translationlabel, sp.latinname) as labelin,
	'' as hinten,
	'' as hintin,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	replace(concat('%DOL{',concat(code,'_nb_trees_preregistred_pull}'),'>0'),'%DOL','$') as relevant,
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
	--ligne 4
    select sp.id as speciesid, 4 as  roworder, 
	'note' as type_,
	concat(code,'_nb_trees_preregistred_pull_note') as name_,
	replace(concat('Trees preregistred (',coalesce(tren.translationlabel, sp.latinname),
    ') : %DOL{',concat(code,'_nb_trees_preregistred_pull}')),'%DOL','$') as labelen,
	replace(concat('Pohon pra-terdaftar (',coalesce(tr.translationlabel, sp.latinname),
    ') : %DOL{',concat(code,'_nb_trees_preregistred_pull}')),'%DOL','$') as labelin,
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
    -- ligne 5
    select sp.id as speciesid, 5 as  roworder, 
	'integer' as type_,
	concat(code,'_nb_trees_delivered_prereg') as name_,
	concat(coalesce(tren.translationlabel, sp.latinname),' - Number of delivered trees') as labelen,
	concat(coalesce(tr.translationlabel, sp.latinname),' - Jumlah pohon yang dikirim') as labelin,
	'' as hinten,
	'' as hintin,
	'TRUE' as required,
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
    --ligne 6
	select sp.id as speciesid, 6 as  roworder, 
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
	'.>=0' as constrainte,
	'It cannot be a negative number.' as constraintmess,
	'' as constraintmessother,
	'0' as default,
	'' as calculation
	from public.species sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3
	union all
	--ligne 7
	select 99999996 as speciesid, 0 as  roworder, 
	'calculate' as type_,
	'filter_select_species' as name_,
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
	(SELECT replace(concat('concat(',string_agg(concat('%DOL{',
        concat(code,'_name'),'}'),' , '),')'),'%DOL','$')
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


-- Species More
with cte as(
	--ligne 1
    select sp.id as speciesid, 1 as  roworder, 
	'integer' as type_,
	concat(code,'_nb_trees_delivered_more') as name_,
	concat(coalesce(tren.translationlabel, sp.latinname),' - Number of delivered trees') as labelen,
	concat(coalesce(tr.translationlabel, sp.latinname),' - Jumlah pohon yang dikirim') as labelin,
	'' as hinten,
	'' as hintin,
	'TRUE' as required,
	'' as apearence,
	'' as choicefilter,
	replace(concat('selected(%DOL{species_selection_other},''',code,''')'),'%DOL','$') as relevant,
	'.>=0' as constrainte,
	'It cannot be a negative number.' as constraintmess,
	'' as constraintmessother,
	'0' as default,
	'' as calculation
	from public.species  sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3)
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

-- Species Normal delivery
with cte as(
	--ligne 1
    select sp.id as speciesid, 1 as  roworder, 
	'calculate' as type_,
	concat(code,'_nb_trees_delivered_normal') as name_,
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
	replace(concat('coalesce(%DOL{',code,'_nb_trees_delivered_prereg},0)+coalesce(%DOL{',code,'_nb_trees_delivered_more},0)'),'%DOL','$') as calculation
	from public.species  sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3)
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

-- Species replanting delivery 
with cte as(
	--ligne 1
    select sp.id as speciesid, 1 as  roworder, 
	'integer' as type_,
	concat(code,'_nb_trees_delivered_replanting') as name_,
	concat(coalesce(tren.translationlabel, sp.latinname),' - Number of delivered trees') as labelen,
	concat(coalesce(tr.translationlabel, sp.latinname),' - Jumlah pohon yang dikirim') as labelin,
	'' as hinten,
	'' as hintin,
	'TRUE' as required,
	'' as apearence,
	'' as choicefilter,
	replace(concat('selected(%DOL{species_selection_replanting},''',code,''')'),'%DOL','$') as relevant,
	'.>=0' as constrainte,
	'It cannot be a negative number.' as constraintmess,
	'' as constraintmessother,
	'' as default,
	'' as calculation
	from public.species  sp
inner join public.projectspecies ps on ps.speciesid = sp.id
left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 3)
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

--Recap delivery
with cte as(
    -- total normal
    select 99999996 as speciesid, 0 as  roworder, 
	'calculate' as type_,
	'total_nb_trees_delivered_normal' as name_,
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
	(SELECT replace(concat(string_agg(concat('coalesce(%DOL{',
        concat(code,'_nb_trees_delivered_normal'),'},0)'),' + ')),'%DOL','$')
		FROM   public.species sp
		inner join public.projectspecies ps on ps.speciesid = sp.id
		left join public.translations tr on tr.id = sp.translationid and tr.languagecode = 'in'
		left join public.translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
		where ps.projectid = 3) as calculation
    union all
    --total replanting
    select 99999997 as speciesid, 0 as  roworder, 
	'calculate' as type_,
	'total_nb_trees_delivered_replanting' as name_,
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
	(SELECT replace(concat(string_agg(concat('coalesce(%DOL{',
        concat(code,'_nb_trees_delivered_replanting'),'},0)'),' + ')),'%DOL','$')
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