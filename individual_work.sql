/*setting up group schema*/
alter session set current_schema = dt228group_28;

/***********************************POPULATION************************************/

insert into customer(customer_id, first_name, surname, address) values
('C0020', 'Fill', 'Kiril', '27 Rathmines road');
commit;

insert into customer(customer_id, first_name, surname, address, email) values
('C0021', 'Gary', 'Barlow', 'Citywest', 'gary@gmail.com');
commit;

insert into customer(customer_id, first_name, surname, address) values
('C0022', 'Bary', 'Wilow', 'Tallagh');
commit;

insert into transaction_t(TRANSACTION_ID, SERIAL_NUMBER, PLAN_ID, PHONE_ID, CUSTOMER_ID, TRANSACTION_TYPE, TOTAL_PRICE, STORE_ID, EMPLOYEE_ID, PHONE_NUMBER)
values ('T0011', 5320834605370, 'PL001', 'P0004', 'C0021', 'online', 245, 'MP002', 'E0002', 0891234576);
commit;

insert into transaction_t(TRANSACTION_ID, SERIAL_NUMBER, PLAN_ID, PHONE_ID, CUSTOMER_ID, TRANSACTION_TYPE, TOTAL_PRICE, STORE_ID, EMPLOYEE_ID, PHONE_NUMBER)
values ('T0012', 8986307059379, 'PL001', 'P0001', 'C0021', 'store', 240, 'MP002', 'E0002', 0891234578);
commit;

insert into transaction_t(TRANSACTION_ID, SERIAL_NUMBER, PLAN_ID, PHONE_ID, CUSTOMER_ID, TRANSACTION_TYPE, TOTAL_PRICE, STORE_ID, EMPLOYEE_ID, PHONE_NUMBER)
values ('T0013', 4123456789102, 'PL001', 'P0004', 'C0022', 'store', 180, 'MP002', 'E0002', 891234573);
commit;

/*check tables that have been changed*/
select *from customer;
select *from transaction_t;
/**************************************TRANSACTION 1************************************/

/*New custome wants phone! Store employee takes the customer details! Made a mistake so
update the customer table with right value! Then take transaction details and issue the 
phone numbe and plan they are on!*/
insert into customer(customer_id, first_name, surname, address, email) values
('C11256', 'Bill', 'Collins', '2 Church Avenue', 'bill@inbox.lv');
commit;

UPDATE customer
SET CUSTOMER_ID='C0006'
WHERE Surname='Collins' AND First_Name='Bill';
commit;

insert into transaction_t(TRANSACTION_ID, SERIAL_NUMBER, PLAN_ID, PHONE_ID, CUSTOMER_ID, TRANSACTION_TYPE, TOTAL_PRICE, STORE_ID, EMPLOYEE_ID, PHONE_NUMBER)
values ('T0007', 2327073314506, 'PL001', 'P0002', 'C0006', 'store', 250, 'MP002', 'E0004', 891234578);
commit;

/*check tables that have been changed*/
select *from customer;
select *from transaction_t;

/**************************************TRANSACTION 2************************************/

/*Customer details where taken when they ordered online! They made transaction, but
they changed their mind and transaction was canceled!*/
insert into customer(customer_id, first_name, surname, address, email) values
('C0009', 'Alice', 'Mi', 'Rathmines', 'alice@inbox.lv'); 
commit;

insert into transaction_t(TRANSACTION_ID, SERIAL_NUMBER, PLAN_ID, PHONE_ID, CUSTOMER_ID, TRANSACTION_TYPE, TOTAL_PRICE, STORE_ID, EMPLOYEE_ID, PHONE_NUMBER)
values ('T0009', 6869996972346, 'PL001', 'P0001', 'C0009', 'online', 225, 'MP002', 'E0002', 891234576);
commit;

delete transaction_t where transaction_id = 'T0009';
commit;

/*check tables that have been changed*/
select *from customer;
select *from transaction_t;

/**************************************TRANSACTION 3************************************/

/*Customer details where taken and transaction was made online!*/
insert into customer(customer_id, first_name, surname, address) values
('C0010', 'Maria', 'Swift', '23 Finglas');
commit;

insert into transaction_t(TRANSACTION_ID, SERIAL_NUMBER, PLAN_ID, PHONE_ID, CUSTOMER_ID, TRANSACTION_TYPE, TOTAL_PRICE, STORE_ID, EMPLOYEE_ID, PHONE_NUMBER)
values ('T0017', 7334623257732, 'PL001', 'P0003', 'C0006', 'online', 170, 'MP002', 'E0002', 891234577);
commit;

