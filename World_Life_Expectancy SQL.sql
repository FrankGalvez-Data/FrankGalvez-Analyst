SELECT * FROM world_life_expectancy;

SELECT country, year, concat(country, year), count(concat(country, year))
from world_life_expectancy
group by country, year, concat(country, year)
having count(concat(country, year)) > 1;


select *
from(
select row_id, 
concat(country, year),
row_number() OVER (partition by concat(country, year) order by concat(country, year)) as Row_num
from world_life_expectancy) as row_table
where row_num > 1;


delete from world_life_expectancy
where
	row_id IN (
    select row_id
from (
    select row_id, 
	concat(country, year),
	row_number() OVER (partition by concat(country, year) order by concat(country, year)) as Row_num
	from world_life_expectancy) as row_table
	where row_num > 1);


SELECT * FROM world_life_expectancy
where status = '';

SELECT * FROM world_life_expectancy;

select distinct(status)
from world_life_expectancy
where status <> '';

SELECT distinct(country)
from world_life_expectancy
where status = 'Developing';

UPDATE world_life_expectancy
set status = 'Developing'
where country IN (SELECT distinct(country)
from world_life_expectancy
where status = 'Developing');


UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	on t1.country = t2.country
    set t1.status = 'Developing'
    where t1.status = ''
    and t2.status <> ''
    and t2.Status = 'Developing'
    ;
    
    
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	on t1.country = t2.country
    set t1.status = 'Developed'
    where t1.status = ''
    and t2.status <> ''
    and t2.Status = 'Developed'
    ;
    
SELECT * FROM world_life_expectancy;

SELECT *
FROM world_life_expectancy
where `Life expectancy` = '';

SELECT country, year, `Life expectancy`
FROM world_life_expectancy; 

SELECT t1.country, t1.year, t1.`Life expectancy`, 
t2.country, t2.year, t2.`Life expectancy`,
t3.country, t3.year, t3.`Life expectancy`,
round((t2.`Life expectancy` + t3.`Life expectancy`) /2,1)
FROM world_life_expectancy t1 
join world_life_expectancy t2
	on t1.country = t2.Country
    and t1.year = t2.year-1
join world_life_expectancy t3
	on t1.country = t3.Country
    and t1.year = t3.year + 1
where t1.`Life expectancy` = '' ;

update world_life_expectancy t1 
join world_life_expectancy t2
	on t1.country = t2.Country
    and t1.year = t2.year-1
join world_life_expectancy t3
	on t1.country = t3.Country
    and t1.year = t3.year + 1
set t1.`Life expectancy` = round((t2.`Life expectancy` + t3.`Life expectancy`) /2,1)
where t1.`Life expectancy` = '';

SELECT *
FROM world_life_expectancy;

SELECT country, 
min(`Life expectancy`), 
max(`Life expectancy`),
round(max(`Life expectancy`) - min(`Life expectancy`),1) as Life_increase_15_years
FROM world_life_expectancy
group by country
having min(`Life expectancy`) <> 0
and max(`Life expectancy`) <> 0
order by Life_increase_15_years desc;



SELECT year, round(avg(`Life expectancy`),2)
FROM world_life_expectancy
group by year
having min(`Life expectancy`) <> 0
and max(`Life expectancy`) <> 0
order by year; 



SELECT 
    country,
    ROUND(AVG(`Life expectancy`), 1) AS life_exp,
    ROUND(AVG(GDP_in_Millions), 1) AS GDP
FROM
    world_life_expectancy
GROUP BY country
HAVING life_exp > 0 AND GDP > 0
ORDER BY gdp desc;


SELECT 
	   sum(case when gdp_in_millions >= 1200 then 1  else 0 end) High_GDP_count, 
       round(avg(case when gdp_in_millions >= 1200 then `Life expectancy`  else null end),2) High_GDP_Life_Expectancy,
       sum(case when gdp_in_millions <= 1200 then 1  else 0 end) Low_GDP_count, 
       round(avg(case when gdp_in_millions <= 1200 then `Life expectancy`  else null end),2) Low_GDP_Life_Expectancy
FROM
    world_life_expectancy;

SELECt status, count(distinct country), round(avg(`Life expectancy`),1)
from world_life_expectancy
group by status;


SELECT country, bmi, `Life expectancy`
from world_life_expectancy
;

SELECT country, year, `Life expectancy`, sum(`Adult Mortality`) OVER(partition by country ORDER BY year) as Rolling_total
from world_life_expectancy