CREATE TABLE DOCTOR
(DOC_ID INT PRIMARY KEY,
F_NAME VARCHAR(20),
LNAME VARCHAR(20),
SPECIALTY VARCHAR(20),
PHONE VARCHAR(20))

DROP  TABLE PATIENT

CREATE TABLE PATIENT
(PAT_ID INT PRIMARY KEY,
FNAME VARCHAR(20),
LNAME VARCHAR(25),
INSURANCE_COMPANY VARCHAR(25),
PHONE VARCHAR(10))

CREATE TABLE CASE1
(CAE_DATE DATE,
PAT_ID INT,
DOC_ID INT,
DIAGNOSIS VARCHAR(150))

CREATE TABLE FEE_PAYMENT
(PAY_DATE DATE,
CASE_ID INT,
AMOUNT FLOAT,
PAY_TYE VARCHAR(20))



CREATE TABLE COUNTRY
(COUNTRY_ID INT PRIMARY KEY,
COUNTRY_NAME VARCHAR(15))

CREATE TABLE RESORT
(RESORT_ID INT PRIMARY KEY,
RESORT_NAME VARCHAR(20),
COUNTRY_ID INT)

DROP TABLE CUSTOMER

DROP TABLE INQUIRY
CREATE TABLE CUSTOMER
(CUST_ID INT PRIMARY KEY,
CUST_NAME VARCHAR(20), 
PHONE VARCHAR(15),
COUNTRY_ID INT)


INSERT INTO COUNTRY VALUES(1, 'US');
INSERT INTO COUNTRY VALUES(2, 'INDIA');
INSERT INTO COUNTRY VALUES(3, 'SRILANKA');
INSERT INTO COUNTRY VALUES(4, 'MALDIVES');


INSERT INTO RESORT VALUES(50, 'BEACH FRONT', 4);
INSERT INTO RESORT VALUES(51, 'OBERAI, GOA', 2);
INSERT INTO RESORT VALUES(52, 'TAJ MALDIVES', 4);
INSERT INTO RESORT VALUES(53, 'TAJ CHENNAI', 2);

INSERT INTO CUSTOMER VALUES(1001, 'TIM DOWNEY', '123456789', 1);
INSERT INTO CUSTOMER VALUES(1002, 'RAMESH K', '596869689', 2);
INSERT INTO CUSTOMER VALUES(1003, 'BILL PRICE', '74849498', 1);
INSERT INTO CUSTOMER VALUES(1004, 'MALINGA', '83733938', 3);
INSERT INTO CUSTOMER VALUES(1005, 'FAROOQ', '8958498', 4);


ALTER TABLE RESORT
ADD CONSTRAINT FK_COUNTRYID
FOREIGN KEY(COUNTRY_ID) REFERENCES COUNTRY(COUNTRY_ID)

ALTER TABLE CUSTOMER
ADD CONSTRAINT FK_COUNTRY_ID
FOREIGN KEY(COUNTRY_ID) REFERENCES COUNTRY(COUNTRY_ID)

SELECT COUNTRY_NAME, COUNT(RESORT_ID) RESORT_COUNT 
FROM COUNTRY C INNER JOIN RESORT R ON C.COUNTRY_ID=R.COUNTRY_ID
GROUP BY COUNTRY_NAME

SELECT COUNTRY_NAME, COUNT(CUST_ID) CUSTOMER_COUNT 
FROM COUNTRY C INNER JOIN CUSTOMER C1 ON C.COUNTRY_ID = C1.COUNTRY_ID
GROUP BY COUNTRY_NAME

SELECT COUNTRY_NAME, COUNT(RESORT_ID) RESORT_COUNT, COUNT(CUST_ID) CUSTOMER_COUNT 
FROM COUNTRY C LEFT OUTER JOIN CUSTOMER C1 
ON C.COUNTRY_ID = C1.COUNTRY_ID
LEFT OUTER JOIN RESORT R ON R.COUNTRY_ID=C.COUNTRY_ID
GROUP BY COUNTRY_NAME



SELECT * FROM COUNTRY
select * from resort
SELECT * FROM CUSTOMER


SELECT COUNTRY_NAME, RESORT_NAME, CUST_NAME 
FROM COUNTRY C INNER JOIN CUSTOMER C1 
ON C.COUNTRY_ID = C1.COUNTRY_ID
INNER JOIN RESORT R ON R.COUNTRY_ID=C.COUNTRY_ID
GROUP BY COUNTRY_NAME

SELECT COUNTRY_NAME FROM COUNTRY 
WHERE COUNTRY_ID NOT IN (SELECT COUNTRY_ID FROM RESORT)

SELECT COUNTRY_NAME, COUNT(CUST_ID) CUSTOMER_COUNT 
FROM COUNTRY C INNER JOIN CUSTOMER C1 
ON C.COUNTRY_ID = C1.COUNTRY_ID
GROUP BY COUNTRY_NAME
HAVING  COUNT(CUST_ID) >= 100

SELECT COUNTRY_NAME, COUNT(RESORT_ID) 
FROM COUNTRY C INNER JOIN RESORT R 
ON R.COUNTRY_ID=C.COUNTRY_ID
WHERE RESORT_NAME = 'BEACH FRONT'
GROUP BY COUNTRY_NAME

SELECT CUST_NAME FROM CUSTOMER
WHERE (CUST_NAME LIKE 'F%' OR CUST_NAME LIKE 'R%') 
AND COUNTRY_ID IN (SELECT COUNTRY_ID 
FROM COUNTRY WHERE COUNTRY_NAME = 'INDIA' OR COUNTRY_NAME = 'SRILANKA')

