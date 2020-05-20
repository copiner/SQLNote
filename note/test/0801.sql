select a.account_id, a.cust_id, a.open_date, a.product_cd from account a
inner join
(select emp_id, assigned_branch_id from employee where start_date < '2007-01-01' and (title = 'Teller' or title = 'Head Teller')) e
on a.open_emp_id = e.emp_id
inner join
(select branch_id from branch where name = 'Woburn Branch') b
on e.assigned_branch_id = b.branch_id;
