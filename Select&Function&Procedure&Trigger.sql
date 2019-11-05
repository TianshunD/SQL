--Part 1 (1) Create Tables
--create table States
create table States
(
stateAbbr varchar(2) primary key,
statename varchar(20) not null
);

--create table City
create table City
(
cityID char(8) primary key,
cityName varchar(25) not null,
stateAbbr varchar(2) not null,
constraint city_fk_states foreign key (stateAbbr) references States(stateAbbr)
);

--create table Airport
create table Airport
(
airportID char(3) primary key,
airportName varchar(45) not null unique,
cityID char(8) not null,
constraint airport_fk_city foreign key (cityID) references City(cityID)
);

--create table FlightRoute
create table FlightRoute
(
flightNumber varchar(6) primary key,
departAirport char(3) not null,
arriveAirport char(3) not null,
scheduledDepartTime timestamp not null,
scheduledArrivalTime timestamp not null,
constraint Flightdepart_fk_Airport foreign key (departAirport) references Airport(airportID),
constraint Flightarrive_fk_Airport foreign key (arriveAirport) references Airport(airportID)
);


--create table AircraftSpecs
create table AircraftSpecs
(
aircraftTypeID char(8) primary key,
aircraftVersion varchar(10) not null,
cabinNumOfSeats int,
fuelCapacity int not null
);

--YYYY-MM-DD
--create table AirPlane
create table AirPlane
(
airplaneID char(8) primary key,
aircraftTypeID char(8) not null,
purchaseDate date default '2014-01-02' not null,
constraint AirPlane_fk_AircraftSpecs foreign key (aircraftTypeID) references AircraftSpecs(aircraftTypeID)
);

--create table FlightStatus
create table FlightStatus
(
statusID char(1) primary key check (statusID in ('O','D','C')),
description varchar(20) not null
);

--create table FlightSchedule
create table FlightSchedule
(
flightNumber varchar(6) not null,
flightDate Date not null,
statusID char(1) not null,
airplaneID char(8) not null,
delayDepartTime timestamp,
delayArrivalTime timestamp,
constraint FlightSchedule_pk primary KEY (flightNumber,flightDate),
constraint FlightSchedule_fk_FlightRoute foreign key (flightNumber) references FlightRoute(flightNumber),
constraint FlightSchedule_fk_FlightStatus foreign key (statusID) references FlightStatus(statusID),
constraint FlightSchedule_fk_Airplane foreign key (airplaneID) references AirPlane(airplaneID)
);

--Part 1 (2) Insert Data
--insert data into table States
insert into States values ('CA','California');
insert into States values ('DC','Washington, D.C.');
insert into States values ('FL','Florida');
insert into States values ('IL','Illinois');
insert into States values ('MA','Massachusetts');
insert into States values ('NY','New York');
insert into States values ('TX','Texas');

--insert data into table City
insert into City values ('C001','Los Angeles','CA');
insert into City values ('C002','San Francisco','CA');
insert into City values ('C003','Washington, D.C.','DC');
insert into City values ('C004','Miami','FL');
insert into City values ('C005','Orlando','FL');
insert into City values ('C006','Chicago','IL');
insert into City values ('C007','Boston','MA');
insert into City values ('C008','New York','NY');
insert into City values ('C009','Syracuse','NY');

--insert data into table Airport
insert into Airport values ('BOS','Deng','C007');
insert into Airport values ('DCA','Ronald Reagan National Airport','C003');
insert into Airport values ('IAD','Washington Dulles International Airport','C003');
insert into Airport values ('JFK','John F. Kennedy International Airport','C008');
insert into Airport values ('LAX','Los Angeles International Airport','C001');
insert into Airport values ('LGA','LaGuardia Airport','C008');
insert into Airport values ('MCO','Orlando International Airport','C005');
insert into Airport values ('MDW','Chicago Midway International Airport','C006');
insert into Airport values ('MIA','Miami International Airport','C004');
insert into Airport values ('ORD','Chicago OHare International Airport','C006');
insert into Airport values ('SFO','San Francisco International Airport','C002');
insert into Airport values ('SYR','Syracuse Hancock International Airport','C009');

