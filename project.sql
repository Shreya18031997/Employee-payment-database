--EMPLOYEE PAYMENT DATABASE
--create employee table
create table emp
(
eno  varchar2(5)primary key,
ename varchar2(15),
title varchar2(15) default 'programmer',
city varchar2(15),
check(title in('manager','programmer','support staff'))
);
select * from emp;
--create project table
create table proj
(
pnum varchar2(5) primary key,
pname varchar2(15),
budget number(7,2),
city varchar2(15)
);
select * from proj;
--create work table
create table works
(
enum varchar2(5) references emp(eno),
pnum varchar2(5) references proj(pnum),
dur number(3),
primary key(enum,pnum)
);
select * from works;
--create pay table
create table pay
(
title varchar2(15) primary key,
salary number(7,2),
check(title in('manager','programmer','support staff'))
);
select * from pay;
--description of employee table
desc emp;
--description of project table
desc proj;
--description of work table
desc works;
--description of pay tsble
desc pay;
--insert statement for employee table
insert into emp values('e1','shreya','manager','toronto');
insert into emp values('e2','reena','programmer','toronto');
insert into emp values('e3','kirti','support staff','toronto');
insert into emp values('e4','shivani','support staff','toronto');
insert into emp values('e5','pratibha','manager','london');
insert into emp values('e6','varsha','support staff','london');
insert into emp values('e7','manisha','programmer','london');
insert into emp values('e8','aanchal','programmer','london');
--insert statements for project table
insert into proj values('p1','medical','7500','london');
insert into proj values('p2','hotel','9500','new york');
insert into proj values('p3','hospital','8000','toronto');
--insert statements for works table
insert into works values('e1','p1',6);
insert into works values('e2','p1',6);
insert into works values('e3','p1',6);
insert into works values('e5','p2',9);
insert into works values('e6','p2',9);
insert into works values('e7','p2',9);
insert into works values('e8','p3',5);
insert into works values('e4','p3',5);
--insert statements for pay table
insert into pay values('programmer','5000');
insert into pay values('manager','15000');
insert into pay values('support staff','30000');
--display records of employee table
select * from emp;
--display records of project table
select * from proj;
--display records of work table
select * from works;
--display records of pay table
select * from pay;
--find cities in which project with maximum budget are handled
select city from proj where budget=(select max(budget)from proj);
--find all employees whose salary is less than the average salary
select c.eno,d.salary from emp c,pay d where c.title=d.title
and d.salary<(select avg(salary) from pay);
--for each city,how many projects are located in that city and what is the total budget over all projects in the city.
select count(pnum),sum(budget),city from proj group by city;
--for each project,what fraction of the budget is spent(in total) on salaries for the people working on that project?Sort your answer by the value of budget.
select sum(b.budget/d.salary) as "fraction_of_salary_in_budget",b.pnum,a.eno
from emp a,proj b,works c,pay d where a.eno=c.enum and b.pnum=c.pnum and 
a.title=d.title group by b.pnum,a.eno;
--find projects who has at least one employee working from different city than location of project.
select b.pname,a.city as "emp_city",b.city as "project_city" from emp a,proj b,works c where
a.ENO=c.ENUM and b.pnum=c.pnum and a.city <> b.city;
--for each project,what is the total salary amount for the people working on that project?Sort your answer by the value of the total salary amount.
select sum(c.salary),b.pnum from emp a,works b,pay c where a.eno=b.enum and a.title=c.title group by b.pnum;
--list all projects located in toronto and include for each one of persons working on the project.
select count(a.eno) from emp a,works b where a.eno=b.enum and 
b.pnum=(select pnum from proj where city='toronto');