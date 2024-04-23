-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DatabaseFinalERD
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DatabaseFinalERD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DatabaseFinalERD` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `DatabaseFinalERD` ;

-- -----------------------------------------------------
-- Table `DatabaseFinalERD`.`region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DatabaseFinalERD`.`region` (
  `REGION_NAME` VARCHAR(45) NOT NULL,
  `REGION_DESC` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`REGION_NAME`),
  UNIQUE INDEX `REGION_DESC` (`REGION_DESC` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DatabaseFinalERD`.`state`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DatabaseFinalERD`.`state` (
  `STATE_NAME` CHAR(2) NOT NULL,
  `REGION_NAME` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`STATE_NAME`),
  INDEX `REGION_NAME` (`REGION_NAME` ASC) VISIBLE,
  CONSTRAINT `state_ibfk_1`
    FOREIGN KEY (`REGION_NAME`)
    REFERENCES `DatabaseFinalERD`.`region` (`REGION_NAME`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DatabaseFinalERD`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DatabaseFinalERD`.`area` (
  `AREA_NAME` VARCHAR(25) NOT NULL,
  `AREA_STATE` CHAR(2) NOT NULL,
  PRIMARY KEY (`AREA_NAME`),
  INDEX `AREA_STATE` (`AREA_STATE` ASC) VISIBLE,
  CONSTRAINT `area_ibfk_1`
    FOREIGN KEY (`AREA_STATE`)
    REFERENCES `DatabaseFinalERD`.`state` (`STATE_NAME`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DatabaseFinalERD`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DatabaseFinalERD`.`department` (
  `DEP_NAME` VARCHAR(45) NOT NULL,
  `DEP_DESC` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`DEP_NAME`),
  UNIQUE INDEX `DEP_DESC` (`DEP_DESC` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DatabaseFinalERD`.`supervisor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DatabaseFinalERD`.`supervisor` (
  `SUP_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
  `SUP_FNAME` VARCHAR(45) NOT NULL,
  `SUP_LNAME` VARCHAR(45) NOT NULL,
  `SUP_MIDINT` VARCHAR(1) NULL DEFAULT NULL,
  `SUP_DEP` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SUP_ID`),
  INDEX `SUP_DEP` (`SUP_DEP` ASC) VISIBLE,
  CONSTRAINT `supervisor_ibfk_1`
    FOREIGN KEY (`SUP_DEP`)
    REFERENCES `DatabaseFinalERD`.`department` (`DEP_NAME`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DatabaseFinalERD`.`j_level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DatabaseFinalERD`.`j_level` (
  `JOB_LEVEL` INT NOT NULL,
  `LEVEL_DESC` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`JOB_LEVEL`),
  UNIQUE INDEX `LEVEL_DESC` (`LEVEL_DESC` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DatabaseFinalERD`.`job`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DatabaseFinalERD`.`job` (
  `JOB_DEP` VARCHAR(45) NOT NULL,
  `JOB_NAME` VARCHAR(45) NOT NULL,
  `JOB_SALARY` INT NOT NULL,
  `JOB_DESC` VARCHAR(200) NOT NULL,
  `JOB_LEVEL` INT NOT NULL,
  PRIMARY KEY (`JOB_NAME`, `JOB_DEP`),
  INDEX `JOB_DEP` (`JOB_DEP` ASC) VISIBLE,
  INDEX `JOB_LEVEL` (`JOB_LEVEL` ASC) VISIBLE,
  CONSTRAINT `job_ibfk_1`
    FOREIGN KEY (`JOB_DEP`)
    REFERENCES `DatabaseFinalERD`.`department` (`DEP_NAME`),
  CONSTRAINT `job_ibfk_2`
    FOREIGN KEY (`JOB_LEVEL`)
    REFERENCES `DatabaseFinalERD`.`j_level` (`JOB_LEVEL`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DatabaseFinalERD`.`locale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DatabaseFinalERD`.`locale` (
  `LOCALE_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
  `LOCALE_REGION` VARCHAR(45) NOT NULL,
  `LOCALE_STATE` CHAR(2) NOT NULL,
  `LOCALE_AREA` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`LOCALE_ID`),
  UNIQUE INDEX `LOCALE_NAME` (`LOCALE_REGION` ASC, `LOCALE_STATE` ASC, `LOCALE_AREA` ASC) VISIBLE,
  INDEX `LOCALE_STATE` (`LOCALE_STATE` ASC) VISIBLE,
  INDEX `LOCALE_AREA` (`LOCALE_AREA` ASC) VISIBLE,
  CONSTRAINT `locale_ibfk_1`
    FOREIGN KEY (`LOCALE_REGION`)
    REFERENCES `DatabaseFinalERD`.`region` (`REGION_NAME`),
  CONSTRAINT `locale_ibfk_2`
    FOREIGN KEY (`LOCALE_STATE`)
    REFERENCES `DatabaseFinalERD`.`state` (`STATE_NAME`),
  CONSTRAINT `locale_ibfk_3`
    FOREIGN KEY (`LOCALE_AREA`)
    REFERENCES `DatabaseFinalERD`.`area` (`AREA_NAME`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DatabaseFinalERD`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DatabaseFinalERD`.`employee` (
  `EMP_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
  `EMP_FNAME` VARCHAR(45) NOT NULL,
  `EMP_LNAME` VARCHAR(45) NOT NULL,
  `EMP_MIDINT` VARCHAR(1) NULL DEFAULT NULL,
  `EMP_DEP` VARCHAR(45) NOT NULL,
  `EMP_JOB` VARCHAR(45) NOT NULL,
  `EMP_DOB` DATE NOT NULL,
  `EMP_HDATE` DATE NOT NULL,
  `LOCALE_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
  `SUP_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY (`EMP_ID`),
  INDEX `SUP_ID` (`SUP_ID` ASC) VISIBLE,
  INDEX `EMP_JOB` (`EMP_JOB` ASC, `EMP_DEP` ASC) VISIBLE,
  INDEX `LOCALE_ID` (`LOCALE_ID` ASC) VISIBLE,
  CONSTRAINT `employee_ibfk_1`
    FOREIGN KEY (`SUP_ID`)
    REFERENCES `DatabaseFinalERD`.`supervisor` (`SUP_ID`),
  CONSTRAINT `employee_ibfk_2`
    FOREIGN KEY (`EMP_JOB` , `EMP_DEP`)
    REFERENCES `DatabaseFinalERD`.`job` (`JOB_NAME` , `JOB_DEP`),
  CONSTRAINT `employee_ibfk_3`
    FOREIGN KEY (`LOCALE_ID`)
    REFERENCES `DatabaseFinalERD`.`locale` (`LOCALE_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DatabaseFinalERD`.`priority`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DatabaseFinalERD`.`priority` (
  `TICKET_PRIORITY` INT NOT NULL,
  `PRIORITY_DESC` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`TICKET_PRIORITY`),
  UNIQUE INDEX `PRIORITY_DESC` (`PRIORITY_DESC` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DatabaseFinalERD`.`tkt_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DatabaseFinalERD`.`tkt_status` (
  `TICKET_STATUS` VARCHAR(30) NOT NULL,
  `STATUS_DESC` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`TICKET_STATUS`),
  UNIQUE INDEX `STATUS_DESC` (`STATUS_DESC` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `DatabaseFinalERD`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DatabaseFinalERD`.`ticket` (
  `TICKET_ID` INT(10) UNSIGNED ZEROFILL NOT NULL,
  `EMP_ID` INT(3) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  `TICKET_DESC` VARCHAR(200) NULL DEFAULT NULL,
  `TICKET_LOCALE_ID` INT(3) UNSIGNED ZEROFILL NOT NULL,
  `TICKET_START_DATE` DATE NOT NULL,
  `TICKET_END_DATE` DATE NULL DEFAULT NULL,
  `TICKET_STATUS` VARCHAR(30) NOT NULL,
  `TICKET_PRIORITY` INT NOT NULL,
  PRIMARY KEY (`TICKET_ID`),
  INDEX `EMP_ID` (`EMP_ID` ASC) VISIBLE,
  INDEX `TICKET_LOCALE_ID` (`TICKET_LOCALE_ID` ASC) VISIBLE,
  INDEX `TICKET_STATUS` (`TICKET_STATUS` ASC) VISIBLE,
  INDEX `TICKET_PRIORITY` (`TICKET_PRIORITY` ASC) VISIBLE,
  CONSTRAINT `ticket_ibfk_1`
    FOREIGN KEY (`EMP_ID`)
    REFERENCES `DatabaseFinalERD`.`employee` (`EMP_ID`),
  CONSTRAINT `ticket_ibfk_2`
    FOREIGN KEY (`TICKET_LOCALE_ID`)
    REFERENCES `DatabaseFinalERD`.`locale` (`LOCALE_ID`),
  CONSTRAINT `ticket_ibfk_3`
    FOREIGN KEY (`TICKET_STATUS`)
    REFERENCES `DatabaseFinalERD`.`tkt_status` (`TICKET_STATUS`),
  CONSTRAINT `ticket_ibfk_4`
    FOREIGN KEY (`TICKET_PRIORITY`)
    REFERENCES `DatabaseFinalERD`.`priority` (`TICKET_PRIORITY`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
