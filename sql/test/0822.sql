---case

select c.cust_id, c.fed_id,
case when c.cust_type_cd = 'I'
     then concat(i.fname,' ', lname)
     when c.cust_type_cd = 'B'
     then b.name
     else 'unknown'
end name
from customer c left outer join individual i
on c.cust_id = i.cust_id
left outer join business b
on c.cust_id = b.cust_id;

