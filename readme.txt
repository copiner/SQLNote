登陆
mysql -h localhost -u root -p

exit

查看数据库
show databases

创建数据库
create database  databasename

删除数据库
drop database databasename

使用某个数据库
use databasename

创建表
create table class(
stu int,
name varchar(20),
age int,
area varchar(20)
);

查看表
show tables;

重命名表
rename table oldname to newname;

删除表
drop table tablename;

查看表信息
desc table tablename;

修改表
alter table msg add age tinyint unsigned;

表的增删改查
insert into msg(id, title, name, content)values(1,"big","calvin","hello");

insert into msg(id, title, name, content)
values(1,"big","calvin","hello"),(2,"small","francis","hi");

update msg set id = 6, content="welcome" where name = "calvin";

delete from msg where id = 2;

select * from msg;
select id,title from msg;
select * from from where id > 1;
select name, content from msg where id >1;

存储范围

整型
Tinyint:1字节，8位  无符号0~255(0~2^8-1)，有符号(默认) -128~127(2^7-1)，最高位是符号位  (补码)
Smallint:2字节
Mediumint:3字节
Int:4字节
bigint:
整型属性：例如
int(M) unsigned zerofill
M : 宽度，在zerofill(0填充)时起作用

unsigned:无符号类型
alter table msg add age tinyint unsigned;

zerofill: 0填充 非负 默认unsigned
alter table msg add num tinyint(5) unsigned zerofill;

列声明默认值
not null default 0
alter table msg add sex tinyint not null default 0;

浮点型
Float(M,D), 4字节或者8字节
M:精度
D:小数位数
float(6,2)  : -9999.99~9999.99

create table goods(
name varchar(10) not null default "",
price float(6,2) not null default 0.00
)charset utf8;

insert into goods(name,price)values("cookie","12.789");

定点型
decimal(M,D), 4字节或者8字节
alter table goods add decimalprice decimal(6,3) not null default 0.0;

字符型
char:char(M),M代表可容纳的字符数,(占空间)，0<=M<=255
其占空间大小固定，若内容小于固定大小，仍占固定大小
varchar: varchar(M),M代表可容纳的字符数，(占空间)， 0<=M<=65535
占空间大小不固定，若内容小于固定大小，按实际大小占居空间。
text:

日期时间型(注意范围)
Year        1990 (1901~2155)
Date        1990-10-01
Time        14:20:52
Datetime    1990-02-11 08:00:00

create table y(
ye year(4)
);
insert into y values('1990');

create table d(
de date
);
insert into d values('1990-10-01');

create table t(
ti time
);
insert into t values('13:14:52');

create table dt(
dti datetime not null default '1000-01-01 00:00:00'
);
insert into dt(dti)values('1990-10-01 13:14:52');

时间戳
1970-01-01 00:00:00 距离当今的秒数
用int型存储时间戳

枚举类型
enum







end
