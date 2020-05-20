### MySQL——约束(constraint)详解

#### 一、什么是约束

约束英文：constraint

约束实际上就是表中数据的限制条件

#### 二、约束作用

表在设计的时候加入约束的目的就是为了保证表中的记录完整和有效

比如name字段中要让其用户名不重复，这就需要添加约束。或者必须注册的时候需要添加邮箱等

#### 三、约束种类

非空约束(not null)

唯一性约束(unique)

主键约束(primary key) PK

外键约束(foreign key) FK

检查约束(目前MySQL不支持、Oracle支持)

#### 四、非空约束

用not null约束的字段不能为null值，必须给定具体的数据

创建表，给字段添加非空约束（创建用户表，用户名不能为空）
```shell
mysql> create table t_user(
    -> id int(10),
    -> name varchar(32) not null
    -> );
Query OK, 0 rows affected (0.08 sec)
```
如果没有插入name字段数据，则会报错
```
mysql> insert into t_user (id) values(1);
ERROR 1364 (HY000): Field 'name' doesn't have a default value
```

#### 五、唯一性约束
unique约束的字段，具有唯一性，不可重复，但可以为null

创建表，保证邮箱地址唯一(列级约束)
```
mysql> create table t_user(
    -> id int(10),
    -> name varchar(32) not null,
    -> email varchar(128) unique
    -> );
Query OK, 0 rows affected (0.03 sec)
```
1、表级约束

```
mysql> create table t_user(
    -> id int(10),
    -> name varchar(32) not null,
    -> email varchar(128），
    -> unique(email)
    -> );
```
如果插入相同email会报错

```
mysql> insert into t_user(id,name,email) values(1,'xlj','810023499@qq.com');
Query OK, 1 row affected (0.00 sec)

mysql> insert into t_user(id,name,email) values(2,'jay','810023499@qq.com');
ERROR 1062 (23000): Duplicate entry '810023499@qq.com' for key 'email'
```

2、使用表级约束，给多个字段联合约束

联合约束，表示两个或以上的字段同时与另一条记录相等，则报错
```
mysql> create table t_user(
    -> id int(10),
    -> name varchar(32) not null,
    -> email varchar(128),
    -> unique(name,email)
    -> );
Query OK, 0 rows affected (0.01 sec)
```
插入第一条数据
```
mysql> insert into t_user(id,name,email) values(1,'xxx','qq.com');
Query OK, 1 row affected (0.05 sec)
```
插入第二条数据如果是与联合字段中的一条相同另一条相同，也是可以的
```
mysql> insert into t_user(id,name,email) values(2,'mmm','qq.com');
Query OK, 1 row affected (0.05 sec)
```
插入第三条数据，如果与联合字段都相同，则报错
```
mysql> insert into t_user(id,name,email) values(3,'mmm','qq.com');
ERROR 1062 (23000): Duplicate entry 'mmm-qq.com' for key 'name'
```
3、表级约束可以给约束起名字(方便以后通过这个名字来删除这个约束)
```
mysql> create table t_user(
    -> id int(10),
    -> name varchar(32) not null,
    -> email varchar(128),
    -> constraint t_user_email_unique unique(email)
    -> );
Query OK, 0 rows affected (0.06 sec)

```
constraint是约束关键字，t_user_email_unique自己取的名字

#### 六、主键约束(primary key)PK
表设计时一定要有主键

1、主键涉及术语

主键约束、主键字段、主键值

2、以上三种术语关系

表中的某个字段添加主键约束后，该字段为主键字段，主键字段中出现的每一个数据都称为主键值

3、主键约束与“not null unique”区别

给某个字段添加主键约束之后，该字段不能重复也不能为空，效果和”not null unique”约束相同，但是本质不同。

主键约束除了可以做到”not null unique”之外，还会默认添加”索引——index”

4、一张表应该有主键字段，如果没有，表示该表无效

主键值：是当前行数据的唯一标识、是当前行数据的身份证号

即使表中两行记录相关数据相同，但由于主键值不同，所以也认为是两行不同的记录

5、按主键约束的字段数量分类

无论是单一主键还是复合主键，一张表主键约束只能有一个(约束只能有一个，但可以作用到好几个字段)

单一主键：给一个字段添加主键约束

复合主键：给多个字段联合添加一个主键约束(只能用表级定义)

单一主键(列级定义)
```
mysql> create table t_user(
    -> id int(10) primary key,
    -> name varchar(32)
    -> );
Query OK, 0 rows affected (0.07 sec)
```

单一主键(表级定义)
```
mysql> create table t_user(
    -> id int(10),
    -> name varchar(32) not null,
    -> constraint t_user_id_pk primary key(id)
    -> );
Query OK, 0 rows affected (0.01 sec)

```
复合主键(表级定义)

