DROP TABLE Supplier CASCADE CONSTRAINTS PURGE;
DROP TABLE Product CASCADE CONSTRAINTS PURGE;
DROP TABLE Order_stock CASCADE CONSTRAINTS PURGE;
DROP TABLE Serial_Numbers CASCADE CONSTRAINTS PURGE;
DROP TABLE Plan_T CASCADE CONSTRAINTS PURGE;
DROP TABLE Store_T CASCADE CONSTRAINTS PURGE;
DROP TABLE Employees CASCADE CONSTRAINTS PURGE;
DROP TABLE Customer CASCADE CONSTRAINTS PURGE;
DROP TABLE Phone_Number CASCADE CONSTRAINTS PURGE;
DROP TABLE Usage_T CASCADE CONSTRAINTS PURGE;
DROP TABLE Transaction_T CASCADE CONSTRAINTS PURGE;


CREATE TABLE Phone_Number
(
	Phone_number         NUMBER(10) NOT NULL ,
 PRIMARY KEY (Phone_number)
);

CREATE TABLE Customer
(
	Customer_ID          VARCHAR2(6) NOT NULL ,
	First_Name           VARCHAR2(20) NOT NULL ,
	Surname              VARCHAR2(20) NOT NULL ,
	Address              VARCHAR2(50) NOT NULL ,
	Email                VARCHAR2(20) NULL ,
  Joining_date         DATE DEFAULT SYSDATE,
 PRIMARY KEY (Customer_ID)
);

CREATE TABLE Usage_T
(
	Usage_ID             VARCHAR2(10) NOT NULL ,
	Customer_ID          VARCHAR2(6) NOT NULL ,
	Phone_number         NUMBER(10) NOT NULL ,
	Usage_Date           DATE NOT NULL ,
	Usage_Type           VARCHAR2(20) NOT NULL ,
	Usage_Duration       NUMBER NULL ,
	Price_per_unit       NUMBER(7,2) NOT NULL ,
    Total_Usage_Price    NUMBER(7,2) NULL,
 PRIMARY KEY (Usage_ID),
FOREIGN KEY (Phone_number) REFERENCES Phone_Number (Phone_number),
FOREIGN KEY (Customer_ID) REFERENCES Customer (Customer_ID)
);

CREATE TABLE Supplier
(
	Supplier_ID          VARCHAR2(6) NOT NULL ,
	Company_Name         VARCHAR2(20) NOT NULL ,
	Address              VARCHAR2(50) NOT NULL ,
	Contact              VARCHAR2(10) NOT NULL ,
 PRIMARY KEY (Supplier_ID)
);

CREATE TABLE Product
(
	Phone_ID             VARCHAR2(6) NOT NULL ,
	Model_Number         NUMBER(4) NOT NULL ,
	Purchase_Price       NUMBER(7,2) NOT NULL ,
	Selling_Price        NUMBER(7,2) NOT NULL ,
	Quantity             NUMBER NULL ,
	Description          VARCHAR2(60) NOT NULL ,
	Initial_credit       NUMBER(7,2) NULL ,
	Brand_Name           VARCHAR2(20) NOT NULL ,
	Supplier_ID          VARCHAR2(6) NOT NULL ,
 PRIMARY KEY (Phone_ID),
FOREIGN KEY (Supplier_ID) REFERENCES Supplier (Supplier_ID)
);

CREATE TABLE Order_stock
(
	Order_ID             VARCHAR2(6) NOT NULL , 
	Phone_ID             VARCHAR2(6) NOT NULL ,
	Order_quantity       NUMBER NULL ,
	Supplier_ID          VARCHAR2(6) NULL ,
  Order_date           DATE DEFAULT SYSDATE,
  Delivery_date        DATE,
PRIMARY KEY (Order_ID),
FOREIGN KEY (Phone_ID) REFERENCES Product (Phone_ID),
FOREIGN KEY (Supplier_ID) REFERENCES Supplier (Supplier_ID)
);

CREATE TABLE Store_T
(
	Store_ID             VARCHAR2(6) NOT NULL ,
	Address              VARCHAR2(50) NOT NULL ,
	Contact              VARCHAR2(10) NOT NULL ,
 PRIMARY KEY (Store_ID)
);

CREATE TABLE Employees
(
	Employee_ID          VARCHAR2(6) NOT NULL ,
	Store_ID             VARCHAR2(6) NOT NULL ,
	First_Name           VARCHAR2(20) NOT NULL ,
	Surname              VARCHAR2(20) NOT NULL ,
	Address              VARCHAR2(50) NOT NULL ,
	Contact              VARCHAR2(10) NOT NULL ,
	Department           VARCHAR2(20) NOT NULL ,
 PRIMARY KEY (Employee_ID,Store_ID),
FOREIGN KEY (Store_ID) REFERENCES Store_T (Store_ID)
);

CREATE TABLE Plan_T
(
	Plan_ID              VARCHAR2(6) NOT NULL ,
	Plan_name            VARCHAR2(10) NOT NULL ,
	SMS_Price            NUMBER(7,2) NOT NULL ,
	Myphone_price        NUMBER(7,2) NOT NULL ,
	OtherNetwork_price   NUMBER(7,2) NOT NULL ,
	International_price  NUMBER(7,2) NOT NULL ,
	Data_price           NUMBER(7,2) NOT NULL ,
 PRIMARY KEY (Plan_ID)
);

CREATE TABLE Serial_Numbers
(
	Serial_Number        NUMBER(13) NOT NULL ,
	Phone_ID             VARCHAR2(6) NOT NULL ,
 PRIMARY KEY (Serial_Number),
FOREIGN KEY (Phone_ID) REFERENCES Product (Phone_ID)
);

CREATE TABLE Transaction_T
(
	Transaction_ID       VARCHAR2(6) NOT NULL ,
	Serial_Number        NUMBER(13)  NOT NULL ,
	Plan_ID              VARCHAR2(6) NOT NULL ,
	Phone_ID             VARCHAR2(6) NOT NULL ,
	Customer_ID          VARCHAR2(6) NOT NULL ,
	Transaction_Type     VARCHAR2(20) NOT NULL ,
	Total_Price          NUMBER(7,2) NOT NULL ,
	Store_ID             VARCHAR2(6) NOT NULL ,
	Employee_ID          VARCHAR2(6) NOT NULL ,
	Phone_number         NUMBER(10) NOT NULL ,
  Tran_date            DATE DEFAULT SYSDATE,
 PRIMARY KEY (Transaction_ID),
FOREIGN KEY (Customer_ID) REFERENCES Customer (Customer_ID),
FOREIGN KEY (Employee_ID, Store_ID) REFERENCES Employees (Employee_ID, Store_ID),
FOREIGN KEY (Phone_ID) REFERENCES Product (Phone_ID),
FOREIGN KEY (Plan_ID) REFERENCES Plan_T (Plan_ID),
FOREIGN KEY (Phone_number) REFERENCES Phone_Number (Phone_number),
FOREIGN KEY (Serial_Number) REFERENCES Serial_Numbers (Serial_Number)
);
commit;