
select 'TND' type_cd, cust_id, lname name
from individual
union all
select 'bus' type_cd, cust_id, name
from business;

---
union all
select 'bus' type_cd, cust_id, name
from business;

select emp_id
from employee
where assigned_branch_id = 2
and (title = 'Teller' or title = 'Head Teller')
union all
select distinct open_emp_id
from account
where open_branch_id = 2;



select emp_id, assigned_branch_id
from employee
where title = 'Teller'
union
select open_emp_id, open_branch_id
from account
where product_cd = 'SAV'
order by emp_id;


select cust_id
from account
where product_cd in ('SAV','MM')
union all
select a.cust_id
from account a
inner join branch b
on a.open_branch_id = b.branch_id
where b.name = 'Woburn Branch'
union
select cust_id
from account
where avail_balance between 500 and 2500;


select  fname, lname
from individual
union
select fname, lname
from employee
