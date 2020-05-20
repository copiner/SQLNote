
###启动MariaDB
systemctl start mariadb

###停止MariaDB
systemctl stop mariadb

###重启MariaDB
systemctl restart mariadb

###设置开机启动
systemctl enable mariadb  


首次安装需要进行数据库的配置，命令都和mysql的一样

```
mysql_secure_installation
```

```

MariaDB [(none)]> use mysql;

MariaDB [mysql]> select host, user from user;
```





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

小案例
name  : char(3)
age   : tinyint unsigned
email : varchar(30)
tel   : char(11)
intro : varchar(1000)
salary: deciaml(7,2)
graduate  : date

create table stuinfo(
id int primary key auto_increment,
name char(3) not null default '',
age tinyint unsigned not null default 0,
email varchar(30) not null default '',
tel char(11) not null default '',
salary decimal(7, 2) not null default '6000.00',
graduate date not null default '2015-10-10'
)charset utf8;

insert into stuinfo
(name,age,email,tel,graduate)
values
('Fra',18,'fra@fra.com','13113113131','2016-06-10');
//and
insert into stuinfo
values
(3,'cal',21,'calcal@cal.com','13134533543','7000.00','2015-07-10');
//and
insert into stuinfo
(name,age,tel)
values
('jac',23,'18666533543'),
('ros',21,'18677533543'),
('tom',25,'18699533543');

update stuinfo
set
email="jac@jack.com",
salary='3999.00'
where id=4;

delete from stuinfo where id=6;

//
invest : decimal(6,2)
alter table stuinfo add invest decimal(6,2) unsigned not null default '1000.00';

子句
where
group by
having
order by
limit

where
<
<=
==
in
!= <>
>=
>
between

NOT !
OR ||
AND &&


select * from stuinfo;
select name,age,tel from stuinfo;
select id,salary>6000 from stuinfo;
select name,age,tel from stuinfo where salary>6000;
select name,age,tel from stuinfo where salary-invest>6000;
select name,age,tel from stuinfo where salary-invest>6000;
select name,age,tel from stuinfo where salary in (6000,8000);
select id,name,age,tel from stuinfo where salary between 6000 and 8000;
select id,name,age,tel from stuinfo where salary > 6000 and salary < 8000;
select id,name,age,tel from stuinfo where salary = 6000 or invest = 2000;

通配符 %  _

select id,name,age,tel from stuinfo where name like 'r%';
select id,name,age,tel from stuinfo where name like 'r__';


group by

max
min
sum
avg
count

select id,salary from stuinfo;
select max(salary) from stuinfo;
select min(salary) from stuinfo;
select age,max(salary) from stuinfo group by age;

select sum(salary) from stuinfo;
select avg(salary) from stuinfo;
select count(*) from stuinfo;
select age,avg(salary) from stuinfo group by age;
select age,count(salary) from stuinfo group by age;

select id,salary-invest from stuinfo;
select age,sum(salary-invest) from stuinfo group by age;

//alias
select age,sum(salary-invest) as total from stuinfo group by age;

having
select id,salary-invest as income from stuinfo having income>6000;
select id,salary-invest as income from stuinfo where age<20 having income>6000;
select age,sum(salary-invest) as income from stuinfo group by age having income>10000;

//练习
create table stu(
name char(10),
subject char(10),
score tinyint
)charset utf8;

insert into stu
values
('calvin','Math',90),
('calvin','English',50),
('calvin','Science',40),
('francis','math',45),
('francis','geo',55),
('Anna','math',90);
查询两门及两门以上不及格学生的平均成绩
select name,score<60 from stu;
select name,sum(score<60) from stu group by name;
select name,sum(score<60),avg(score) as av from stu group by name;
select name,sum(score<60) as su,avg(score) as av from stu group by name having su>=2;
//利用子查询
select name,count(*) as total from stu where score<60 group by name having total>=2;
select name from (select name,count(*) as total from stu where score<60 group by name having total>=2) as temp;
select name,avg(score) from stu where name in (select name from (select name,count(*) as total from stu where score<60 group by name having total>=2) as temp) group by name;


排序 order by
select name,salary from stuinfo order by salary;
select name,salary from stuinfo order by salary desc;
select name,salary from stuinfo order by salary asc;
select name,age,salary from stuinfo order by age,salary;


limit 限制
limit [offset,]N
offset 偏移量
N 取条目数量

select name,salary from stuinfo order by salary desc limit 3,3;
select name,salary from stuinfo order by salary desc limit 0,3;

小练习 每个年龄工资最高的条目
select name,age,salary from stuinfo group by age;
select age,salary from stuinfo order by age,salary desc;
select * from (select age,salary from stuinfo order by age,salary desc) as temp group by age;


子查询
where
from
exists

select name,age,salary from stuinfo where age = (select max(age) from stuinfo);

select * from (select age,salary from stuinfo order by age,salary desc) as temp group by age;

select age from stuinfo where exists(select * from stuin where stuin.age = stuinfo.age);


union:联合 不同表之间
select name,salary from stuinfo where salary > 8000;
select name,salary from stuinfo where salary < 5000;
select name,salary from stuinfo where salary > 8000 union select name,salary from stuinfo where salary < 5000;

小案例
create table ta(
id char(1),
num int
);
insert into ta
values
('a', 5),
('b', 10),
('c', 15),
('d', 20);

create table tb(
id char(1),
num int
)

insert into tb
values
('a', 50),
('s', 55),
('d', 60),
('f', 65);

select * from ta union select * from tb;
select id,sum(num) from (select * from ta union select * from tb) as temp group by id;

update tb set num=20 where id = 'd';

如果不同的语句中取出的行，有完全相同的，相同的行将会合并。
select * from ta union select * from tb;
或者不合并
select * from ta union all select * from tb;

注意 : 与order by limit 连用需用括号来表明作用范围，以免出错。


select * from ta,tb;
左连接
select * from ta left join tb on ta.id = tb.id;
右连接
select * from ta right join tb on ta.id = tb.id;
内链接
select * from ta inner join tb on ta.id = tb.id;

小案例
create table boy(
name char(10),
flower char(10)
) charset utf8;

insert into boy
values
('Calvin',"a rose"),
('Couke',"a apple"),
('Jay',"a sing"),
('Jack',"a lover"),
('Tanna',"a dog");

create table girl(
name char(10),
flower char(10)
) charset utf8;

insert into girl
values
('Avle',"a rose"),
('Anna',"a apple"),
('Duan',"a singer"),
('Mury',"a singer"),
('Milk',"a cat");

select boy.*, girl.* from boy left join girl on boy.flower=girl.flower;
select boy.*, girl.* from girl right join boy on boy.flower=girl.flower;

select boy.*, girl.* from girl left join boy on boy.flower=girl.flower;
select boy.*, girl.* from boy right join girl on boy.flower=girl.flower;

select boy.*, girl.* from boy inner join girl on boy.flower=girl.flower;

select boy.*, girl.* from girl left join boy on boy.flower=girl.flower union select boy.*, girl.* from girl right join boy on boy.flower=girl.flower;

清空表
truncate stuinfo
end
