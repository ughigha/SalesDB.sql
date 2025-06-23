Enter password: ********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 16
Server version: 9.3.0 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> -- 1. Create a new database named SalesDB
Query OK, 0 rows affected (0.006 sec)

mysql> CREATE DATABASE SalesDB;
ERROR 1007 (HY000): Can't create database 'salesdb'; database exists
mysql>
mysql> -- 2. Use the newly created database
Query OK, 0 rows affected (0.012 sec)

mysql> USE SalesDB;
Database changed
mysql>
mysql> -- 3. Create a table named Orders with the specified schema
Query OK, 0 rows affected (0.004 sec)

mysql> CREATE TABLE Orders (
    ->     OrderID INT PRIMARY KEY AUTO_INCREMENT,
    ->     OrderDate DATETIME,
    ->     CustomerID INT,
    ->     TotalAmount DECIMAL(10, 2) -- DECIMAL(precision, scale) for monetary values
    -> );
ERROR 1050 (42S01): Table 'orders' already exists
mysql>
mysql> -- 4. Populate the Orders table with sample data
Query OK, 0 rows affected (0.002 sec)

mysql> INSERT INTO Orders (OrderDate, CustomerID, TotalAmount) VALUES
    -> ('2023-01-15 10:00:00', 101, 250.75),
    -> ('2023-01-15 10:30:00', 102, 120.00),
    -> ('2023-01-16 11:15:00', 101, 300.50),
    -> ('2023-01-17 14:45:00', 103, 75.20),
    -> ('2023-01-18 09:00:00', 102, 450.00);
Query OK, 5 rows affected (0.047 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Optional: Verify the data
Query OK, 0 rows affected (0.003 sec)

mysql> SELECT * FROM Orders;
+---------+---------------------+------------+-------------+
| OrderID | OrderDate           | CustomerID | TotalAmount |
+---------+---------------------+------------+-------------+
|       1 | 2023-01-15 10:00:00 |        101 |      250.75 |
|       2 | 2023-01-15 10:30:00 |        102 |      120.00 |
|       3 | 2023-01-16 11:15:00 |        101 |      300.50 |
|       4 | 2023-01-17 14:45:00 |        103 |       75.20 |
|       5 | 2023-01-18 09:00:00 |        102 |      450.00 |
|       6 | 2024-02-05 12:00:00 |        104 |      650.00 |
|       7 | 2024-02-10 15:30:00 |        105 |     1200.50 |
|       8 | 2024-02-12 08:00:00 |        101 |      550.00 |
|       9 | 2024-01-20 10:00:00 |        106 |      700.00 |
|      10 | 2024-02-08 11:00:00 |        107 |      499.99 |
|      11 | 2023-01-15 10:00:00 |        101 |      250.75 |
|      12 | 2023-01-15 10:30:00 |        102 |      120.00 |
|      13 | 2023-01-16 11:15:00 |        101 |      300.50 |
|      14 | 2023-01-17 14:45:00 |        103 |       75.20 |
|      15 | 2023-01-18 09:00:00 |        102 |      450.00 |
+---------+---------------------+------------+-------------+
15 rows in set (0.011 sec)

mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.014 sec)

mysql> SELECT *
    -> FROM Orders
    -> WHERE OrderDate BETWEEN '2024-02-01 00:00:00' AND '2024-02-15 23:59:59'
    ->   AND TotalAmount > 500.00;
+---------+---------------------+------------+-------------+
| OrderID | OrderDate           | CustomerID | TotalAmount |
+---------+---------------------+------------+-------------+
|       6 | 2024-02-05 12:00:00 |        104 |      650.00 |
|       7 | 2024-02-10 15:30:00 |        105 |     1200.50 |
|       8 | 2024-02-12 08:00:00 |        101 |      550.00 |
+---------+---------------------+------------+-------------+
3 rows in set (0.028 sec)

mysql> -- Add more sample data for the query to find
Query OK, 0 rows affected (0.008 sec)

