/*Случайное тестовое задание по mySQL, найденное на просторах сети: сортируем сотрудников*/

create database employees;

/*Условие: Имеется таблица Сотрудники (sotr) со следующей структурой: */
create table employees.sotr (
    name varchar(100),
    address varchar(100),
    mesto varchar(100),
    sex varchar(1),
    birthdate date
);

insert into employees.sotr values
('Петр', 'Г.Москва, ул. Петрова, д.4', 'Москва', 'M', '1985-04-23'),
('Иван', 'Г.Киев, ул. Иванова, д.3', 'Киев', 'M', '1979-12-12'),
('Маша', 'Г.Москва, ул. Машина, д.1', 'Москва', 'W', '1980-09-11'),
('Федор', 'Г.Москва, ул. Федорова, д.10', 'Г.Москва, ул. Федорова, д.10', 'M', '1976-07-03');


/*Необходимо написать запрос, который выводит все записи по сотрудникам, родившимся в 1977 - 1983 годах*/
select * from employees.sotr where birthdate between '1977-01-01' and '1983-12-31';

/*выводим содержимое таблицы sotr по сотрудникам, у которых пол – женский */
select * from employees.sotr where sex='W';

/*Условие: Есть еще одна таблица zarp со следующей структурой: */
create table employees.zarp (
	sotr_name varchar(100),
    	sotr_zarp decimal(6,2)
);

insert into employees.zarp values
	('Петр', 100),
	('Федор', 200),
	('Маша', 300);

/* из таблиц SOTR и ZARP выводим информацию по сотруднику Федор:
Имя сотрудника; Адрес; Зарплата */
select name, address, sotr_zarp from employees.sotr join employees.zarp on zarp.sotr_name = sotr.name where name='Федор';


/*Написать запрос, который из таблиц SOTR и ZARP выводит следующую информацию:
Имя сотрудника; Адрес; Зарплата
Примечание. Если по одному из сотрудников зарплата не указана, то в результирующей выборке в поле Зарплата указывать 0.*/

/*Вариант решения 1 (ifnull):*/
select name, address, ifnull(sotr_zarp, 0) as zarp 
	from employees.sotr left join employees.zarp on zarp.sotr_name = sotr.name;

/*Вариант решения 2 (функция coalesce):*/ 
select name, address, coalesce(sotr_zarp, 0) as zarp 
	from employees.sotr left join employees.zarp on zarp.sotr_name = sotr.name;

/*Вариант решения 3 (функция if):*/
select name, address, if(sotr_zarp is null, 0, sotr_zarp) as zarp 
	from employees.sotr left join employees.zarp on zarp.sotr_name = sotr.name;


/*Есть таблица PAYMENTS с выплатами зарплаты по месяцам, со следующей структурой: */
create table employees.payments (
	sotr_name varchar(100),
    	pay_date date,
    	amount decimal(6,2)
);

insert into employees.payments values
	('Петр', '2007-03-30', 70),
    	('Федор', '2007-03-30', 200), 
    	('Петр', '2007-04-30', 100), 
   	('Маша', '2007-04-30', 250), 
    	('Федор', '2007-04-30', 200), 
    	('Федор', '2007-05-31', 200), 
    	('Маша', '2007-05-31', 300), 
    	('Петр', '2007-05-31', 100); 

/* Написать запрос, который из таблиц SOTR и PAYMENTS выводит следующую информацию:
Имя сотрудника; Общая выплаченная сумма
Примечание. Если по одному из сотрудников не было выплат, то в поле с общей выплаченной суммой указывать 0.
*/
select name, ifnull(sum(amount), 0) from employees.sotr left join employees.payments on payments.sotr_name=sotr.name group by name;



