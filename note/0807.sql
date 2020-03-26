
select account_id, sign(avail_balance),abs(avail_balance)
from account;

select str_to_date('September 17,2008','%M%d,%Y');

select substring('Please find the substring in this string', 17,1);

select abs(-25.76823), sign(-25.76823), round(-25.76823,2);

select current_date(), current_time(), current_timestamp();

select dayname('2019-08-09');

select extract(Month from current_date());

select extract(Year from current_date());