--insert data into table FlightRoute
insert into FlightRoute values ('3310','SYR','JFK','08:00','09:02');
insert into FlightRoute values ('3312','JFK','SYR','12:20','13:30');
insert into FlightRoute values ('3426','LAX','ORD','11:15','15:05');
insert into FlightRoute values ('5063','BOS','MCO','14:30','18:45');

--insert data into table AircraftSpecs
insert into AircraftSpecs values ('AIR1','A321-200','220','7930');
insert into AircraftSpecs values ('AIR2','737-600ER','132','6875');
insert into AircraftSpecs values ('BOE1','747-400ER','416','63705');
insert into AircraftSpecs values ('BOE2','767-300ER','350','23980');
insert into AircraftSpecs values ('BOE3','737-600ER','132','6875');

--insert data into table AirPlane
insert into Airplane values ('AP098640','AIR2','2013-03-01');
insert into Airplane values ('AP239471','AIR1','1990-01-01');
insert into Airplane values ('AP309814','BOE2','2012-05-22');
insert into Airplane values ('AP629342','BOE1','1990-01-01');
insert into Airplane values ('AP872139','BOE3','1990-01-01');
insert into Airplane values ('AP998911','BOE2','1990-01-01');

--insert data into table FlightStatus 
insert into FlightStatus values ('C','Cancelled');
insert into FlightStatus values ('D','Delay');
insert into FlightStatus values ('O','On Time');

--insert data into table FlightSchedule
insert into FlightSchedule (flightNumber,flightDate,statusID,airplaneID) values ('3310','2014-02-10','O','AP629342');
insert into FlightSchedule (flightNumber,flightDate,statusID,airplaneID) values ('3310','2014-02-11','O','AP629342');
insert into FlightSchedule (flightNumber,flightDate,statusID,airplaneID) values ('3312','2014-02-10','O','AP872139');
insert into FlightSchedule (flightNumber,flightDate,statusID,airplaneID) values ('3426','2014-02-12','O','AP239471');
insert into FlightSchedule values ('5063','2014-02-13','D','AP309814','15:40','20:05');

--Part 1 (3) Select Data
select * from States;
select * from City;

--Part 2: Table Queries
alter table city add Zipcode char(5);
update city set Zipcode = '13244' where cityName = 'Syracuse';
alter table city drop column Zipcode;

--Assignment 5
--Insert Data
--insert new data
--insert data into table AirPlane
INSERT INTO airplane VALUES ('AP323344','AIR1','2011-02-21');
INSERT INTO airplane VALUES ('AP432379','AIR2','2012-03-22');
INSERT INTO airplane VALUES ('AP241175','BOE3','2012-02-20');
INSERT INTO airplane VALUES ('AP137783','AIR1','2012-04-16');
INSERT INTO airplane VALUES ('AP100772','AIR1','2012-06-07');
INSERT INTO airplane VALUES ('AP132221','AIR2','2010-07-04');
INSERT INTO airplane VALUES ('AP107207','BOE2','2012-07-29');
INSERT INTO airplane VALUES ('AP461923','BOE1','2012-07-31');
INSERT INTO airplane VALUES ('AP913157','BOE3','2012-10-12');
INSERT INTO airplane VALUES ('AP133451','BOE1','2011-09-22');
INSERT INTO airplane VALUES ('AP813701','AIR1','2013-01-03');
INSERT INTO airplane VALUES ('AP479451','BOE3','2012-01-13');
INSERT INTO airplane VALUES ('AP132984','AIR2','2013-11-28');

--insert data into table flightroute
INSERT INTO flightroute VALUES ('4375','IAD','JFK','06:00','07:03');
INSERT INTO flightroute VALUES ('1307','SFO','LGA','00:20','07:40');
INSERT INTO flightroute VALUES ('3019','ORD','LAX','14:40','18:15');
INSERT INTO flightroute VALUES ('1436','LAX','BOS','10:05','15:33');
INSERT INTO flightroute VALUES ('7192','SYR','MIA','11:30','12:45');
INSERT INTO flightroute VALUES ('2533','JFK','DCA','07:20','13:30');

