--- Create a Scalar function
--- FUNCTION 1:  Given some parameters, the function returns a single value: e.g., given an orderID, the function returns the total balance of the order. 
CREATE OR REPLACE FUNCTION one_order_balance(p_orderID NUMBER)
RETURN NUMBER
AS
 v_ret NUMBER(10);
BEGIN
	SELECT SUM(ol.ORDER_QUANTITY*p.STANDARD_PRICE) INTO v_ret
	FROM ORDER_LINE_T  ol
	INNER JOIN PRODUCT_T p ON ol.PRODUCT_ID = p.PRODUCT_ID
	WHERE ol.order_id = p_orderID;
	RETURN v_ret;
END;

--- Create TABLE-VALUE function
-- Call FUNCTION 1
SELECT one_order_balance(1001) FROM dual; 



--- FUNCTION 2: Create a Table functoin
CREATE OR REPLACE TYPE s_record AS OBJECT (
    oID NUMBER, 
    count number
    );

CREATE OR REPLACE TYPE t_table AS TABLE OF s_record;


CREATE OR REPLACE FUNCTION all_order_balance  
RETURN t_table 
AS 
     v_ret t_table;
BEGIN 

    SELECT s_record(ol.ORDER_ID, SUM(ol.ORDER_QUANTITY*p.STANDARD_PRICE))
    BULK COLLECT INTO v_ret 
    FROM ORDER_LINE_T ol
    INNER JOIN PRODUCT_T p ON ol.PRODUCT_ID = p.PRODUCT_ID
    GROUP BY ol.ORDER_ID; 

RETURN v_ret; 
END all_order_balance;

-- Call FUNCTION 2
SELECT * FROM TABLE(all_order_balance);


--- FUNCTION 3: Create a Table functoin THAT TAKES A PARAMETER

CREATE OR REPLACE FUNCTION selected_order_balance (porderID NUMBER) 
RETURN t_table 
AS 
     v_ret t_table;
BEGIN 

    SELECT s_record(ol.ORDER_ID, SUM(ol.ORDER_QUANTITY*p.STANDARD_PRICE)) BULK COLLECT INTO v_ret 
    FROM ORDER_LINE_T ol
    INNER JOIN PRODUCT_T p ON ol.PRODUCT_ID = p.PRODUCT_ID AND p.PRODUCT_ID = porderID
    GROUP BY ol.ORDER_ID; 
 
    RETURN v_ret; 
END selected_order_balance;

-- Call FUNCTION 3
SELECT * FROM table(selected_order_balance(1));


--- sample queries FOR UNDERSTANDING THE ABOVE FUNCTIONS

	SELECT SUM(ol.ORDER_QUANTITY*p.STANDARD_PRICE)
	FROM ORDER_LINE_T  ol
	INNER JOIN PRODUCT_T p ON ol.PRODUCT_ID = p.PRODUCT_ID
	WHERE ol.order_id = 1001;

    SELECT ol.ORDER_ID, SUM(ol.ORDER_QUANTITY*p.STANDARD_PRICE) 
    FROM ORDER_LINE_T ol
    INNER JOIN PRODUCT_T p ON ol.PRODUCT_ID = p.PRODUCT_ID AND p.PRODUCT_ID = 1
    GROUP BY ol.ORDER_ID; 