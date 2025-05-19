# DataAnalytics-Assessment
Contains the assessment answers for Cowrywise assessment.
# Question 1
Explanations: The goal is to identify customers who have both a savings account and an investment plan—indicating cross-selling potential. By;
Identifing customers in users_customuser with at least one savings and one investment account.
Filtering for only funded accounts (checking nonzero balances or successful deposits).
Sorting by total deposits to prioritize the most valuable customers.
--Challenges: Tables have a lot of columns I thought were not needed for the exercise.

# Question 2
Explanations: The finance team needs to segment users based on how often they transact per month:
I did a Count of total transactions per customer.
Determined the average transactions per month (COUNT / unique months).
Classified customers into:
High Frequency (≥10 transactions/month)
Medium Frequency (3-9 transactions/month)
Low Frequency (≤2 transactions/month)
--Chalenges: Some users may have inactive months, affecting their average frequency.

# Question 3
Explanations: Operations needs to identify accounts with no inflow transactions in the past year (365 days):
Identify active accounts (either savings or investment).
Check last inflow transaction date per customer.
Flag accounts where the last inflow transaction was more than a year ago or has no record at all.
--Challenges: Some accounts may have never had an inflow (handling NULL values).
Filtering only inflow transactions, excluding withdrawals.
Optimizing queries for efficient date comparisons when working with large datasets.

# Questions 4
Explanations: Marketing wants to estimate CLV based on tenure and transaction volume:
Calculate account tenure (months since signup).
Count total transactions per customer.
Estimate CLV.
--Challenges: Customers with few transactions may have skewed CLV calculations.
Ensuring profit calculation is accurate based on a valid column
