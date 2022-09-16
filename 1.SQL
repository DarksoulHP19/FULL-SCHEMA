create table client_master 
(client_no varchar2(6) primary key, 
name varchar2(20), 
address1 varchar2(30), 
address2 varchar2(30), 
city varchar2(15), 
state varchar2(15), 
pincode number(6), 
bal_due number(10,2) 
);

create table product_master 
(product_no varchar2(6) primary key check(product_no like 'P%'), 
description varchar2(15), 
profit_percent number(4,2), 
unit_measure varchar2(10), 
qty_on_hand number(8), 
reorder_lvl number(8), 
sell_price number(8,2), 
cost_price number(8,2) 
);



create table sales_master( 
    salesman_no varchar(6) CONSTRAINT s_no PRIMARY KEY CHECK(salesman_no like 'S%'), 
    sal_name varchar(20) NOT NULL, 
    address1 varchar(30) not null, 
    address2 varchar(30) not null, 
    city varchar(20) , 
    state varchar(20), 
    pincode number(6), 
    sal_amt number(8,2) not null check(sal_amt > 0), 
    tgt_to_get number(6,2) not null check(tgt_to_get > 0), 
    ytd_sales number (6,2) not null , 
    remarks varchar(60) 
);

create table sales_order( 
    s_order_no VARCHAR2(6) PRIMARY KEY check(s_order_no like 'O%'), 
    order_date DATE NOT NULL, 
    client_no varchar2(6) REFERENCES client_master(client_no), 
    dely_add varchar2(25), 
    salesman_no varchar2(6) REFERENCES sales_master(salesman_no) CHECK(salesman_no like 'S%'), 
    dely_type char(1) default 'F' check(dely_type in ('F','P') ), 
    bill_yn char(1) , 
    dely_date DATE, 
    order_status varchar2(10) , 
    check(dely_date>order_date), 
    check(order_status in ('in process','fulfilled','back order','cancelled')) 
);

CREATE TABLE sales_order_details( 
    s_order_no varchar2(6) REFERENCES sales_order(s_order_no) check(s_order_no like 'O%'), 
    product_no varchar2(6) REFERENCES product_master(product_no) check(product_no like 'P%'), 
    qty_order number(8) , 
    qty_disp number(8) , 
    product_rate number(10,2) 
);


create table challan_header ( 
    challan_no VARCHAR2(6) primary key , 
    s_order_no varchar2(6) CONSTRAINT S_ORDER REFERENCES sales_order(s_order_no) check (s_order_no like 'O%'), 
    challan_date date not null, 
    billed_yn char(1) default 'N' check(billed_yn in ('Y','N')) 
);

create table challan_details ( 
    challan_no varchar2(6) REFERENCES challan_header(challan_no), 
    product_no varchar2(6) REFERENCES product_master(product_no) check(product_no like 'P%'), 
    qty_disp number(4,2) not null 
)
;

Insert into CLIENT_MASTER  values ('0001','Ivan','A/2','Worli','Bombay','Maharashtra',400054,15000);
Insert into CLIENT_MASTER  values ('0002','Vandana','B/2','Juhu','Madras','Tamilnadu',780001,0);
Insert into CLIENT_MASTER  values ('0003','Pramada','C/4','Nariman','Bombay','Maharashtra',400057,5000);
Insert into CLIENT_MASTER  values ('0004','Basu','A/5','Bandra','Bombay','Maharashtra',400056,0);
Insert into CLIENT_MASTER  values ('0005','Ravi','E/10','Delhi','Delhi','Delhi',100001,2000);
Insert into CLIENT_MASTER  values ('0006','Rukmini','B/6','Juhu','Bombay','Maharashtra',400050,0);


Insert into PRODUCT_MASTER values ('P00001','1.44floppies',5,'piece',100,20,525,500);
Insert into PRODUCT_MASTER values ('P03453','Monitors',6,'piece',10,3,12000,11200);
Insert into PRODUCT_MASTER values ('P06734','Mouse',5,'piece',20,5,1050,500);
Insert into PRODUCT_MASTER values ('P07865','1.22 floppies',5,'piece',100,20,525,500);
Insert into PRODUCT_MASTER values ('P07868','Keyboards',2,'piece',10,3,3150,3050);
Insert into PRODUCT_MASTER values ('P07885','CD Drive',2.5,'piece',10,3,5250,5100);
Insert into PRODUCT_MASTER values ('P07965','540 HDD',4,'piece',10,3,8400,8000);
Insert into PRODUCT_MASTER values ('P07975','1.44 Drive',5,'piece',10,3,1050,1000);
Insert into PRODUCT_MASTER values ('P08865','1.22 Drive',5,'piece',2,3,1050,1000);

