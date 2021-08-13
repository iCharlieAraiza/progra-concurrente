-- MySQL Script generated by MySQL Workbench
-- Fri Aug 13 04:38:37 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user_details` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user_details` (
  `iduser_details` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_mame` VARCHAR(45) NULL,
  `second_name` VARCHAR(45) NULL,
  `jon_title` VARCHAR(45) NULL,
  PRIMARY KEY (`iduser_details`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `iduser` INT NOT NULL,
  `iduserdetails_fk` INT NULL,
  PRIMARY KEY (`iduser`),
  INDEX `fk_userdetails_idx` (`iduserdetails_fk` ASC) VISIBLE,
  CONSTRAINT `fk_userdetails`
    FOREIGN KEY (`iduserdetails_fk`)
    REFERENCES `mydb`.`user_details` (`iduser_details`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`timestamps`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`timestamps` ;

CREATE TABLE IF NOT EXISTS `mydb`.`timestamps` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NULL,
  `action` VARCHAR(45) NULL,
  `query` VARCHAR(45) NULL,
  `iduser_fk` INT NULL,
  CONSTRAINT `iduser_fk`
    FOREIGN KEY ()
    REFERENCES `mydb`.`user` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `mydb`.`table1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`table1` ;

CREATE TABLE IF NOT EXISTS `mydb`.`table1` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`project` ;

CREATE TABLE IF NOT EXISTS `mydb`.`project` (
  `idproject` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` TEXT(3000) NULL,
  `idprojectdetails_fk` INT NULL,
  `idusercreated_fk` INT NULL,
  PRIMARY KEY (`idproject`),
  INDEX `idusercreated_idx` (`idusercreated_fk` ASC) VISIBLE,
  CONSTRAINT `idusercreated`
    FOREIGN KEY (`idusercreated_fk`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`projet_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`projet_details` ;

CREATE TABLE IF NOT EXISTS `mydb`.`projet_details` (
  `idprojet_details` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `project_idproject` INT NOT NULL,
  PRIMARY KEY (`idprojet_details`),
  INDEX `fk_projet_details_project1_idx` (`project_idproject` ASC) VISIBLE,
  CONSTRAINT `fk_projet_details_project1`
    FOREIGN KEY (`project_idproject`)
    REFERENCES `mydb`.`project` (`idproject`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bug_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`bug_details` ;

CREATE TABLE IF NOT EXISTS `mydb`.`bug_details` (
  `idbug_details` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `position` VARCHAR(45) NULL,
  PRIMARY KEY (`idbug_details`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`bug`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`bug` ;

CREATE TABLE IF NOT EXISTS `mydb`.`bug` (
  `idbug` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `idproject_fk` VARCHAR(45) NULL,
  `priority` ENUM('high', 'low', 'medium') NULL,
  `created` DATETIME NULL,
  `finish` DATETIME NULL,
  `idbugdetails_fk` INT NULL,
  `bug_details_idbug_details` INT NOT NULL,
  `idusercreated_fk` INT NULL,
  PRIMARY KEY (`idbug`),
  INDEX `fk_bug_bug_details1_idx` (`bug_details_idbug_details` ASC) VISIBLE,
  INDEX `fk_user__idx` (`idusercreated_fk` ASC) VISIBLE,
  CONSTRAINT `fk_bug_bug_details1`
    FOREIGN KEY (`bug_details_idbug_details`)
    REFERENCES `mydb`.`bug_details` (`idbug_details`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_`
    FOREIGN KEY (`idusercreated_fk`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`release`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`release` ;

CREATE TABLE IF NOT EXISTS `mydb`.`release` (
  `idrelease` INT NOT NULL,
  `version` VARCHAR(45) NULL,
  `details` VARCHAR(45) NULL,
  `idproject_id` INT NULL,
  PRIMARY KEY (`idrelease`),
  INDEX `idprojects_fk_idx` (`idproject_id` ASC) VISIBLE,
  CONSTRAINT `idprojects_fk`
    FOREIGN KEY (`idproject_id`)
    REFERENCES `mydb`.`project` (`idproject`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`task_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`task_details` ;

CREATE TABLE IF NOT EXISTS `mydb`.`task_details` (
  `idtask_details` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `area` VARCHAR(45) NULL,
  `body` VARCHAR(45) NULL,
  `p_language` VARCHAR(45) NULL,
  PRIMARY KEY (`idtask_details`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`task` ;

CREATE TABLE IF NOT EXISTS `mydb`.`task` (
  `idtask` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `status` VARCHAR(45) NULL,
  `idproject_fk` INT NULL,
  `id_createduser_fk` INT NULL,
  `start` DATETIME NULL,
  `finish` DATETIME NULL,
  `task_details_idtask_details` INT NOT NULL,
  PRIMARY KEY (`idtask`),
  INDEX `fk_project_idx` (`idproject_fk` ASC) VISIBLE,
  INDEX `fk_task_task_details1_idx` (`task_details_idtask_details` ASC) VISIBLE,
  CONSTRAINT `fk_project`
    FOREIGN KEY (`idproject_fk`)
    REFERENCES `mydb`.`project` (`idproject`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_task_details1`
    FOREIGN KEY (`task_details_idtask_details`)
    REFERENCES `mydb`.`task_details` (`idtask_details`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user_project` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user_project` (
  `iduser_project` INT NOT NULL,
  `idproject_fk` INT NULL,
  `iduser_fk` INT NULL,
  `details` VARCHAR(45) NULL,
  `role` INT NULL,
  PRIMARY KEY (`iduser_project`),
  INDEX `ifuserfk_idx` (`idproject_fk` ASC) VISIBLE,
  CONSTRAINT `ifuserfk`
    FOREIGN KEY (`idproject_fk`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idproject_fk`
    FOREIGN KEY (`idproject_fk`)
    REFERENCES `mydb`.`project` (`idproject`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`view1` (`id` INT);

-- -----------------------------------------------------
--  routine1
-- -----------------------------------------------------

USE `mydb`;
DROP  IF EXISTS `mydb`.`routine1`;

DELIMITER $$
USE `mydb`$$
$$

DELIMITER ;

-- -----------------------------------------------------
-- View `mydb`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`view1`;
DROP VIEW IF EXISTS `mydb`.`view1` ;
USE `mydb`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
