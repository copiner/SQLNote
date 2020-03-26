
select account_id, product_cd, cust_id, avail_balance
from account
where open_emp_id <>
(select e.emp_id
from employee e inner join branch b
on e.assigned_branch_id = b.branch_id
where e.title = 'Head Teller' and b.city = 'Woburn');

---error
select account_id, product_cd, cust_id, avail_balance
from account
where open_emp_id <>
(select e.emp_id
from employee e inner join branch b
on e.assigned_branch_id = b.branch_id
where e.title = 'Teller' and b.city = 'Woburn');

select branch_id, name, city
from branch
where name in ('Headquarters','Quincy Branch');

select emp_id, fname, lname, title
from employee
where emp_id in (
select superior_emp_id
from employee);

select emp_id, fname, lname, title
from employee
where emp_id in (
select distinct superior_emp_id
from employee);


select emp_id, fname, lname, title
from employee
where emp_id not in (
select superior_emp_id
from employee
where superior_emp_id is not null);

select emp_id, fname, lname, title
from employee
where emp_id not in (1,2,null);


select emp_id, fname, lname, title
from employee
where emp_id <> all(
select superior_emp_id
from employee
where superior_emp_id is not null);

select account_id, cust_id, product_cd, avail_balance
from account
where avail_balance < all (
select a.avail_balance
from account a
inner join individual i
on a.cust_id = i.cust_id
where i.fname = 'Frank' and i.lname = 'Tucker');


select account_id, cust_id, product_cd, avail_balance
from account
where avail_balance > any (
select a.avail_balance
from account a
inner join individual i
on a.cust_id = i.cust_id
where i.fname = 'Frank' and i.lname = 'Tucker');

select account_id, product_cd, cust_id
from account
where open_branch_id = (
select branch_id
from branch
where name = 'Woburn Branch')
and open_emp_id
in (
select emp_id
from employee
where title = 'Teller' or title = 'Head Teller');


select account_id, product_cd, cust_id,open_branch_id, open_emp_id
from account
where (open_branch_id, open_emp_id)
in (
select b.branch_id, e.emp_id
from branch b
inner join employee e
on b.branch_id = e.assigned_branch_id
where b.name = 'Woburn Branch'
and (e.title = 'Teller' or e.title = 'Head Teller'));

select c.cust_id, c.cust_type_cd, c.city
from customer c
where 2 = (
select count(*)
from account a
where a.cust_id = c.cust_id);

select c.cust_id, c.cust_type_cd, c.city
from customer c
where (
select sum(a.avail_balance)
from account a
where a.cust_id = c.cust_id)
between 5000 and 10000;


select a.account_id, a.product_cd, a.cust_id, a.avail_balance
from account a
where exists (
select 1 from transaction t
where t.account_id = a.account_id
and t.txn_date = '2002-09-30');

select a.account_id, a.product_cd, a.cust_id
from account a
where not exists (
select 1
from buiness b
where b.cust_id = a.cust_id);


select d.dept_id, d.name, e_cnt.how_many num_empoyees
from department d
inner join
(select dept_id, count(*) how_many
from employee
group by dept_id) e_cnt
on d.dept_id = e_cnt.dept_id;


select 'Samll Fry' name, 0 low_limit, 4999.99 high_limit
union all
select 'Average Joes' name, 5000 low_limit, 9999.99 high_limit
union all
select 'Heavy Hitters' name, 10000 low_limit, 9999999.99 high_limit;

select sum(a.avail_balance) cust_balance
from account a
inner join product p
on a.product_cd = p.product_cd
where p.product_type_cd = 'ACCOUNT'
group by a.cust_id;


select group.name, count(*) num_customers
from
(select sum(a.avail_balance) cust_balance
from account a
inner join product p
on a.product_cd = p.product_cd
where p.product_type_cd = 'ACCOUNT'
group by a.cust_id
) cust_rollup
inner join
(select 'Samll Fry' name, 0 low_limit, 4999.99 high_limit
union all
select 'Average Joes' name, 5000 low_limit, 9999.99 high_limit
union all
select 'Heavy Hitters' name, 10000 low_limit, 9999999.99 high_limit
) groups
on cust_rollup.cust_balance
between groups.low_limit and groups.high_limit
group by groups.name;


