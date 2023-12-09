SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP SCHEMA IF EXISTS `shverdiakov_lab2`;
CREATE SCHEMA IF NOT EXISTS `shverdiakov_lab2` DEFAULT CHARACTER SET utf8 ;
USE `shverdiakov_lab2`;

DROP TABLE IF EXISTS `shverdiakov_lab2`.`owners`;
CREATE TABLE IF NOT EXISTS `shverdiakov_lab2`.`owners` (
  `idOwner` INT(10) NOT NULL AUTO_INCREMENT,
  `Owner` VARCHAR(100) NOT NULL COMMENT 'Хозяин вещи',
  `Group` VARCHAR(100) NOT NULL COMMENT 'A-06-21',
  UNIQUE INDEX `idOwnerINX` (`idOwner` ASC),
  PRIMARY KEY (`idOwner`)
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARACTER SET = utf8;

DROP TABLE IF EXISTS `shverdiakov_lab2`.`items`;
CREATE TABLE IF NOT EXISTS `shverdiakov_lab2`.`items` (
  `idItem` INT(10) NOT NULL AUTO_INCREMENT,
  `NameOfItem` VARCHAR(100) NOT NULL COMMENT 'Название предмета',
  `Photo` LONGBLOB NOT NULL COMMENT 'Фото вещи',
  `Quantity` INT(10) NOT NULL COMMENT 'Количество',
  PRIMARY KEY (`idItem`)
) ENGINE = InnoDB AUTO_INCREMENT = 9 DEFAULT CHARACTER SET = utf8;

DROP TABLE IF EXISTS `shverdiakov_lab2`.`inventory`;
CREATE TABLE IF NOT EXISTS `shverdiakov_lab2`.`inventory` (
  `idRelation` INT(10) NOT NULL AUTO_INCREMENT,
  `idOwner` INT(10) NOT NULL,
  `idItem` INT(10) NOT NULL,
  `Owner` VARCHAR(100) NOT NULL COMMENT 'Фамилия владельца',
  `NameOfItem` VARCHAR(100) NOT NULL COMMENT 'Название вещи',
  `Quantity` INT(10) NOT NULL,
  `Date` DATE NOT NULL COMMENT 'Дата приобретения',
  PRIMARY KEY (`idRelation`),
  INDEX `Quantity_INX` (`Quantity` ASC),
  INDEX `Date_INX` USING BTREE (`Date`),
  CONSTRAINT `FK_idOwner`
    FOREIGN KEY (`idOwner`)
    REFERENCES `shverdiakov_lab2`.`owners` (`idOwner`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_idItem`
    FOREIGN KEY (`idItem`)
    REFERENCES `shverdiakov_lab2`.`items` (`idItem`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 16 DEFAULT CHARACTER SET = utf8;

USE `shverdiakov_lab2`;
CREATE TABLE IF NOT EXISTS `shverdiakov_lab2`.`5_items_owner` (
  `idOwner` INT,
  `Owner` VARCHAR(100),
  `Group` VARCHAR(100),
  `NameOfItem` VARCHAR(100),
  `Quantity` INT(10),
  `Date` DATE
);

USE `shverdiakov_lab2`;
DROP FUNCTION IF EXISTS `shverdiakov_lab2`.`LargestQuantity`;

DELIMITER $$
CREATE FUNCTION `LargestQuantity`() RETURNS INT
DETERMINISTIC
BEGIN
   DECLARE result INT;
   SELECT MAX(Quantity) INTO result FROM items;
   RETURN result;
END$$

DELIMITER ;

USE `shverdiakov_lab2`;
DROP PROCEDURE IF EXISTS `shverdiakov_lab2`.`View_Table_5owners`;

DELIMITER $$
USE `shverdiakov_lab2`$$
CREATE PROCEDURE `View_Table_5owners`()
BEGIN
    SELECT idOwner, Owner, NameOfItem, Quantity FROM `shverdiakov_lab2`.`5_items_owner`;
END$$

DELIMITER ;

DROP TABLE IF EXISTS `shverdiakov_lab2`.`5_items_owner`;
DROP VIEW IF EXISTS `shverdiakov_lab2`.`5_items_owner`;
USE `shverdiakov_lab2`;
CREATE OR REPLACE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `shverdiakov_lab2`.`5_items_owner` AS
SELECT `shverdiakov_lab2`.`owners`.`idOwner` AS `idOwner`,
       `shverdiakov_lab2`.`owners`.`Owner` AS `Owner`,
       `shverdiakov_lab2`.`owners`.`Group` AS `Group`,
       `shverdiakov_lab2`.`inventory`.`NameOfItem` AS `NameOfItem`,
       `shverdiakov_lab2`.`inventory`.`Quantity` AS `Mark`
FROM `shverdiakov_lab2`.`owners`
JOIN `shverdiakov_lab2`.`inventory` ON (`shverdiakov_lab2`.`inventory`.`Owner` = `shverdiakov_lab2`.`owners`.`Owner`)
WHERE `shverdiakov_lab2`.`inventory`.`Quantity` = 5;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

START TRANSACTION;
USE `shverdiakov_lab2`;
INSERT INTO `shverdiakov_lab2`.`owners` (`idOwner`, `Owner`, `Group`) VALUES (1, 'Швердяков', 'А-06-21');
INSERT INTO `shverdiakov_lab2`.`owners` (`idOwner`, `Owner`, `Group`) VALUES (2, 'Щевелева', 'А-06-21');
INSERT INTO `shverdiakov_lab2`.`owners` (`idOwner`, `Owner`, `Group`) VALUES (3, 'Мащенок', 'А-13-21');
INSERT INTO `shverdiakov_lab2`.`owners` (`idOwner`, `Owner`, `Group`) VALUES (4, 'Лопатина', 'А-01-21');
INSERT INTO `shverdiakov_lab2`.`owners` (`idOwner`, `Owner`, `Group`) VALUES (5, 'Самсонова', 'А-05-21');
INSERT INTO `shverdiakov_lab2`.`owners` (`idOwner`, `Owner`, `Group`) VALUES (6, 'Федулов', 'А-02-21');
COMMIT;

START TRANSACTION;
USE `shverdiakov_lab2`;
INSERT INTO `shverdiakov_lab2`.`items` (`idItem`, `NameOfItem`, `Photo`, `Quantity`) VALUES (1, 'Ноутбук', BLOB, 10); -- instead o BLOB dummy insert a real BLOB
INSERT INTO `shverdiakov_lab2`.`items` (`idItem`, `NameOfItem`, `Photo`, `Quantity`) VALUES (2, 'Чашка', BLOB, 3);
INSERT INTO `shverdiakov_lab2`.`items` (`idItem`, `NameOfItem`, `Photo`, `Quantity`) VALUES (3, 'Принтер', BLOB, 7);
INSERT INTO `shverdiakov_lab2`.`items` (`idItem`, `NameOfItem`, `Photo`, `Quantity`) VALUES (4, 'Нож', BLOB, 5);
INSERT INTO `shverdiakov_lab2`.`items` (`idItem`, `NameOfItem`, `Photo`, `Quantity`) VALUES (5, 'Шторы', BLOB, 8);
INSERT INTO `shverdiakov_lab2`.`items` (`idItem`, `NameOfItem`, `Photo`, `Quantity`) VALUES (6, 'Хвост', BLOB, 3);
INSERT INTO `shverdiakov_lab2`.`items` (`idItem`, `NameOfItem`, `Photo`, `Quantity`) VALUES (7, 'Лапы', BLOB, 7);
INSERT INTO `shverdiakov_lab2`.`items` (`idItem`, `NameOfItem`, `Photo`, `Quantity`) VALUES (8, 'Лампа', BLOB, 4);
COMMIT;

START TRANSACTION;
USE `shverdiakov_lab2`;
INSERT INTO `shverdiakov_lab2`.`inventory` (`idRelation`, `idOwner`, `idItem`, `Owner`, `NameOfItem`, `Quantity`, `Date`) VALUES (1, 1, 1, 'Швердяков', 'Ноутбук', 5, '2023-01-01');
INSERT INTO `shverdiakov_lab2`.`inventory` (`idRelation`, `idOwner`, `idItem`, `Owner`, `NameOfItem`, `Quantity`, `Date`) VALUES (2, 1, 2, 'Швердяков', 'Чашка', 2, '2023-02-15');
INSERT INTO `shverdiakov_lab2`.`inventory` (`idRelation`, `idOwner`, `idItem`, `Owner`, `NameOfItem`, `Quantity`, `Date`) VALUES (3, 1, 3, 'Швердяков', 'Принтер', 2, '2023-06-30');
INSERT INTO `shverdiakov_lab2`.`inventory` (`idRelation`, `idOwner`, `idItem`, `Owner`, `NameOfItem`, `Quantity`, `Date`) VALUES (4, 3, 4, 'Мащенок', 'Нож', 3, '2023-09-10');
INSERT INTO `shverdiakov_lab2`.`inventory` (`idRelation`, `idOwner`, `idItem`, `Owner`, `NameOfItem`, `Quantity`, `Date`) VALUES (5, 5, 5, 'Самсонова', 'Шторы', 5, '2023-10-25');
INSERT INTO `shverdiakov_lab2`.`inventory` (`idRelation`, `idOwner`, `idItem`, `Owner`, `NameOfItem`, `Quantity`, `Date`) VALUES (6, 4, 6, 'Лопатина', 'Хвост', 2, '2023-12-31');
INSERT INTO `shverdiakov_lab2`.`inventory` (`idRelation`, `idOwner`, `idItem`, `Owner`, `NameOfItem`, `Quantity`, `Date`) VALUES (7, 2, 7, 'Щевелева', 'Лапы', 3, '2023-09-16');
INSERT INTO `shverdiakov_lab2`.`inventory` (`idRelation`, `idOwner`, `idItem`, `Owner`, `NameOfItem`, `Quantity`, `Date`) VALUES (8, 2, 8, 'Федулов', 'Лампа', 3, '2023-09-17');

COMMIT;

USE `shverdiakov_lab2`;

DELIMITER $$

USE `shverdiakov_lab2`$$
DROP TRIGGER IF EXISTS `shverdiakov_lab2`.`AfterDeleteGroup` $$
USE `shverdiakov_lab2`$$
CREATE
TRIGGER `shverdiakov_lab2`.`AfterDeleteGroup`
AFTER DELETE ON `shverdiakov_lab2`.`owners`
FOR EACH ROW
BEGIN
DELETE FROM inventory WHERE idOwner = OLD.idOwner;
END$$


USE `shverdiakov_lab2`$$
DROP TRIGGER IF EXISTS `shverdiakov_lab2`.`InsertTrigger` $$
USE `shverdiakov_lab2`$$
CREATE
TRIGGER `shverdiakov_lab2`.`InsertTrigger`
BEFORE INSERT ON `shverdiakov_lab2`.`inventory`
FOR EACH ROW
BEGIN
DECLARE cnt INT DEFAULT 0;
SELECT COUNT(*) INTO cnt FROM owners
WHERE NEW.idOwner = owners.idOwner;
IF cnt = 0 THEN
signal sqlstate '45000' set message_text = 'Ошибка! Владельца с таким номером нет';
END IF;
END$$

DELIMITER ;