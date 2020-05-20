select c.cust_id, c.fed_id,
case when c.cust_type_cd = 'I' then
     (select concat(i.fname,' ',i.lname)
     from individual i
     where i.cust_id = c.cust_id)
     when c.cust_type_cd = 'B' then
     (select b.name
     from business b
     where b.cust_id = c.cust_id)
     else 'nonono'
end name
from customer c;

select year(open_date) year, count(*) how_many
from account
where open_date > '1999-12-31'
and open_date < '2006-01-01'
group by year(open_date);

select
sum(case
	when extract(year from open_date) = 2000 then 1
	else 0
    end) year_2000,
sum(case
	when extract(year from open_date) = 2001 then 1
	else 0
    end) year_2001,
sum(case
	when extract(year from open_date) = 2002 then 1
	else 0
    end) year_2002,
sum(case
	when extract(year from open_date) = 2003 then 1
	else 0
    end) year_2003,
sum(case
	when extract(year from open_date) = 2004 then 1
	else 0
    end) year_2004,
sum(case
	when extract(year from open_date) = 2005 then 1
	else 0
    end) year_2005
from account
where open_date > '1999-12-31' and open_date < '2006-01-01';


select c.cust_id,c.fed_id,c.cust_type_cd,

case when exists(
    select 1 from account a
    where a.cust_id = c.cust_id
    and a.product_cd = 'CHK') then 'Y'
    else 'N'
end has_checking,

case when exists(
    select 1 from account a
    where a.cust_id = c.cust_id
    and a.product_cd = 'SAV') then 'Y'
    else 'N'
end has_savings

from customer c;

select c.cust_id, c.fed_id, c.cust_type_cd,
case (select count(*) from account a
     where a.cust_id = c.cust_id)
     when 0 then 'none'
     when 1 then '1'
     when 2 then '2'
     else '3+'
end num_accounts
from customer c;
    
    

select a.cust_id, a.product_cd, a.avail_balance,
prod_tots.tot_balance, a.avail_balance /
case
	when prod_tots.tot_balance = 0 then 1
	else prod_tots.tot_balance
end percent_of_total
from account a inner join
(select a.product_cd, sum(a.avail_balance) tot_balance
from account a
group by a.product_cd) prod_tots
on a.product_cd = prod_tots.product_cd;

select emp_id,
case
	when title like '%President' or title = 'Loan Manager'
	     or title = 'Treasurer'
	then 'Management'
	when title like '%Teller' or title = 'Operations Manager'
	then 'Operations'
	else 'nonono'
end header
from employee;


select
sum(case
	when open_branch_id = '1'
	then 1
	else 0
     end ) branch_1,
sum(case
	when open_branch_id = '2'
	then 1
	else 0
     end ) branch_2,
sum(case
	when open_branch_id = '3'
	then 1
	else 0
     end ) branch_3,
sum(case
	when open_branch_id = '4'
	then 1
	else 0
     end ) branch_4
from account;
     

     