--insert data into table flightschedule
INSERT INTO flightschedule VALUES ('4375','2015-02-14','D','AP132984','06:30','07:40');
INSERT INTO flightschedule VALUES ('1307','2014-12-15','C','AP133451',NULL,NULL);
INSERT INTO flightschedule VALUES ('1307','2014-12-16','D','AP137783',NULL,NULL);
INSERT INTO flightschedule VALUES ('3019','2015-01-16','O','AP432379',NULL,NULL);
INSERT INTO flightschedule VALUES ('2533','2015-01-16','O','AP133451',NULL,NULL);
INSERT INTO flightschedule VALUES ('4375','2014-12-16','D','AP132221','06:30','07:40');
INSERT INTO flightschedule VALUES ('7192','2015-01-17','O','AP100772',NULL,NULL);
INSERT INTO flightschedule VALUES ('7192','2014-12-18','O','AP107207',NULL,NULL);

--Data QUESTIONS 
--1. Find out all flight schedule information of flight “3310” and “3312”. Make sure to show all the fields.
select * from FlightSchedule where flightNumber='3310' or flightNumber='3312';

--2. Find all flights departing from airports that start with ‘S’. Show flight number, depart airport, arrival airport, and depart time.
select flightNumber, departAirport, arriveAirport, scheduledDepartTime 
from FlightRoute WHERE departAirport LIKE 'S%';

--3. Find 4 most recently purchased planes. Show airplane ID and purchase date only.
select airplaneID, purchaseDate from AirPlane order by purchaseDate desc 
FETCH FIRST 4 ROWS ONLY;

--4. Count the number of flights departing each day. Show the date and the number of flights. 
select flightDate, count(flightNumber) as NumberOfFlights from FlightSchedule 
group by flightDate;

--5. Sort the AircraftSpecs table by fuel capacity in descending order. Show the result with aircraft version and fuel capacity. 
select aircraftVersion, fuelCapacity from AircraftSpecs 
order by fuelCapacity desc;

--6. Find all flights which depart from “BOS” after noon. Show flight number, flight date, depart airport and scheduled depart time.  
select r.flightNumber, s.flightDate, r.departAirport, r.scheduledDepartTime
from FlightRoute r inner join FlightSchedule s on r.flightNumber = s.flightNumber
where r.departAirport = 'BOS' and r.scheduledDepartTime > '12:00';

--7. Find all airplanes which were delayed or cancelled. Show only airplane ID, flight date and status description. 
select sc.airplaneID, sc.flightDate, s.description 
from FlightSchedule sc inner join FlightStatus s on sc.statusID = s.statusID
where sc.statusID = 'D' or sc.statusID = 'C';

--8. Find the flight(s) which are “on time”, display the Flight number and departure airport. 
select r.flightNumber, r.departAirport
from FlightSchedule s inner join FlightRoute r on s.flightNumber = r.flightNumber
where s.statusID = 'O';

--9. Find all the airplanes that have not been scheduled to fly. You can use Left Join
select p.airplaneID
from AirPlane p left join FlightSchedule s on p.airplaneID = s.airplaneID
where s.flightNumber is null;

--10. Find all only airplanes that have been scheduled to fly and delayed. Display Airplane ID of the flight (Use Right Join) 
select distinct p.airplaneID
from AirPlane p right join FlightSchedule s on p.airplaneID = s.airplaneID
where s.statusID = 'D';

--SQL tasks about Function, Procedure, and Trigger
--11. Write a function, called totalFlights, which only returns the total number of flights at different statuses., including D, C, and O. (The output
--should show the statusID and the number of flights in that status given the current data.) 
--sample query
select count(flightNumber) as NumberOfFlights, statusID from FlightSchedule 
group by statusID;

CREATE OR REPLACE TYPE f_record AS OBJECT (
    staID CHAR, 
    count number
    );

CREATE OR REPLACE TYPE f_table AS TABLE OF f_record;


CREATE OR REPLACE FUNCTION totalFlights  
RETURN f_table 
AS 
     v_ret f_table;
