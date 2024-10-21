-- MySQL Workbench Forward Engineering


-- -----------------------------------------------------
-- Schema e_commerce
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema e_commerce

-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `e_commerce` DEFAULT CHARACTER SET utf8;
USE `e_commerce` ;

-- -----------------------------------------------------
-- Table `e_commerce`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `password_UNIQUE` (`password` ASC)  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_commerce`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `contact` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_user1_idx` (`user_id` ASC)  ,
  CONSTRAINT `fk_customer_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `e_commerce`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_commerce`.`vendor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`vendor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_commerce`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `sequence` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_commerce`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `description` VARCHAR(45) NULL,
  `stock_qty` INT NOT NULL,
  `vendor_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`id`, `vendor_id`, `category_id`),
  INDEX `fk_product_vendor1_idx` (`vendor_id` ASC)  ,
  INDEX `fk_product_category1_idx` (`category_id` ASC)  ,
  CONSTRAINT `fk_product_vendor1`
    FOREIGN KEY (`vendor_id`)
    REFERENCES `e_commerce`.`vendor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `e_commerce`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_commerce`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `message` VARCHAR(45) NOT NULL,
  `rating` VARCHAR(45) NOT NULL,
  `customer_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `product_vendor_id` INT NOT NULL,
  `product_category_id` INT NOT NULL,
  PRIMARY KEY (`id`, `product_id`, `product_vendor_id`, `product_category_id`),
  INDEX `fk_review_customer_idx` (`customer_id` ASC)  ,
  INDEX `fk_review_product1_idx` (`product_id` ASC, `product_vendor_id` ASC, `product_category_id` ASC)  ,
  CONSTRAINT `fk_review_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `e_commerce`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_product1`
    FOREIGN KEY (`product_id` , `product_vendor_id` , `product_category_id`)
    REFERENCES `e_commerce`.`product` (`id` , `vendor_id` , `category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `e_commerce`.`customer_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `e_commerce`.`customer_product` (
  `customer_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`, `product_id`),
  INDEX `fk_customer_has_product_product1_idx` (`product_id` ASC)  ,
  INDEX `fk_customer_has_product_customer1_idx` (`customer_id` ASC)  ,
  CONSTRAINT `fk_customer_has_product_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `e_commerce`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_has_product_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `e_commerce`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


