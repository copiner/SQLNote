---10


select a.account_id, c.cust_id
from account a
inner join customer c on a.cust_id = c.cust_id;


select a.account_id, b.cust_id, b.name
from account a inner join business b
on a.cust_id = b.cust_id;

select a.account_id, a.cust_id, b.name
from account a
left outer join business b
on a.cust_id = b.cust_id;

select a.account_id, a.cust_id, i.fname, i.lname
from account a left outer join individual i
on a.cust_id = i.cust_id;

select c.cust_id, b.name from customer c
right outer join business b
on c.cust_id = b.cust_id;


select a.account_id, a.product_cd, concat(i.fname, ' ', i.lname) person_name,
b.name business_name
from account a left outer join individual i
on a.cust_id = i.cust_id
left outer join business b
on a.cust_id = b.cust_id;


select a.account_id, a.product_cd, concat(i.fname,' ', i.lname) person_name
from account a left outer join individual i
on a.cust_id = i.cust_id;


select a.account_id, a.product_cd, b.name business_name
from account a left outer join business b
on a.cust_id = b.cust_id;

select account_ind.account_id, account_ind.cust_id, account_ind.product_cd,
account_ind.person_name, b.name business_name
from
(select a.account_id, a.product_cd, a.cust_id,
	concat(i.fname,' ',i.lname) person_name
	from account a left outer join individual i
	on a.cust_id = i.cust_id) account_ind
left outer join business b
on account_ind.cust_id = b.cust_id;

select e.fname, e.lname, e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
from employee e inner join employee e_mgr
on e.superior_emp_id = e_mgr.emp_id;

select e.fname, e.lname, e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
from employee e left outer join employee e_mgr
on e.superior_emp_id = e_mgr.emp_id;

select e.fname, e.lname, e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
from employee e right outer join employee e_mgr
on e.superior_emp_id = e_mgr.emp_id;


select pt.name, p.product_cd, p.name
from product p cross join product_type pt;

select p.product_cd, p.name, a.account_id
from product p
left outer join account a
on p.product_cd = a.product_cd;

select p.product_cd, p.name, a.account_id
from account a 
right outer join product p
on p.product_cd = a.product_cd;

select a.account_id, a.product_cd, i.fname, i.lname, b.name
from account a
left outer join individual i
on a.cust_id = i.cust_id
left outer join business b
on a.cust_id = b.cust_id;
