

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

### 存储范围/类型


整型
```
Tinyint:1字节，8位  无符号0~255(0~2^8-1)，有符号(默认) -128~127(2^7-1)，最高位是符号位(补码)
Smallint:2字节
Mediumint:3字节
Int:4字节
bigint:8字节

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
```

浮点型
```
Float(M,D), 4字节或者8字节
M:精度
D:小数位数
float(6,2)  : -9999.99~9999.99

create table goods(
name varchar(10) not null default "",
price float(6,2) not null default 0.00
)charset utf8;

insert into goods(name,price)values("cookie","12.789");
```

定点型
```
decimal(M,D), 4字节或者8字节
alter table goods add decimalprice decimal(6,3) not null default 0.0;
```

字符型
```
char:
char(M),M代表可容纳的字符数,(占空间)，0<=M<=255其占空间大小固定，若内容小于固定大小，仍占固定大小，有一个最大空间限制
varchar:
varchar(M),M代表可容纳的字符数，(占空间)， 0<=M<=65535
占空间大小不固定，若内容小于固定大小，按实际大小占居空间，有一个最大空间限制


text:
tinytext:最大长度为2^8次方
text:最大长度为2^16次方
mediumtext
longtext

```

日期时间型(注意范围)
```
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
```

枚举类型
```
enum
```

创建表时，不能在同一个字段上建立两个索引(主键默认建立唯一索引)，
在需要经常查询的字段上建立索引

如：deal_id已经是主键，不能再次执行：create index tmp_table_index on tmp_table(deal_id),会报错;


### 小案例
```
name  : char(3)
age   : tinyint unsigned
email : varchar(30)
tel   : char(11)
intro : varchar(1000)
salary: deciaml(8,2)
graduate  : date
createtemp:  timestamp
updatetemp:  timestamp
```

```
create table planer(
  id int primary key auto_increment,
  name char(3) not null default '',
  age tinyint unsigned not null default 0,
  email varchar(30) not null default '',
  tel char(11) not null default '',
  salary decimal(8, 2) not null default '6000.00',
  graduate date not null default '2015-10-10',
  createtemp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'create time',
  updatetemp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'update time'
)charset utf8;
```

```
insert into planer
(name,age,email,tel,graduate)
values
('Fra',18,'sophia@sop.com','13113113131','2016-06-10');


insert into planer
values
(3,'cal',21,'calcal@cal.com','13134533543','70000.50','2015-07-10');


insert into planer
(name,age,tel)
values
('jac',23,'18666533543'),
('ros',21,'18677533543'),
('tom',25,'18699533543');

```

```
update planer
set
email="jac@jack.com",
salary='3999.00'
where id=4;

delete from planer where id=6;
```

```
invest : decimal(6,2)
alter table planer add invest decimal(6,2) unsigned not null default '1000.00' after salary;
alter table planer drop column invest;
```

子句
```
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

```

select * from planer;
select name,age,tel from planer;
select id,salary>6000 from planer;
select name,age,tel from planer where salary>6000;
select name,age,tel from planer where salary-invest>6000;
select name,age,tel from planer where salary-invest>6000;
select name,age,tel from planer where salary in (6000,8000);
select id,name,age,tel from planer where salary between 6000 and 8000;
select id,name,age,tel from planer where salary > 6000 and salary < 8000;
select id,name,age,tel from planer where salary = 6000 or invest = 2000;

通配符 %  _

```
select * from planer p where p.name like '%a%';
select * from planer p where p.name like 'a%';
select * from planer p where p.name like '%a';

select * from planer p where p.name like '__a';
select * from planer p where p.name like '_al';
```

group by

max
min
sum
avg
count

```

select id,salary from planer;
select max(salary) from planer;
select min(salary) from planer;
select age,max(salary) from planer group by age;

select sum(salary) from planer;
select avg(salary) from planer;
select count(*) from planer;
select age,avg(salary) from planer group by age;
select age,count(salary) from planer group by age;

select id,salary-invest from planer;
select age,sum(salary-invest) from planer group by age;

# alias
select age,sum(salary-invest) as total from planer group by age;
```
having
```

select id,salary-invest as income from planer having income>6000;
select id,salary-invest as income from planer where age<20 having income>6000;
select age,sum(salary-invest) as income from planer group by age having income>10000;

```

