
alert table department
add index dept_name_idx (name);

---or
create index dept_name_idx
on department (name);


show index from department \G;

alert table department drop index dept_name_idx;

---
drop index dept_name_idx; --Oracle


alert table department
add unique dept_name_idx (name);

---Orecle
create unique index dept_name_idx
on department (name);



---constraint

create table product
(product_cd varchar(10) NOT NULL,
 name varchar(50) NOT NULL,
 product_type_cd varchar(10) not null,
 date_offered date,
 date_retired DATE,
 	      constraint fk_product_type foreign key (product_type_cd)
	      references product_type (peoduct_type_cd),
	      constraint pk_product primary key(product_cd)
);



---or
alert table product
add constraint fk_product
primary key (product_cd);


alert table product
add constraint fk_product_type_cd
foreign key (product_type_cd)
references product_type (product_type_cd);
---
alert table product
drop primary key;

alert table product
drop foreign key fk_product_type_cd;



select * from product;
select * from product_type;

update product
set product_type_cd = 'XYZ'
where product_type_cd = 'LOAN';

update product_type
set product_type_cd = 'XYZ'
where product_type_cd = 'LOAN';


alert table product
add constraint fk_product_type_cd foreign key (product_type_cd)
references product_type (product_type_cd)
on update cascade;


alert table product
add constraint fk_product_type_cd foreign key (product_type_cd)
references product_type (product_type_cd)
on update cascade
on delete cascade;