mysql> INSERT INTO Orders (OrderDate, CustomerID, TotalAmount) VALUES
    -> ('2024-02-05 12:00:00', 104, 650.00),
    -> ('2024-02-10 15:30:00', 105, 1200.50),
    -> ('2024-02-12 08:00:00', 101, 550.00),
    -> ('2024-01-20 10:00:00', 106, 700.00), -- This one will NOT be picked due to date range
    -> ('2024-02-08 11:00:00', 107, 499.99); -- This one will NOT be picked due to amount
Query OK, 5 rows affected (0.043 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT *
    -> FROM Orders
    -> WHERE OrderDate BETWEEN '2024-02-01 00:00:00' AND '2024-02-15 23:59:59'
    ->   AND TotalAmount > 500.00;
+---------+---------------------+------------+-------------+
| OrderID | OrderDate           | CustomerID | TotalAmount |
+---------+---------------------+------------+-------------+
|       6 | 2024-02-05 12:00:00 |        104 |      650.00 |
|      16 | 2024-02-05 12:00:00 |        104 |      650.00 |
|       7 | 2024-02-10 15:30:00 |        105 |     1200.50 |
|      17 | 2024-02-10 15:30:00 |        105 |     1200.50 |
|       8 | 2024-02-12 08:00:00 |        101 |      550.00 |
|      18 | 2024-02-12 08:00:00 |        101 |      550.00 |
+---------+---------------------+------------+-------------+
6 rows in set (0.018 sec)

mysql> -- Add more sample data for the query to find
Query OK, 0 rows affected (0.008 sec)

mysql> INSERT INTO Orders (OrderDate, CustomerID, TotalAmount) VALUES
    -> ('2024-02-05 12:00:00', 104, 650.00),
    -> ('2024-02-10 15:30:00', 105, 1200.50),
    -> ('2024-02-12 08:00:00', 101, 550.00),
    -> ('2024-01-20 10:00:00', 106, 700.00), -- This one will NOT be picked due to date range
    -> ('2024-02-08 11:00:00', 107, 499.99); -- This one will NOT be picked due to amount
Query OK, 5 rows affected (0.081 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SHOW PROFILES;
+----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                                                                                                                                                                                                                                        |
+----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|        1 | 0.00242925 | SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2024-02-01 00:00:00' AND '2024-02-15 23:59:59'
  AND TotalAmount > 500.00                                                                                                                                                                                      |
|        2 | 0.00025050 | -- Add more sample data for the query to find                                                                                                                                                                                                                                                                |
|        3 | 0.00392575 | INSERT INTO Orders (OrderDate, CustomerID, TotalAmount) VALUES
('2024-02-05 12:00:00', 104, 650.00),
('2024-02-10 15:30:00', 105, 1200.50),
('2024-02-12 08:00:00', 101, 550.00),
('2024-01-20 10:00:00', 106, 700.00), -- This one will NOT be picked due to date range
('2024-02-08 11:00:00', 107, 499.99 |
|        4 | 0.00139550 | SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2024-02-01 00:00:00' AND '2024-02-15 23:59:59'
  AND TotalAmount > 500.00                                                                                                                                                                                      |
|        5 | 0.00033025 | -- Add more sample data for the query to find                                                                                                                                                                                                                                                                |
|        6 | 0.00770025 | INSERT INTO Orders (OrderDate, CustomerID, TotalAmount) VALUES
('2024-02-05 12:00:00', 104, 650.00),
('2024-02-10 15:30:00', 105, 1200.50),
('2024-02-12 08:00:00', 101, 550.00),
('2024-01-20 10:00:00', 106, 700.00), -- This one will NOT be picked due to date range
('2024-02-08 11:00:00', 107, 499.99 |
+----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
6 rows in set, 1 warning (0.007 sec)

mysql> -- OR for more detail on the last query:
Query OK, 0 rows affected (0.004 sec)

mysql> SHOW PROFILE FOR QUERY LAST;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'LAST' at line 1
mysql> -- Use the SalesDB database if not already selected
Query OK, 0 rows affected (0.007 sec)

mysql> USE SalesDB;
Database changed
mysql>
mysql> -- Create an index on the OrderDate column
Query OK, 0 rows affected (0.003 sec)

mysql> CREATE INDEX idx_order_date ON Orders (OrderDate);
ERROR 1061 (42000): Duplicate key name 'idx_order_date'
mysql> -- Create an index on the CustomerID column
Query OK, 0 rows affected (0.008 sec)

mysql> CREATE INDEX idx_customer_id ON Orders (CustomerID);
Query OK, 0 rows affected (0.537 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> SHOW INDEXES FROM Orders;
+--------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table  | Non_unique | Key_name             | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+--------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| orders |          0 | PRIMARY              |            1 | OrderID     | A         |          10 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| orders |          1 | idx_order_date       |            1 | OrderDate   | A         |          10 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| orders |          1 | idx_order_date_total |            1 | OrderDate   | A         |          10 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| orders |          1 | idx_order_date_total |            2 | TotalAmount | A         |          10 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
| orders |          1 | idx_customer_id      |            1 | CustomerID  | A         |           7 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+--------+------------+----------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
5 rows in set (0.126 sec)

mysql> SHOW CREATE TABLE Orders;
+--------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table  | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                              |
+--------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Orders | CREATE TABLE `orders` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `OrderDate` datetime DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `TotalAmount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `idx_order_date` (`OrderDate`),
  KEY `idx_order_date_total` (`OrderDate`,`TotalAmount`),
  KEY `idx_customer_id` (`CustomerID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+--------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.015 sec)

mysql> -- Ensure profiling is still enabled (though it usually persists for the session)
Query OK, 0 rows affected (0.007 sec)

mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.008 sec)

mysql>
mysql> -- Rerun the query to retrieve orders based on your criteria
Query OK, 0 rows affected (0.005 sec)

mysql> SELECT *
    -> FROM Orders
    -> WHERE OrderDate BETWEEN '2024-02-01 00:00:00' AND '2024-02-15 23:59:59'
    ->   AND TotalAmount > 500.00;
+---------+---------------------+------------+-------------+
| OrderID | OrderDate           | CustomerID | TotalAmount |
+---------+---------------------+------------+-------------+
|       6 | 2024-02-05 12:00:00 |        104 |      650.00 |
|      16 | 2024-02-05 12:00:00 |        104 |      650.00 |
|      21 | 2024-02-05 12:00:00 |        104 |      650.00 |
|       7 | 2024-02-10 15:30:00 |        105 |     1200.50 |
|      17 | 2024-02-10 15:30:00 |        105 |     1200.50 |
|      22 | 2024-02-10 15:30:00 |        105 |     1200.50 |
|       8 | 2024-02-12 08:00:00 |        101 |      550.00 |
|      18 | 2024-02-12 08:00:00 |        101 |      550.00 |
|      23 | 2024-02-12 08:00:00 |        101 |      550.00 |
+---------+---------------------+------------+-------------+
9 rows in set (0.016 sec)

mysql> SHOW PROFILES;
+----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                                                                                                                                                                                                                                        |
+----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|        6 | 0.00770025 | INSERT INTO Orders (OrderDate, CustomerID, TotalAmount) VALUES
('2024-02-05 12:00:00', 104, 650.00),
('2024-02-10 15:30:00', 105, 1200.50),
('2024-02-12 08:00:00', 101, 550.00),
('2024-01-20 10:00:00', 106, 700.00), -- This one will NOT be picked due to date range
('2024-02-08 11:00:00', 107, 499.99 |
|        7 | 0.00018525 | -- OR for more detail on the last query:                                                                                                                                                                                                                                                                     |
|        8 | 0.00035775 | SHOW PROFILE FOR QUERY LAST                                                                                                                                                                                                                                                                                  |
|        9 | 0.00027925 | -- Use the SalesDB database if not already selected                                                                                                                                                                                                                                                          |
|       10 | 0.00031025 | SELECT DATABASE()                                                                                                                                                                                                                                                                                            |
|       11 | 0.00012900 | -- Create an index on the OrderDate column                                                                                                                                                                                                                                                                   |
|       12 | 0.00323100 | CREATE INDEX idx_order_date ON Orders (OrderDate)                                                                                                                                                                                                                                                            |
|       13 | 0.00030600 | -- Create an index on the CustomerID column                                                                                                                                                                                                                                                                  |
|       14 | 0.05335175 | CREATE INDEX idx_customer_id ON Orders (CustomerID)                                                                                                                                                                                                                                                          |
|       15 | 0.01220000 | SHOW INDEXES FROM Orders                                                                                                                                                                                                                                                                                     |
|       16 | 0.00109150 | SHOW CREATE TABLE Orders                                                                                                                                                                                                                                                                                     |
|       17 | 0.00028350 | -- Ensure profiling is still enabled (though it usually persists for the session)                                                                                                                                                                                                                            |
|       18 | 0.00046650 | SET profiling = 1                                                                                                                                                                                                                                                                                            |
|       19 | 0.00022000 | -- Rerun the query to retrieve orders based on your criteria                                                                                                                                                                                                                                                 |
|       20 | 0.00111525 | SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2024-02-01 00:00:00' AND '2024-02-15 23:59:59'
  AND TotalAmount > 500.00                                                                                                                                                                                      |
+----------+------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
15 rows in set, 1 warning (0.009 sec)

mysql> -- OR for a detailed breakdown of the last query:
Query OK, 0 rows affected (0.004 sec)

mysql> SHOW PROFILE FOR QUERY LAST;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'LAST' at line 1
mysql> EXPLAIN SELECT *
    -> FROM Orders
    -> WHERE OrderDate BETWEEN '2024-02-01 00:00:00' AND '2024-02-15 23:59:59'
    ->   AND TotalAmount > 500.00;
+----+-------------+--------+------------+-------+-------------------------------------+----------------+---------+------+------+----------+------------------------------------+
| id | select_type | table  | partitions | type  | possible_keys                       | key            | key_len | ref  | rows | filtered | Extra                              |
+----+-------------+--------+------------+-------+-------------------------------------+----------------+---------+------+------+----------+------------------------------------+
|  1 | SIMPLE      | Orders | NULL       | range | idx_order_date,idx_order_date_total | idx_order_date | 6       | NULL |   12 |    33.33 | Using index condition; Using where |
+----+-------------+--------+------------+-------+-------------------------------------+----------------+---------+------+------+----------+------------------------------------+
1 row in set, 1 warning (0.014 sec)

mysql> -- Use the SalesDB database if not already selected
Query OK, 0 rows affected (0.012 sec)

mysql> USE SalesDB;
Database changed
mysql>
mysql> -- Drop the existing single-column index on CustomerID
Query OK, 0 rows affected (0.004 sec)

mysql> DROP INDEX idx_customer_id ON Orders;
Query OK, 0 rows affected (0.167 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> -- Create a composite index on OrderDate and TotalAmount
Query OK, 0 rows affected (0.007 sec)

mysql> CREATE INDEX idx_order_date_total ON Orders (OrderDate, TotalAmount);
ERROR 1061 (42000): Duplicate key name 'idx_order_date_total'
mysql> -- Ensure profiling is still enabled
Query OK, 0 rows affected (0.006 sec)

mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.005 sec)

mysql>
mysql> -- Rerun the query
Query OK, 0 rows affected (0.005 sec)

mysql> SELECT *
    -> FROM Orders
    -> WHERE OrderDate BETWEEN '2024-02-01 00:00:00' AND '2024-02-15 23:59:59'
    ->   AND TotalAmount > 500.00;
+---------+---------------------+------------+-------------+
| OrderID | OrderDate           | CustomerID | TotalAmount |
+---------+---------------------+------------+-------------+
|       6 | 2024-02-05 12:00:00 |        104 |      650.00 |
|      16 | 2024-02-05 12:00:00 |        104 |      650.00 |
|      21 | 2024-02-05 12:00:00 |        104 |      650.00 |
|       7 | 2024-02-10 15:30:00 |        105 |     1200.50 |
|      17 | 2024-02-10 15:30:00 |        105 |     1200.50 |
|      22 | 2024-02-10 15:30:00 |        105 |     1200.50 |
|       8 | 2024-02-12 08:00:00 |        101 |      550.00 |
|      18 | 2024-02-12 08:00:00 |        101 |      550.00 |
|      23 | 2024-02-12 08:00:00 |        101 |      550.00 |
+---------+---------------------+------------+-------------+
9 rows in set (0.016 sec)

mysql>
mysql> -- View the profiling information
Query OK, 0 rows affected (0.005 sec)

mysql> SHOW PROFILES;
+----------+------------+---------------------------------------------------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                                                           |
+----------+------------+---------------------------------------------------------------------------------------------------------------------------------+
|       20 | 0.00111525 | SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2024-02-01 00:00:00' AND '2024-02-15 23:59:59'
  AND TotalAmount > 500.00         |
|       21 | 0.00018850 | -- OR for a detailed breakdown of the last query:                                                                               |
|       22 | 0.00023550 | SHOW PROFILE FOR QUERY LAST                                                                                                     |
|       23 | 0.00101500 | EXPLAIN SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2024-02-01 00:00:00' AND '2024-02-15 23:59:59'
  AND TotalAmount > 500.00 |
|       24 | 0.00043675 | -- Use the SalesDB database if not already selected                                                                             |
|       25 | 0.00051000 | SELECT DATABASE()                                                                                                               |
|       26 | 0.00020175 | -- Drop the existing single-column index on CustomerID                                                                          |
|       27 | 0.01637050 | DROP INDEX idx_customer_id ON Orders                                                                                            |
|       28 | 0.00019475 | -- Create a composite index on OrderDate and TotalAmount                                                                        |
|       29 | 0.00249700 | CREATE INDEX idx_order_date_total ON Orders (OrderDate, TotalAmount)                                                            |
|       30 | 0.00025375 | -- Ensure profiling is still enabled                                                                                            |
|       31 | 0.00030375 | SET profiling = 1                                                                                                               |
|       32 | 0.00026275 | -- Rerun the query                                                                                                              |
|       33 | 0.00116100 | SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2024-02-01 00:00:00' AND '2024-02-15 23:59:59'
  AND TotalAmount > 500.00         |
|       34 | 0.00020375 | -- View the profiling information                                                                                               |
+----------+------------+---------------------------------------------------------------------------------------------------------------------------------+
15 rows in set, 1 warning (0.003 sec)

mysql> -- OR for a detailed breakdown of the last query:
Query OK, 0 rows affected (0.004 sec)

mysql> SHOW PROFILE FOR QUERY LAST;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'LAST' at line 1
mysql> EXPLAIN SELECT *
    -> FROM Orders
    -> WHERE OrderDate BETWEEN '2024-02-01 00:00:00' AND '2024-02-15 23:59:59'
    ->   AND TotalAmount > 500.00;
+----+-------------+--------+------------+-------+-------------------------------------+----------------+---------+------+------+----------+------------------------------------+
| id | select_type | table  | partitions | type  | possible_keys                       | key            | key_len | ref  | rows | filtered | Extra                              |
+----+-------------+--------+------------+-------+-------------------------------------+----------------+---------+------+------+----------+------------------------------------+
|  1 | SIMPLE      | Orders | NULL       | range | idx_order_date,idx_order_date_total | idx_order_date | 6       | NULL |   12 |    33.33 | Using index condition; Using where |
+----+-------------+--------+------------+-------+-------------------------------------+----------------+---------+------+------+----------+------------------------------------+
1 row in set, 1 warning (0.014 sec)

mysql>