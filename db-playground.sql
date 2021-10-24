-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema playground_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema playground_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `playground_db` DEFAULT CHARACTER SET utf8 ;
USE `playground_db` ;

-- -----------------------------------------------------
-- Table `playground_db`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `categoryId` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_categories_idx` (`categoryId` ASC) VISIBLE,
  CONSTRAINT `fk_users_categories`
    FOREIGN KEY (`categoryId`)
    REFERENCES `playground_db`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db`.`courses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `image` VARCHAR(45) NOT NULL,
  `date_start` DATE NOT NULL,
  `date_end` DATE NOT NULL,
  `quota` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db`.`units`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db`.`units` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `date_start` DATE NOT NULL,
  `courseId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_units_courses_idx` (`courseId` ASC) VISIBLE,
  CONSTRAINT `fk_units_courses`
    FOREIGN KEY (`courseId`)
    REFERENCES `playground_db`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db`.`lessons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db`.`lessons` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `date_start` DATE NOT NULL,
  `visible` TINYINT NOT NULL,
  `unitId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lessons_units_idx` (`unitId` ASC) VISIBLE,
  CONSTRAINT `fk_lessons_units`
    FOREIGN KEY (`unitId`)
    REFERENCES `playground_db`.`units` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db`.`types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db`.`types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db`.`blocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db`.`blocks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `content` VARCHAR(255) NOT NULL,
  `visible` TINYINT NOT NULL,
  `typeId` INT NOT NULL,
  `lessonId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_blocks_types_idx` (`typeId` ASC) VISIBLE,
  INDEX `fk_blocks_lessons_idx` (`lessonId` ASC) VISIBLE,
  CONSTRAINT `fk_blocks_types`
    FOREIGN KEY (`typeId`)
    REFERENCES `playground_db`.`types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_blocks_lessons`
    FOREIGN KEY (`lessonId`)
    REFERENCES `playground_db`.`lessons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db`.`courses_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db`.`courses_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userId` INT NOT NULL,
  `courseId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_courses_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_courses_users_idx` (`courseId` ASC) VISIBLE,
  CONSTRAINT `fk_users_courses`
    FOREIGN KEY (`userId`)
    REFERENCES `playground_db`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_users`
    FOREIGN KEY (`courseId`)
    REFERENCES `playground_db`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
