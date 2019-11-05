
--- TRIGGER 1: CREATE A TRIGGER USING AN INTERNAL VARIABLE
CREATE OR REPLACE TRIGGER insertOLTrigger
    AFTER INSERT ON ORDER_LINE_T
    FOR EACH ROW
    
DECLARE 
    cid INTEGER; 
    
BEGIN
    SELECT o.customer_ID INTO cid 
    FROM ORDER_T o WHERE :NEW.order_ID = o.order_ID;
    dbms_output.put_line(cid);
        
    UPDATE CUSTOMER_T 
	SET balance = balance + 
            (SELECT :NEW.ORDER_QUANTITY*p.STANDARD_PRICE 
            FROM product_T p 
            WHERE p.product_ID = :NEW.product_ID)
    WHERE CUSTOMER_ID  = cid; 
  
END insertOLTrigger;

INSERT INTO ORDER_LINE_T VALUES(1001, 5, 2);



--- TRIGGER 2: USING A GLOBAL VARIABLE
CREATE OR replace package global_v
IS 
    customerid NUMBER;
END; 

CREATE OR REPLACE TRIGGER insertOLTrigger
BEFORE INSERT ON ORDER_LINE_T
FOR EACH ROW
BEGIN 
    SELECT o.customer_ID INTO global_v.customerid 
    FROM ORDER_T o WHERE :new.order_ID = o.order_ID;
    DBMS_OUTPUT.PUT_LINE(' THIS is first trigger:'|| global_v.customerid );

    UPDATE CUSTOMER_T 
	SET balance = 
        (SELECT SUM(ol.ORDER_QUANTITY*p.STANDARD_PRICE) 
		FROM ORDER_T o, PRODUCT_T p, order_line_T ol
		WHERE ol.PRODUCT_ID = p.PRODUCT_ID  AND ol.order_ID = o.order_ID AND
        o.customer_ID = global_v.customerid) 
    WHERE CUSTOMER_T.CUSTOMER_ID  = global_v.customerid ; 
END;



INSERT INTO ORDER_LINE_T VALUES(1003, 6, 2);



---- TRIGGER that COULD result in a conflict

CREATE OR REPLACE TRIGGER WrongInsertOLTrigger
BEFORE INSERT ON ORDER_LINE_T
FOR EACH ROW
    
DECLARE 
    cid INTEGER; 
    
BEGIN 
    SELECT o.customer_ID INTO cid
    FROM ORDER_T o WHERE :new.order_ID = o.order_ID;
    DBMS_OUTPUT.PUT_LINE(' THIS is first trigger:'|| cid  );

    UPDATE CUSTOMER_T 
	SET balance = 
        (SELECT SUM(ol.ORDER_QUANTITY*p.STANDARD_PRICE) 
		FROM ORDER_T o, PRODUCT_T p, order_line_T ol
		WHERE ol.PRODUCT_ID = p.PRODUCT_ID  AND ol.order_ID = o.order_ID AND
        o.customer_ID = cid) 
    WHERE CUSTOMER_T.CUSTOMER_ID  = cid ; 
END;

INSERT INTO ORDER_LINE_T VALUES(1007, 4, 1);