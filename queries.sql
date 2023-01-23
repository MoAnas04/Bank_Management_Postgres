-- queries for the given questions
--Question 1:
SELECT sender_id, receiver_id, amount, created_at 
FROM Transactions
WHERE created_at <= now() AND created_at >= given_date;

SELECT account_id, amount, balance, created_at 
FROM Withdraws/Deposits
WHERE created_at <= now() AND created_at >= given_date;

--Question 2
--- for converting into json format
SELECT sender_id, receiver_id, amount, created_at 
FROM Transactions
WHERE created_at <= now() AND created_at >= given_date
FOR JSON AUTO;

SELECT account_id, amount, balance, created_at 
FROM Withdraws/Deposits
WHERE created_at <= now() AND created_at >= given_date
FOR JSON AUTO;

--Question 3
--loan account report
SELECT customer_id, type, amount, interest, period, balance, monthly_emi, monthly_emi_remaining, monthly_emi_date
FROM Loans
WHERE customer_id = given_id;

--Question 4
--a
SELECT id, account_id, SUM(amount) AS amount
FROM Deposits
WHERE account_id = given_id AND created_at <= now() AND created_at >= given_date
GROUP BY account_id;

--b
SELECT id, account_id, SUM(amount) AS amount
FROM Withdraws
WHERE account_id = given_id AND created_at <= now() AND created_at >= given_date
GROUP BY account_id;

--c
SELECT customer_id, COUNT(*) as number_of_loans
FROM Loans
WHERE customer_id = given_id AND created_at <= now() AND created_at >= given_date
GROUP BY customer_id;

--d
SELECT t1.loan_id, t1.COUNT(*) as number_of_payments, t2.customer_id
FROM Loan_Payments t1 
INNER JOIN Loans t2 ON t1.loan_id = t2.id
WHERE t2.customer_id = given_id AND t1.date <= now() AND t1.date >= given_date;

--e
