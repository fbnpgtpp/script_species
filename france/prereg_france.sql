--Kobo France Prereg

--Prereg

select case when sp.treecategid = 1 then 'species_arbustes'
			when sp.treecategid = 2 then 'species_cepees_arbres'
			when sp.treecategid = 3 then 'species_hauts_jets'
			when sp.treecategid = 4 then 'species_fruitiers' end
			,sp.treecategid
	, code as name_
	,coalesce(tr.translationlabel, sp.latinname) as labelen 
	,coalesce(tres.translationlabel, sp.latinname) as tranfr
	from species sp
	inner join projectspecies p on p.speciesid = sp.mainspeciesid 
	left join translations tr on tr.id = sp.translationid and tr.languagecode = 'en'
	left join translations tres on tres.id = sp.translationid and tres.languagecode = 'fr'
	where p.projectid = 9 and sp.treecategid in (1,2,3,4)
order by sp.treecategid,tres.translationlabel;

-- species arbustes selection


with cte as (
select 	1 as ordre2, coalesce(tr.translationlabel, sp.latinname) as ordre1
		,'begin_group' as type_
		,code as name_
		,coalesce(tren.translationlabel, sp.latinname) as labelen
		,coalesce(tr.translationlabel, sp.latinname) as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,replace(concat('selected(%DOL{species_arbustes}, ''',code,''')'),'%DOL','$')  as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,'' as calculation
from species sp
inner join projectspecies ps on ps.speciesid = sp.mainspeciesid
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 9 and sp.treecategid = 1
union all
select 	2 as ordre2, coalesce(tr.translationlabel, sp.latinname) as ordre1
		,'integer' as type_
		,concat(code,'_nb_of_trees') as name_
		,concat(coalesce(tren.translationlabel, sp.latinname) ,' number of trees') as labelen
		,concat(coalesce(tr.translationlabel, sp.latinname) ,' - nombre d''arbres') as labelfr
		,'' as hinten
		,'' as hintes
		,'false' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'.>=0' as constraint_
		,'It cannot be a negative number.' as contraintmessen
		,'It cannot be a negative number.' as contraintmesses
		,'0' as default_
		,'' as calculation
from species sp
inner join projectspecies ps on ps.speciesid = sp.mainspeciesid
inner join translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 9 and sp.treecategid = 1
union all
select 	8 as ordre2, coalesce(tr.translationlabel, sp.latinname) as ordre1
		,'end_group' as type_
		,'' as name_
		,'' as labelen
		,'' as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,'' as calculation
from species sp
inner join projectspecies ps on ps.speciesid = sp.mainspeciesid
inner join translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 9 and sp.treecategid = 1
union all
select 	7 as ordre2, 'zzz' as ordre1
		,'calculate' as type_
		,'recap_avalaible_arbustes' as name_
		,'' as labelen
		,'' as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,(SELECT replace(concat('%DOL{nb_of_arbustes_before_dispatching} - ',string_agg(concat('coalesce(${',
			concat(code,'_nb_of_trees'),
			'},0)'), ' - ')),'%DOL','$')
			FROM   species sp
			inner join projectspecies p on p.speciesid = sp.mainspeciesid 
			where p.projectid = 9 and sp.treecategid = 1) as calculation
union all
select 	8 as ordre2, 'zzz' as ordre1
		,'note' as type_
		,'share_info' as name_
		,replace(concat('<span style="color:red"> arbustes remaining : %DOL{recap_avalaible_arbustes} trees</span>'),'%DOL','$') as labelen
		,replace(concat('<span style="color:red"> arbustes restants : %DOL{recap_avalaible_arbustes} arbres</span>'),'%DOL','$') as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,'' as calculation)
select  type_
		,name_
		, labelen
		, labelfr
		, hinten
		, hintes
		, required
		,apparence
		, choicefilter
		, relevant
		, constraint_
		, contraintmessen
		, contraintmesses
		, default_
		,calculation
from cte order by ordre1, ordre2;



-- species cepees  selection

with cte as (
select 	1 as ordre2, coalesce(tr.translationlabel, sp.latinname) as ordre1
		,'begin_group' as type_
		,code as name_
		,coalesce(tren.translationlabel, sp.latinname) as labelen
		,coalesce(tr.translationlabel, sp.latinname) as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,replace(concat('selected(%DOL{species_cepees_arbres}, ''',code,''')'),'%DOL','$')  as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,'' as calculation
from species sp
inner join projectspecies ps on ps.speciesid = sp.mainspeciesid
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 9 and sp.treecategid = 2
union all
select 	2 as ordre2, coalesce(tr.translationlabel, sp.latinname) as ordre1
		,'integer' as type_
		,concat(code,'_nb_of_trees') as name_
		,concat(coalesce(tren.translationlabel, sp.latinname) ,' number of trees') as labelen
		,concat(coalesce(tr.translationlabel, sp.latinname) ,' - nombre d''arbres') as labelfr
		,'' as hinten
		,'' as hintes
		,'false' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'.>=0' as constraint_
		,'It cannot be a negative number.' as contraintmessen
		,'It cannot be a negative number.' as contraintmesses
		,'0' as default_
		,'' as calculation
from species sp
inner join projectspecies ps on ps.speciesid = sp.mainspeciesid
inner join translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 9 and sp.treecategid = 2
union all
select 	8 as ordre2, coalesce(tr.translationlabel, sp.latinname) as ordre1
		,'end_group' as type_
		,'' as name_
		,'' as labelen
		,'' as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,'' as calculation
from species sp
inner join projectspecies ps on ps.speciesid = sp.mainspeciesid
inner join translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 9 and sp.treecategid = 2
union all
select 	7 as ordre2, 'zzz' as ordre1
		,'calculate' as type_
		,'cepees_available_after' as name_
		,'' as labelen
		,'' as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,(SELECT replace(concat('%DOL{nb_of_cepees_before_dispatching} - ',string_agg(concat('coalesce(${',
			concat(code,'_nb_of_trees'),
			'},0)'), ' - ')),'%DOL','$')
			FROM   species sp
			inner join projectspecies p on p.speciesid = sp.mainspeciesid 
			where p.projectid = 9 and sp.treecategid = 2) as calculation
union all
select 	8 as ordre2, 'zzz' as ordre1
		,'note' as type_
		,'share_info_cp' as name_
		,replace(concat('<span style="color:red"> cépées remaining : %DOL{cepees_available_after} trees</span>'),'%DOL','$') as labelen
		,replace(concat('<span style="color:red"> cépées restants : %DOL{cepees_available_after} arbres</span>'),'%DOL','$') as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,'' as calculation)
select  type_
		,name_
		, labelen
		, labelfr
		, hinten
		, hintes
		, required
		,apparence
		, choicefilter
		, relevant
		, constraint_
		, contraintmessen
		, contraintmesses
		, default_
		,calculation
from cte order by ordre1, ordre2;


-- species haut jets  selection

with cte as (
select 	1 as ordre2, coalesce(tr.translationlabel, sp.latinname) as ordre1
		,'begin_group' as type_
		,code as name_
		,coalesce(tren.translationlabel, sp.latinname) as labelen
		,coalesce(tr.translationlabel, sp.latinname) as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,replace(concat('selected(%DOL{species_hauts_jets}, ''',code,''')'),'%DOL','$')  as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,'' as calculation
from species sp
inner join projectspecies ps on ps.speciesid = sp.mainspeciesid
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 9 and sp.treecategid = 3
union all
select 	2 as ordre2, coalesce(tr.translationlabel, sp.latinname) as ordre1
		,'integer' as type_
		,concat(code,'_nb_of_trees') as name_
		,concat(coalesce(tren.translationlabel, sp.latinname) ,' number of trees') as labelen
		,concat(coalesce(tr.translationlabel, sp.latinname) ,' - nombre d''arbres') as labelfr
		,'' as hinten
		,'' as hintes
		,'false' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'.>=0' as constraint_
		,'It cannot be a negative number.' as contraintmessen
		,'It cannot be a negative number.' as contraintmesses
		,'0' as default_
		,'' as calculation
from species sp
inner join projectspecies ps on ps.speciesid = sp.mainspeciesid
inner join translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 9 and sp.treecategid = 3
union all
select 	8 as ordre2, coalesce(tr.translationlabel, sp.latinname) as ordre1
		,'end_group' as type_
		,'' as name_
		,'' as labelen
		,'' as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,'' as calculation
from species sp
inner join projectspecies ps on ps.speciesid = sp.mainspeciesid
inner join translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 9 and sp.treecategid = 3
union all
select 	7 as ordre2, 'zzz' as ordre1
		,'calculate' as type_
		,'haut_jets_available_after_' as name_
		,'' as labelen
		,'' as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,(SELECT replace(concat('%DOL{nb_of_hauts_jets_before_dispatching} - ',string_agg(concat('coalesce(${',
			concat(code,'_nb_of_trees'),
			'},0)'), ' - ')),'%DOL','$')
			FROM   species sp
			inner join projectspecies p on p.speciesid = sp.mainspeciesid 
			where p.projectid = 9 and sp.treecategid = 3) as calculation
union all
select 	8 as ordre2, 'zzz' as ordre1
		,'note' as type_
		,'share_info_hj' as name_
		,replace(concat('<span style="color:red"> Hauts jets remaining : %DOL{haut_jets_available_after_} trees</span>'),'%DOL','$') as labelen
		,replace(concat('<span style="color:red"> Hauts jets restants : %DOL{haut_jets_available_after_} arbres</span>'),'%DOL','$') as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,'' as calculation)
select  type_
		,name_
		, labelen
		, labelfr
		, hinten
		, hintes
		, required
		,apparence
		, choicefilter
		, relevant
		, constraint_
		, contraintmessen
		, contraintmesses
		, default_
		,calculation
from cte order by ordre1, ordre2;


-- species fruitiers  selection

with cte as (
select 	1 as ordre2, coalesce(tr.translationlabel, sp.latinname) as ordre1
		,'begin_group' as type_
		,code as name_
		,coalesce(tren.translationlabel, sp.latinname) as labelen
		,coalesce(tr.translationlabel, sp.latinname) as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,replace(concat('selected(%DOL{species_fruitiers}, ''',code,''')'),'%DOL','$')  as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,'' as calculation
from species sp
inner join projectspecies ps on ps.speciesid = sp.mainspeciesid
left join translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 9 and sp.treecategid = 4
union all
select 	2 as ordre2, coalesce(tr.translationlabel, sp.latinname) as ordre1
		,'integer' as type_
		,concat(code,'_nb_of_trees') as name_
		,concat(coalesce(tren.translationlabel, sp.latinname) ,' number of trees') as labelen
		,concat(coalesce(tr.translationlabel, sp.latinname) ,' - nombre d''arbres') as labelfr
		,'' as hinten
		,'' as hintes
		,'false' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'.>=0' as constraint_
		,'It cannot be a negative number.' as contraintmessen
		,'It cannot be a negative number.' as contraintmesses
		,'0' as default_
		,'' as calculation
from species sp
inner join projectspecies ps on ps.speciesid = sp.mainspeciesid
inner join translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 9 and sp.treecategid = 4
union all
select 	8 as ordre2, coalesce(tr.translationlabel, sp.latinname) as ordre1
		,'end_group' as type_
		,'' as name_
		,'' as labelen
		,'' as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,'' as calculation
from species sp
inner join projectspecies ps on ps.speciesid = sp.mainspeciesid
inner join translations tr on tr.id = sp.translationid and tr.languagecode = 'fr'
left join translations tren on tren.id = sp.translationid and tren.languagecode = 'en'
where ps.projectid = 9 and sp.treecategid = 4
union all
select 	7 as ordre2, 'zzz' as ordre1
		,'calculate' as type_
		,'fruitiers_available_after_' as name_
		,'' as labelen
		,'' as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,(SELECT replace(concat('%DOL{nb_of_fruitiers_before_dispatching} - ',string_agg(concat('coalesce(${',
			concat(code,'_nb_of_trees'),
			'},0)'), ' - ')),'%DOL','$')
			FROM   species sp
			inner join projectspecies p on p.speciesid = sp.mainspeciesid 
			where p.projectid = 9 and sp.treecategid = 4) as calculation
union all
select 	8 as ordre2, 'zzz' as ordre1
		,'note' as type_
		,'share_info_fr' as name_
		,replace(concat('<span style="color:red"> Fruitiers remaining : %DOL{fruitiers_available_after_} trees</span>'),'%DOL','$') as labelen
		,replace(concat('<span style="color:red"> Fruitiers restants : %DOL{fruitiers_available_after_} arbres</span>'),'%DOL','$') as labelfr
		,'' as hinten
		,'' as hintes
		,'' as required
		,'' as apparence
		,'' as choicefilter
		,'' as relevant
		,'' as constraint_
		,'' as contraintmessen
		,'' as contraintmesses
		,'' as default_
		,'' as calculation)
select  type_
		,name_
		, labelen
		, labelfr
		, hinten
		, hintes
		, required
		,apparence
		, choicefilter
		, relevant
		, constraint_
		, contraintmessen
		, contraintmesses
		, default_
		,calculation
from cte order by ordre1, ordre2;



-- Recap global


SELECT replace(concat(string_agg(concat('coalesce(${',
			code,
			'},0)'), ' + ')),'%DOL','$')
			FROM   species sp
			inner join projectspecies p on p.speciesid = sp.mainspeciesid 
			where p.projectid = 9 and sp.treecategid in (1,2,3,4);
			
			



-- Recap fin de parcelle
select 
	'calculate' as type_,
	concat(code,'_nb_of_trees_out') as name_,
	'' as labelen,
	'' as labelgh,
	'' as hinten,
	'' as hintgh,
	'false' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess,
	'' as constraintmess2,
	'' as default,
	replace(
	concat('if(selected(%DOL{parcel_relevant_for_planting_yn},''yes'') and selected(%DOL{',
	case when sp.treecategid = 1 then 'species_arbustes'
			when sp.treecategid = 2 then 'species_cepees_arbres'
			when sp.treecategid = 3 then 'species_hauts_jets'
			when sp.treecategid = 4 then 'species_fruitiers' end
	,'}, ''',code,''') and %DOL{',code, '_total_nb} != '''',%DOL{',code, '_total_nb},0)')--'_nb_of_trees'
				
	,'%DOL','$') as calculation
	from species sp
	inner join projectspecies p on p.speciesid = sp.mainspeciesid 
	left join translations tr on tr.id = sp.translationid and tr.languagecode = 'en'
	left join translations tres on tres.id = sp.translationid and tres.languagecode = 'fr'
	where p.projectid = 9 and sp.treecategid in (1,2,3,4);


--Recap final


with cte as(
	--ligne 1
	select 0 as speciesid, 1 as  roworder, 0 as treecategid,
	'note' as type_,
	'species_recap' as name_,
	'__Nombre total d''''arbres par espèces :__' as labelgh,
	'' as hintgh,
	'' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess2,
	'' as default,
	'' as calculation
	union all
	--ligne 2
	select sp.id as speciesid, 0 as  roworder,  sp.treecategid,
	'calculate' as type_,
	concat(code,'_total_nb') as name_,
	'' as labelgh,
	'' as hintgh,
	'false' as required,
	'' as apearence,
	'' as choicefilter,
	'' as relevant,
	'' as constrainte,
	'' as constraintmess2,
	'' as default,
	replace(concat('sum(%DOL{',
	concat(code,'_nb_of_trees_out'),
	'})'),'%DOL','$') as calculation
	from species sp
	inner join projectspecies p on p.speciesid = sp.mainspeciesid 
	left join translations tr on tr.id = sp.translationid and tr.languagecode = 'en'
	left join translations tres on tres.id = sp.translationid and tres.languagecode = 'fr'
	where p.projectid = 9 and sp.treecategid in (1,2,3,4)
	union all
	--ligne 3
	select sp.id as speciesid, 3 as  roworder,  sp.treecategid,
	'note' as type_,
	concat(code,'_nb_of_trees_info') as name_,
	concat(coalesce(tres.translationlabel, sp.latinname) , ' nombre total d''arbres : <span style="color:red">${',code,'_total_nb} arbres</span>') as labelgh,
	'' as hintgh,
	'false' as required,
	'' as apearence,
	'' as choicefilter,
	concat('${',code,'_total_nb','} > 0') as relevant,
	'' as constrainte,
	'' as constraintmess2,
	'' as default,
	'' as calculation
	from species sp
	inner join projectspecies p on p.speciesid = sp.mainspeciesid 
	left join translations tr on tr.id = sp.translationid and tr.languagecode = 'en'
	left join translations tres on tres.id = sp.translationid and tres.languagecode = 'fr'
	where p.projectid = 9 and sp.treecategid in (1,2,3,4))
select type_,
	name_,
	labelgh,
	hintgh,
	required,
	apearence,
	choicefilter,
	relevant,
	constrainte,
	constraintmess2,
	"default",
	calculation from cte 
order by speciesid asc, treecategid asc,roworder asc;