SELECT CUST_NAME FROM CUSTOMER 
WHERE COUNTRY_ID IN 
(SELECT COUNTRY_ID FROM COUNTRY WHERE COUNTRY_NAME = 'US') 
AND PHONE IS NULL 

SELECT COUNTRY_NAME, RESORT_NAME 
FROM COUNTRY C LEFT OUTER JOIN RESORT R
ON C.COUNTRY_ID= R.COUNTRY_ID

SELECT DAYNAME(CURDATE())

SELECT MONTHNAME(CURDATE())

SELECT * FROM BOOK

create table deparment(
dept_id int primary key,
dept_name varchar(26), 
dept_loc varchar(15))

insert into deparment values(10,'Accounting','Banglore');
insert into deparment values(11,'IT','Banglore');
insert into deparment values(12,'Production','Mysore');
drop table emP
create table emP(
emp_id int primary key,
emp_name varchar(20),
dept_id int,
CTC int,
date_of_join date,
date_of_birth date,
job_id int,
Gender char(1))

insert into emP values(100,'Ram',10,340000,'2018-01-10','1998-11-08',50,'M');
insert into emP values(101,'Tim',11,400000,'2019-04-15','1980-01-18',52,'M');
insert into emP values(102,'Uma',10,450000,'2018-10-18','1984-04-22',50,'F');
insert into emP values(103,'Kumar',10,500000,'2021-01-10','1992-04-01',53,'M');
insert into emP values(104,'Mahesh',11,500000,'2021-01-14','1990-08-04',52,'M');
insert into emP values(105,'Rama',10,150000,'2020-01-15','1995-11-14',51,'F');
insert into emP values(106,'Suraj',11,200000,'2019-03-14','1993-05-17',51,'M');

create table jobs(
job_id int primary key,
job_role varchar(30),
jo_desc varchar(50),
min_ctc int,
max_ctc int)

alter table emP
add constraint FK_deptid
FOREIGN KEY(dept_id) references deparment(dept_id)

alter table emP
add constraint FK_jobid
FOREIGN KEY(job_id) references jobs(job_id)

insert into jobs values(50, 'Accountant', 'Book keeping',300000,500000);
insert into jobs values(51, 'Operation Exexcutive', 'Overseas Operations',100000,200000);
insert into jobs values(52, 'Software Engineer', 'Develop Applications',400000,800000);
insert into jobs values(53, 'Finance Analyst', 'Support Management team',400000,700000);
insert into jobs values(54, 'CFO', 'Responsible for entire finance in the company',800000,1400000);

select emp_name,YEAR(sysdate())-YEAR(date_of_birth) emp_year from emP 
where MONTH(date_of_birth)=5

select dept_name,emp_name, max(CTC) from emP e inner join deparment d 
on e.dept_id = d.dept_id
group by dept_name

select dept_name, emp_name,salary_rank from
(select dept_name, emp_name, dense_rank () over( partition by dept_name order by ctc desc) as salary_rank
from emP e inner join deparment d 
on e.dept_id = d.dept_id)temp
where salary_rank<=2

select dept_name from deparment
where dept_id not in (select dept_id from emP)

select job_role from jobs where job_id in
(select temp1.job_id from
(select job_id from emP where dept_id=10)temp1 
inner join
(select job_id from emP where dept_id=11)temp2
on temp1.job_id=temp2.job_id)

select emp_name from emP e inner join jobs j
on e.job_id=j.job_id
where ctc not between min_ctc and max_ctc

select dept_name, emp_name,job_role from emP e 
inner join deparment d 
on e.dept_id=d.dept_id
inner join jobs j
on e.job_id=j.job_id
where MONTH(date_of_join)=4 and YEAR(date_of_join)=2019

select job_role from jobs where job_id not in(select job_id from emP)

select dept_name, count(emp_id) no_of_employee, count(distinct job_id) no_of_job_roles
from deparment d inner join emP e 
on d.dept_id=e.dept_id
group by dept_name

select dept_name, 
sum( case when gender = 'M'then 1 else 0 end) as no_of_male_employee,
sum( case when gender = 'F'then 1 else 0 end) as no_of_female_employee 
from deparment d inner join emP e
on d.dept_id=e.dept_id
group by dept_name

select dept_name,emp_name,jo_desc from emP e 
inner join deparment d on d.dept_id=e.dept_id
inner join jobs j on j.job_id=e.job_id
where gender='F' 
and (MONTH(date_of_join)=1 or MONTH(date_of_join)=11) 
and (Year(date_of_join)=2018 or Year(date_of_join)=2020)

select dept_name,emp_name,max(YEAR(sysdate())-YEAR(date_of_birth)) emp_ager 
from emP e inner join deparment d
on d.dept_id=e.dept_id

select job_role,max(no_of_employee) from jobs j inner join
(select job_id,count(job_id) no_of_employee from emP
group by job_id)temp 
on j.job_id=temp.job_id

select job_role from 
(select job_role, rank() over(order by temp.no_of_employee desc) as max_employee_rank from jobs j  inner join 
(select job_id,count(job_id) no_of_employee from emP
group by job_id)temp 
on j.job_id = temp.job_id)temp1
where max_employee_rank = 1

create view employee_view as 
select dept_name,dept_loc,emp_name,date_of_join, 
YEAR(sysdate())-Year(date_of_join) as years_of_experience_in_our_company,
date_of_birth,YEAR(sysdate())-YEAR(date_of_birth) emp_age,gender
from deparment d inner join emP e 
on d.dept_id=e.dept_id

