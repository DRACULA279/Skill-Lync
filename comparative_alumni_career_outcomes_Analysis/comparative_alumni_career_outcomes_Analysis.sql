-- Active: 1767506199827@@127.0.0.1@3306@alumni
CREATE DATABASE alumni; -- Schema "alumni" created successfully and imported all the .csv files as tables


-- Structure of the tables (description)

DESCRIBE college_a_hs; -- Higher Secondary college a
DESCRIBE college_a_se; -- Self Employed
DESCRIBE college_a_sj; -- Service/job
DESCRIBE college_b_hs;-- Higher Secondary college b
DESCRIBE college_b_se;
DESCRIBE college_b_sj;

SELECT * FROM college_b_sj_v;