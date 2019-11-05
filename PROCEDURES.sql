
---- PROCEDURE 1 : create a PROCEDURE WITHOUT PARAMETERS

CREATE OR REPLACE PROCEDURE customer_order_total_price
AS
BEGIN
	UPDATE CUSTOMER_T 
	SET balance = 
        (SELECT SUM(ol.ORDER_QUANTITY*p.STANDARD_PRICE)
		FROM ORDER_T o
		INNER JOIN ORDER_LINE_T ol
			ON o.order_ID = ol.ORDER_ID
		INNER JOIN PRODUCT_T p
			ON ol.PRODUCT_ID = p.PRODUCT_ID
       WHERE CUSTOMER_T.CUSTOMER_ID = o.CUSTOMER_ID
		GROUP BY o.CUSTOMER_ID);
END customer_order_total_price;

---- CALL PROCEDURE 1

EXEC customer_order_total_price

---- PROCEDURE 2 : Create a PROCEDURE WITH PARAMETERS, E.G., create a procedure that updates the balance of a specific customer

CREATE OR REPLACE PROCEDURE customer_order_price (cid IN INTEGER) 
AS
BEGIN
	UPDATE CUSTOMER_T 
	SET balance = 
        (SELECT SUM(ol.ORDER_QUANTITY*p.STANDARD_PRICE)
		FROM ORDER_T o
		INNER JOIN ORDER_LINE_T ol
			ON o.order_ID = ol.ORDER_ID
		INNER JOIN PRODUCT_T p
			ON ol.PRODUCT_ID = p.PRODUCT_ID
       WHERE CUSTOMER_T.CUSTOMER_ID = o.CUSTOMER_ID AND CUSTOMER_T.CUSTOMER_ID = cid)
        WHERE CUSTOMER_T.CUSTOMER_ID = cid;
END customer_order_price;

---- CALL PROCEDURE 2

EXEC customer_order_price(1)



--- queries for understanding the above procedures
SELECT SUM(ol.ORDER_QUANTITY*p.STANDARD_PRICE)
		FROM ORDER_T o
		INNER JOIN ORDER_LINE_T ol
			ON o.order_ID = ol.ORDER_ID
		INNER JOIN PRODUCT_T p
			ON ol.PRODUCT_ID = p.PRODUCT_ID
		GROUP BY o.CUSTOMER_ID