Insert into SALES_MASTER values ('S00001','Aman','A/14','Worli','Mumbai','Maharashtra',400002,3000,100,50,'Good');
Insert into SALES_MASTER values ('S00002','Omkar','65','Nariman','Mumbai','Maharashtra',400001,3000,200,100,'Good');
Insert into SALES_MASTER values ('S00003','Raj','P-7','Bandra','Mumbai','Maharashtra',400032,3000,200,100,'Good');
Insert into SALES_MASTER values ('S00004','Ashish','A/5','Juhu','Mumbai','Maharashtra',400044,3500,200,150,'Good');



Insert into SALES_ORDER  values ('O19001',to_date('12-JAN-96','DD-MON-RR'),'0001',null,'S00001','F','N',to_date('20-JAN-96','DD-MON-RR'),'in process');
Insert into SALES_ORDER  values ('O19002',to_date('25-JAN-96','DD-MON-RR'),'0002',null,'S00002','P','N',to_date('27-JAN-96','DD-MON-RR'),'cancelled');
Insert into SALES_ORDER  values ('O16865',to_date('18-FEB-96','DD-MON-RR'),'0003',null,'S00003','F','Y',to_date('20-FEB-96','DD-MON-RR'),'fulfilled');
Insert into SALES_ORDER  values ('O19003',to_date('03-APR-96','DD-MON-RR'),'0001',null,'S00001','F','Y',to_date('07-APR-96','DD-MON-RR'),'fulfilled');
Insert into SALES_ORDER  values ('O46866',to_date('20-MAY-96','DD-MON-RR'),'0004',null,'S00002','P','N',to_date('22-MAY-96','DD-MON-RR'),'cancelled');
Insert into SALES_ORDER  values  ('O10008',to_date('24-MAY-96','DD-MON-RR'),'0005',null,'S00004','F','N',to_date('26-MAY-96','DD-MON-RR'),'in process');



Insert into SALES_ORDER_DETAILS  values ('O19001','P00001',4,4,525);
Insert into SALES_ORDER_DETAILS  values ('O19001','P07965',2,1,8400);
Insert into SALES_ORDER_DETAILS  values ('O19001','P07885',2,1,5250);
Insert into SALES_ORDER_DETAILS  values ('O19002','P00001',10,0,525);
Insert into SALES_ORDER_DETAILS  values ('O16865','P07868',3,3,3150);
Insert into SALES_ORDER_DETAILS  values ('O16865','P07885',10,10,5250);
Insert into SALES_ORDER_DETAILS  values ('O19003','P00001',4,4,1050);
Insert into SALES_ORDER_DETAILS  values ('O19003','P03453',2,2,1050);
Insert into SALES_ORDER_DETAILS  values ('O46866','P06734',1,1,12000);
Insert into SALES_ORDER_DETAILS  values ('O46866','P07865',1,0,8400);
Insert into SALES_ORDER_DETAILS  values ('O10008','P07975',1,0,1050);
Insert into SALES_ORDER_DETAILS  values ('O10008','P00001',10,5,525);

Insert into CHALLAN_HEADER values ('CH9001','O19001',to_date('12-DEC-95','DD-MON-RR'),'Y');
Insert into CHALLAN_HEADER values   ('CH6865','O46866',to_date('12-NOV-95','DD-MON-RR'),'Y');
Insert into CHALLAN_HEADER values   ('CH3965','O10008',to_date('12-OCT-95','DD-MON-RR'),'Y');

Insert into CHALLAN_DETAILS values ('CH9001','P00001',4);
Insert into CHALLAN_DETAILS values ('CH9001','P07965',1);
Insert into CHALLAN_DETAILS values ('CH9001','P07885',1);
Insert into CHALLAN_DETAILS values ('CH9001','P07868',3);
Insert into CHALLAN_DETAILS values ('CH6865','P03453',4);
Insert into CHALLAN_DETAILS values ('CH6865','P00001',10);
Insert into CHALLAN_DETAILS values ('CH3965','P00001',5);
Insert into CHALLAN_DETAILS values ('CH3965','P07965',2);


-- SELECT * FROM CLIENT_MASTER;
-- SELECT * FROM PRODUCT_MASTER;
-- SELECT * FROM SALES_MASTER;
-- SELECT * FROM SALES_ORDER;
-- SELECT * FROM SALES_ORDER_DETAILS;
-- SELECT * FROM CHALLAN_HEADER;
-- SELECT * FROM CHALLAN_DETAILS;




---
---   FULL SCHEMA :- https://livesql.oracle.com/apex/livesql/s/n2g0bxt0nbp35951htjf9o1jh
---