SELECT *
FROM startups
WHERE country = 'Nigeria';

SELECT *
FROM funding_rounds
WHERE amount_usd > 500000
ORDER BY amount_usd ASC;

SELECT startup_id, SUM(amount_usd)
FROM funding_rounds
GROUP BY startup_id
ORDER BY 2 ASC
;

WITH CTE AS
( 
	SELECT 
		star.startup_id,star.startup_name, SUM(amount_usd) AS total_funding
	FROM funding_rounds fund
	JOIN startups star
    ON fund.startup_id = star.startup_id
    GROUP BY star.startup_id, star.startup_name
)
SELECT * 
FROM CTE 
ORDER BY total_funding DESC
;


SELECT round_stage,
	COUNT(round_id) AS total_rounds
FROM funding_rounds
GROUP BY round_stage;

WITH CTE AS
( 
	SELECT 
		star.startup_id,star.startup_name, SUM(amount_usd) AS total_funding
	FROM funding_rounds fund
	JOIN startups star
    ON fund.startup_id = star.startup_id
    GROUP BY star.startup_id, star.startup_name
)
SELECT * 
FROM CTE 
ORDER BY total_funding DESC
LIMIT 5;

SELECT round_stage, AVG(amount_usd)
FROM funding_rounds
GROUP BY round_stage;

SELECT
    i.investor_id,
    i.investor_name,
    COUNT(ri.round_id) AS rounds_participated
FROM investors AS i
JOIN round_investors AS ri
    ON i.investor_id = ri.investor_id
GROUP BY i.investor_id, i.investor_name
ORDER BY rounds_participated DESC;


SELECT *
FROM startups;

SELECT *
FROM funding_rounds;

SELECT *
FROM round_investors;

SELECT
    fr.round_id,
    s.startup_name,
    s.industry,
    s.country AS startup_country,
    fr.round_stage,
    fr.announced_date,
    fr.amount_usd,
    fr.post_money_valuation_usd,
    i.investor_name,
    i.investor_type,
    ri.is_lead_investor
FROM funding_rounds AS fr
JOIN startups AS s
    ON fr.startup_id = s.startup_id
JOIN round_investors AS ri
    ON fr.round_id = ri.round_id
JOIN investors AS i
    ON ri.investor_id = i.investor_id
ORDER BY fr.announced_date DESC;


SELECT s.industry,
    SUM(fr.amount_usd) AS total_funding
FROM startups AS s
JOIN funding_rounds AS fr
	ON s.startup_id = fr.startup_id
    GROUP BY s.industry 
    ORDER BY total_funding DESC
;


SELECT s.country,
    SUM(fr.amount_usd) AS total_funding
FROM startups AS s
JOIN funding_rounds AS fr
	ON s.startup_id = fr.startup_id
    GROUP BY s.country 
    ORDER BY total_funding DESC;
    
    SELECT s.startup_id,s.startup_name,COUNT(fr.round_id) AS total_rounds
    FROM startups AS s
    JOIN funding_rounds AS fr
    ON s.startup_id = fr.startup_id
    GROUP BY s.startup_id,s.startup_name
    HAVING total_rounds >1
    ORDER BY total_rounds DESC;
    
SELECT startup_id, COUNT(*) AS total
FROM startups
GROUP BY startup_id
HAVING COUNT(*) > 1;

SELECT round_Id, COUNT(*) AS total
FROM funding_rounds
GROUP BY round_id
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS missing_round_ids
FROM round_investors
WHERE round_id IS NULL;

SELECT
    s.startup_name,
    SUM(fr.amount_usd) AS total_amount_raised
FROM startups AS s
JOIN funding_rounds AS fr
    ON s.startup_id = fr.startup_id
GROUP BY s.startup_name
ORDER BY total_amount_raised DESC;

SELECT
    s.startup_name,
    COUNT(fr.round_id) AS total_rounds
FROM startups AS s
JOIN funding_rounds AS fr
    ON s.startup_id = fr.startup_id
GROUP BY  s.startup_name
ORDER BY total_rounds DESC;


SELECT  i.investor_name,
	COUNT(ri.round_id) AS total_rounds
    FROM investors AS i
    JOIN round_investors AS ri
    ON i.investor_id = ri.investor_id
    GROUP BY   i.investor_name
    ORDER BY total_rounds DESC;

SELECT *
FROM funding_rounds;

SELECT
    i.investor_name,
    COUNT(ri.round_id) AS round_count
FROM investors AS i
JOIN round_investors AS ri
    ON i.investor_id = ri.investor_id
	WHERE ri.is_lead_investor  = 1
	GROUP BY investor_name
	ORDER BY round_count DESC ;

SELECT
    round_stage,
    AVG(amount_usd) AS average_funding
FROM funding_rounds
	GROUP BY  round_stage
ORDER BY average_funding DESC;
