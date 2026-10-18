-- Creating table Bank_Loan

create table Bank_Loan(
id int primary key,
address_state varchar(10) not null,
application_type varchar(50) not null,
emp_length varchar(20) not null,
emp_title varchar(200),
grade varchar(5) not null,
home_ownership varchar(50) not null,
issue_date date not null,
last_credit_pull_date date not null,
last_payment_date date not null,
loan_status varchar(20) not null,
next_payment_date date not null,
member_id int not null,
purpose varchar(200) not null,
sub_grade varchar(20) not null,
term varchar(50) not null,
verification_status varchar(50) not null,
annual_income float not null,
dti float not null,
installment float not null,
int_rate float not null,
loan_amount float not null,
total_acc int not null,
total_payment float not null
)

-- Queries

-- 1.Finding Total Loan Applications
  
select count(id) as total_loan_applications from bank_loan;

-- 2.Finding Total Funded Amount

select sum(loan_amount) as Total_Funded_Amount from bank_loan;

-- 3. Total payment amount recorded across loan records (not a payment-level cash-flow measure)

select sum(total_payment) as total_amount_received from bank_loan;

-- 4.Finding Average Interest Rate

select round(avg(int_rate)::numeric*100,2) as avg_interest_rate from bank_loan;

-- 5.Average Debt to Income Ratio

select round(avg(dti)::numeric * 100,2) as debt_to_income_ratio from bank_loan

-- 6.Finding Good Loan Percentage

SELECT ROUND(100.0 * COUNT(*) FILTER (
    WHERE loan_status IN ('Fully Paid', 'Current')
) / NULLIF(COUNT(*), 0), 2) AS good_loan_percentage
FROM bank_loan;

-- 7.Finding Good Loan Applications

select count(id) as good_loan_applications from bank_loan where loan_status = 'Fully Paid' or loan_status = 'Current';

-- 8.Finding Good Loan Funded Amount

select sum(loan_amount) as good_loan_funded_amount from bank_loan  where loan_status = 'Fully Paid' or loan_status = 'Current';

-- 9. Total payment amount recorded for good-loan records

select sum(total_payment) as good_loan_received_amount from bank_loan where loan_status = 'Fully Paid' or loan_status = 'Current';

-- 10.Finding Bad Loan Percentage

SELECT ROUND(100.0 * COUNT(*) FILTER (
    WHERE loan_status = 'Charged Off'
) / NULLIF(COUNT(*), 0), 2) AS bad_loan_percentage
FROM bank_loan;

-- 11.Finding Bad Loan Applications

select count(id) as bad_loan_applications from bank_loan where loan_status = 'Charged Off';

-- 12.Finding Bad Loan Funded Amount

select sum(loan_amount) as bad_loan_funded_amount from bank_loan where loan_status = 'Charged Off';

-- 13. Total payment amount recorded for bad-loan records

select sum(total_payment) as bad_loan_received_amount from bank_loan where loan_status = 'Charged Off';

-- 14.Finding Loan status Grid Query

select loan_status,count(id) as total_applications,sum(total_payment) as total_amount_received,
sum(loan_amount) as total_funded_amount,round(avg(int_rate*100)::numeric,2) as avg_interest_rate,
round(avg(dti*100)::numeric,2) as DTI from bank_loan group by loan_status;

-- 15.Finding Monthly trends

SELECT DATE_TRUNC('month', issue_date)::date AS issue_month,
       COUNT(*) AS total_applications,
       SUM(loan_amount) AS total_funded_amount,
       SUM(total_payment) AS total_payment_recorded_for_issued_loans
FROM bank_loan
GROUP BY 1
ORDER BY 1;

-- 16.Findind Regional Analysis by state query

select address_state,count(id) as total_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_received_amount from bank_loan
group by 1 order by 2 desc;

-- 17. Loan Term Analysis
SELECT term,
       COUNT(*) AS total_applications,
       SUM(loan_amount) AS total_funded_amount,
       SUM(total_payment) AS total_payment_recorded
FROM bank_loan
GROUP BY term
ORDER BY term;

-- 18.Findind Loan purpose Analysis

select purpose,count(id) as total_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_received_amount from bank_loan
group by 1 order by 1 desc;

-- 19.Finding Home Owner ship Analysis

select home_ownership,count(id) as total_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_received_amount from bank_loan
group by 1 order by 1 desc;

