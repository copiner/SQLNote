
show table status like 'transaction' \G

alert table transaction engine = InnoDB;


savepoint my_savepoint;

rollback to savepoint my_savepoint;

---
start transaction;

update product
set date_retired = current_timestamp()
where product_cd = 'XYZ';

savepoint before_close_accounts;

update account

set status = 'CLOSE', close_date = current_timestamp(),
    last_activity_date = current_timestamp()
where product_cd = 'xyz';

roolback to savepoint before_close_accounts;
commit;

---
