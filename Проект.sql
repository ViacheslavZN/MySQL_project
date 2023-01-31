/* Проект "Аккредитация специалистов"
 * Проект представляет собой базу данных, содержащую информацию по присвоению профессиональных званий практикующим специалистам, состояющим в 
 * профессиональном сообществе.
 * Для аккредитации важна информация об общем стаже работы человека, указываемым им в заявлении, личные данные, уровень образования, повышение 
 * квалификации (CPD), участия в мероприятиях сообщества, в том числе в качестве организатора.
 * В аккредитации специалиста участвуют 2 эксперта, выбираемых из базы экспертов, они принимают решение о присвоении звания, которое хранится в таблице Membership.
 *Вступаю в профессиональное сообщество заявитель указывает одно из направлений, наиболее подходяющее ему, список направлений содержится в 
 * таблице directions.
 * В ходе экспертной оценки проводится оценка компетенций, каждый пользователь должен соответствовать всем из набора. 
 * Повышение компетенции CPD соответствует каждой из компетенций.*/


DROP database IF EXISTS accreditation; 
create database accreditation;

use accreditation;

drop table if exists users;
create table users 
(
id serial primary key, -- serial=bigint unsigned unique not null,
firstname varchar(100),
lastname varchar(100), 
date_of_birth date,
gender char(1),
summ_work_experience int, 
email VARCHAR(100) unique,
phone bigint unsigned,
passport_number bigint unsigned unique,
company varchar(100),
current_position varchar(100),
INDEX users_firstname_lastname_idx(lastname, firstname)
);


insert into users 
values
('1', 'Ali', 'Mante', '2015-07-28', 'F', 1, 'howe.nickolas@example.net', '1', '43980241', 'Botsford LLC', 'manager'),
('2', 'Ashtyn', 'Schuster', '2005-11-19', 'M', 5, 'citlalli.medhurst@example.com', '511441', '9712393', 'Mraz-Zieme', 'head of department'),
('3', 'Hannah', 'Pfeffer', '1978-08-09', 'F', 8, 'jess.runolfsdottir@example.net', '3466939438', '19670', 'Casper LLC', 'engineer'),
 ('4', 'Kade', 'Zulauf', '2012-01-26', 'M', 6, 'stamm.eldora@example.com', '8030724885', '6726080', 'Witting-Oberbrunner', 'engineer'),
 ('5', 'Bennie', 'Harber', '1989-05-12', 'F', 3, 'westley.fritsch@example.com', '4213292936', '282', 'Wuckert, Gorczany and Lang','manager'),
 ('6', 'Theron', 'Dickinson', '1998-06-20', 'M', 7, 'eichmann.jaren@example.com', '100', '0', 'Ebert PLC', ' manager'),
 ('7', 'Rita', 'Gulgowski', '2019-12-07', 'M', 9, 'ervin.huels@example.com', '153', '62426', 'Lowe-Pfeffer', ' engineer '),
 ('8', 'Alanis', 'Wunsch', '2012-05-07', 'M', 6, 'derrick31@example.org', '858', '74406998', 'Doyle, Kub and Jenkins', ' engineer'),
 ('9', 'Freida', 'Berge', '1988-12-23', 'M', 8, 'stephania64@example.org', '1', '42869000', 'McDermott Group', 'head of department'),
 ('10', 'Audie', 'Lang', '1979-12-08', 'M', 3, 'xjerde@example.org', '0', '7270732', 'Glover LLC', ' engineer '),
 ('11', 'Drake', 'Shanahan', '1987-10-13', 'F', 1, 'paucek.maida@example.net', '997', '706', 'Goldner-D\'Amore', 'head of department'),
 ('12', 'Geovany', 'Lowe', '1973-02-22', 'M', 5, 'mhane@example.net', '0', '863', 'Dach-Trantow', ' engineer');

______________________________________ 
1-1
drop table if exists directions;
create table directions
(dir_id bigint unsigned unique not null primary key,
direction varchar(150)
);

