--Exercício 4 - Pizzaria no SQL Server (continuação da Aula 04).
--Usando o modelo lógico da Pizzaria do exercício 6 da Aula 04 e os tipos da tabela abaixo, crie o banco Pizzaria
--com todas as tabelas (CLIENTE, TELEFONE_CLIENTE, ENTREGADOR, PIZZA, PEDIDO e ITEM_PEDIDO),
--com todas as PKs, FKs e pelo menos um UNIQUE, um CHECK e um DEFAULT. Salve o script como Pizzaria_DDL.sql: ele recebe dados na Aula 07.

CREATE DATABASE PIZZARIA;
GO

USE PIZZARIA;
GO


CREATE TABLE CLIENTE(
    cpf char(11) primary key,
    nome varchar(100) not null,
    rua varchar(50) not null,
    numero varchar(10) not null,
    bairro varchar(60) not null,

    CONSTRAINT UQ_CLIENTE_CPF UNIQUE (cpf)
);
GO


CREATE TABLE ENTREGADOR(
    matricula int primary key,
    nome varchar(100) not null,
    placa_moto char(7) not null,
    CONSTRAINT UQ_ENTREGADOR_placa UNIQUE (placa_moto)
);
GO


CREATE TABLE PIZZA(
   codigo int primary key,
   sabor varchar(50) not null,
   preco decimal(6,2) not null,

   CONSTRAINT ck_pizza_preco CHECK (preco > 0)
);
GO


CREATE TABLE PEDIDO(
   numero int primary key,
   data_pedido date DEFAULT GETDATE() not null,
   hora time not null,
   cpf_cliente char(11) not null,
   matricula_entregador int not null,

   CONSTRAINT fk_PEDIDO_CLIENTE FOREIGN KEY (cpf_cliente) REFERENCES CLIENTE (cpf),
   CONSTRAINT fk_PEDIDO_ENTREGADOR FOREIGN KEY (matricula_entregador) REFERENCES ENTREGADOR (matricula),
);
GO


CREATE TABLE ITEM_PEDIDO(
   quantidade tinyint primary key,
   numero_pedido int not null,
   codigo_pizza int not null,

   CONSTRAINT fk_ITEM_PEDIDO_PEDIDO FOREIGN KEY (numero_pedido) REFERENCES PEDIDO (numero),
   CONSTRAINT fk_ITEM_PEDIDO_PIZZA FOREIGN KEY (codigo_pizza) REFERENCES PIZZA (codigo)
);
GO


CREATE TABLE TELEFONE_CLIENTE(
   telefone varchar(15) primary key,
   cpf_cliente char(11) not null,

   CONSTRAINT fk_TELEFONE_CLIENTE_CLIENTE FOREIGN KEY (cpf_cliente) REFERENCES CLIENTE (cpf)
);
GO

------------------------------------------------------------------------------------------------------

-- Exercício 4 — Pizzaria com dados (continuação da Aula 06). No banco Pizzaria, escreva o script **Pizzaria_DML.sql** com:

USE PIZZARIA;
GO

--1. Pelo menos 5 clientes (um deles com CPF começando com 0), 2 telefones para pelo menos 2 clientes, 3 entregadores e 6 pizzas.

INSERT INTO CLIENTE (cpf, nome, rua, numero, bairro) VALUES (02512458977,'Maria', 'Pitangueiras', '25', 'Saúde'),
                                                            (25879641236,'João', 'Acarajé', '100', 'Ipiranga'),
                                                            (58714789633,'José', 'Chacara Inglesa', '147', 'Vila Mariana'),
                                                            (25896314788,'Lula', 'Congresso', '13', 'Palacio'),
                                                            (14587452369,'Francisco', 'Kilimanjaro', '50', 'Morumbi')

INSERT INTO TELEFONE_CLIENTE (telefone, cpf_cliente) VALUES (11945852233, 02512458977),
                                                            (11958749633, 02512458977),
                                                            (11952418745, 25879641236),
                                                            (11989745214, 25879641236)

INSERT INTO ENTREGADOR (matricula, nome, placa_moto) VALUES (147852, 'Murillo', 'JHU1254'),
                                                            (258749, 'Jesse', 'KJH7415'),
                                                            (364125, 'Fabio', 'GTR5897')

