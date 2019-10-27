CREATE TABLE customerAAA
(
  customerAAASSN NUMERIC(10,0) NOT NULL,
  customerFName VARCHAR(20) NOT NULL,
  customerLName VARCHAR(20) NOT NULL,
  customerStreetNo VARCHAR(10) NOT NULL,
  customerStreet VARCHAR(20) NOT NULL,
  customerCity VARCHAR(20) NOT NULL,
  customerState VARCHAR(2) NOT NULL,
  customerZip VARCHAR(9) NOT NULL,
  customerGender CHAR(1) NOT NULL,
  customerTotalOrders INTEGER NOT NULL,

  CONSTRAINT customer_AAAPK_SSN PRIMARY KEY (customerAAASSN)

);


CREATE TABLE customerBBB
(
  customerBBBSSN NUMERIC(10,0) NOT NULL,
  customerFName VARCHAR(20) NOT NULL,
  customerLName VARCHAR(20) NOT NULL,
  customerStreetNo VARCHAR(10) NOT NULL,
  customerStreet VARCHAR(20) NOT NULL,
  customerCity VARCHAR(20) NOT NULL,
  customerState VARCHAR(2) NOT NULL,
  customerZip VARCHAR(9) NOT NULL,
  customerGender CHAR(1) NOT NULL,
  customerTotalOrders INTEGER NOT NULL,

  CONSTRAINT customer_BBBPK_SSN PRIMARY KEY (customerBBBSSN)

);




INSERT INTO customerAAA values (1, 'John', 'Smith', '708', 'Main Street', 'Pinesville', 'TX', '45678','M',0);
INSERT INTO customerAAA values (2, 'Abe', 'Kelly', '6508', 'Wright Street', 'Pinesville', 'MN', '24680','F',0);
INSERT INTO customerAAA values (3, 'Ben', 'Muller', '508', 'Oak Street', 'Greensville', 'NY', '13579','M',0);
INSERT INTO customerAAA values (4, 'Carl', 'Lyle', '608', 'Pine Street', 'Mountain View', 'CA', '12345','M',0);
INSERT INTO customerAAA values (5, 'Diane', 'Nielsen', '650', 'Maple Street', 'Savoy', 'RI', '67890','F',0);
INSERT INTO customerAAA values (6, 'Elaine', 'Thomas', '511', 'Apple Street', 'Thunder', 'CA', '55555','F',0);

INSERT INTO customerBBB values (1, 'John', 'Smith', '708', 'Main Street', 'Pinesville', 'TX', '45678','M',2);
INSERT INTO customerBBB values (2, 'Abe', 'Kelly', '6508', 'Wright Street', 'Pinesville', 'MN', '24680','F',3);
INSERT INTO customerBBB values (3, 'Ben', 'Muller', '508', 'Oak Street', 'Greensville', 'NY', '13579','M',5);
INSERT INTO customerBBB values (4, 'Carl', 'Lyle', '608', 'Pine Street', 'Mountain View', 'CA', '12345','M',3);
INSERT INTO customerBBB values (5, 'Diane', 'Nielsen', '650', 'Maple Street', 'Savoy', 'RI', '67890','F',3);
INSERT INTO customerBBB values (7, 'Henry', 'Thomas', '765', 'Pear Street', 'Thunder', 'CA', '55555','M',10);
INSERT INTO customerBBB values (8, 'Lora', 'Thomas', '765', 'Pear Street', 'Thunder', 'CA', '55555','F',12);


CREATE TABLE customerAAAOrder
(
  orderID NUMBER GENERATED ALWAYS AS IDENTITY START WITH 1001 INCREMENT BY 1,
  orderDate CHAR(20),
  customerSSN NUMERIC(10,0) NOT NULL,
  
  CONSTRAINT order_class8_PK PRIMARY KEY (orderID),
  CONSTRAINT order_class8_FK FOREIGN KEY (customerSSN) REFERENCES customerAAA(customerAAASSN)
);


INSERT INTO customerAAAOrder(orderDate, customerSSN)  VALUES('17-OCT-2019', 1);
UPDATE customerAAA SET customerTotalOrders = customerTotalOrders+1 WHERE customerAAASSN = 1;

INSERT INTO customerAAAOrder(orderDate, customerSSN)  VALUES('17-OCT-2019', 2);
UPDATE customerAAA SET customerTotalOrders = customerTotalOrders+1 WHERE customerAAASSN = 2;

INSERT INTO customerAAAOrder(orderDate, customerSSN)  VALUES('17-OCT-2019', 3);
UPDATE customerAAA SET customerTotalOrders = customerTotalOrders+1 WHERE customerAAASSN = 3;

INSERT INTO customerAAAOrder(orderDate, customerSSN)  VALUES('17-OCT-2019', 4);
UPDATE customerAAA SET customerTotalOrders = customerTotalOrders+1 WHERE customerAAASSN = 4;

INSERT INTO customerAAAOrder(orderDate, customerSSN)  VALUES('17-OCT-2019', 5);
UPDATE customerAAA SET customerTotalOrders = customerTotalOrders+1 WHERE customerAAASSN = 5;

INSERT INTO customerAAAOrder(orderDate, customerSSN)  VALUES('17-OCT-2019', 3);
UPDATE customerAAA SET customerTotalOrders = customerTotalOrders+1 WHERE customerAAASSN = 3;


----- the above is tested 
SELECT t1.*,t2.*
FROM customerAAA t1
INNER JOIN customerBBB t2 ON t1.customerAAASSN = t2.customerBBBSSN;

SELECT t1.*,t2.*
FROM customerAAA t1
LEFT JOIN customerBBB t2 ON t1.customerAAASSN = t2.customerBBBSSN;

SELECT t1.*,t2.*
FROM customerAAA t1
LEFT JOIN customerAAAOrder t2 ON t1.customerAAASSN = t2.customerSSN;


SELECT t1.*,t2.*
FROM customerAAA t1
FULL OUTER JOIN customerBBB t2 on t1.customerAAASSN = t2.customerBBBSSN;

SELECT t1.*, t2.*
FROM customerAAA t1
LEFT JOIN customerBBB t2 ON t1.customerAAASSN = t2.customerBBBSSN
WHERE t2.customerBBBSSN is NULL


SELECT t1.*, t2.*
FROM customerAAA t1
FULL OUTER JOIN customerBBB t2 ON t1.customerAAASSN = t2.customerBBBSSN
WHERE t1.customerAAASSN IS NULL OR t2.customerBBBSSN IS NULL;


SELECT allproducts.productID, COUNT(DISTINCT allproducts.orderID)
FROM
(SELECT p.productID, ol.orderID
FROM product p
LEFT JOIN orderline ol
ON p.productID=ol.productID) allproducts
GROUP BY productID



SELECT * FROM product 
WHERE standardPrice=(select max(standardPrice) from product)
UNION
SELECT * FROM product 
WHERE standardPrice=(select min(standardPrice) from product);


SELECT customerAAASSN as customerSSN, sum(customerTotalOrders) as totalOrders
FROM
(SELECT customerAAASSN, customerTotalOrders
FROM customerAAA
UNION
SELECT customerBBBSSN, customerTotalOrders
FROM customerBBB) allorders
GROUP BY customerAAASSN
