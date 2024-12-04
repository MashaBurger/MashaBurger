/*Случайное тестовое задание по mySQL, найденное на просторах сети*/

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
('Петр', '100'),
('Федор', '200'),
('Маша', '300');

/* из таблиц SOTR и ZARP выводим информацию по сотруднику Федор:
Имя сотрудника; Адрес; Зарплата */
select name, address, sotr_zarp from employees.sotr join employees.zarp on zarp.sotr_name = sotr.name where name='Федор';