INSERT INTO PIZZA (codigo, sabor, preco) VALUES (001, 'Marguerita', 40.50),
                                                (002, '4 Queijos', 50.50),
                                                (003, 'Calabresa', 35.50),
                                                (004, 'Mussarela', 32.50),
                                                (005, 'Lombinho', 42.50),
                                                (006, 'Frango Cremoso', 45.50)

--2. Pelo menos 8 pedidos em datas diferentes, com 1 a 3 itens cada. Deixe pelo menos **um cliente sem pedido** e **uma pizza que nunca foi pedida** (vamos usar isso na Aula 09).

INSERT INTO PEDIDO (numero, data_pedido, hora, cpf_cliente, matricula_entregador) VALUES (0001, '2026-10-25', '22:30:00', 02512458977, 147852),
                                                                                  (0002, '2026-09-12', '21:00:00', 25879641236, 364125),
                                                                                  (0003, '2026-10-10', '20:15:00', 25879641236, 147852),
                                                                                  (0004, '2026-09-15', '22:00:00', 58714789633, 364125),
                                                                                  (0005, '2026-10-09', '19:30:00', 58714789633, 147852),
                                                                                  (0006, '2026-08-20', '20:45:00', 25896314788, 258749),
                                                                                  (0007, '2026-06-13', '22:20:00', 25896314788, 147852),
                                                                                  (0008, '2026-05-18', '21:50:00', 02512458977, 258749)

INSERT INTO ITEM_PEDIDO (quantidade, numero_pedido, codigo_pizza) VALUES (1, 0001, 001),
                                                                         (2, 0002, 003),
                                                                         (3, 0003, 005),
                                                                         (4, 0004, 002),
                                                                         (5, 0005, 001),
                                                                         (6, 0006, 002),
                                                                         (7, 0007, 002),
                                                                         (8, 0008, 003)

--3. Um UPDATE que aumenta em 10% o preço de todas as pizzas.

UPDATE PIZZA SET preco = preco * 1.10;

--4. Um DELETE que cancela um pedido inteiro (itens e pedido).

DELETE FROM ITEM_PEDIDO WHERE quantidade = 1;

DELETE FROM PEDIDO WHERE numero = 0001;



SELECT * FROM CLIENTE
SELECT * FROM ENTREGADOR
SELECT * FROM PEDIDO
SELECT * FROM ITEM_PEDIDO
SELECT * FROM PIZZA


/**Exercício 1 — Pizzaria (continuação da Aula 07).** No banco Pizzaria:

1. Todas as pizzas da mais cara para a mais barata.
2. As 3 pizzas mais baratas.
3. Pizzas com preço entre R $50 e R$ 60.
4. Clientes que moram no Centro ou no Jardim.
5. Pedidos feitos em outubro de 2026.
6. Quantos pedidos cada cliente fez (cpf e quantidade), do maior para o menor.
7. Quantas pizzas (soma das quantidades) foram vendidas de cada código de pizza.
8. Entregadores (matrícula) que fizeram mais de 2 entregas.
9. Preço médio, menor e maior preço das pizzas.
10. Quantos pedidos houve em cada dia, só dos dias com mais de 1 pedido.*/


1.
SELECT * from pizza order by preco desc
2.
select top 3 * from PIZZA order by preco 
3.
select * from PIZZA where preco between 50 and 60 
4.
select * from cliente where bairro = 'centro' or bairro = 'Jardim'
5.
select * from PEDIDO where data_pedido  <= '2026-10-01' and data_pedido <='2026-10-31'
6.
select cpf_cliente , count (*) as total_vendido from PEDIDO group by cpf_cliente order by total_vendido desc
7.
select COUNT(numero) as quantidade_de_vendas from PEDIDO group by cpf_cliente order by quantidade_de_vendas desc
8.
select matricula_entregador , count (*) as quantidade_entregas from PEDIDO group by matricula_entregador having count (*) >2
9.
select cast (avg (preco) as decimal (10,2)) as preco_medio, min (preco) as minimo_preco ,max (preco) as preco_maximo from PIZZA
10.
select data_pedido, count (*) as pedidos_do_dia from pedido group by data_pedido having count (data_pedido) >=1 




