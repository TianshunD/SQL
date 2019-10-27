create table TVProduct
(
ProductNM varchar(20) primary key,
CostChannel varchar(20) not null,
IsPackage char(1) not null check (IsPackage in ('Y','N')),
Description varchar(20) not null
);
 
create table Contains 
(
Product varchar(20) not null,
Package varchar(20) not null,
constraint Contain_pk primary KEY (Product,Package),
constraint Product_fk_Product foreign key (Product) references TVProduct(ProductNM),
constraint Package_fk_Product foreign key (Package) references TVProduct(ProductNM)
);
 
create table Client
(
ClientID varchar(20) primary key,
FirstNM varchar(20) not null,
LastNM varchar(20) not null,
WorkPhone varchar(20) not null,
HomePhone varchar(20) not null,
Email varchar(25) not null,
StreetAddress varchar(20) not null,
City varchar(20) not null,
State varchar(2) not null,
Zip varchar(9) not null
);

create table Device
(
DeviceNM varchar(20) not null,
ClientID varchar(20) not null,
constraint Device_pk primary KEY (DeviceNM,ClientID),
constraint Device_fk_Client foreign key (ClientID) references Client(ClientID)
);

create table purchase
(
ClientID varchar(20) not null,
ProductNM varchar(20) not null,
PurchasedTime date not null,
constraint purchase_pk primary KEY (ClientID,ProductNM),
constraint purchase_fk_Client foreign key (ClientID) references Client(ClientID),
constraint purchase_fk_Product foreign key (ProductNM) references TVProduct(ProductNM)
); 

insert into TVProduct values ('HBO USA','300','N','HBO');
insert into TVProduct values ('HBO 2','300','N','HBO');
insert into TVProduct values ('HBO 3','300','N','HBO');
insert into TVProduct values ('HBO 4','300','N','HBO');
insert into TVProduct values ('HBO 5','300','N','HBO');
insert into TVProduct values ('HBO ZONE','300','N','HBO');
insert into TVProduct values ('HBO FAMILY','300','N','HBO');
insert into TVProduct values ('COMEDY','200','N','Online');
insert into TVProduct values ('SKY MOVIE DRAMA','200','N','Online');
insert into TVProduct values ('SKY MOVIE HORROR','200','N','Online');
insert into TVProduct values ('MOVIETIME','200','N','Online');
insert into TVProduct values ('Movie 1','200','N','Online');
insert into TVProduct values ('Movie 2','200','N','Online');
insert into TVProduct values ('Movie 3','200','N','Online');
insert into TVProduct values ('Happy Movie','400','N','Online');
insert into TVProduct values ('Movie Night','400','N','Online');
insert into TVProduct values ('Movie Moring','200','N','Online');
insert into TVProduct values ('Series','200','N','Online');
insert into TVProduct values ('FOX','200','N','Online');
insert into TVProduct values ('DDL','300','N','Online');
insert into TVProduct values ('Football','200','N','Online');
insert into TVProduct values ('Basketball','200','N','Online');
insert into TVProduct values ('Ping-pong','200','N','Online');
insert into TVProduct values ('Running','200','N','Online');
insert into TVProduct values ('Swimming','300','N','Online');
insert into TVProduct values ('Call of Duty','500','N','Mobile avaliable');
insert into TVProduct values ('Identity V','500','N','Mobile avaliable');
insert into TVProduct values ('Glory of Kings','600','N','Mobile avaliable');
insert into TVProduct values ('LPL','600','N','Mobile avaliable');
insert into TVProduct values ('LOL','600','N','Mobile avaliable');
insert into TVProduct values ('HBO1','700','Y','Medium');
insert into TVProduct values ('Movies','300','Y','Medium');
insert into TVProduct values ('ForFamily','600','Y','Medium');
insert into TVProduct values ('Sports','300','Y','Medium');
insert into TVProduct values ('Games','900','Y','Medium');
insert into TVProduct values ('Recreation','1200','Y','Grand');
insert into TVProduct values ('Union','1000','Y','Grand');
insert into TVProduct values ('Relax','1000','Y','Grand');

select * from TVProduct;

insert into Contains values ('HBO USA','HBO1');
insert into Contains values ('HBO 2','HBO1');
insert into Contains values ('HBO 3','HBO1');
insert into Contains values ('COMEDY','Movies');
insert into Contains values ('SKY MOVIE DRAMA','Movies');
insert into Contains values ('Happy Movie','ForFamily');
insert into Contains values ('Movie Night','ForFamily');
insert into Contains values ('Football','Sports');
insert into Contains values ('Basketball','Sports');
insert into Contains values ('Identity V','Games');
insert into Contains values ('Glory of Kings','Games');
insert into Contains values ('Movies','Recreation');
insert into Contains values ('Movies','Recreation');
insert into Contains values ('Games','Recreation');
insert into Contains values ('HBO1','Union');
insert into Contains values ('ForFamily','Union');
insert into Contains values ('Sports','Relax');
insert into Contains values ('Games','Relax');