create table student(
name char(10),
subject char(10),
score tinyint
)charset utf8;

insert into student
values
('calvin','Math',90),
('calvin','English',50),
('calvin','Science',40),
('francis','Math',45),
('francis','Geography',55),
('Anna','Math',90);

查询两门及两门以上不及格学生的平均成绩

alter table student add column id int not null primary key auto_increment first;

```
select name,score<60 from student;
select name,sum(score<60) from student group by name;
select name,sum(score<60), avg(score) as av from student group by name;
select name,sum(score<60) as su, avg(score) as av from student group by name having su>=2;

select name,sum(score<60) su, avg(score) av from student group by name having su>=2;
```

利用子查询
```
select name, count(*) as total from student where score<60 group by name having total>=2;

select name from (select name,count(*) as total from student where score<60 group by name having total>=2) as temp;

select name,avg(score) from student where name in (select name from (select name,count(*) as total from student where score<60 group by name having total>=2) as temp) group by name;

```

排序 order by

```
select name,salary from planer order by salary;
select name,salary from planer order by salary desc;
select name,salary from planer order by salary asc;
select name,age,salary from planer order by age,salary;
```

limit 限制
limit [offset,]N
offset 偏移量
N 取条目数量
```
select name,salary from planer order by salary desc limit 3,3;
select name,salary from planer order by salary desc limit 0,3;
```

每个年龄工资最高的条目



```
select p.* from planer p, (select max(salary) sly, age from  planer group by age) as t
where p.salary = t.sly and p.age = t.age

```

union:联合 不同表之间

```
select name,salary from planer where salary > 8000;
select name,salary from planer where salary < 5000;
select name,salary from planer where salary > 8000 union select name,salary from planer where salary < 5000;
```

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

```
select * from ta,tb;
左连接
select * from ta left join tb on ta.id = tb.id;
右连接
select * from ta right join tb on ta.id = tb.id;
内链接
select * from ta inner join tb on ta.id = tb.id;
```

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

```
select boy.*, girl.* from boy left join girl on boy.flower=girl.flower;
select boy.*, girl.* from girl right join boy on boy.flower=girl.flower;

select boy.*, girl.* from girl left join boy on boy.flower=girl.flower;
select boy.*, girl.* from boy right join girl on boy.flower=girl.flower;

select boy.*, girl.* from boy inner join girl on boy.flower=girl.flower;

select boy.*, girl.* from girl left join boy on boy.flower=girl.flower union select boy.*, girl.* from girl right join boy on boy.flower=girl.flower;
```


清空表
truncate stuinfo
end


### sequence

drop table if exists sequence;  
create table sequence (   
  seq_name        VARCHAR(50) NOT NULL,   
  current_val     INT         NOT NULL,     
  increment_val   INT         NOT NULL   DEFAULT 1,      
  PRIMARY KEY (seq_name)
);

INSERT INTO sequence VALUES ('seq_test1_num1', '0', '1');
INSERT INTO sequence VALUES ('seq_test1_num2', '0', '2');

```

create function currval(v_seq_name VARCHAR(50))   
returns integer
begin     
    declare value integer;       
    set value = 0;       
    select current_val into value  from sequence where seq_name = v_seq_name;
   return value;
end;


select currval('seq_test1_num1');
```

```
create function nextval (v_seq_name VARCHAR(50))
    returns integer
begin
    update sequence set current_val = current_val + increment_val  where seq_name = v_seq_name;
    return currval(v_seq_name);
end;



select nextval('seq_test1_num1');

```

test
```
DROP TABLE IF EXISTS `test1`;
CREATE TABLE `test1` (
  `name` varchar(255) NOT NULL,
  `value` double(255,0) DEFAULT NULL,
  `num1` int(11) DEFAULT NULL,
  `num2` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
);



```

trigger
```

CREATE TRIGGER `TRI_test1_num1` BEFORE INSERT ON `test1` FOR EACH ROW BEGIN
set NEW.num1 = nextval('seq_test1_num1');
set NEW.num2 = nextval('seq_test1_num2');
END
```

```
INSERT INTO test1 (name, value) VALUES ('1', '111');
INSERT INTO test1 (name, value) VALUES ('2', '222');
INSERT INTO test1 (name, value) VALUES ('3', '333');
INSERT INTO test1 (name, value) VALUES ('4', '444');
```
