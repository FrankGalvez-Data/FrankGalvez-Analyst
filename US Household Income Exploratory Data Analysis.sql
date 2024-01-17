SELECT * FROM us_project.us_household_income_statistics;

SELECT * FROM us_project.us_household_income;

SELECT 
    State_Name, sum(ALand), sum(AWater)
FROM
    us_project.us_household_income
Group by State_Name
order by 3 desc
limit 10;


SELECT 
    *
FROM
    us_project.us_household_income u
inner join 
    us_project.us_household_income_statistics us
on u.id=us.id
where mean <> 0;


SELECT 
    u.State_Name, u.county, `type`, `primary`, mean, median
FROM
    us_project.us_household_income u
inner join 
    us_project.us_household_income_statistics us
on u.id=us.id
where mean <> 0;

SELECT  u.State_Name, round(avg(mean),1), round(avg(median),1)
FROM us_project.us_household_income u
inner join 
    us_project.us_household_income_statistics us
on u.id=us.id
-- where mean <> 0
group by u.State_Name
order by 3 desc
limit 10;


SELECT type, count(type), round(avg(mean),1), round(avg(median),1)
FROM us_project.us_household_income u
inner join  us_project.us_household_income_statistics us
	on u.id=us.id
where mean <> 0
group by type
having count(type) > 100
order by 4 desc
;

SELECT u.State_Name, city, round(avg(mean),1) as avg_mean, round(avg(median),1)
FROM us_project.us_household_income u
inner join us_project.us_household_income_statistics us
on u.id=us.id
group by u.State_Name, city
order by avg_mean desc


