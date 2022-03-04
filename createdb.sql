
//1515009 김다영
CREATE TABLE DBCOURSE_DIRECTOR( NAME VARCHAR(30) PRIMARY KEY,
				MOVIE VARCHAR(30));
				CREATE TABLE DBCOURSE_TITLE_ID(
				WORKING_TITLE_ID INT PRIMARY KEY,
				 WORKING_TITLE VARCHAR(30) NOT NULL,
				DONE VARCHAR(30));
//1515005 권성경
create table DBCOURSE_MOVIE(working_title_id int not null,
				 director varchar(30) not null,
				genre varchar(30),
				 primary key (working_title_id),
				foreign key (working_title_id) references dbcourse_title_id(working_title_id));
//1515005 권성경
CREATE TABLE DBCOURSE_FILM_FESTIVAL(MOVIE VARCHAR(30) NOT NULL,
				DIRECTOR VARCHAR(30) NOT NULL,
				 FESTIV_NAME VARCHAR(30) PRIMARY KEY,
				FOREIGN KEY(DIRECTOR) REFERENCES dbcourse_DIRECTOR(NAME));
//1515004 권나현			
create table DBCOURSE_INVESTOR( inv_name varchar(30) not null,
				working_title_id int not null,
				 investment int,
				primary key (inv_name, working_title_id));
create table DBCOURSE_movie_asset( working_title_id int not null,
				 current_investment int,
				 budget int,
				 primary key(working_title_id),
				 foreign key(working_title_id) references dbcourse_movie(working_title_id));

create table DBCOURSE_ACTOR( name varchar(30) not null,
				 gender char(1),
				debut_year varchar(30),
				career int,
				 primary key(name));
				create table DBCOURSE_FILMOGRAPHY(
				 actor_name varchar(30) not null,
				 movie varchar(30) not null,			
				 year int,
				 role varchar(30),
				 primary key(actor_name),
				 foreign key(actor_name) references DBCOURSE_ACTOR(name));

create table DBCOURSE_RECRUIT(working_title_id int(5) not null,
		                applied_actor varchar(30) not null,
		                casting_role varchar(30),
		                primary key(working_title_id,applied_actor),
		                foreign key(applied_actor) references DBCOURSE_ACTOR(name));
		         
create table DBCOURSE_AUDITION( working_title_id int(5) not null,
		                aud_date date,
		                announce_date date,
		                primary key(working_title_id));		               
//1515005 권성경
create view invest as 
select * 
 from DBCOURSE_MOVIE, DBCOURSE_INVESTOR 
 where dbcourse_movie.working_title_id = dbcourse_investor.working_title_id;

create view asset as 
 select * 
from DBCOURSE_MOVIE, DBCOURSE_movie_asset 
where dbcourse_movie.working_title_id = dbcourse_investor.working_title_id;
			
insert into dbcourse_director 
values('Junho Bong','The Host');
insert into dbcourse_director 
values('Steven Spielberg','Saving Private');


insert into dbcourse_title_id 
values(10000,'Parasite',null);
insert into dbcourse_title_id 
 values(20000,'Ready Play One',null);

insert into dbcourse_movie 
values(10000,'Junho Bong','Action');
insert into dbcourse_movie 
values(20000,'Steven Spielberg','SF');

//1515009 김다영
insert into DBCOURSE_DIRECTOR 
values('Christopher Nolan','Interstella');

//1515005 권성경
insert into DBCOURSE_TITLE_ID 
values(20001,'The Post',NULL);

//1515005 김다영
insert into DBCOURSE_TITLE_ID 
values(30000,'Dunkirk',NULL);
insert into DBCOURSE_MOVIE 
values(20001,'Steven Spielberg','drama');

insert into DBCOURSE_MOVIE 
values(30000,'Christopher Nolan','action');

//1515005 권성경ㅇ
insert into dbcourse_investor 
values('CJ',10000,10000);
insert into dbcourse_investor 
values('new',20000,1000000);
insert into dbcourse_investor 
values('new',20001,1500000);
insert into dbcourse_investor 
values('new',30000,3000000);

insert into dbcourse_movie_asset 
values(10000,10000,1000000);
insert into dbcourse_movie_asset 
values(20000,1000000,3000000);
insert into dbcourse_movie_asset 
values(20001,1500000,2000000);
insert into dbcourse_movie_asset 
values(30000,3000000,3000000);

//1515004 권나현
insert into dbcourse_actor 
values('Kangho Song','m',1996,21),
('Simon Pegg','m',1999,18),
('Olivia Cooke','f',2012,5),
('Meryl Streep','f',1977,40),
('Mark Rylance','m',1985,32),
('Tom Hardy','m',2001,16),
('Tom Hanks','m',1980,37),
('T.J.Miller','m',2007,10),
('Julie Nickson','f',1980,37),
('Aneurin Barnard','m',2011,6);
insert into dbcourse_recruit 
values(10000,'Kangho Song','Main'),
(20000,'Simon Pegg','Sub'),
(20000,'Olivia Cooke',null),
(20000,'Meryl Streep', 'Main'),
(20000,'Mark Rylance',null),
(30000,'Mark Rylance',null),
(30000,'Tom Hardy',null),
(20001,'Tom Hanks',null),
(20000,'T.J. Miller',null),
(20001,'Julie Nickson',null),
(30000,'Aneurin Barnard',null);

   
insert into DBCOURSE_FILM_FESTIVAL 
           values('Saving Private','Steven Spielberg','Academy');
         insert into DBCOURSE_FILM_FESTIVAL 
           values('Interstella','Christopher Nolan','Max Movie');

					        
		         insert into dbcourse_filmography 
		                values('Kangho Song','The Host',2006,'main'),
			                ('Simon Pegg','Star Wars',2015,'main'),
			                ('Olivia Cooke','The Signal',2014,'main'),
			                ('Meryl Streep','The Devil wears Prada',2006,'main'),
			                ('Mark Rylance','Bridge of Spies',2015,'main'),
			                ('Tom Hardy','Mad Max',2015,'main'),
			                ('Tom Hanks','Bridge of Spies',2015,'main'),
			                ('T.J.Miller','Deadpool',2016,'sub'),
			                ('Julie Nickson','Rambo2',1985,'sub'),
			                ('Aneurin Barnard','Legend',2015,'sub');
		         insert into dbcourse_audition 
			                values(10000,'2017-07-25','2017-08-31'),
			                (20000,'2017-06-21','2017-07-01'),
			                (20001,'2017-05-27','2017-06-03'),
			                (30000,'2017-05-27','2017-06-05');
alter table DBCOURSE_movie add index(working_title_id(20));
alter table DBCOURSE_investor add index(inv_name(30));


