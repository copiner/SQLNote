
select product_cd,
max(avail_balance) max_balance,
min(avail_balance) min_balance,
avg(avail_balance) avg_balance,
sum(avail_balance) tot_balance,
count(*) num_accounts
from account
group by product_cd;


select account_id, open_emp_id
from account
order by open_emp_id;

select count(open_emp_id)
from account;

select count(distinct open_emp_id)
from account;

select MAX(pending_balance - avail_balance) max_uncleared
from account;

---

create table number_tbl
(val smallint);

desc number_tbl;

insert into number_tbl values(1);

insert into number_tbl values(3);

insert into number_tbl values(5);

select
count(*) num_rows,---3
count(val) num_vals,---3
sum(val) total,
max(val) max_val,
avg(val) avg_val
from number_tbl;

insert into number_tbl values(null);

select
count(*) num_rows,---4
count(val) num_vals,---3
sum(val) total,
max(val) max_val,
avg(val) avg_val
from number_tbl;


select product_cd, sum(avail_balance) prod_balance
from account
group by product_cd;

select product_cd, open_branch_id, sum(avail_balance) tot_balance
from account
group by product_cd, open_branch_id;

select extract(year from start_date) year, count(*) how_many
from employee
group by extract(year from start_date);

select product_cd, sum(avail_balance) prod_balance
from account
where status = 'active'
group by product_cd
having sum(avail_balance) >= 10000;


select product_cd, sum(avail_balance) prod_balance
from account
where status = 'active'
group by product_cd
having min(avail_balance) >= 1000
and max(avail_balance) <= 10000;

select product_cd, open_branch_id, sum(avail_balance) tot_balance, count(*) pnum
from account
group by product_cd, open_branch_id
having pnum > 1
order by tot_balance desc;

