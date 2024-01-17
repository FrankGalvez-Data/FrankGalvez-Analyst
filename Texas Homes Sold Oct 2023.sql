SELECT 
    *
FROM
    tx_homes_sold.tx_homes_sold_oct_2023;

    
-- ## MIN, MAX & AVG Sales price per City ## -- 
SELECT DISTINCT
    city,
    MIN(close_price),
    MAX(close_price),
    ROUND(AVG(Close_Price), 1) AS Avg_Sales_price
FROM
    tx_homes_sold_oct_2023
GROUP BY city
ORDER BY city ASC , Avg_Sales_price ASC;


-- ## Listings sold that had a pool ## -- 
SELECT 
    *
FROM
    tx_homes_sold_oct_2023
WHERE
    pool = 'YES'
        AND (close_price BETWEEN 150000 AND 500000)
ORDER BY Close_Price ASC;


-- ## Listings sold by brokerages I have been a part of ## -- 
SELECT 
    address,
    city,
    Zip_Code,
    Subdivision_Name,
    Square_footage,
    Beds_Total,
    Bath_Total,
    Acreage,
    pool,
    Close_Price,
    (close_price * 0.03) AS commission,
    Buyer_Agent,
    Buyer_Brokerage_Office
FROM
    tx_homes_sold_oct_2023
WHERE
    Buyer_Brokerage_Office LIKE '%Insight%'
        OR Buyer_Brokerage_Office LIKE '%Keller Williams Realty FtWorth%'
ORDER BY Buyer_Agent ASC;


-- ##  AVG COMMISSION BY BROKERAGE I HAVE BEEN A PART OF  ## --
select Buyer_Brokerage_Office, avg(commission)
from (SELECT 
    address,
    city,
    Zip_Code,
    Subdivision_Name,
    Square_footage,
    Beds_Total,
    Bath_Total,
    Acreage,
    pool,
    Close_Price,
    (close_price * 0.03) AS commission,
    Buyer_Agent,
    Buyer_Brokerage_Office
FROM
    tx_homes_sold_oct_2023
WHERE
   Buyer_Brokerage_Office LIKE '%Insight%'
        OR Buyer_Brokerage_Office LIKE '%Keller Williams Realty FtWorth%') as T_table 
group by Buyer_Brokerage_Office;


-- ##  AVG COMMISSION BY BROKERAGE  ## -- SUBQUERY
select Buyer_Brokerage_Office, avg(commission) AS avg_commission
from (SELECT 
    address,
    city,
    Zip_Code,
    Subdivision_Name,
    Square_footage,
    Beds_Total,
    Bath_Total,
    Acreage,
    pool,
    Close_Price,
    (close_price * 0.03) AS commission,
    Buyer_Agent,
    Buyer_Brokerage_Office
FROM
    tx_homes_sold_oct_2023)  as T_table 
group by Buyer_Brokerage_Office
ORDER BY avg_commission desc;

select *
from tx_homes_sold_oct_2023
where Buyer_Brokerage_Office in ('Brix Realty', 'JPAR Plano', 'NextHome Integrity Group')
order by Buyer_Brokerage_Office;