insert into directions 
values
(1, 'electrical engineering'),
(2, 'mechanical engineering'),
(3, 'economy'),
(4, 'environment'),
(5, 'safety'),
(6, 'automatic systems'),
(7, 'digital technologies');

drop table if exists user_directions;
create table user_directions
(
dir_id bigint unsigned not null,
users_id bigint unsigned not null primary key,
FOREIGN KEY (users_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE cascade,
FOREIGN KEY (dir_id) REFERENCES directions(dir_id) ON UPDATE CASCADE ON DELETE cascade
);

insert into user_directions 
values
(2,1),
(1,2),
(3,3),
(4,4),
(2,5),
(3,6),
(6,7),
(7,8),
(5,9),
(3,10),
(5,11),
(6,12);

______________________________________ 

drop table if exists experts;
create table experts 
(
expert_id serial primary key,
firstname varchar(100),
lastname varchar(100), 
date_of_birth date,
gender char(1),
company varchar(100),
current_position varchar(100), 
certificate_number bigint not null unique, 
Valid_till date,
INDEX users_firstname_lastname_idx(lastname, firstname)
)


insert into experts values
('1', 'Shanel', 'Weimann', '2021-03-18', 'F', 'Spinka Ltd', 'manager', '123456', '2022-11-28'),
('2', 'Elody', 'Lind', '2003-06-01', 'F', 'Balistreri-Schulist', 'financial adviser', '13345209', '2022-05-10'),
('3', 'Adrian', 'Senger', '2016-03-05', 'M', 'Ritchie, Corwin and Bailey', 'engineer', '4', '2022-02-08'),
('4', 'Madison', 'Hettinger', '2016-01-06', 'F', 'Koelpin-Quigley', 'seniour engineer', '545', '2022-02-28'),
('5', 'Rodolfo', 'Jerde', '2014-09-27', 'M', 'Wilkinson-D\'Amore', 'manager', '24499223', '2022-04-28'),
('6', 'Dustin', 'Willms', '1998-01-26', 'M', 'Hammes, Mitchell and Schoen', 'engineer', '59', '2022-03-12'),
('7', 'Marielle', 'Kuphal', '2021-09-17', 'F', 'Hickle, Jones and Lueilwitz','director', '71293567', '2022-08-06'),
('8', 'Constance', 'Lehner', '1987-11-15', 'F', 'Corwin, Hudson and Dare', 'senour adviser', '75870', '2022-01-28'),
('9', 'Kiana', 'Kuhlman', '1999-11-01', 'F', 'Kessler-Schoen', 'engineer', '318287', '2022-01-29'),
('10', 'Jessika', 'McGlynn', '1997-05-04', 'F', 'Weissnat LLC', 'engineer', '48933655', '2022-11-06'),
('11', 'Juliet', 'Leannon', '1992-08-09', 'F', 'Cremin, Beatty and Legros', 'director', '30778', '2022-06-29'),
('12', 'Dedrick', 'Nolan', '1974-11-27', 'M', 'Doyle-Rau', 'CEO', '728', '2022-06-16');

_______________________________________________________

drop table if exists application_process;
create table application_process 
(
application_id serial primary key,
user_id bigint unsigned not null,
date_of_application date,
peer_review_date date,
expert_1_id bigint unsigned not null,
expert_2_id bigint unsigned not null,
interview_date date,
interview_results ENUM ('supported', 'denied', 'postponed'),
certificate_number bigint unique not null,
approval_date date,
FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (expert_1_id) REFERENCES experts(expert_id) ON UPDATE CASCADE ON DELETE cascade,
FOREIGN KEY (expert_2_id) REFERENCES experts(expert_id) ON UPDATE CASCADE ON DELETE CASCADE
)

insert into application_process 
values
 ('1', '1', '2021-06-10', '2021-05-13', '6', '1', '2022-10-22', 'denied', '81', '2022-04-29'),
 ('2', '2', '2021-03-23', '2021-11-03', '5', '1', '2022-12-13', 'supported', '15283', '2022-04-07'),
 ('3', '3', '2021-10-09', '2021-10-01', '3', '5', '2022-04-05', 'supported', '187', '2022-05-28'),
 ('4', '4', '2021-04-30', '2021-10-10', '3', '7', '2022-11-26', 'supported', '10944', '2022-11-20'),
 ('5', '5', '2021-05-20', '2021-04-06', '2', '3', '2022-02-13', 'postponed', '1514983', '2022-09-04'),
 ('6', '6', '2021-08-19', '2021-11-04', '3', '1', '2022-09-26', 'supported', '2345', '2022-03-22'),
 ('7', '7', '2021-08-05', '2021-02-28', '6', '7', '2022-12-30', 'denied', '65444', '2022-04-08'),
 ('8', '8', '2021-06-24', '2021-12-05', '1', '2', '2022-10-08', 'denied', '31690', '2022-06-14'),
 ('9', '9', '2021-07-27', '2021-01-07', '5', '4', '2022-11-11', 'postponed', '51073', '2022-02-16'),
('10', '10', '2021-07-08', '2021-05-20', '6', '3', '2022-02-15', 'supported', '54444', '2022-12-30'),
 ('11', '11', '2021-09-15', '2021-03-23', '7', '4', '2022-01-09', 'postponed', '874669020', '2022-09-23'),
 ('12', '12', '2021-11-14', '2021-03-28', '5', '3', '2022-08-10', 'denied', '267676', '2022-10-08');

_____________________________________________________

drop table if exists membership;
create table membership
(
user_id bigint unsigned not null primary key,
membership_grade varchar (100) ,
updated_at date,
certificate_mumber bigint unique not null,
previous_grade varchar (100),
INDEX membership_grade_idx(membership_grade),
FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (certificate_mumber) REFERENCES application_process (certificate_number) ON UPDATE CASCADE ON DELETE CASCADE
);

insert into membership values
('1', 'Member', '2022-05-21', '81', '-'),
('2', 'Fellow', '2022-05-21', '15283', 'Member'),
('3', 'Member', '2022-05-21', '187', '-'),
('4', 'Graduate', '2022-05-21', '10944', '-'),
('5', 'Member', '2022-05-21', '1514983', 'Graduate'),
('6', 'Member', '2022-05-21', '2345', '-'),
('7', 'Member', '2022-05-21', '65444', 'Graduate'),
('8', 'Member', '2022-05-21', '31690', '-'),
('9', 'Fellow', '2022-05-21', '51073', 'Member'),
('10', 'Member', '2022-05-21', '54444', '-'),
('11', 'Member', '2022-05-21', '874669020', 'Graduate'),
('12', 'Member', '2022-05-21', '267676', '-');

______________________________________________________________________

drop table if exists education_type; ++
create table education_type 
(
grade_id serial ,
grade varchar (100) primary key)

insert into education_type 
values 
(1, 'Secondary School'),
(2, 'College'),
(3, 'Bachelor'),
(4, 'Master'),
(5, 'PhD'),
(6, 'Doctor of science');

______________________________________________________________________

drop table if exists education; ++
create table education 
(
edu_id serial primary key,
user_id bigint unsigned not null,
enter_date date,
grad_date date,
grade bigint unsigned not null,
FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE cascade,
FOREIGN KEY (grade) REFERENCES education_type(grade_id) ON UPDATE CASCADE ON DELETE cascade
)
SET FOREIGN_KEY_CHECKS=0;
insert into education
values  
(2, 2, '1995-03-30', '1999-05-19', 2),
(3, 3, '1995-02-28', '1999-10-20', 3),
(4, 4, '1995-09-09', '1999-10-04', 2),
(5, 5, '1995-01-30', '1999-01-28', 3),
(6, 6, '1995-01-19', '1999-09-07', 4),
(7, 7, '1995-08-29', '1999-06-15', 5),
(8, 8, '1995-07-20', '1999-12-22', 4),
(9, 9, '1995-01-14', '1999-10-11', 5),
(10, 10, '1995-06-01', '1999-04-03', 4),
(11, 11, '1995-09-19', '1999-01-16', 5),
(12, 12, '1995-02-13', '1999-05-19', 4);
______________________________________ 

drop table if exists comptetences; ++
create table competences 
(
comp_id serial primary key,
comp_name varchar (100),
INDEX competences_name_idx(comp_name)
)


insert into competences 
values 
(1, 'Knowledge and understanding'),
(2, 'Design, development and solving engineering problems'),
(3, 'Responsibility, management and leadership'),
(4, 'Communication and interpersonal skills'),
(5, 'Professional commitment');

_______________________________________

drop table if exists other_certification; ++
create table other_certification
(
user_id bigint unsigned not null,
organisation varchar (100),
country varchar (100),
grade varchar (100),
date_of_certification date,
FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
)

insert into other_certification 
values
('2', 'veritatis', 'Cayman Islands', 'ad', '2014-04-25'),
('3', 'nesciunt', 'Lao People\'s Democratic Republic', 'voluptates', '2014-04-13'),
('2', 'ad', 'Greenland', 'error', '2014-01-25'),
('5', 'reprehenderit', 'Falkland Islands (Malvinas)', 'iure', '2014-02-28'),
('7', 'in', 'Eritrea', 'nulla', '2014-11-26');

____________________________________________

drop table if exists CPD;
create table CPD 
(
id serial,
CPD_type ENUM ('work-based learning', 'professional activity', 'formal learning', 'self direct learning', 'other') primary key
)


insert into cpd 
values 
(1, 'work-based learning'),
(2, 'professional activity'),
(3, 'formal learning'),
(4, 'self direct learning');

_______________________________________________________

drop table if exists user_CPD;
create table user_CPD 
(cpd_ID int primary key,
user_id bigint unsigned not null, 
CPD_type ENUM ('work-based learning', 'professional activity', 'formal learning', 'self direct learning', 'other'),
hours_number int not null,
completion_date date, 
competence_id bigint unsigned not null,
FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE cascade,
foreign key (CPD_type) references CPD(CPD_type) ON UPDATE CASCADE ON DELETE cascade,
foreign key (competence_id) references competences(comp_id) ON UPDATE CASCADE ON DELETE cascade
)

insert into  user_CPD 
values
(1,4, 'other', 4, '2010-11-07', 1),
(2,7, 'formal learning', 8, '2018-02-25', 2),
(3, 7, 'formal learning', 7, '2007-08-17', 3),
(4,5, 'formal learning', 4, '2016-07-31', 4),
(5, 2, 'professional activity', 2, '2008-07-18', 5),
(6, 2, 'formal learning', 8, '2006-03-21', 1),
(7, 7, 'professional activity', 5, '2003-01-20', 3),
(8, 8, 'other', 1, '1979-05-17', 4),
(9, 1, 'self direct learning', 9, '2021-12-15', 5),
(10, 8, 'other', 6, '1993-07-04', 2),
(11,7, 'professional activity', 5, '2014-04-15', 4),
(12,9, 'work-based learning', 4, '2010-12-09', 3);

________________________________________ 

drop table if exists events;
create table events 
(
event_id int primary key not null unique,
event_name varchar (100),
number_of_participants bigint,
number_of_members int,
organiser_id bigint unsigned not null,
competence_id bigint unsigned not null,
FOREIGN KEY (organiser_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE cascade,
foreign key (competence_id) references competences(comp_id) ON UPDATE CASCADE ON DELETE cascade
)

insert into events
values
(1, 'Conference of young researchers', 250, 3, 1, 1),
(2, 'Forum of scientsist',100, 4, 2,4)


drop table if exists user_conferences;
create table user_conferences
(c_id int unique not null primary key,
user_id bigint unsigned not null,
conf int not null,
FOREIGN KEY (conf) REFERENCES events(event_id) ON UPDATE CASCADE ON DELETE cascade,
foreign key (user_id) references competences(comp_id) ON UPDATE CASCADE ON DELETE cascade
)


insert into user_conferences 
values
(1, 1,1),
(2,2,1),
(3,10,2),
(4, 5,2);




______________________________________________________________________________________________
 







)
