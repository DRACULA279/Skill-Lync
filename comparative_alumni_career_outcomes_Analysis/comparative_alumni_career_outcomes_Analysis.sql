-- Active: 1767506199827@@127.0.0.1@3306@alumni
CREATE DATABASE alumni; -- Schema "alumni" created successfully and imported all the .csv files as tables


-- Structure of the tables (description)

DESCRIBE college_a_hs; -- Higher Secondary college a
DESCRIBE college_a_se; -- Self Employed
DESCRIBE college_a_sj; -- Service/job
DESCRIBE college_b_hs;-- Higher Secondary college b
DESCRIBE college_b_se;
DESCRIBE college_b_sj;

SELECT * FROM college_a_hs_v;

DELIMITER $$

CREATE PROCEDURE lower_case_views()
BEGIN

SELECT 
RollNo,
LOWER(Name) AS Name,
LOWER(FatherName) AS FatherName,
LOWER(MotherName) AS MotherName
FROM college_a_hs_v;

SELECT 
RollNo,
LOWER(Name) AS Name,
LOWER(FatherName) AS FatherName,
LOWER(MotherName) AS MotherName
FROM college_a_se_v;

SELECT 
RollNo,
LOWER(Name) AS Name,
LOWER(FatherName) AS FatherName,
LOWER(MotherName) AS MotherName
FROM college_a_sj_v;

SELECT 
RollNo,
LOWER(Name) AS Name,
LOWER(FatherName) AS FatherName,
LOWER(MotherName) AS MotherName
FROM college_b_hs_v;

SELECT 
RollNo,
LOWER(Name) AS Name,
LOWER(FatherName) AS FatherName,
LOWER(MotherName) AS MotherName
FROM college_b_se_v;

SELECT 
RollNo,
LOWER(Name) AS Name,
LOWER(FatherName) AS FatherName,
LOWER(MotherName) AS MotherName
FROM college_b_sj_v;

END$$

DELIMITER ;

CALL lower_case_views();


-- college A 

DELIMITER $$

CREATE PROCEDURE get_name_collegeA()
BEGIN

DECLARE done INT DEFAULT 0;
DECLARE student_name VARCHAR(100);

DECLARE cur CURSOR FOR
SELECT Name FROM college_a_hs_v
UNION
SELECT Name FROM college_a_se_v
UNION
SELECT Name FROM college_a_sj_v;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

CREATE TEMPORARY TABLE temp_students(
student_name VARCHAR(100)
);

OPEN cur;

read_loop: LOOP

FETCH cur INTO student_name;

IF done = 1 THEN
LEAVE read_loop;
END IF;

INSERT INTO temp_students VALUES(student_name);

END LOOP;

CLOSE cur;

SELECT * FROM temp_students;

DROP TEMPORARY TABLE temp_students;

END$$

DELIMITER ;

CALL get_name_collegeA();


--college_B

DELIMITER $$

CREATE PROCEDURE get_name_collegeB()
BEGIN

DECLARE done INT DEFAULT 0;
DECLARE student_name VARCHAR(100);

DECLARE cur CURSOR FOR
SELECT Name FROM college_b_hs_v
UNION
SELECT Name FROM college_b_se_v
UNION
SELECT Name FROM college_b_sj_v;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

CREATE TEMPORARY TABLE temp_students(
student_name VARCHAR(100)
);

OPEN cur;

read_loop: LOOP

FETCH cur INTO student_name;

IF done = 1 THEN
LEAVE read_loop;
END IF;

INSERT INTO temp_students VALUES(student_name);

END LOOP;

CLOSE cur;

SELECT * FROM temp_students;

DROP TEMPORARY TABLE temp_students;

END$$

DELIMITER ;

CALL get_name_collegeB();


-- percentage of career choices 

SELECT 
College,
Career,
ROUND((Students / Total) * 100, 2) AS Percentage
FROM
(
    SELECT 
    'College A' AS College,
    'Higher Studies' AS Career,
    COUNT(*) AS Students,
    (
        (SELECT COUNT(*) FROM college_a_hs_v) +
        (SELECT COUNT(*) FROM college_a_se_v) +
        (SELECT COUNT(*) FROM college_a_sj_v)
    ) AS Total
    FROM college_a_hs_v

    UNION ALL

    SELECT 
    'College A',
    'Self Employed',
    COUNT(*),
    (
        (SELECT COUNT(*) FROM college_a_hs_v) +
        (SELECT COUNT(*) FROM college_a_se_v) +
        (SELECT COUNT(*) FROM college_a_sj_v)
    )
    FROM college_a_se_v

    UNION ALL

    SELECT 
    'College A',
    'Service / Job',
    COUNT(*),
    (
        (SELECT COUNT(*) FROM college_a_hs_v) +
        (SELECT COUNT(*) FROM college_a_se_v) +
        (SELECT COUNT(*) FROM college_a_sj_v)
    )
    FROM college_a_sj_v

    UNION ALL

    SELECT 
    'College B',
    'Higher Studies',
    COUNT(*),
    (
        (SELECT COUNT(*) FROM college_b_hs_v) +
        (SELECT COUNT(*) FROM college_b_se_v) +
        (SELECT COUNT(*) FROM college_b_sj_v)
    )
    FROM college_b_hs_v

    UNION ALL

    SELECT 
    'College B',
    'Self Employed',
    COUNT(*),
    (
        (SELECT COUNT(*) FROM college_b_hs_v) +
        (SELECT COUNT(*) FROM college_b_se_v) +
        (SELECT COUNT(*) FROM college_b_sj_v)
    )
    FROM college_b_se_v

    UNION ALL

    SELECT 
    'College B',
    'Service / Job',
    COUNT(*),
    (
        (SELECT COUNT(*) FROM college_b_hs_v) +
        (SELECT COUNT(*) FROM college_b_se_v) +
        (SELECT COUNT(*) FROM college_b_sj_v)
    )
    FROM college_b_sj_v

) AS CareerStats;
