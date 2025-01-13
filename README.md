# SymCom Synonym Tool

This tool allows to manage synonym references inside of medical symptoms.

## Runnining

To start this, it is necessary to first start MariaDB and afterwards start the backend itself.

### Start Database

To start this, first start MariaDB:

docker run --name mariadb-container -e MARIADB_ROOT_PASSWORD=my-secret-pw -p 3306:3306 -d mariadb:11.4.3

Wait until MariaDB is started (~5 seconds on current hardware).

Afterwards, initialize the database:

``` 
mysql -P 3306 -uroot -pmy-secret-pw --execute="CREATE USER 'symcomUser'@'%' IDENTIFIED BY 'symcom';"
mysql -P 3306 -uroot -pmy-secret-pw --execute="CREATE DATABASE synonym_db_test;"
mysql -P 3306 -uroot -pmy-secret-pw --execute="GRANT ALL PRIVILEGES ON synonym_db_test.* TO 'symcomUser'@'%';"
```

Finally, get the `IPAddress` of the created container using `docker inspect mariadb-container` and save the address into `symcom-synonym-tool/config/route.php` (for example changing `$dbHost = 'localhost';` to `$dbHost = '172.17.0.3:3306';`, where you'll need to add 3306 to the IP (if you didn't change the port).

### Start Backend

To start the backend, execute `docker build -t "synonym" . && docker run -p 80:80 -d synonym`. Afterwards, you can access the system in your browser using http://localhost/symcom-synonym-tool/login.php.
