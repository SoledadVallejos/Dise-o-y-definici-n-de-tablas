-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bazar_digital
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bazar_digital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bazar_digital` DEFAULT CHARACTER SET utf8 ;
USE `bazar_digital` ;

-- -----------------------------------------------------
-- Table `bazar_digital`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar_digital`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar_digital`.`subcategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar_digital`.`subcategories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `categotyId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subcategories_categories_idx` (`categotyId` ASC) VISIBLE,
  CONSTRAINT `fk_subcategories_categories`
    FOREIGN KEY (`categotyId`)
    REFERENCES `bazar_digital`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar_digital`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar_digital`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(8,2) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `stock` TINYINT(10) NOT NULL,
  `profesional_use` INT NOT NULL,
  `subcategoriesId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_products_subcategories_idx` (`subcategoriesId` ASC) VISIBLE,
  CONSTRAINT `fk_products_subcategories`
    FOREIGN KEY (`subcategoriesId`)
    REFERENCES `bazar_digital`.`subcategories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar_digital`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar_digital`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar_digital`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar_digital`.`employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `dni` TINYINT(10) NOT NULL,
  `salary` TINYINT(10) NOT NULL,
  `rolId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_emploees_rols_idx` (`rolId` ASC) VISIBLE,
  CONSTRAINT `fk_emploees_rols`
    FOREIGN KEY (`rolId`)
    REFERENCES `bazar_digital`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar_digital`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar_digital`.`sales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `article` VARCHAR(45) NOT NULL,
  `source_payment` VARCHAR(45) NOT NULL,
  `total_purchase` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bazar_digital`.`employees_access`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bazar_digital`.`employees_access` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `productId` INT NOT NULL,
  `rolId` INT NOT NULL,
  `saleId` VARCHAR(45) NULL,
  `employees_accesscol` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_products_employees_access_idx` (`productId` ASC) VISIBLE,
  INDEX `fk_employees_access_employees_idx` (`rolId` ASC) VISIBLE,
  CONSTRAINT `fk_products_employees_access`
    FOREIGN KEY (`productId`)
    REFERENCES `bazar_digital`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_access_employees`
    FOREIGN KEY (`rolId`)
    REFERENCES `bazar_digital`.`employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_access_sales`
    FOREIGN KEY (`id`)
    REFERENCES `bazar_digital`.`sales` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
