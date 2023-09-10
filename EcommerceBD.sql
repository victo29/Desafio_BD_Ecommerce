create database ecommerce;
use ecommerce;
create table clients(
	idClient INT auto_increment primary key,
    Fname VARCHAR(15),
    Minit CHAR(3),
    Lname VARCHAR(20),
    CPF CHAR (11)  not null,
    constraint unique_cpf_client unique(CPF),
    Address varchar(45),
    Date_of_birth date
    
);
alter table clients auto_increment =1;

create table address_client(
	Address_idClient int not null,
	Address varchar(45),
	constraint fk_idClient_Address foreign key(Address_idClient) references clients(idClient) 
    on delete cascade
);

create table product(
	idProduct int auto_increment primary key,
	Pname varchar(10) not null,
	Category enum('Eletronico','Vestimenta','Brinquedo','Alimentos') not null,
	Description_p varchar(45),
	Value_p float not null
);
alter table product auto_increment =1;

create table orders(
	idOrder int auto_increment primary key,
	Order_idClient int not null,
	OrderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
	OrderDescription varchar(45),
	sendValue float,
	constraint fk_idClient_Order foreign key (Order_idClient) references clients(idClient)
);
alter table orders auto_increment =1;

create table payments(
	Pay_idClient int not null,
	Pay_idOrder int not null, 
	Payment enum('Pix', 'Money', 'Debit', 'Credit') not null,
	constraint pk_payments primary key (Pay_idClient,Pay_idOrder),
	constraint fk_payments_order foreign key (Pay_idOrder) references orders(idOrder),
	constraint fk_payments_client foreign key (Pay_idClient) references orders(Order_idClient)
);

create table order_product(
	Order_idOrder int not null,
	Product_idProduct int not null,
	Amount int not null,
	Product_status ENUM('disponível', 'sem estoque'),
	constraint fk_order_idProduct foreign key (Product_idProduct) references product(idProduct),
    constraint fk_order_idOrder foreign key (Order_idOrder) references product(idProduct)
    
);

create table storages(
	idStorage int not null primary key,
	location varchar (45) not null
);

create table storage_product(
	idStorage int not null,
    idProduct int not null,
    Amount int not null,
    constraint pk_storage_product primary key(idStorage,idProduct),
    constraint fk_idStorage_storage foreign key(idStorage) references storages(idStorage),
    constraint fk_idProduct_storage foreign key(idProduct) references product(idProduct)
);

create table supplier(
	idSupplier int auto_increment primary key,
	CNPj char(14) not null,
    constraint unique_CNPJ_supplier unique (CNPJ),
	CompanyName varchar(45),
    constraint unique_CompanyName_supplier unique(CompanyName)
);
alter table supplier auto_increment =1;

create table supplier_number(
	Spplier_idSupplier int not null,
    Phone_number varchar(15) not null,
    constraint unique_Phone_number_supplier unique (Phone_number),
    constraint pk_supplier_number primary key(Spplier_idSupplier,Phone_number ),
	constraint fk_idSupplier_number foreign key(Spplier_idSupplier) references supplier(idSupplier)
    on delete cascade
);

create table supplier_product(
	idSupplier int not null,
    idProduct int not null,
    Amount int not null,
    constraint pk_product_suplier primary key(idProduct, idSupplier),
    constraint fk_idSupplier_product_suplier foreign key(idSupplier) references supplier(idSupplier),
    constraint fk_idProduct_product_suplier foreign key(idProduct) references product(idProduct)
    );
    
create table sellers(
	idSeller int auto_increment primary key,
	CompanyName varchar(45),
    CNPJ char(14) not null,
	AbstractName varchar(45),
    Address varchar(45),
    constraint unique_CompanyName_sellers unique(CompanyName),
    constraint unique_CNPJ_sellers unique(CNPJ)
);
alter table sellers auto_increment =1;

create table sellers_product(
	Product_idProduct int not null,
    Seller_idSeller int not null,
    amount int not null,
    constraint pk_sellers_product primary key(Product_idProduct,Seller_idSeller),
    constraint fk_idProduct_sellers_product foreign key(Product_idProduct) references product(idProduct),
    constraint fk_idSeller_sellers_product  foreign key(Seller_idSeller) references sellers(idSeller)
);





