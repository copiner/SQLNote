

select
(select p.name from product p
where p.product_cd = a.product_cd
and p.product_type_cd = 'ACCOUNT') product,
(select b.name from branch b
where b.branch_id = a.open_branch_id) branch,
(select concat(e.fname,' ',e.lname) from employee e
where e.emp_id = a.open_emp_id) name,
sum(a.avail_balance) tot_deposits
from account a
group by a.product_cd, a.open_branch_id, a.open_emp_id
order by 1,2;

select all_prods.product, all_prods.branch,
all_prods.name, all_prods.tot_deposits
from (
select
(select p.name from product p
where p.product_cd = a.product_cd
and p.product_type_cd = 'ACCOUNT') product,
(select b.name from branch b
where b.branch_id = a.open_branch_id) branch,
(select concat(e.fname,' ',e.lname) from employee e
where e.emp_id = a.open_emp_id) name,
sum(a.avail_balance) tot_deposits
from account a
group by a.product_cd, a.open_branch_id, a.open_emp_id
) all_prods
where all_prods.product is not null
order by 1,2;

select emp.emp_id, concat(emp.fname,' ',emp.lname) emp_name,
(select concat(boss.fname,' ',boss.lname)
from employee boss
where boss.emp_id = emp.superior_emp_id) boss_name
from employee emp
where emp.superior_emp_id is not null
order by (
select boss.lname from employee boss
where boss.emp_id = emp.superior_emp_id), emp.lname;


select a.account_id,a.product_cd,a.cust_id,a.avail_balance
from account a
where a.product_cd in
(select product_cd from where product_type_cd = 'LOAN');
