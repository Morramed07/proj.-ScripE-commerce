-- criação do banco de dados para o cenário e-commerce
-- drop database ecommerce;
create database ecommerce;
use ecommerce;
-- criar tabela cliente 


create table clients(
idClient int auto_increment primary key,
Fname varchar(10),
Minit char(3),
LName varchar(20),
CPF_ou_CNPJ char (15) not null, 
constraint unique_cpf_client unique(CPF_ou_CNPJ),
rua varchar(20),
bairro varchar (20),
número int,
complemento varchar(20),
cidade varchar(20),
estado varchar(20),
CEP char(10)
);

-- criar tabela produto

#size = dimensão do produto
create table product(
idProduct int auto_increment primary key,
Classification_kids bool default false,
category enum ('Eletronico', 'Vestuário', 'Brinquedo', 'Alimentos', 'Pet', 'naturais', 'Moveis') not null, 
avaliação  float default 0,
size varchar(10),
product_value float not null
);

-- criar tabela FORMA DE PAGAMENTO

create table PAYMENT( 
idClient int,
idPayment int,
typePayment enum ('Cartão Débito', 'Cartão Crédito', 'Dois Cartões' ),
limitAvaible float,
primary key (idClient, idPayment, typePayment),
constraint fk_Clientpayment foreign key (idClient) references clients (idClient)
);

 -- criar tabela pedido
create table orders(
idOrder int auto_increment primary key,
idOrderClient int,
idOrderPayment int,
orderStatus enum ('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
orderdescription varchar(255),
freight float default 10,
paymentCash bool default false,
paymentStatus enum ('Autorizado' , 'Não autorizado'),
orTypePayment enum ('Cartão Débito', 'Cartão Crédito', 'Dois Cartões' ),
constraint fk_orders_client_payment foreign key (idOrderClient, idOrderPayment, orTypePayment) references PAYMENT (idClient,idPayment, typePayment )
);



-- Criar tabela estoque

create table productStorage(
idprodStorage int auto_increment primary key,
Location varchar(45) not null,
Quantity int default 0 not null
);


-- criar tabela Fornecedor

create table supplier(
idSupplier int auto_increment primary key,
SocialName varchar(255) not null,
CNPJ char(15) not null, 
constraint unique_supplier unique (CNPJ), 
contact char(11) default 0
);


-- criar tabela vendedor 
create table Seller(
idSeller int auto_increment primary key,
SocialName varchar(255) not null,
FantasyName varchar(255),
CNPJ char(15), 
CPF char(11),
constraint unique_CNPJ_supplier unique (CNPJ), 
constraint unique_CPF_supplier unique (CPF),
contact char(11) not null default 0,
location varchar (255)
);


-- criar tabela entrega

create table Delivery( 
idDelivery int auto_increment primary key,
IdOrdersDelivery int,
DeliveryCode varchar (10) not null,
constraint unique_DeliveryCode unique(DeliveryCode),
statusDelivery enum ('Se encontra em uma filial', 'Em transporte', 'Saiu para entrega') default 'Em transporte',
constraint fk_ordersDelivery foreign key (IdOrdersDelivery) references orders (idOrderClient)
);


-- criar tabela produtos vendedor

create table productSeller( 
idPSeller int,
idPProduct int,
ProdQuantity int default 1,
primary key (idPSeller, idPProduct),
constraint fk_product_seller foreign key (idPseller) references  Seller(idSeller),
constraint fk_product_product foreign key (idPProduct) references product(idProduct)
);
desc productSeller;


-- criar tabela produto pedido

create table productOrder( 
idPOproduct int,
idPOorder int,
POQuantity int default 1,
POstatus enum ('Disponível', 'Sem estoque') default 'Disponível' ,
primary key (idPOproduct, idPOorder),
constraint fk_POproduct foreign key (idPOproduct) references product (idProduct),
constraint fk_POorder foreign key (idPOorder) references orders(idOrder)

);

-- criar tabela produto em estoque

create table storageLocation( 
idLproduct int,
idLstorage int,
Location varchar (255) not null,
primary key (idLproduct, idLstorage),
constraint fk_location_product foreign key (idLproduct) references product (idProduct),
constraint fk_Location_storage foreign key (idLstorage) references productStorage(idprodStorage)
);


-- criar tabela produto pedido

create table supplierproduct( 
idSPproduct int,
idSPsuplier int,
sale_value float not null,
primary key (idSPproduct , idSPsuplier),
constraint fk_spproduct foreign key (idSPproduct) references product (idProduct),
constraint fk_spsuplier foreign key (idSPsuplier) references supplier(idSupplier)
);


show tables;  