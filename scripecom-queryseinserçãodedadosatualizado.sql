-- INSERÇÃO DE DADOS E QUERIES
USE ecommerce;
show tables;

-- Inserir valores na tabela Clientes
INSERT INTO clients (Fname, Minit, LName, CPF_ou_CNPJ, rua, bairro, número, complemento, cidade, estado, CEP)
VALUES
('João', 'A', 'Silva', '12345678901', 'Rua 1', 'Centro', 123, 'Apto 101', 'São Paulo', 'SP', '01001000'),
('Maria', 'B', 'Oliveira', '98765432100', 'Rua 2', 'Bairro 1', 456, NULL, 'Rio de Janeiro', 'RJ', '20020030'),
('Carlos', 'C', 'Almeida', '11223344556', 'Av. Brasil', 'Jardins', 789, 'Bloco 2', 'Belo Horizonte', 'MG', '30120000'),
('Ana', 'D', 'Costa', '66778899000', 'Rua Sol', 'Vila Nova', 321, 'Cobertura', 'Curitiba', 'PR', '80010000');

-- Inserir valores na tabela Product
INSERT INTO product (Classification_kids, category, avaliação, size, product_value)
VALUES
(TRUE, 'Brinquedo', 4.5, 'M', 50.00),
(FALSE, 'Eletrônico', 4.8, 'L', 1200.00),
(TRUE, 'Pet', 4.2, 'G', 80.00),
(FALSE, 'Móveis', default, 'P', 350.00);

-- Inserir valores na tabela PAYMENT
INSERT INTO PAYMENT (idClient, idPayment, typePayment, limitAvaible)
VALUES
(1, 101, 'Cartão Débito', 500.00),
(2, 102, 'Cartão Crédito', NULL),
(3, 103, 'Dois Cartões', 200.00),
(4, 104, 'Cartão Débito', 800.00);

-- Inserir valores na tabela ORDERS
INSERT INTO orders (idOrderClient, idOrderPayment, orderStatus, orderdescription, freight, paymentCash, paymentStatus, orTypePayment)
VALUES
(1, 101, 'Confirmado', 'Pedido Eletrônicos', 20.00, FALSE, 'Autorizado', 'Cartão Débito'),
(2, 102, 'Em processamento', 'Pedido Roupas', 15.00, TRUE, 'Autorizado', 'Cartão Crédito'),
(3, 103, 'Cancelado', 'Pedido Brinquedos', 10.00, FALSE, 'Não autorizado', 'Dois Cartões'),
(4, 104, 'Em processamento', 'Pedido Móveis', 12.00, TRUE, 'Autorizado', 'Cartão Débito');

-- Inserir valores na tabela productStorage
INSERT INTO productStorage (Location, Quantity)
VALUES
('Filial A', 100),
('Filial B', 50),
('Filial C', 200),
('Filial D', 30);

-- Inserir valores na tabela supplier
INSERT INTO supplier (SocialName, CNPJ, contact)
VALUES
('Fornecedor A', '12345678000100', '12345678901'),
('Fornecedor B', '98765432000199', '11223344556'),
('Fornecedor C', '11223344000188', '22334455667'),
('Fornecedor D', '55667788000166', '33445566778');

-- Inserir valores na tabela Seller
INSERT INTO Seller (SocialName, FantasyName, CNPJ, CPF, contact, location)
VALUES
('Vendedor A', 'Vendas A', '12345678000100', '12345678901', '12345678901', 'São Paulo'),
('Vendedor B', 'Vendas B', '98765432000199', '98765432101', '98765432101', 'Rio de Janeiro'),
('Vendedor C', 'Vendas C', NULL, '11223344556', '11223344556', 'Belo Horizonte'),
('Vendedor D', 'Vendas D', '55667788000166', NULL, '33445566778', 'Curitiba');

-- Inserir valores na tabela Delivery
INSERT INTO Delivery (IdOrdersDelivery, DeliveryCode, statusDelivery)
VALUES
(1, 'D001', 'Se encontra em uma filial'),
(2, 'D002', 'Em transporte'),
(3, 'D003', 'Saiu para entrega'),
(4, 'D004', 'Em transporte');

-- Inserir valores na tabela productSeller
INSERT INTO productSeller (idPSeller, idPProduct, ProdQuantity)
VALUES
(1, 1, 20),
(2, 2, 30),
(3, 3, 15),
(4, 4, 50);

-- Inserir valores na tabela productOrder
INSERT INTO productOrder (idPOproduct, idPOorder, POQuantity, POstatus)
VALUES
(1, 1, 2, 'Disponível'),
(2, 2, 1, 'Disponível'),
(3, 3, 3, 'Sem estoque'),
(4, 4, 5, 'Disponível');

-- Inserir valores na tabela storageLocation
INSERT INTO storageLocation (idLproduct, idLstorage, Location)
VALUES
(1, 1, 'Filial A'),
(2, 2, 'Filial B'),
(3, 3, 'Filial C'),
(4, 4, 'Filial D');

-- Inserir valores na tabela supplierproduct
INSERT INTO supplierproduct (idSPproduct, idSPsuplier, sale_value)
VALUES
(1, 1, 50.00),
(2, 2, 1200.00),
(3, 3, 80.00),
(4, 4, 350.00);


-- PERGUNTAS RESPONDIDAS COM QUERIES 

-- 1) Lista dos id e dos valores dos produtos da tabela product possuem uma avaliação superior a 4

select * from product;

select idProduct , product_value
from product
where avaliação > 4;

-- 2) Mostre todas as informações de todos os vendedores que possuem um CPF registrado na tabela Seller.

select * from seller;

select *
from seller
where CPF is not null;

-- ordenando os resultados pelo atributo idSELLER
select *
from seller
where CPF is not null
order by idSeller;

-- 3)Encontre todos os fornecedores que fornecem um produto com valor de venda superior a 100 e mostre o nome do fornecedor e o valor de venda.
select * from supplierproduct;

select * from supplier;

select s.SocialName, sp.sale_value
from supplierproduct sp inner join supplier s
ON sp.idSPsuplier = s.idSupplier
where sp.sale_value >100;

-- 4) Exiba os produtos que têm uma quantidade de estoque menor que 50 e o nome do local de armazenamento.

select * from storageLocation;

select * from productStorage;

select Location, Quantity
from productStorage
where Quantity <50 ;

-- me mostre os status da entrega junto ao id do PEDIDO e AS forma de pagamento que não usaram dinheiro

select * from Delivery;
select * from orders;

select d. statusDelivery, o. idOrder, o. orTypePayment
from Delivery d join orders o
on d. idOrdersDelivery = o. idOrder
where o. paymentCash = 0
group by d. statusDelivery, o. idOrder, o. orTypePayment;

-- me diga qual os status dos pedidos e quanto pedidos existem para cada status

select orderStatus, count(*) AS total_orders
from orders 
group by orderStatus
having orderStatus in ( 'Confirmado' , 'Em processamento' );


