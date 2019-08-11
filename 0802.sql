select a.account_id, e.emp_id, b_a.name open_branch, b_e.name emp_branch
from account a inner join branch b_a
on a.open_branch_id = b_a.branch_id
inner join employee e
on a.open_emp_id = e.emp_id
inner join branch b_e
on e.assigned_branch_id = b_e.branch_id
where a.product_cd = 'CHK';


select e.fname, e.lname, e_mgr.fname mgr_fname, e_mgr.lname mgr_lname
from employee e
inner join employee e_mgr
on e.superior_emp_id = e_mgr.emp_id;

select e.emp_id, e.fname, e.lname, e.start_date from employee e
inner join product p
on e.start_date >= p.date_offered
and e.start_date <= p.date_retired
where p.name = 'no-fee checking';


select e1.fname, e1.lname, 'vs' vs, e2.fname, e2.lname
from employee e1 inner join employee e2
---on e1.emp_id != e2.emp_id
on e1.emp_id > e2.emp_id
where e1.title = 'Teller' and e2.title = 'Teller';


select e.emp_id, e.fname, e.lname, e.dept_id emp_dept, mgr.dept_id mgr_dept
from employee e
inner join employee mgr on e.superior_emp_id = mgr.emp_id
where e.dept_id != mgr.dept_id;

select a.account_id, c.fed_id, p.name from account a
     inner join customer c
     on c.cust_id = a.cust_id
     inner join product p
     on a.product_cd = p.product_cd
     where c.cust_type_cd = 'I';
