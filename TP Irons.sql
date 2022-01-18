--DROPPING IRONS TABLE--
DROP TABLE tp_irons;

--dropping intersection table of order and iron
DROP TABLE tp_iron_order;
--dropping associate table
DROP TABLE tp_associates;

--dropping warehouse table
DROP TABLE tp_warehouse;

--dropping customers table
DROP TABLE tp_customer;

--dropping order table
DROP TABLE tp_order;

--dropping customer and iron intersection table
DROP TABLE tp_customer_iron;

--dropping intersection table of iron and warehouse
DROP TABLE tp_iron_warehouse;

--CREATING IRONS TABLE
CREATE TABLE tp_irons(
iron_id         INTEGER,
iron_name       VARCHAR(50) NOT NULL,
iron_description VARCHAR(200),
iron_model      VARCHAR(50),
iron_color      VARCHAR(50),
quantity_on_hand INTEGER,
iron_type       VARCHAR(50),
iron_accessories VARCHAR(50),
iron_discount   DECIMAL(8,2),
iron_price      DECIMAL(8,2) NOT NULL,
iron_weight     DECIMAL(5,2),
iron_rating     DECIMAL(10,2),
warehouse_id      INTEGER
);

--creating default values for iron_discount
ALTER TABLE tp_irons
ALTER iron_discount SET DEFAULT 5;

--creating default values for iron_rating
ALTER TABLE tp_irons
ALTER iron_rating SET DEFAULT 10;


--CREATING PRIMARY KEY FOR IRONS TABLE
ALTER TABLE tp_irons
ADD CONSTRAINT tp_iron_iron_id
PRIMARY KEY(iron_id);

--ADDING CHECK CONSTRAINT to discount so that they can enter only values between o and 100
ALTER TABLE tp_irons
ADD CONSTRAINT tp_iron_iron_discount_ck
CHECK(iron_discount BETWEEN 0 AND 100);

--ADDING CHECK  CONSTRAINT to iron_rating so that they can enter only data between 0 and 10
ALTER TABLE tp_irons
ADD CONSTRAINT tp_iron_iron_rating_ck
CHECK(iron_rating BETWEEN 0 AND 10);



--create warehouse table
CREATE TABLE tp_warehouse(
warehouse_id        INTEGER,
warehouse_name      VARCHAR(60),
warehouse_city      VARCHAR(40),
warehouse_state     VARCHAR(40),
warehouse_postal_code   VARCHAR(40),
warehouse_country   VARCHAR(40)
);



--Creating default value for warehouse_country
ALTER TABLE tp_warehouse
ALTER warehouse_country SET DEFAULT 'Canada';

--adding  primary key to warehouse table
ALTER TABLE tp_warehouse
ADD CONSTRAINT tp_warehouse_warehouse_id
PRIMARY KEY(warehouse_id);

-- inserting tables into warehouse table
INSERT INTO tp_warehouse
VALUES(101,'STEELIX IRONS Pvt Ltd','Canada','Ontario','Sarnia','N7T 859'),
      (102,'STEELIX IRONS Pvt Ltd','Canada','Ontario','Toronto','P7T 459'),
      (103,'STEELIX IRONS Pvt Ltd','Canada','Ontario','London','N5V 0A5'),
      (104,'STEELIX IRONS Pvt Ltd','Canada','Ontario','Windsor','N8N 0A4');
      
    
-- selecing all values from warehouse_table
SELECT * FROM tp_warehouse;





--adding foreign key for irons table
ALTER TABLE tp_irons
ADD CONSTRAINT tp_iron_warehouse_id_fk
FOREIGN KEY(warehouse_id)
REFERENCES tp_warehouse(warehouse_id);

--inserting values into iron table
INSERT INTO tp_irons
VALUES(1,'Conair','Ceramic sole plates are plates made of aluminum or plastic with ceramic coating.','2019','WHITE',150,'Steam',NULL,12,40,150,5,101);

--inserting values into iron table
INSERT INTO tp_irons
VALUES(2,'Consew','Stainless Steel sole plates are plates made of aluminum or plastic with  Stainless Steel coating.','2019','Black',100,'Steam',NULL,11,40,150,4,102);

--inserting values into iron table
INSERT INTO tp_irons
VALUES(3,'Hamilton Beach ','Titanium plates are plates made of aluminum or plastic with Tiranium coating.','2018','Grey',120,'Electric','Extra Wire of 3 meters',10,45,135,5,103);