BEGIN 

    SELECT f_record(statusID, count(flightNumber))
    BULK COLLECT INTO v_ret 
    FROM FlightSchedule
    GROUP BY statusID; 

RETURN v_ret; 
END totalFlights;

SELECT * FROM TABLE(totalFlights);
--12. Write a procedure, called airportFlights, which calculates and writes the number of non-cancelled flights to the airport table respectively.  
--In order to do so, you need to first add a new column, totalFlights NUMBER, to airport table first. 
ALTER TABLE Airport ADD TotalDepart NUMBER;
ALTER TABLE Airport ADD TotalArrive NUMBER;

/*select r.departAirport, count(r.flightNumber)
from FlightRoute r inner join FlightSchedule s on r.flightNumber = s.flightNumber
where Airport.airportID = r.departAirport
and s.statusID != 'C'
group by r.departAirport;*/

select r.departAirport, count(r.flightNumber)
from Airport a inner join FlightRoute r on a.airportID = r.departAirport
inner join FlightSchedule s on r.flightNumber = s.flightNumber
where s.statusID != 'C'
group by r.departAirport;

CREATE OR REPLACE PROCEDURE airportFlights
AS
BEGIN
	UPDATE Airport 
	SET TotalDepart = 
        (SELECT COUNT(r.flightNumber)
		FROM FlightRoute r
		INNER JOIN FlightSchedule s
			ON r.flightNumber = s.flightNumber
        WHERE Airport.airportID = r.departAirport
		AND s.statusID != 'C'
		GROUP BY r.departAirport);
END airportFlights;

EXEC airportFlights;

CREATE OR REPLACE PROCEDURE airportFlights2
AS
BEGIN
	UPDATE Airport 
	SET TotalArrive = 
        (SELECT COUNT(r.flightNumber)
		FROM FlightRoute r
		INNER JOIN FlightSchedule s
			ON r.flightNumber = s.flightNumber
        WHERE Airport.airportID = r.arriveAirport
		AND s.statusID != 'C'
		GROUP BY r.arriveAirport);
END airportFlights2;

EXEC airportFlights2;
--13. Write a trigger that automatically updates the totalFlights in the airport table. Whenever there is a new flight added, the total number should 
--be increased by 1; when there is an existing flight cancelled, the trigger should reduce the count by 1.  
--Using an internal variable for updating totalDepart
CREATE OR REPLACE TRIGGER updateTotalDepart
    AFTER INSERT ON FlightSchedule
    FOR EACH ROW
    
DECLARE 
    aid CHAR(3); 
    
BEGIN
    SELECT r.DepartAirport INTO aid 
    FROM FlightRoute r WHERE :NEW.flightNumber = r.flightNumber;
    dbms_output.put_line(aid);
        
    UPDATE Airport 
	SET TotalDepart = TotalDepart + 
		(SELECT COUNT(r.flightNumber)
		FROM FlightRoute r
		WHERE r.flightNumber = :NEW.flightNumber
		AND :NEW.statusID != 'C')
        WHERE Airport.airportID = aid;
  
END updateTotalDepart;

--Using an internal variable for updating totalArrive
CREATE OR REPLACE TRIGGER updateTotalArrive
    AFTER INSERT ON FlightSchedule
    FOR EACH ROW
    
DECLARE 
    aid CHAR(3); 
    
BEGIN
    SELECT r. ArriveAirport INTO aid 
    FROM FlightRoute r WHERE :NEW.flightNumber = r.flightNumber;
    dbms_output.put_line(aid);
        
    UPDATE Airport 
	SET TotalArrive = TotalArrive + 
		(SELECT COUNT(r.flightNumber)
		FROM FlightRoute r
		WHERE r.flightNumber = :NEW.flightNumber
		AND :NEW.statusID != 'C')
        WHERE Airport.airportID = aid;
  
END updateTotalArrive;

--Test the trigger
select * from airport;

INSERT INTO flightschedule VALUES ('4375','2008-10-20','O','AP132221','08:30','09:40');

select * from airport;