```
mysql> create table t_user(
    -> id int(10),
    -> name varchar(32) not null,
    -> email varchar(128) unique,
    -> primary key(id,name)
    -> );
Query OK, 0 rows affected (0.05 sec)
```

6、在MySQL数据库提供了一个自增的数字，专门用来自动生成主键值，主键值不用用户维护，自动生成，自增数从1开始，以1递增(auto_increment)
```
mysql> create table t_user(
    -> id int(10) primary key auto_increment,
    -> name varchar(32) not null
    -> );
Query OK, 0 rows affected (0.03 sec)

```

插入两行记录，id主键值会自动增加
```
mysql> insert into t_user(name) values('jay');
Query OK, 1 row affected (0.04 sec)

mysql> insert into t_user(name) values('man');
Query OK, 1 row affected (0.00 sec)


mysql> select * from t_user;
+----+------+
| id | name |
+----+------+
|  1 | jay  |
|  2 | man  |
+----+------+
2 rows in set (0.00 sec)

```
#### 七、外键约束(foreign key)FK

只能是表级定义（如以下例子）
```
foreign key(classno) references t_class(cno)
```

什么是外键

若有两个表A、B，id是A的主键，而B中也有id字段，则id就是表B的外键，外键约束主要用来维护两个表之间数据的一致性。
A为基本表，B为信息表

1、外键涉及到的术语

外键约束、外键字段、外键值

2、外键约束、外键字段、外键值之间的关系

某个字段添加外键约束之后，该字段称为外键字段，外键字段中每个数据都是外键值

3、按外键约束的字段数量分类

单一外键：给一个字段添加外键约束

复合外键：给多个字段联合添加一个外键约束

4、一张表可以有多个外键字段（与主键不同）

`设计数据库表，用来存储学生和班级信息`

方案一：将学生信息和班级信息存储到一张表
```
sno     sname      classno      cname
1       jay         100         浙江省第一中学高三1班
2       lucy        100         浙江省第一中学高三1班
3       king        200         浙江省第一中学高三2班
```
缺点：数据冗余，比如cname字段的数据重复太多

方案二：将学生信息和班级信息分开两张表存储

学生表（添加单一外键）
```
sno(pk)     sname       classno(fk)
1           jack        100
2           lucy        100
3           king        200
```
班级表
```
cno(pk)     cname
100         浙江省第一中学高三1班
200         浙江省第一中学高三2班
```

`为了保证学生表中的classno字段中的数据必须来自于班级表中的cno字段中的数据，有必要给学生表中的classno字段添加外键约束`

注意

外键值可以为null

外键字段去引用一张表的某个字段的时候，被引用的字段必须具有unique约束

有了外键引用之后，表分为父表和子表 

	班级表：父表
	
	学生表：子表
	
创建先创建父表

删除先删除子表数据

插入先插入父表数据

#### 实例
存储学生班级信息
```
mysql> drop table if exists t_student;
mysql> drop table if exists t_class;

mysql> create table t_class(
    -> cno int(10) primary key,
    -> cname varchar(128) not null unique
    -> );

mysql> create table t_student(
    -> sno int(10) primary key auto_increment,
    -> sname varchar(32) not null,
    -> classno int(3),
    -> foreign key(classno) references t_class(cno)
    -> );

mysql> insert into t_class(cno,cname) values(100,'aaaaaaxxxxxx');
mysql> insert into t_class(cno,cname) values(200,'oooooopppppp');
mysql> insert into t_student(sname,classno) values('jack',100);
mysql> insert into t_student(sname,classno) values('lucy',100);
mysql> insert into t_student(sname,classno) values('king',200);

```
班级表t_class
```
mysql> select * from t_class;
+-----+--------------+
| cno | cname        |
+-----+--------------+
| 100 | aaaaaaxxxxxx |
| 200 | oooooopppppp |
+-----+--------------+

```
学生表t_student

```

mysql> select * from t_student;
+-----+-------+---------+
| sno | sname | classno |
+-----+-------+---------+
|   1 | jack  |     100 |
|   2 | lucy  |     100 |
|   3 | king  |     200 |
+-----+-------+---------+
```

上表中找出每个学生的班级名称
```

mysql> select s.*,c.* from t_student s join t_class c on s.classno=c.cno;
+-----+-------+---------+-----+--------------+
| sno | sname | classno | cno | cname        |
+-----+-------+---------+-----+--------------+
|   1 | jack  |     100 | 100 | aaaaaaxxxxxx |
|   2 | lucy  |     100 | 100 | aaaaaaxxxxxx |
|   3 | king  |     200 | 200 | oooooopppppp |
+-----+-------+---------+-----+--------------+

```

#### 结论

以上是典型的一对多的设计：在多个地方加外键(子表加外键)