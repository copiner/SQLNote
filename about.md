
systemctl start mariadb  #启动MariaDB
systemctl stop mariadb  #停止MariaDB
systemctl restart mariadb  #重启MariaDB
systemctl enable mariadb  #设置开机启动


首次安装需要进行数据库的配置，命令都和mysql的一样

```
mysql_secure_installation
```

```

MariaDB [(none)]> use mysql;

MariaDB [mysql]> select host, user from user;
```