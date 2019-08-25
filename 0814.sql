select p.name product, b.name branch,
concat(e.fname, ' ', e.lname) name,
sum(a.avail_banlace) tot_deposits
from account a
inner join employee e
on a.open_emp_id = e.emp_id
inner join branch b
on a.open_branch_id = b.branch_id
inner join product p
on a.product_cd = p.product_cd
where p.product_type_cd = 'ACCOUNT'
group by p.name, b.name, e.fname, e.lname
order by 1, 2;

select product_cd, open_branch_id branch_id, open_emp_id emp_id,
sum(avail_balance) tot_deposits
from account
group by product_cd, open_branch_id, open_emp_id;

select p.name product, b.name branch,
concat(e.fname,' ',e.lname) name,
account_groups.tot_deposits
from
(select product_cd, open_branch_id branch_id, open_emp_id emp_id,
sum(avail_balance) tot_deposits
from account
group by product_cd, open_branch_id, open_emp_id
) account_groups
inner join employee e on e.emp_id = account_groups.emp_id
inner join branch b on b.branch_id = account_groups.branch_id
inner join product p on p.product_cd = account_groups.product_cd
where p.product_type_cd = 'ACCOUNT';


select open_emp_id, count(*) how_many
from account
group by open_emp_id
having count(*) = (
select max(emp_cnt.how_many)
from (
select count(*) how_many
from account
group by open_emp_id
) emp_cnt);

