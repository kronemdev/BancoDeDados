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