--inserting values into iron table
INSERT INTO tp_irons
VALUES(4,'Conair','Ceramic sole plates are plates made of aluminum or plastic with ceramic coating.','2019','Blue',80,'Electric',NULL,13,55,130,5,104),
      (5,'Hamilton Beach','Titanium plates are plates made of aluminum or plastic with Tiranium coating.','2018','Black and White',20,'Steam','Additional Plate',12,30,145,3,102),
      (6,'Conair','Ceramic sole plates are plates made of aluminum or plastic with ceramic coating.','2019','WHITE',60,'Steam',NULL,11,40,150,5,103),
      (7,'Consew','Stainless Steel sole plates are plates made of aluminum or plastic with  Stainless Steel coating.','2017','Blue and White',50,'Steam',NULL,12,60,120,4,101),
      (8,'Hamilton Beach','Titanium plates are plates made of aluminum or plastic with Tiranium coating.','2019','WHITE',40,'Electric','Additional plates',13,55,140,5,102),
      (9,'Pacific Gravity','Titanium plates are plates made of aluminum or plastic with Tiranium coating.','2018','WHITE',30,'Steam',NULL,13,35,150,4,102),
      (10,'Ace Hi Silver Star ','Titanium plates are plates made of aluminum or plastic with Tiranium coating.','2018','WHITE',86,'Electric',NULL,12,40,160,3,103);

--selecting all values from iron table
SELECT * FROM tp_irons;






--creating customer table
CREATE TABLE tp_customer(
customer_id                 INTEGER,
customer_first_name         VARCHAR(50),
customer_last_name          VARCHAR(50),
customer_phone_number     DECIMAL(10,0),
customer_address          VARCHAR(100),
iron_id                   INTEGER,
order_id                  INTEGER
);

ALTER TABLE tp_customer
ADD CONSTRAINT tp_customer_customer_phone_number_uk
UNIQUE(customer_phone_number);

--creating primary key for the customer table
ALTER TABLE tp_customer
ADD CONSTRAINT tp_customer_customer_id_pk
PRIMARY KEY(customer_id);

--creating foreign key in customer table which references to iron table
ALTER TABLE tp_customer
ADD CONSTRAINT tp_customer_iron_id_fk
FOREIGN KEY(iron_id)
REFERENCES tp_irons(iron_id);






--creating order table
CREATE TABLE tp_order(
order_id        INTEGER,
order_date      DATE NOT NULL,
order_quantity  INTEGER NOT NULL,
order_tax       DECIMAL(5,2),
order_total     DECIMAL(20,2) NOT NULL,
iron_id       INTEGER        
);

--creating default value for order_date
ALTER TABLE tp_order
ALTER order_date SET DEFAULT CURRENT_DATE;


--creating primary key for the order table
ALTER TABLE tp_order
ADD CONSTRAINT tp_order_order_id_pk
PRIMARY KEY(order_id);

--creating foreign key for the order table
ALTER TABLE tp_order
ADD CONSTRAINT tp_order_iron_id_fk
FOREIGN KEY(iron_id)
REFERENCES tp_irons(iron_id);

--inserting values into the order table
INSERT INTO tp_order
VALUES(201,'2019-10-23',2,10,1000,1),
      (202,'2019-10-24',3,10,2000,2),
      (203,'2019-11-23',2,10,3000,1),
      (204,'2019-12-23',2,10,1000,1),
      (205,'2019-10-20',2,10,2000,1),
      (206,'2019-10-13',2,10,1000,1),
      (207,'2019-10-16',2,10,3000,1),
      (208,'2019-10-19',2,10,2000,1),
      (209,'2019-10-10',2,10,1000,1),
      (210,'2019-05-23',2,10,3000,1);
 
--selecting all values from order table
SELECT * FROM tp_order;



--creating foreign key in customer table which references to order table
ALTER TABLE tp_customer
ADD CONSTRAINT tp_customer_order_id_fk
FOREIGN KEY(order_id)
REFERENCES tp_order(order_id);

--inserting values into customer table
INSERT INTO tp_customer
VALUES(301,'Dinesh','k',1234567890,'123 alice Street Sarnia',1,201),
      (302,'Dheeraj','d',7418523690,'456 alice Street Sarnia',1,203),
      (303,'Prashanth','c',3698521470,'789 mary street london canada',1,202),
      (304,'Deepak','a',7896541320,'456 mary street london canada',1,204),
      (305,'Saud','w',1534567980,'426 christiana street sarnia',1,203),
      (306,'Kashif','q',1465987123,'486 christiana street sarnia',1,204),
      (307,'Sai','r',1598746320,'753 bakers street toronto',1,202),
      (308,'Bharadwaj','v',1324657980,'459 london road sarnia',1,203),
      (309,'Nithin','g',1734567880,'159 queens road london',1,201),
      (310,'Aaron','h',4598761230,'483 kurby street sarnia',1,205);

--selecting all values from the customer table
SELECT * FROM tp_customer;





--creating intersection table of order and iron
CREATE TABLE tp_iron_order(
order_id      INTEGER,
iron_id      INTEGER
);

--creating primary keys for the intersection table of order and iron
ALTER TABLE tp_iron_order
ADD CONSTRAINT tp_iron_order_iron_id_order_id_pk
PRIMARY KEY(order_id,iron_id);

--creating iron id foreign for the intersection table of order and iron
ALTER TABLE tp_iron_order
ADD CONSTRAINT tp_iron_order_iron_id_fk
FOREIGN KEY(iron_id)
REFERENCES tp_irons(iron_id);

--creating order id foreign for the intersection table of order and iron
ALTER TABLE tp_iron_order
ADD CONSTRAINT tp_iron_order_order_id_fk
FOREIGN KEY(order_id)
REFERENCES tp_order(order_id);

