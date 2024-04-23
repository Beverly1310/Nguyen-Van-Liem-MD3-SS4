create schema bt5_ss4;
use bt5_ss4;
create table account
(
    accid      int auto_increment,
    username   varchar(30) not null,
    password   varchar(30) not null,
    permission bit         not null,
    accstatus  bit         not null,
    constraint account_pk
        primary key (accid)
);
create table bill
(
    billid   int auto_increment,
    billcode varchar(10) not null,
    billtype bit         not null,
    accid    int         not null,
    created  date        not null,
    authdate date        not null,
    constraint bill_pk
        primary key (billid),
    constraint bill_account_accid_fk
        foreign key (accid) references account (accid)
);
create table product
(
    productid     int auto_increment,
    productname   varchar(150) not null,
    manufacturer  varchar(200) not null,
    created       date         null,
    batch         tinyint      null,
    quantity      int          null,
    productstatus int          null,
    constraint product_pk
        primary key (productid)
);
create table billdetail
(
    billdetailid int auto_increment primary key ,
    billid       int   null,
    productid    int   null,
    quantity     int   null,
    price        float null,
    constraint billdetail_bill_billid_fk
        foreign key (billid) references bill (billid),
    constraint billdetail_product_productid_fk
        foreign key (productid) references product (productid)
);
INSERT INTO account (username, password, permission, accstatus) VALUES
                                                                    ('user1', 'password1', 1, 1),
                                                                    ('user2', 'password2', 0, 1),
                                                                    ('user3', 'password3', 1, 0),
                                                                    ('user4', 'password4', 0, 1),
                                                                    ('user5', 'password5', 1, 1);
INSERT INTO bill (billcode, billtype, accid, created, authdate) VALUES
                                                                    ('B1001', 1, 1, '2024-04-23', '2024-04-23'),
                                                                    ('B1002', 0, 2, '2024-04-23', '2024-04-23'),
                                                                    ('B1003', 1, 3, '2024-04-23', '2024-04-23'),
                                                                    ('B1004', 1, 4, '2024-04-23', '2024-04-23'),
                                                                    ('B1005', 0, 5, '2024-04-23', '2024-04-23');
INSERT INTO product (productname, manufacturer, created, batch, quantity, productstatus) VALUES
                                                                                             ('Product 1', 'Manufacturer 1', '2024-04-23', 1, 100, 1),
                                                                                             ('Product 2', 'Manufacturer 2', '2024-04-23', 2, 200, 0),
                                                                                             ('Product 3', 'Manufacturer 3', '2024-04-23', 3, 150, 1),
                                                                                             ('Product 4', 'Manufacturer 4', '2024-04-23', 4, 120, 1),
                                                                                             ('Product 5', 'Manufacturer 5', '2024-04-23', 5, 180, 0);
INSERT INTO billdetail (billid, productid, quantity, price) VALUES
                                                                (1, 1, 5, 10.5),
                                                                (2, 2, 10, 20.5),
                                                                (3, 3, 8, 15.75),
                                                                (4, 4, 6, 12.25),
                                                                (5, 5, 7, 18.0);
select account.username from account left join bill b on account.accid = b.accid where b.accid is null ;
-- 2
select * from bill join billdetail b on bill.billid = b.billid where quantity>=10;
-- 3
select product.productid,productname from product left join billdetail b on product.productid = b.productid where b.productid is null ;
-- 4
select product.productid,productname from product join
    (select b.productid from bill join billdetail b on bill.billid = b.billid where quantity<10 and billtype = 1) as bangnhap on product.productid = bangnhap.productid;
-- 5
select * from bill join billdetail b on bill.billid = b.billid where date(created) = 23 and month(created)= 4 and year(created) = 2024 and billtype = 1