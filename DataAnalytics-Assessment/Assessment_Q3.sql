-- This script identifies accounts that belong to savings or investment plans and sorts them by inactivity period.

-- Creating a temporary table (Common Table Expression - CTE)
WITH ranked_transactions AS (
    SELECT 
        a.owner_id, -- Selecting owner ID of the account
        CASE 
            WHEN a.is_a_fund = 1 THEN 'investment' -- Categorizing as investment if the condition is met
            WHEN a.is_regular_savings = 1 THEN 'savings' -- Categorizing as savings if the condition is met
        END AS account_type,
        MAX(DATE(b.transaction_date)) AS last_transaction_date, -- Getting the latest transaction date for each account
        DATEDIFF(CURRENT_DATE, MAX(b.transaction_date)) AS inactivity_days -- Calculating inactivity duration in days
    FROM plans_plan a
    LEFT JOIN savings_savingsaccount b ON a.owner_id = b.owner_id 
    WHERE (a.is_fixed_investment = 1 OR a.is_regular_savings = 1) -- Ensuring only savings and investment accounts
    AND b.transaction_date IS NOT NULL -- Excluding NULL transaction dates
    GROUP BY a.owner_id, account_type -- Grouping data by owner and account type to aggregate transactions
)

-- Retrieving final results for accounts with their last transaction date and inactivity period
SELECT owner_id, account_type, last_transaction_date, inactivity_days
FROM ranked_transactions
WHERE account_type IS NOT NULL -- Ensuring only accounts classified as savings or investment are included
ORDER BY inactivity_days DESC; -- Ordering results by inactivity duration in descending order
