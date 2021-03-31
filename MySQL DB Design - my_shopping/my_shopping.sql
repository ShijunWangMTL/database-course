-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema my_shopping
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema my_shopping
-- -----------------------------------------------------
DROP DATABASE IF EXISTS my_shopping;
CREATE DATABASE IF NOT EXISTS my_shopping;
CREATE SCHEMA IF NOT EXISTS `my_shopping` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `my_shopping` ;
SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

-- -----------------------------------------------------
-- Table `my_shopping`.`addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_shopping`.`addresses` ;

CREATE TABLE IF NOT EXISTS `my_shopping`.`addresses` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `street_number` INT NOT NULL,
  `street_name` VARCHAR(20) NOT NULL,
  `city` VARCHAR(20) NOT NULL,
  `province` VARCHAR(15) NOT NULL,
  `country` VARCHAR(20) NOT NULL,
  `zip_code` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `my_shopping`.`brands`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_shopping`.`brands` ;

CREATE TABLE IF NOT EXISTS `my_shopping`.`brands` (
  `brand_id` INT NOT NULL AUTO_INCREMENT,
  `brand_name` VARCHAR(15) NOT NULL,
  `brand_description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`brand_id`),
  UNIQUE INDEX `brand_name_UNIQUE` (`brand_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `my_shopping`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_shopping`.`products` ;

CREATE TABLE IF NOT EXISTS `my_shopping`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(30) NOT NULL,
  `price` INT NOT NULL,
  `brand_id` INT NOT NULL,
  PRIMARY KEY (`product_id`, `brand_id`),
  INDEX `fk_products_Brands1_idx` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_brands`
    FOREIGN KEY (`brand_id`)
    REFERENCES `my_shopping`.`brands` (`brand_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 20009
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `my_shopping`.`shopping_cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_shopping`.`shopping_cart` ;

CREATE TABLE IF NOT EXISTS `my_shopping`.`shopping_cart` (
  `shopping_cart_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`shopping_cart_id`, `product_id`),
  INDEX `fk_shopping_product_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_shopping_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `my_shopping`.`products` (`product_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `my_shopping`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_shopping`.`customers` ;

CREATE TABLE IF NOT EXISTS `my_shopping`.`customers` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(15) NOT NULL,
  `last_name` VARCHAR(15) NOT NULL,
  `gender` ENUM('Female', 'Male', 'Non-binary') NOT NULL,
  `phone_number` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `shopping_cart_id` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_customers_shopping_cart_idx` (`shopping_cart_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_shopping_cart`
    FOREIGN KEY (`shopping_cart_id`)
    REFERENCES `my_shopping`.`shopping_cart` (`shopping_cart_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 10006
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `my_shopping`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_shopping`.`orders` ;

CREATE TABLE IF NOT EXISTS `my_shopping`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `create_date` DATE NOT NULL,
  `payment_type` ENUM('cash', 'credit card', 'debit card') NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_customers1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`user_id`)
    REFERENCES `my_shopping`.`customers` (`user_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 60005
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `my_shopping`.`receivers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_shopping`.`receivers` ;

CREATE TABLE IF NOT EXISTS `my_shopping`.`receivers` (
  `receiver_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `first_name` VARCHAR(15) NOT NULL,
  `last_name` VARCHAR(15) NOT NULL,
  `phone_number` VARCHAR(20) NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`receiver_id`),
  INDEX `fk_receivers_address_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_receivers_customers_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_receivers_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `my_shopping`.`addresses` (`address_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_receivers_customers`
    FOREIGN KEY (`user_id`)
    REFERENCES `my_shopping`.`customers` (`user_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 70006
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `my_shopping`.`orders_has_products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_shopping`.`orders_has_products` ;

CREATE TABLE IF NOT EXISTS `my_shopping`.`orders_has_products` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `shipping_company` VARCHAR(15) NOT NULL,
  `shipping_date` DATE NULL DEFAULT NULL,
  `receiver_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `product_id`),
  INDEX `fk_orders_has_products_products_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_orders_has_products_orders_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_orders_has_products_receivers_idx` (`receiver_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_has_products_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `my_shopping`.`orders` (`order_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_has_products_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `my_shopping`.`products` (`product_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_has_products_receivers`
    FOREIGN KEY (`receiver_id`)
    REFERENCES `my_shopping`.`receivers` (`receiver_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `my_shopping`.`sellers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_shopping`.`sellers` ;

CREATE TABLE IF NOT EXISTS `my_shopping`.`sellers` (
  `seller_id` INT NOT NULL AUTO_INCREMENT,
  `company_name` VARCHAR(15) NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`seller_id`, `address_id`),
  INDEX `fk_sellers_address_idx` (`address_id` ASC) INVISIBLE,
  CONSTRAINT `fk_sellers_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `my_shopping`.`addresses` (`address_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 30006
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `my_shopping`.`products_has_sellers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_shopping`.`products_has_sellers` ;

CREATE TABLE IF NOT EXISTS `my_shopping`.`products_has_sellers` (
  `product_id` INT NOT NULL,
  `seller_id` INT NOT NULL,
  PRIMARY KEY (`product_id`, `seller_id`),
  INDEX `fk_products_has_sellers_sellers_idx` (`seller_id` ASC) VISIBLE,
  INDEX `fk_products_has_sellers_products_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_has_sellers_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `my_shopping`.`products` (`product_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_has_sellers_seller`
    FOREIGN KEY (`seller_id`)
    REFERENCES `my_shopping`.`sellers` (`seller_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `my_shopping`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `my_shopping`.`users` ;

CREATE TABLE IF NOT EXISTS `my_shopping`.`users` (
  `user_id` INT NOT NULL,
  `password` VARCHAR(16) NOT NULL,
  `priority` INT NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_users_customers1_idx` (`user_id` ASC) INVISIBLE,
  CONSTRAINT `fk_users_customers`
    FOREIGN KEY (`user_id`)
    REFERENCES `my_shopping`.`customers` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `my_shopping`;

DELIMITER $$

USE `my_shopping`$$
DROP TRIGGER IF EXISTS `my_shopping`.`trig_shipping_date` $$
USE `my_shopping`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `my_shopping`.`trig_shipping_date`
BEFORE INSERT ON `my_shopping`.`orders_has_products`
FOR EACH ROW
BEGIN
	IF NEW.shipping_date > date_format(sysdate(), '%Y-%m-%d') THEN     
		SET NEW.shipping_date = date_format(sysdate(), '%Y-%m-%d');     
	END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into brands values (1,'Apple','The most popular brand'),
                          (2,'Samsung','Cell phone brand'),
                          (3,'Adidas','Sport brand'),
                          (4,'Nike','Sport brand'),
						  (5,'Canada Goose','Cloth brand');

insert into products values (20001,'Iphone 10',1499,1),
                            (20002,'Iphone X',1699,1),
                            (20003,'Galaxy 5G',1149,2),
                            (20004,'S 10',1559,2),
                            (20005,'ZX 2K BOOST SHOES',180,3),
                            (20006,'STAR WARS ZX 2K BOOST SHOES',220,3),
                            (20007,'Nike Sportswear Synthetic-Fill',185,4),
                            (20008,'Nike Pro',110,4);

insert into shopping_cart values (90001,20001,1),
						         (90001,20002,1),
						         (90002,20003,2),
						         (90002,20004,3),
						         (90003,20005,2),
                                 (90003,20006,4),
                                 (90003,20007,2),
                                 (90004,20008,4),
                                 (90004,20001,1),
                                 (90005,20002,3),
                                 (90005,20003,2),
                                 (90006,20004,3),
                                 (90007,20005,2),
                                 (90007,20006,2);

insert into customers values (10001,'Georgi','Facello','Male','1234567891','rgfd@gmail.com',90001),
                             (10002,'Bezalel','Simmel','Female','1234567892','had@chff.com',90002),
                             (10003,'Parto','Bamford','Male','1234567893','fhgdf@dlng.net',90003),
                             (10004,'Chirstian','Koblick','Male','1234567894','hasdf@lkfg.com',90004),
                             (10005,'Kyoichi','Maliniak','Male','1234567895','jrtr@dfs.com',90005);

insert into addresses values (80001,'123','street Wigoag','Moigdsa','OS','Canada','H4V 4F3'),
						     (80002,'4322','street Dotmong','NewYork','EA','United States','534643'),
						     (80003,'5421','Chemin Orange','Washington','TG','United States','754356'),
						     (80004,'6354','street Onetime','Qoioing','LD','United States','4fds323'),
						     (80005,'844','street Eong','Koblick','BF','United States','74564534'),
                             (80006,'7434','Ave Lernt','Winston','EA','United States','743432'),
						     (80007,'3224','rue Goereg','Mingsk','IN','Russa','934566'),
						     (80008,'2222','rue Jkong','Dnwog','LH','Canada','F3E 1Q6'),
						     (80009,'8632','street Orgasol','Hangzhou','ZJ','China','7gf364'),
						     (80010,'2554','Av Plongs','NewYork','LA','United States','33423332'),
							 (80011,'3474','Ave Hort','Yogan','DF','Canada','45g5gh4'),
							 (80012,'1934','street Esgsn','Senong','CD','Swiss','3fd4ga2'),
							 (80013,'5322','blv Monga','Dengag','TX','India','54grty54');



insert into receivers values (70001,10001,'Georgi','Facello','1234567891',80001),
						     (70002,10002,'Bezalel','Simmel','1234567892',80002),
						     (70003,10002,'Udi','Jansch',1234574343,80003),
						     (70004,10003,'Parto','Bamford',1234567893,80005),
						     (70005,10003,'Bouloucos','Schusler',1234567895,80006),
							 (70006,10004,'Alejandro','McAlpine',1234567896,80008),
							 (70007,10005,'Gino','Leonhardt',1234567897,80009),
							 (70008,10005,'Nooteboom','Awdeh',1234567898,80010);

insert into sellers values (30001,'Duangkaew',80004),
						   (30002,'Piveteau',80007),
						   (30003,'Cappelletti',80011),
						   (30004,'Nooteboom',80012),
						   (30005,'Bouloucos',80013);

insert into orders values (60001,10001,'2020-07-21','Credit card'),
						  (60002,10002,'2020-08-22','Debit card'),
						  (60003,10003,'2020-09-11','Credit card'),
						  (60004,10004,'2020-09-12','Credit card'),
                          (60005,10005,'2020-09-20','Credit card');

insert into orders_has_products values (60001,20001,1,'Haddadi','2020-07-21',70001),
						               (60001,20002,1,'Warwick','2020-07-22',70001),
						               (60001,20003,2,'Warwick','2020-07-21',70001),
						               (60001,20004,3,'Haddadi','2020-07-23',70001),
						               (60002,20005,2,'Montemayor','2020-08-22',70002),
                                       (60002,20006,4,'Montemayor','2020-08-22',70002),
                                       (60002,20007,2,'Pettey','2020-08-23',70003),
                                       (60002,20008,4,'Montemayor','2020-08-22',70003),
                                       (60003,20001,1,'Heyers','2020-09-11',70004),
                                       (60003,20002,3,'Montemayor','2020-09-11',70005),
                                       (60003,20003,2,'Pettey','2020-09-12',70005),
                                       (60004,20004,3,'Montemayor','2020-09-12',70006),
                                       (60005,20005,2,'Montemayor','2020-09-20',70007),
                                       (60005,20006,2,'Heyers','2020-10-23',70008);

insert into products_has_sellers values (20001,30001),
						                (20002,30001),
						                (20003,30001),
						                (20004,30001),
						                (20001,30002),
						                (20002,30002),
						                (20003,30002),
						                (20004,30002),
                                        (20005,30003),
						                (20006,30003),
						                (20007,30003),
						                (20008,30003),
						                (20001,30004),
						                (20002,30004),
						                (20005,30004),
						                (20007,30004),
                                        (20003,30005),
						                (20004,30005),
						                (20006,30005),
						                (20007,30005);

insert into users values (10001,'fds3232',1),
						 (10002,'30001',2),
						 (10003,'3dffsd3',3),
						 (10004,'sdf34gj',1),
						 (10005,'d23fju5',2);
