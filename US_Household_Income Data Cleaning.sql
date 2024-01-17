SELECT * FROM us_project.us_household_income;

SELECT * FROM us_project.us_household_income_statistics;

alter table us_household_income_statistics rename column `ï»¿id` to `id`;

SELECT count(id)
FROM us_project.us_household_income;

SELECT count(id)
FROM us_project.us_household_income_statistics;

SELECT id, count(id)
from us_household_income
GROUP BY id
HAVING count(id) > 1;

select *
from(
SELECT row_id, 
id,
row_number() over(PARTITION BY id order by id) row_num
from us_household_income) duplicates
where row_num > 1;

DELETE FROM us_household_income
where row_id IN (select row_id
		from(
			SELECT row_id, 
					id,
					row_number() over(PARTITION BY id order by id) row_num
			from us_household_income) duplicates
		where row_num > 1);

select *
		from(
			SELECT row_id, 
					id,
					row_number() over(PARTITION BY id order by id) row_num
			from us_household_income) duplicates
		where row_num > 1;
        
SELECT id, 
		count(id)
From us_household_income_statistics
GROUP BY id
having count(id) >1;

SELECT State_Name, count(distinct State_Name)
FROM us_household_income
group by State_Name
order by state_name asc;

UPDATE us_household_income
set state_name = "Georgia"
where state_name = "georia";

UPDATE us_household_income
set state_name = "Alabama"
where state_name = "alabama";

SELECT *
from us_household_income
where county = "Autauga County"
order by 1;

update us_household_income
set place = "Autaugaville"
where county = "Autauga County"
and city = "Vinemont";

SELECT type, count(type)
from us_household_income
group by type;


update us_household_income
set type ='Borough'
where type = 'Boroughs';


