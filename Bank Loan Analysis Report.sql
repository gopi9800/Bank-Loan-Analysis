-- Creating table Bank_Loan

create table Bank_Loan(
id int primary key,
address_state varchar(10) not null,
applicationZ_type varchar(50) not null,
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
team varchar(50) not null,
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

-- 3.Finding Total Amount Received

select sum(total_payment) as total_amount_received from bank_loan;

-- 4.Finding Average Interest Rate

select round(avg(int_rate)::numeric*100,2) as avg_interest_rate from bank_loan;

-- 5.Average Debt to Income Ratio

select round(avg(dti)::numeric * 100,2) as debt_to_income_ratio from bank_loan

-- 6.Finding Good Loan Percentage

select (count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)*100)/
count(id) as Good_loan_percentage from bank_loan;

-- 7.Finding Good Loan Applications

select count(id) as good_loan_applications from bank_loan where loan_status = 'Fully Paid' or loan_status = 'Current';

-- 8.Finding Good Loan Funded Amount

select sum(loan_amount) as good_loan_funded_amount from bank_loan  where loan_status = 'Fully Paid' or loan_status = 'Current';

-- 9.Finding Good Loan Received Amount

select sum(total_payment) as good_loan_receivd_amount from bank_loan where loan_status = 'Fully Paid' or loan_status = 'Current';

-- 10.Finding Bad Loan Percentage

select (count(case when loan_status = 'Charged Off' then id end)*100)/count(id) || '%' as Bad_loan_percentage from bank_loan

-- 11.Finding Bad Loan Applications

select count(id) as bad_loan_applications from bank_loan where loan_status = 'Charged Off';

-- 12.Finding Bad Loan Funded Amount

select sum(loan_amount) as bad_loan_funded_amount from bank_loan where loan_status = 'Charged Off';

-- 13.Finding Bad Loan Received Amount

select sum(total_payment) as bad_loan_received_amount from bank_loan where loan_status = 'Charged Off';

-- 14.Finding Loan status Grid Query

select loan_status,count(id) as total_applications,sum(total_payment) as total_amount_received,
sum(loan_amount) as total_funded_amount,round(avg(int_rate*100)::numeric,2) as avg_interest_rate,
round(avg(dti*100)::numeric,2) as DTI from bank_loan group by loan_status;

-- 15.Finding Monthly trends

select extract(month from issue_date) as month_no,to_char(issue_date,'Mon'),count(id) as total_applications,
sum(loan_amount) as total_funded_amount,sum(total_payment) as total_received_amount from bank_loan
group by 1,2 order by 1;

-- 16.Findind Regional Analysis by state query

select address_state,count(id) as total_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_received_amount from bank_loan
group by 1 order by 2 desc;

-- 17.Finding Loan Status Analysis

select team,count(id) as total_applications,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_received_amount from bank_loan
group by 1 order by 1 desc;

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

