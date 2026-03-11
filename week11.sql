DELIMITER $$

CREATE PROCEDURE sakila.getaddress()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_address VARCHAR(255);

    DECLARE addressdetail CURSOR FOR
        SELECT address FROM sakila.address;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN addressdetail;

    read_loop: LOOP
        FETCH addressdetail INTO v_address;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SELECT v_address AS address;
    END LOOP;

    CLOSE addressdetail;
END $$

DELIMITER ;

CALL getaddress();


DELIMITER $$

CREATE PROCEDURE sakila.getactorname()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_firstname VARCHAR(50);
    DECLARE v_lastname VARCHAR(50);

    DECLARE actornamedetail CURSOR FOR
        SELECT first_name, last_name FROM sakila.actor;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN actornamedetail;

    read_loop: LOOP
        FETCH actornamedetail INTO v_firstname, v_lastname;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SELECT v_firstname AS first_name, v_lastname AS last_name;
    END LOOP;

    CLOSE actornamedetail;
END $$

DELIMITER ;

CALL sakila.getactorname();