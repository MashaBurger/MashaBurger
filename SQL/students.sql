/* ЗАДАНИЕ:
Допустим, что студенты должны ежемесячно выплачивать профсоюзный взнос в размере 100 рублей, 
при этом им разрешено платить частями в течение месяца.

Даны две таблицы: 
- студенты: Student (поля id, name, surname) и  
- профсоюзные взносы: Payment (student_id, amount, payment_date). 

Считаем, что платеж студента всегда относится к тому месяцу, в который он платит взнос. 
Если студент есть в таблице Student, то взнос он платить должен.

Напишите SQL-запрос, который позволит найти должников и сумму долга каждого из них профсоюзу за прошлый месяц 
(дата запуска может быть любая).*/

/*Решение: */

create table students.stud (
    id int primary key auto_increment,
    st_name varchar(100) not null,
    surname varchar(100) not null
    );

create table students.payment (
	  student_id int not null,
    amount decimal (6.2) not null,
    payment_date date not null,
    foreign key (student_id) references stud (id)
    );

  insert into students.stud (st_name, surname) values 
		  ('Иван', 'Логический'),
      ('Платон', 'Ассиметрический'),
      ('Юлия', 'Премурова'),
      ('Эвелина', 'Петрова'),
      ('Семен', 'Великовжицкий');

insert into students.payment values
      (1, 100, '2024-11-05'),
      (2, 100, '2024-11-10'),
      (3, 50, '2024-11-04'),
      (4, 100, '2024-11-15'),
      (1, 50, '2024-12-10'),
      (4, 100, '2024-12-15'),
      (2, 20, '2024-12-22'),
      (2, 50, '2024-12-28'),
      (5, 80, '2024-12-01'),
      (4, 100, '2025-01-08');


/*Находим должников и сумму долга за прошлый месяц*/

select st_name, surname, 100-sum(ifnull(amount, 0)) as duty 
from students.stud left join students.payment 
	on stud.id = payment.student_id 
    and date_format(payment_date, '%Y-%m') =  date_format(date_sub(curdate(), interval 1 month), '%Y-%m')
group by stud.id
having 100-sum(ifnull(amount, 0))>0;
      






