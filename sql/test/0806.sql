
select cust_id, cust_type_cd, fed_id,
fed_id regexp '.{3}-.{2}-.{4}' is_ss_no_format
from customer;

select concat(fname, ' ', lname, ' has been a ',
title, ' since ', start_date) emp_narrative
from employee
where title = 'Teller' or title = 'Head Teller';

select fname ||  ' ' ||  lname || ' has been a '||
title || ' since ' ||  start_date  emp_narrative
from employee
where title = 'Teller' or title = 'Head Teller';

select insert('goodbye world', 9, 0, 'cruel ') string;

select insert('goodbye world', 1, 7, 'hello ') string;

select substring('goodbye cruel world', 9, 5);

select substr('goodbye cruel world', 9, 5);
