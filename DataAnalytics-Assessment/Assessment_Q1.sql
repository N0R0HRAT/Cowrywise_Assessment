-- This query identifies high-value customers who actively participate in both savings and investments and filters those 
-- with a balance

SELECT * FROM (
    SELECT 
        b.id AS owner_id,  -- Selecting customer ID
        CONCAT(first_name, ' ', last_name) AS full_name, -- Joining first and last names so there is one column- fullname
        COUNT(DISTINCT CASE WHEN a.is_a_fund = 1 THEN a.owner_id END) AS investment_count, -- Counting distinct investments
        COUNT(DISTINCT CASE WHEN a.is_regular_savings = 1 THEN a.owner_id END) AS savings_count, -- Counting distinct savings
        SUM(c.confirmed_amount )/ 100 AS total_deposit -- Summing deposits and dividing by 100 since amount fields are in KOBO
    FROM users_customuser b
    JOIN plans_plan a 
    ON b.id = a.owner_id 
    JOIN savings_savingsaccount c 
    ON b.id = c.owner_id 
    WHERE a.id IS NOT NULL AND c.id IS NOT NULL -- Ensuring the user has both investment and savings accounts
    GROUP BY b.id, COALESCE(b.first_name, b.last_name) -- Grouping by customer ID and name
    HAVING (SUM(confirmed_amount) - SUM(deduction_amount)) > 0 -- Filtering customers with funded plans
) a
WHERE investment_count > 0 AND savings_count > 0 -- Ensuring users have at least one investment and one savings account
ORDER BY total_deposit DESC; -- Sorting results by total deposits in descending order
