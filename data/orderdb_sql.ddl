DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Masks');
INSERT INTO category(categoryName) VALUES ('Hand Sanitizers');
INSERT INTO category(categoryName) VALUES ('Hand Soaps');
INSERT INTO category(categoryName) VALUES ('Disinfectant Spray');
INSERT INTO category(categoryName) VALUES ('Disinfectant Wipes');
INSERT INTO category(categoryName) VALUES ('Bleach');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Cloth Mask', 1, '3 Cloth Masks',10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Mask Filter', 1, 'Pack of 20',12.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Surgical Mask',1,'Pack of 30',20.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('N95 Mask',1,'Pack of 5',20.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Face Shield',1,'Pack of 5',16.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Liquid Hand Sanitizer',2,'4oz',6.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Liquid Scented Hand Sanitizer',2,'4oz',6.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gel Hand Sanitizer',2,'4oz',6.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gel Scented Hand Sanitizer',2,'4oz.',7.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Liquid Hand Soap',3,'500ml',6.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Liquid Scented Hand Soap',3,'500ml',6.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Foaming Hand Soap',3,'500ml',7.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Foaming Hand Soap',3,'500ml',7.50;
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Liquid Hand Soap Refill',3,'900ml',5.00;
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Liquid Scented Hand Soap Refill',3,'900ml',5.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Foaming Hand Soap Refill',3,'900ml',6.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Foaming Hand Soap Refill',3,'900ml',6.50;
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Disinfectant Spray-Original',4,'950ml',8.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Disinfectant Spray-Lemon',4,'950ml',8.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Disinfectant Spray-Lime',4,'950ml',8.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Disinfectant Spray-Linen Scent',4,'950ml.',8.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Disinfectant Wipes-Original',5,'100 wipes',8.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Disinfectant Wipes-Lemon',5,'100 wipes',8.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Disinfectant Wipes-Lime',5,'100 wipes',8.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Disinfectant Wipes-Linen Scent',5,'100 wipes',8.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Bleach-Original',6,'1.89L',10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Bleach-Lemon',6,'1.89L',10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Bleach-Lime',6,'1.89L.',10.00);

INSERT INTO warehouse(warehouseId, warehouseName) VALUES (1, 'Main warehouse');
INSERT INTO warehouse(warehouseId, warehouseName) VALUES (2,'Second warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (11, 1, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (12, 1, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (13, 1, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (14, 1, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (15, 1, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (16, 1, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (17, 1, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (18, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (19, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (20, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (21, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (22, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (23, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (24, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (25, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (26, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (27, 2, 3, 31);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (28, 2, 3, 31);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Kristine', 'Kim', 'ykim@gmail.com', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'kristine' , 'password');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;
