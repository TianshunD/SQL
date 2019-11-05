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
