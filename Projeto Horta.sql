CREATE DATABASE HortaDaFelicidade;
USE HortaDaFelicidade;


-- ----------------------------
-- PROJETO HORTA
-- ----------------------------

-- ---------------------
-- TABELA VOLUNTÁRIOS
-- ---------------------

CREATE TABLE Voluntarios (
  id_voluntario    INT PRIMARY KEY AUTO_INCREMENT,
  Nome             VARCHAR(100) NOT NULL,
  Contato          VARCHAR(50),
  Funcao           VARCHAR(100)
);

 -- -------------------
 -- TABELA PLANTA
 -- -------------------

 CREATE TABLE Plantas (
 id_planta    INT PRIMARY KEY AUTO_INCREMENT,
 Nome         VARCHAR (100) NOT NULL,
 Tipo         VARCHAR (50) 
 );

-- ---------------------
-- TABELA CANTEIROS
-- ---------------------

CREATE TABLE Canteiros (
id_canteiro    INT PRIMARY KEY AUTO_INCREMENT,
Localizacao    VARCHAR (100),
Tamanho        DECIMAL (5,2)
);

-- ---------------------
-- TABELA CULTIVOS 
-- ---------------------

CREATE TABLE Cultivos (
id_cultivo               INT PRIMARY KEY AUTO_INCREMENT,
data_plantio             DATE NOT NULL,
quantidade_plantada_kg   DECIMAL (8,2),
id_voluntario            INT,
id_planta                INT,
id_canteiro              INT, 
FOREIGN KEY              (id_voluntario) REFERENCES Voluntarios(id_voluntario),
FOREIGN KEY              (id_planta)     REFERENCES Plantas(id_planta),
FOREIGN KEY              (id_canteiro)   REFERENCES Canteiros(id_canteiro)
);

-- -----------------
-- TABELA COLHEITAS 
-- -----------------

CREATE TABLE Colheitas (
id_colheita               INT PRIMARY KEY AUTO_INCREMENT, 
data_colheita             DATE NOT NULL,
quantidade_colhida_kg     DECIMAL (8,2),
id_canteiro               INT,
id_cultivo                INT,
FOREIGN KEY (id_canteiro) REFERENCES Canteiros(id_canteiro),
FOREIGN KEY (id_cultivo)  REFERENCES Cultivos (id_cultivo)
);

-- --------------------
-- TABELA INSTITUIÇÕES
-- -------------------- 

CREATE TABLE Instituicoes (
id_instituicao   INT PRIMARY KEY AUTO_INCREMENT,
Nome             VARCHAR (100) NOT NULL, 
Endereco         VARCHAR (150)
);

-- -----------------
-- TABELA DOAÇÕES  
-- -----------------

CREATE TABLE Doacoes (
id_doacao                     INT PRIMARY KEY AUTO_INCREMENT,
data_doacao                   DATE NOT NULL, 
quantidade_doada_kg           DECIMAL (8,2),
id_colheita                   INT, 
id_instituicao                INT,
FOREIGN KEY (id_colheita)     REFERENCES Colheitas(id_colheita),
FOREIGN KEY (id_instituicao)  REFERENCES Instituicoes(id_instituicao)
);  

-- -------------------
-- Inserção de dados  
-- -------------------
-- ----------------------
-- DADOS VOLUNTÁRIOS
-- -----------------------

INSERT INTO Voluntarios (id_voluntario, nome, contato, funcao) 
VALUES 
(1, 'Maria Pereira', '81 99970-7171','Agricultora '),
(2, 'Cris Silva', '81 99453-8732', 'Coordenadora de plantio'),
(3, 'Ana Maria', '81 99876-5636', 'Agricultora'), 
(4, 'José Lima', '81 99863-6621', 'Agricultor');

-- -----------------
-- DADOS DA PLANTA
-- -----------------

INSERT INTO Plantas (id_planta, nome, tipo)
VALUES 
(1, 'Solanum lycopersicum', 'Tomate'),
(2, 'Allium cepa', 'Cebola'),
(3, 'Solanum Tuberosum', 'Batata'), 
(4, 'Coriandrum sativum', 'coentro');

-- ------------------
-- DADOS DO CANTEIRO
-- ------------------

INSERT INTO Canteiros (id_canteiro, localizacao, tamanho)
VALUES 
(1, 'Setor Norte - Próximo á entrada principal', 12.50),
(2, 'Setor Sul - Ao lado do reservatório de água', 10.75),
(3, 'Setor Leste - Próximo do galpão de ferramentas', 13.60);  

-- ------------------
-- DADOS DO CULTIVOS
-- ------------------

INSERT INTO Cultivos (data_plantio, quantidade_plantada_kg, id_voluntario, id_planta, id_canteiro)
VALUES 
('2025-08-18', 6.50, 1, 1, 1),
('2025-08-18', 5.50, 3, 3, 2),
('2025-08-18', 7.00, 4, 4, 3),
('2025-08-20', 4.50, 1, 2, 1); 
-- -------------------
-- DADOS DA COLHEITAS 
-- -------------------

INSERT INTO Colheitas (data_colheita, quantidade_colhida_kg, id_canteiro)
VALUES 
('2025-10-18', 6.50, 1),
('2025-10-18', 7.00, 3),
('2025-10-20', 4.50, 1);

-- ----------------------
-- DADOS DA INSTITUICÕES
-- ----------------------

INSERT INTO Instituicoes (nome, endereco)
VALUES
('Lar Esperança', 'Rua das Flores, 120 - Camaragibe'),
('Casa do Bem', 'Av. Principal, 505 - Recife'),
('Centro Comunitário São José', 'Rua Verde, 89 - Camaragibe');