--Inserting values into intersection table of order and iron
INSERT INTO tp_iron_order
VALUES(201,1),
      (201,2);
INSERT INTO tp_iron_order
VALUES(202,1),
      (202,2),
      (203,1),
      (203,2),
      (204,1),
      (204,2),
      (205,1),
      (205,2),
      (206,1),
      (206,2),
      (207,1),
      (207,2),
      (208,1),
      (208,2),
      (209,1),
      (209,2),
      (210,1),
      (210,2);
 
    
--selecting all values from intersection table of order and iron
SELECT * FROM tp_iron_order;





--creating customer and iron intersection table
CREATE TABLE tp_customer_iron(
customer_id       INTEGER,
iron_id         INTEGER
);

--creating primary keys for customer and iron intersection table
ALTER TABLE tp_customer_iron
ADD CONSTRAINT tp_customer_iron_customer_id_iron_id_pk
PRIMARY KEY(customer_id,iron_id);

--creating iron id foreign key for the intersection table of customer and iron
ALTER TABLE tp_customer_iron
ADD CONSTRAINT tp_customer_iron_iron_id_fk
FOREIGN KEY(iron_id)
REFERENCES tp_irons(iron_id);

--creating customer  id foreign key for the intersection table of customer and iron
ALTER TABLE tp_customer_iron
ADD CONSTRAINT tp_customer_iron_customer_id_fk
FOREIGN KEY(customer_id)
REFERENCES tp_customer(customer_id);


--inserting into customer and iron intersection table
INSERT INTO tp_customer_iron
VALUES(301,1),
      (301,2),
      (301,3),
      (301,4);

--selecting all values from customer and iron intersection table
SELECT * FROM tp_customer_iron;




--creating intersection table of iron and warehouse
CREATE TABLE tp_iron_warehouse(
iron_id       INTEGER,
warehouse_id    INTEGER
);

--creating primary keys for intersection table of iron and warehouse
ALTER TABLE tp_iron_warehouse
ADD CONSTRAINT tp_iron_warehouse_iron_id_warehouse_id_pk
PRIMARY KEY(iron_id,warehouse_id);

--creating foreign key for the intersection table of iron and warehouse
ALTER TABLE tp_iron_warehouse
ADD CONSTRAINT tp_iron_warehouse_iron_id_fk
FOREIGN KEY(iron_id)
REFERENCES tp_irons(iron_id);

--creating foreign key for the intersection table of iron and warehouse
ALTER TABLE tp_iron_warehouse
ADD CONSTRAINT tp_iron_warehouse_warehouse_id_fk
FOREIGN KEY(warehouse_id)
REFERENCES tp_warehouse(warehouse_id);

--inserting values into intersection table of iron and warehouse
INSERT INTO tp_iron_warehouse
VALUES(1,101),
      (2,102);
    
--selecting all values from intersection table of iron and warehouse
SELECT * FROM tp_iron_warehouse;



--Creating associate table
CREATE TABLE tp_associates(
associates_id            INTEGER,
associates_name          VARCHAR(50),
associates_address          VARCHAR(50),
associates_social_no        INTEGER,
associates_phone_number        DECIMAL(10,0),
associates_joining_date  DATE NOT NULL,
warehouse_id            INTEGER
);


--adding unique for tp_associate table
ALTER TABLE tp_associates
ADD CONSTRAINT tp_associate_associates_social_no_uk
UNIQUE(associates_social_no);

--creating primary key for associate
ALTER TABLE tp_associates
ADD CONSTRAINT tp_associates_associates_id_pk
PRIMARY KEY(associates_id);

--creating foreign key for associate table
ALTER TABLE tp_associates
ADD CONSTRAINT tp_associates_warehouse_id_fk
FOREIGN KEY(warehouse_id)
REFERENCES tp_warehouse(warehouse_id);

--inserting values into associate table
INSERT INTO tp_associates
VALUES(401,'Younus','alice street',75963,7896541320,'2019-1-12',101),
      (402,'dheeraj','alice street',14785,1236547900,'2019-2-15',101),
      (403,'prashanth','alice street',23698,7531463023,'2019-2-15',101),
      (404,'Nithin','alice street',14563,1234569870,'2019-3-02',101);
    
--selecing all values from the associate table
SELECT * FROM tp_associates;

--creating views 
CREATE OR replace VIEW PRODV1 As
SELECT iron_id, iron_description,quantity_on_hand,iron_price
FROM tp_irons;

SELECT * FROM PRODV1;


CREATE OR replace VIEW PRODV2 As
SELECT  c.customer_first_name||' '||customer_last_name AS customer_name, TO_CHAR(o.order_date,'mm/dd/yy') AS order_date,  c.order_id AS order_number,o.iron_id,i.iron_description, o.order_quantity AS num_ordered,o.order_total AS quoted_price
FROM tp_irons i
JOIN tp_customer c USING(iron_id)
JOIN tp_order o
ON c.order_id=o.order_id;

SELECT * FROM PRODV2;