select * from Contains;

insert into Client values ('1','Dean','Winchester','2177216543','2177213289','dean@illinois.edu','Green ST','Champaign','IL','61801');
insert into Client values ('2','Adrianne','Palicki','2177216548','2177217680','Adri@illinois.edu','White ST','Champaign','IL','61802');
insert into Client values ('3','Alona','Tal','2177215223','2177210001','Alone@illinois.edu','Union ST','Champaign','IL','61803');
insert into Client values ('4','Jensen','Ackles','2177210002','2177210034','Jensen@illinois.edu','Illi ST','Champaign','IL','61804');
insert into Client values ('5','Katie','Cassidy','2177210098','2177210078','Katie@illinois.edu','Capstone ST','Champaign','IL','61805');

select * from Client;

insert into Device values ('TV','1');
insert into Device values ('laptop','1');
insert into Device values ('iPad','1');
insert into Device values ('SmartPhone','1');
insert into Device values ('SmartPhone','2');
insert into Device values ('SmartPhone','3');
insert into Device values ('SmartPhone','4');
insert into Device values ('SmartPhone','5');

select * from Device;

insert into purchase values ('1','HBO USA','2018-03-01');
insert into purchase values ('1','HBO 2','2019-10-01');
insert into purchase values ('1','HBO 3','2019-10-02');
insert into purchase values ('1','HBO 4','2019-10-21');
insert into purchase values ('1','Relax','2019-10-21');
insert into purchase values ('2','Movie 1','2019-10-21');
insert into purchase values ('2','Movie 2','2019-10-21');
insert into purchase values ('2','Movie 3','2019-10-21');
insert into purchase values ('2','Sports','2019-9-21');
insert into purchase values ('3','FOX','2019-10-21');
insert into purchase values ('3','DDL','2019-10-21');
insert into purchase values ('3','Relax','2019-9-24');
insert into purchase values ('3','Union','2019-10-21');
insert into purchase values ('4','Running','2019-10-21');
insert into purchase values ('4','Swimming','2019-9-10');
insert into purchase values ('4','Games','2019-10-21');
insert into purchase values ('4','Relax','2019-9-27');
insert into purchase values ('5','HBO 2','2019-10-21');
insert into purchase values ('5','HBO 4','2019-10-21');
insert into purchase values ('5','LOL','2019-10-21');

select * from purchase;

--A. Count the number of clients who have more than 3 devices. 
select count(*) from (select c.ClientID, count(*) 
from Client c inner join Device d on c.ClientID = d.ClientID 
group by c.ClientID
having count(customerID)>3);

--B. What channels does a medium package X contain, and how much does each channel cost originally? 
select p.ProductNM, p.CostChannel
from Contains c inner join TVProduct p on p.ProductNM = c.Product where c.Package = 'Games';

--C. What channels does a grand package X contain, and how much does each channel cost originally? 
select p.ProductNM, p.CostChannel
from (select c2.Product from (select * from Contains where Package = 'Relax') c1 inner join Contains c2 on c1.Product = c2.Package) c 
inner join TVProduct p on p.ProductNM = c.Product;

--D. What is the amount of the discount customers will get when purchasing a medium package X (from the query B)? 
select ((select CostChannel from TVProduct where ProductNM = 'Games')-sum(p.CostChannel)) from TVProduct p 
inner join Contains c on p.ProductNM = c.Product 
where c.Package = 'Games';

--E. What is the amount of the discount customers will get when purchasing a grand package X (from the query C)? 
select (1-sum(DISTINCT p.CostChannel)/(select CostChannel from TVProduct where ProductNM = 'Relax'))
from (select c2.Product from (select * from Contains where Package = 'Relax') c1 inner join Contains c2 on c1.Product = c2.Package) c 
inner join TVProduct p on p.ProductNM = c.Product;
sum(DISTINCT p.CostChannel)

--F. In the last month, who has purchased package X? Give complete information about the client, the date that they ordered the package, 
--and order the query by date. 
select c.*, p.PurchasedTime from Client c inner join purchase p on c.ClientID=p.ClientID 
where p.ProductNM='Sports' 
and p.PurchasedTime>'2019-9-1'
and p.PurchasedTime<'2019-9-30'
order by p.PurchasedTime desc;

--G. Create a report that lists a client’s complete information. It should include complete information about the client and all products he/she purchased. 
select c.*, p.ProductNM from Client c 
inner join purchase p on c.ClientID=p.ClientID 
where c.ClientID='1';

--H. Give the names and addresses of clients who made a purchase on date X. 
select distinct c.ClientID, c.FirstNM, c.LastNM, c.StreetAddress, c.City, c.State, c.Zip from Client c
inner join purchase p on c.ClientID=p.ClientID 
where p.PurchasedTime='2019-10-21';