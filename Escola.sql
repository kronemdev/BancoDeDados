
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