-- --------------------
-- DADOS DAS DOAÇÕES 
-- --------------------

INSERT INTO Doacoes (data_doacao, quantidade_doada_kg, id_colheita, id_instituicao)
VALUES

('2025-10-20', 3.50, 1, 1),
('2025-10-22', 2.50, 1, 2),
('2025-10-25', 3.50, 3, 3);

-- --------------
-- Consultas SQL
-- --------------
-- -------------------------------------------------------
-- Mostrar todos os voluntários e suas respectivas funções (1)
-- --------------------------------------------------------
SELECT * FROM HortaDaFelicidade.Voluntarios;
SELECT Nome AS Voluntario, Funcao
FROM Voluntarios;

-- ------------------------------------------------------------------------------------------
-- Mostrar as plantas cultivadas em cada canteiro, com o nome do canteiro e a data do plantio. (2) 
-- ------------------------------------------------------------------------------------------

SELECT * FROM HortaDaFelicidade.Plantas;
SELECT 
p.Nome AS Planta,
c.Localizacao AS Canteiro,
cu.data_plantio AS DataPlantio
FROM Cultivos cu
JOIN Plantas p ON cu.id_planta = p.id_planta
JOIN Canteiros c ON cu.id_canteiro = c.id_canteiro;

-- ---------------------------------------------------------------
-- Exibir os nomes dos voluntários e as plantas que eles cultivaram. (3)
-- ---------------------------------------------------------------
SELECT * FROM HortaDaFelicidade.Voluntarios;
SELECT 
v.Nome AS Voluntario,
p.Nome AS Planta
FROM Cultivos cu
JOIN Voluntarios v ON cu.id_voluntario = v.id_voluntario
JOIN Plantas p ON cu.id_planta = p.id_planta;

-- --------------------------------------------------------------------------------------
-- Listar todas as colheitas realizadas, mostrando o canteiro e a quantidade colhida (kg). (4)
-- --------------------------------------------------------------------------------------
SELECT * FROM HortaDaFelicidade.Colheitas;
SELECT 
co.id_colheita,
ca.Localizacao AS Canteiro,
co.quantidade_colhida_kg AS QuantidadeColhida
FROM Colheitas co
JOIN Canteiros ca ON co.id_canteiro = ca.id_canteiro;

-- ---------------------------------------------------------------------
-- Mostrar as instituições que receberam doações e as quantidades doadas. (5)
-- ---------------------------------------------------------------------
SELECT * FROM HortaDaFelicidade.Instituicoes;
SELECT 
i.Nome AS Instituicao,
d.quantidade_doada_kg AS QuantidadeDoada
FROM Doacoes d
JOIN Instituicoes i ON d.id_instituicao = i.id_instituicao;

-- -------------------------------------------------------------
-- Listar o total de quilos doados por instituição (use GROUP BY) (6)
-- --------------------------------------------------------------
SELECT * FROM HortaDaFelicidade.Doacoes;
SELECT 
i.Nome AS Instituicao,
SUM(d.quantidade_doada_kg) AS TotalDoado
FROM Doacoes d
JOIN Instituicoes i ON d.id_instituicao = i.id_instituicao
GROUP BY i.Nome;

-- ---------------------------------------------------------------------------
-- Mostrar os canteiros que ainda não foram colhidos (subconsulta ou LEFT JOIN) (7)
-- ---------------------------------------------------------------------------
SELECT * FROM HortaDaFelicidade.Canteiros;
SELECT 
c.Localizacao AS Canteiro
FROM Canteiros c
LEFT JOIN Colheitas co ON c.id_canteiro = co.id_canteiro
WHERE co.id_canteiro IS NULL;

-- --------------------------------------------------------------------------------
-- Exiba o voluntário que realizou o maior número de cultivos (use COUNT e ORDER BY (8)
-- ---------------------------------------------------------------------------------
SELECT * FROM HortaDaFelicidade.Voluntarios;
SELECT 
v.Nome AS Voluntario,
COUNT(cu.id_cultivo) AS QuantidadeCultivos
FROM Cultivos cu
JOIN Voluntarios v ON cu.id_voluntario = v.id_voluntario
GROUP BY v.Nome
ORDER BY QuantidadeCultivos DESC
LIMIT 1;

-- --------------------------------------------------------------------------
-- Mostrar as plantas que ainda não foram colhidas (subconsulta ou LEFT JOIN). (9)
-- --------------------------------------------------------------------------
SELECT * FROM HortaDaFelicidade.Plantas;
SELECT 
p.Nome AS Planta
FROM Cultivos cu
LEFT JOIN Colheitas co ON cu.id_cultivo = co.id_cultivo
JOIN Plantas p ON cu.id_planta = p.id_planta
WHERE co.id_cultivo IS NULL;

-- -----------------------------------------------------------------------------------------------------------
-- Listar todas as doações realizadas em setembro/outobro de 2025, com o nome da instituição e a data da doação. (10)
-- -----------------------------------------------------------------------------------------------------------
SELECT * FROM HortaDaFelicidade.Doacoes;
SELECT 
i.Nome AS Instituicao,
d.data_doacao AS DataDoacao,
d.quantidade_doada_kg AS QuantidadeDoada
FROM Doacoes d
JOIN Instituicoes i ON d.id_instituicao = i.id_instituicao
WHERE d.data_doacao BETWEEN '2025-10-01' AND '2025-10-30';
