-- This script segments users based on transaction activity, providing insights into their engagement levels.

-- Creating a temporary table (Common Table Expression - CTE)
WITH transaction_counts AS (
    SELECT 
        a.id AS customer_id, -- Selecting customer ID
        COUNT(b.id) AS transaction_count, -- Counting total transactions per customer
        COUNT(b.id) / COUNT(DISTINCT DATE_FORMAT(b.transaction_date, '%Y-%m')) AS avg_transactions_per_month 
        -- Calculating average transactions per month by:
        -- - Counting total transactions
        -- - Dividing by the number of distinct months where transactions occurred
    FROM 
        users_customuser a
    LEFT JOIN 
        savings_savingsaccount b
    ON 
        a.id = b.owner_id -- Joining users with their savings accounts
    GROUP BY 
        a.id 
)

-- Categorizing customers based on their average transactions per month
SELECT 
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency' -- Customers with 10+ transactions/month
        WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency' -- Customers with 3-9 transactions/month
        ELSE 'Low Frequency' -- Customers with 2 or fewer transactions/month
    END AS frequency_category,
    COUNT(customer_id) AS customer_count, -- Counting the number of customers in each category
    AVG(avg_transactions_per_month) AS avg_transactions_per_month -- Calculating the average transactions per month for each group
FROM 
    transaction_counts -- Using the results from the CTE
GROUP BY 
    frequency_category; -- Grouping by transaction frequency category to aggregate data

    