/*check tables that have been changed*/
select *from customer;
select *from transaction_t;

/***********************************PROJECTION********************************************/
/*Projection - specific colum from table*/
/*check table contents*/
select *from product;
select *from store_t;

/*check the quantity of phones in stock*/
select brand_name, quantity from product;

/*check quantaty and selling price of phones*/
select brand_name, model_number, quantity, to_char (selling_price, 'U99,999.99') from product;

/*customer wants to know details about other stores*/
select address, contact from store_t;

/**********************************RESTRICTION***********************************************/

/*check for phones that are cheap less than €100*/
select brand_name, model_number, to_char (selling_price, 'U99,999.99') from product where selling_price < 100;

/*checks for phones that are smartphones*/
select model_number, brand_name, description from product where description like '%Smartphone%';

/*see the customers_id if they bought phones online or in store*/
select *from transaction_t;
select Customer_id from transaction_t where transaction_type = 'store';
select Customer_id from transaction_t where transaction_type = 'online';

/**********************************SORTING**********************************/

select *from product order by selling_price;

select *from transaction_t order by total_price;

/******************************************FUNCTIONS****************************************/

/*display earning from today and uses trunc() function on sysdate to get just a date with out time*/
select *from product;
select sum(total_price) as "Earning" from transaction_t where tran_date >= trunc(sysdate);

/*round() function is used on average selling price for phones in stock*/
select round(avg(selling_price)) as "Average phone price" from product;

/*************************************TESTING FOR NULL's************************************/

/*display customers who has emails*/
select *from customer;
select customer_id from customer where email is not null;

/*check if we are out of stock in any phone model*/
select *from product;
select model_number, brand_name from product where quantity is null;

/*******************************************AGGREGATION********************************************/

/*count() function is used to find out how many transactions was made today*/
select *from transaction_t;
select count(*) as "Num of transactions made today" from transaction_t where tran_date >= trunc(sysdate);

/*sum() function is used to find Total profit if everything is sold*/
select *from product;
select sum((selling_price - purchase_price) * quantity) as "Total Profit"from product;

/*Aggregation with 'Group by' is used to find out how many customers spend over 200 and what price they paid*/
select total_price, count(*) as "Customer count" from transaction_t where total_price > 200 group by total_price;

/*Aggregation with 'Having' clause is used to find customers who have more than 1 phone numbers*/
select customer_id, count(phone_number) as "Phone number count" from transaction_t group by customer_id having count(*) > 1;

/**************************************MINUS, INTERSECTION, UNION**********************************/

/*used MINUS - display serial numbers that are not yet used*/
select *from serial_numbers;
select serial_number from serial_numbers
minus
select serial_number from transaction_t;

/*used INTERSECTION - customers that bought phones in store and online*/
select *from customer;
select *from transaction_t;
select Customer_id from transaction_t where transaction_type = 'store'
intersect
select Customer_id from transaction_t where transaction_type = 'online';

/*used UNION - in total sold Nokia and Samsung phones*/
select count(transaction_t.phone_id) as "Count" from transaction_t join product on transaction_t.phone_id = product.phone_id
where brand_name = 'Nokia'
union
select count(transaction_t.phone_id) as "Count" from transaction_t join product on transaction_t.phone_id = product.phone_id
where brand_name = 'Samsung';

/*************************************JOIN*******************************************/
/*Join...Using*/
select *from product;
select *from transaction_t;

/*serial numbers that are used in transaction*/
select transaction_t.serial_number from transaction_t join product using(phone_id);

/*Join...On*/
select *from customer;
select *from transaction_t;
select *from phone_number;
select *from serial_numbers;

/*customers who have made transactions*/
select distinct customer.first_name, customer.surname from customer 
join transaction_t on transaction_t.customer_id = customer.customer_id;

/*phone number that customer get after transaction*/
select customer.first_name, customer.surname, phone_number.phone_number from customer 
join transaction_t on transaction_t.customer_id = customer.customer_id 
join phone_number on transaction_t.phone_number = phone_number.phone_number;

/*****************************************SUBQUERY**************************************/

/*displayes the first name and surname who have made atleast 1 transaction*/
select first_name, surname from customer where customer_id in(select customer_id from transaction_t);