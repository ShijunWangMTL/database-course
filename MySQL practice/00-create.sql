# Got to i then DDL tab to see the result
# Command + b or Ctrl + b format code
# Command + Enter or Ctrl + Enter run the selected command by cursor

-- Comment
# Comment
/*
Comment
*/

# How to create a database
CREATE DATABASE IF NOT EXISTS shopping;


# How to start using an existing database
USE shopping;


# How to create a table with a Primary Key
# customers table can not be deleted if it is referencesed by other tables
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers				
(
    customer_id INT,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
PRIMARY KEY (customer_id)
);
DESCRIBE customers;

# How to make a  Not Null and  Auto Increment Primary Key
# customers table can not be deleted if it is referencesed by other tables
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers				
(
    customer_id INT NOT NULL AUTO_INCREMENT ,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
PRIMARY KEY (customer_id)
);
DESCRIBE customers;


# How to make email address unique
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers				
(
    customer_id INT NOT NULL AUTO_INCREMENT ,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    UNIQUE KEY (email_address),
PRIMARY KEY (customer_id)
);
DESCRIBE customers;


# How to create a Primary Key from two columns
DROP TABLE IF EXISTS companies;
CREATE TABLE companies (
    company_name VARCHAR(255) NOT NULL,
    headquarters_phone_number INT(12) NOT NULL,
PRIMARY KEY (company_name,  headquarters_phone_number )
);


# How to drop a Primary Key when it composed of two columns
DESCRIBE companies;
ALTER TABLE companies 
DROP PRIMARY KEY;
DESCRIBE companies;



DROP TABLE IF EXISTS companies;
CREATE TABLE companies (
    company_id INT NOT NULL AUTO_INCREMENT,
    company_name VARCHAR(255),
    headquarters_phone_number INT(12),
PRIMARY KEY (company_id )
);
DESCRIBE companies;


# How to set a default value for a column
DROP TABLE IF EXISTS items;
CREATE TABLE items (
    item_id INT NOT NULL AUTO_INCREMENT,
    item VARCHAR(255) DEFAULT "I do not know",
    unit_price NUMERIC DEFAULT 0,
    company_id VARCHAR(255),
PRIMARY KEY (item_id)
);
DESCRIBE items;


# NUMERIC = DECIMAL 
# NUMERIC(10 , 2 ) means total 10 digits which contains 8 digits before the floating point and  2 digits after
DROP TABLE IF EXISTS items;
CREATE TABLE items (
    item_id INT NOT NULL AUTO_INCREMENT,
    item VARCHAR(255),
    unit_price NUMERIC(10 , 2 ) DEFAULT 12345678.91,
    company_id VARCHAR(255),
PRIMARY KEY (item_id)
);
DESCRIBE items;


# How to drop the default value for an existing table
ALTER TABLE items
ALTER COLUMN unit_price DROP DEFAULT;
DESCRIBE items;

# How to add a default value for a column in an existing table
ALTER TABLE items
CHANGE COLUMN unit_price unit_price INT DEFAULT 0;
DESCRIBE items;


# An other approach to define a Primary Key
DROP TABLE IF EXISTS sales;
CREATE TABLE sales 
(
	purchase_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date_of_purchase DATE NOT NULL,     
    customer_id INT,
    item_code VARCHAR(10) NOT NULL
);
DESCRIBE sales;


# How to create a one to one relationship from sales to customers
# Parent table = Referenced Table = customers
# Child Table = Referencing Table = sales
# Child table FK must have the same type and values as Parent table PK
DROP TABLE IF EXISTS sales;
CREATE TABLE sales
(
	purchase_id INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10)  NOT NULL,
    PRIMARY KEY (purchase_id),

/*
FOREIGN KEY (customer_id)                       # local column name
REFERENCES customers(customer_id)      # referencing other table (customers) for column value (customer_id)
*/
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);
DESCRIBE sales;
# MUL multiple accurances of the same value are allowed


# How to add an Enum to a database table after a specific column
DESCRIBE customers;
ALTER TABLE customers
ADD COLUMN gender ENUM('M', 'F') AFTER last_name;
DESCRIBE customers;


# How to modify an existing table and create a one to one relation
DROP TABLE IF EXISTS sales;
CREATE TABLE sales
(
	purchase_id INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10)  NOT NULL,
PRIMARY KEY (purchase_id)
);

DESCRIBE sales;
ALTER TABLE sales 
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;
DESCRIBE sales;


SHOW TABLES;

# How to change a column to be NULL or NOT NULL 
# How to use  MODIFY
DESCRIBE companies;
ALTER TABLE companies
MODIFY company_name VARCHAR(255) NULL;
DESCRIBE companies;

# How to use Change
DESCRIBE companies;
ALTER TABLE companies
CHANGE COLUMN company_name company_name VARCHAR(128) NOT NULL;
DESCRIBE companies;


# How to rename a column
DESCRIBE companies;
ALTER TABLE companies 
CHANGE company_name just_name VARCHAR(255);
DESCRIBE companies;


# How to drop a column
DESCRIBE companies;
ALTER TABLE companies 
DROP COLUMN headquarters_phone_number;
DESCRIBE companies;


# How to add a column
DESCRIBE companies;
ALTER TABLE companies 
ADD COLUMN headquarters_phone_number INT(12);
DESCRIBE companies;


# How to change a column type
DESCRIBE companies;
ALTER TABLE companies 
MODIFY COLUMN headquarters_phone_number DOUBLE;
DESCRIBE companies;


# How to drop a Primary Keys
# You should remove the autoincrement property for dropping the key
DESCRIBE sales;
ALTER TABLE sales 
DROP PRIMARY KEY,
CHANGE purchase_id purchase_id INT;
DESCRIBE sales;


# How to drop a Foreign Keys
DESCRIBE sales;
# You need to find the constraint's name: sales_ibfk_1
# Look at the documents to find out how to find th constraint's name
SHOW CREATE TABLE sales;

-- ALTER TABLE sales 
-- DROP FOREIGN KEY sales_ibfk_1;


# How ro rename a table
DROP TABLE IF EXISTS company;
RENAME TABLE companies TO company;
DESCRIBE company;
-- DESCRIBE companies;

# How to drop a table
DROP TABLE IF EXISTS companies;
DROP TABLE IF EXISTS company;