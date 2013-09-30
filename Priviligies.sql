/*In store sales and online Sanita*/
grant select, insert, update, delete on customer to stifentale;
grant select, insert, update, delete on transaction_T to stifentale;
grant select on phone_number to stifentale;
grant select on product to stifentale;
grant select on serial_numbers to stifentale;
grant select on plan_t to stifentale;
grant select on store_t to stifentale;

/*Ordering stock Kenny*/
grant select, insert, update, delete on order_stock to kscally;
grant select, insert, update, delete on product to kscally;
grant select, insert, update, delete on serial_numbers to kscally;
grant select, insert, update, delete on supplier to kscally;
grant select on transaction_t to kscally;

/*Billing Amil*/
grant select, insert, update, delete on usage_t to aosmanli;
grant select, insert, update, delete on plan_t to aosmanli;
grant select, insert, update, delete on employees to aosmanli;
grant select on store_t to aosmanli;
grant select on customer to aosmanli;
grant select on transaction_t to aosmanli;
grant select on phone_number to aosmanli;

commit;