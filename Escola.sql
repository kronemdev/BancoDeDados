
-- novo banco de dados.
CREATE DATABASE Escola;

USE Escola;

---Tabela 'pai'
CREATE TABLE ALUNO (
   matricula int primary key,
   nome varchar(50) not null,
   data_nascimento date not null,
   email varchar(100) not null,

   --CONSTRAINT (restricao)
   --nao aceitamos emails duplicados.
   --UQ_Aluno_Email nome da restricao
   --UNIQUE - unico
   --(email) coluna que recebe a restricao.
   CONSTRAINT UQ_Aluno_Email UNIQUE (email)

);

-- drop table professor

CREATE TABLE PROFESSOR(
    registro_professor int primary key,
    nome varchar(50) not null,
    email varchar(100) not null unique
);

CREATE TABLE CURSO (
    codigo_curso int primary key,    
    nome varchar(50) not null unique,
    carga_horaria smallint not null,
    registro_professor int not null,

    --aceita o registro apenas de a carga horaria for maior que 0
    CONSTRAINT ck_curso_carga CHECK ( carga_horaria > 0 ),

    CONSTRAINT fk_curso_professor 
                               FOREIGN KEY (registro_professor)
    REFERENCES PROFESSOR (registro_professor)
)

-- DROP TABLE MATRICULA

CREATE TABLE MATRICULA(

      matricula_aluno int not null primary key,
      codigo_curso int not null,

      --DEFAULT restricao padrao
      --GETDATE() busca horario atual do servidor
      data_matricula datetime  DEFAULT GETDATE(),

      CONSTRAINT fk_matricula_codigo_curso FOREIGN KEY (codigo_curso) 
      REFERENCES CURSO (codigo_curso)

)

CREATE TABLE ESPECIALIDADE_PROFESSOR(

     registro_professor int not null,
     especialidade varchar(50) not null,

     --duas colunas se tornam uma PK
     CONSTRAINT pk_especialidade_professor
     PRIMARY KEY ( registro_professor,especialidade),


     CONSTRAINT fk_especialidade_professor 
     FOREIGN KEY (registro_professor)
     REFERENCES PROFESSOR(registro_professor)

)

---------------------------------------------------------------------------------------

-- Exercicios - Lista 6

Use Escola;
GO

--Exercício 1 — Vai dar erro? No banco Escola, diga se cada comando funciona. Se der erro, diga qual regra barrou:

1. INSERT INTO ALUNO (matricula, nome, data_nascimento) VALUES (2026006, 'Felipe Costa', '2003-05-05');
-- *Nao funcionou. Email nao pode ser NULL
2. INSERT INTO ALUNO (matricula, nome, data_nascimento, email) VALUES (2026007, 'Gabi', '2002-02-02', 'ana@email.com');
-- *Funcionou
3. INSERT INTO MATRICULA (matricula_aluno, codigo_curso) VALUES (2026001, 1);
-- * Nao funcionou, conflito com a constraint FK_matricula_codigo_curso.
4. INSERT INTO CURSO (codigo_curso, nome, carga_horaria, registro_professor) VALUES (5, 'Java', 40, 104);
-- *Nao funcionou, conflito com a constraint FK_curso_aluno
5. DELETE FROM PROFESSOR WHERE registro_professor = 102; 
-- * Funcionou
6. INSERT INTO ALUNO (matricula, data_nascimento) VALUES (2026008, '2001-01-01');
-- * Nao funcionou, pois nao permite que a coluna nome seja NULL.

SELECT * FROM ALUNO
SELECT * FROM PROFESSOR
SELECT * FROM CURSO
SELECT * FROM ESPECIALIDADE_PROFESSOR
SELECT * FROM MATRICULA

-- Exercício 2 — Escreva o UPDATE no banco Escola:

--1. O professor 1030 passou a ter o e-mail paula@escola.com.

UPDATE PROFESSOR SET email = 'paula@escola.com' WHERE registro_professor = 1030

--2. Todos os cursos com menos de 40 horas ganharam mais 10 horas.

UPDATE CURSO SET carga_horaria = carga_horaria + 10 WHERE carga_horaria < 40;

--3. O curso Redes de Computadores passou para o professor 1040

UPDATE ESPECIALIDADE_PROFESSOR SET especialidade = 'Rede de Computadores' WHERE registro_professor = 1040;



-- Exercício 3 — Escreva o DELETE no banco Escola:

--1. Apague a matrícula da aluna 2026005 no curso 2.

DELETE FROM MATRICULA WHERE matricula_aluno = 2026005 AND codigo_curso = 2;

--2. Apague o aluno 2026002 (pense na ordem!).

DELETE FROM ALUNO WHERE matricula = 2026002;

--3. Confira com SELECT.

SELECT * FROM ALUNO
SELECT * FROM MATRICULA
SELECT * FROM CURSO



INSERT INTO ALUNO (matricula, nome, data_nascimento, email)
VALUES    (2026005, 'Aline', '2000-12-15','aline@escola.com')

INSERT INTO ALUNO (matricula, nome, data_nascimento, email)
VALUES    (2026002, 'Joao', '2002-03-06','joao@escola.com')

INSERT INTO CURSO (codigo_curso, nome, carga_horaria, registro_professor)
VALUES    (2, 'C#', 160, 1050)

INSERT INTO CURSO (codigo_curso, nome, carga_horaria, registro_professor)
VALUES    (5, 'SQL', 80, 1030)

INSERT INTO MATRICULA (matricula_aluno, codigo_curso, data_matricula)
VALUES    (2026005, 2,'2005-12-20')

INSERT INTO MATRICULA (matricula_aluno, codigo_curso, data_matricula)
VALUES    (2026002, 2,'2005-11-05')

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

INSERT INTO PEDIDO (numero, data, hora, cpf_cliente, matricula_entregador) VALUES (0001, '2026-10-25', '22:30:00', 02512458977, 147852),
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