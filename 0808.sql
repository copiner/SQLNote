
select open_emp_id
from account
group by open_emp_id;

select open_emp_id, count(*) how_many
from account
group by open_emp_id;

select open_emp_id, count(*) how_many
from account
group by open_emp_id
having count(*) > 4;



select avail_balance,
avail_balance,
avail_balance,
avail_balance
from account
where product_cd = 'CHK';



select max(avail_balance) max_balance,
min(avail_balance) min_balance,
avg(avail_balance) avg_balance,
sum(avail_balance) tot_balance,
count(*) num_accounts
from account
where product_cd = 'CHK';
