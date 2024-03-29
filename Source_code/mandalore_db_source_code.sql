-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mandalore
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mandalore
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mandalore` DEFAULT CHARACTER SET utf8 ;
USE `mandalore` ;

-- -----------------------------------------------------
-- Table `mandalore`.`locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mandalore`.`locations` (
  `location_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mandalore`.`people`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mandalore`.`people` (
  `people_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `homeworld_id` SMALLINT NOT NULL,
  PRIMARY KEY (`people_id`),
  INDEX `fk_people_locations_idx` (`homeworld_id` ASC) VISIBLE,
  CONSTRAINT `fk_people_locations`
    FOREIGN KEY (`homeworld_id`)
    REFERENCES `mandalore`.`locations` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mandalore`.`organizations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mandalore`.`organizations` (
  `organization_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `location_id` SMALLINT NOT NULL,
  PRIMARY KEY (`organization_id`),
  INDEX `fk_organizations_locations1_idx` (`location_id` ASC) VISIBLE,
  CONSTRAINT `fk_organizations_locations1`
    FOREIGN KEY (`location_id`)
    REFERENCES `mandalore`.`locations` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mandalore`.`events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mandalore`.`events` (
  `event_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `location_id` SMALLINT NOT NULL,
  `date` VARCHAR(50) NOT NULL,
  `notes` VARCHAR(255) NULL,
  PRIMARY KEY (`event_id`),
  INDEX `fk_events_locations1_idx` (`location_id` ASC) VISIBLE,
  CONSTRAINT `fk_events_locations1`
    FOREIGN KEY (`location_id`)
    REFERENCES `mandalore`.`locations` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mandalore`.`participants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mandalore`.`participants` (
  `people_id` SMALLINT NOT NULL,
  `event_id` SMALLINT NOT NULL,
  PRIMARY KEY (`people_id`, `event_id`),
  INDEX `fk_people_has_events_events1_idx` (`event_id` ASC) VISIBLE,
  INDEX `fk_people_has_events_people1_idx` (`people_id` ASC) VISIBLE,
  CONSTRAINT `fk_participants_people1`
    FOREIGN KEY (`people_id`)
    REFERENCES `mandalore`.`people` (`people_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_partiipants_events1`
    FOREIGN KEY (`event_id`)
    REFERENCES `mandalore`.`events` (`event_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mandalore`.`affiliations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mandalore`.`affiliations` (
  `people_id` SMALLINT NOT NULL,
  `organization_id` SMALLINT NOT NULL,
  INDEX `fk_affiliations_people1_idx` (`people_id` ASC) VISIBLE,
  INDEX `fk_affiliations_organizations1_idx` (`organization_id` ASC) VISIBLE,
  PRIMARY KEY (`people_id`, `organization_id`),
  CONSTRAINT `fk_affiliations_people1`
    FOREIGN KEY (`people_id`)
    REFERENCES `mandalore`.`people` (`people_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_affiliations_organizations1`
    FOREIGN KEY (`organization_id`)
    REFERENCES `mandalore`.`organizations` (`organization_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
