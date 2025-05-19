
SELECT 
    u.id AS customer_id, -- Selecting customer ID for identification
    CONCAT(u.first_name, ' ', u.last_name) AS name, -- Combining first and last name into a single column
    TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) AS tenure_months, -- Calculating how long the customer has been active (in months)
    COUNT(s.id) AS total_transactions, -- Counting the number of transactions per customer
    ROUND((COUNT(s.id) / TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE)) * 12 * 0.001 * AVG(s.available_returns) / 100, 2) AS estimated_clv 
    -- CLV formula: 
    -- (total transactions / tenure) * 12 * avg_profit_per_transaction
    -- where profit per transaction is 0.1% (0.001) of transaction value
    -- available_returns is divided by 100 to convert kobo to naira
FROM users_customuser u
LEFT JOIN savings_savingsaccount s ON u.id = s.owner_id 
WHERE u.date_joined IS NOT NULL -- only users with a valid join date are included
GROUP BY u.id, name, tenure_months -- Grouping data by customer to perform aggregations
ORDER BY estimated_clv DESC; -- Ordering customers by estimated CLV, highest first

