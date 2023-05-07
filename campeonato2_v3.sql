CREATE DATABASE Campeonato_2_v3
GO

USE Campeonato_2_v3
GO

CREATE TABLE Times (
CodigoTime           INT              NOT NULL,
NomeTime             VARCHAR(100)     NOT NULL,
Cidade               VARCHAR(100)     NOT NULL,
Estadio              VARCHAR(100)     NOT NULL,
MaterialEsportivo    VARCHAR(100)     NOT NULL
PRIMARY KEY(CodigoTime)
)
GO

CREATE TABLE Grupos (
Grupo                CHAR(1)      CHECK(Grupo = 'A' OR Grupo = 'B' OR Grupo ='C' OR Grupo = 'D')             NOT NULL,
CodigoTime           INT                       NOT NULL
PRIMARY KEY(CodigoTime)
FOREIGN KEY(CodigoTime) REFERENCES Times(CodigoTime)
)
GO

CREATE TABLE Jogos (
CodigoTimeA               INT           NOT NULL,
CodigoTimeB               INT           NOT NULL,
GolsTimeA                 INT           NULL,
GolsTimeB                 INT           NULL,
Data                      DATE     NOT NULL
PRIMARY KEY(CodigoTimeA, CodigoTimeB)
FOREIGN KEY(CodigoTimeA) REFERENCES Times(CodigoTime),
FOREIGN KEY(CodigoTimeB) REFERENCES Times(CodigoTime)
)
GO





INSERT INTO  Times VALUES 
(1, 'Agua Santa', 'Diadema', 'Distrital do Inamar', 'Karilu'),
(2, 'Botafogo-SP', 'Riberão Preto', 'Santa Cruz', 'Volt Sport'),
(3, 'Corinthians', 'São Paulo', 'Neo Química Arena', 'Nike'),
(4, 'Ferroviária', 'Araraquara','Fonte Luminosa', 'Lupo'),
(5, 'Guarani', 'Campinas', 'Brinco de Ouro', 'Kappa'),
(6, 'Inter de Limeira', 'Limeira', 'Limerão', 'Alluri Sports'),
(7, 'Ituano', 'Itu', 'Novelli Júnior', 'Kanxa'),
(8, 'Mirassol', 'Mirassol', 'José Maria de Campos Maia', 'Super Bolla'),
(9, 'Novorizontino', 'Novo Horizonte', 'Jorge  Ismael de Biasi', 'Physicus'),
(10, 'Palmeiras', 'São Paulo', 'Allianz Parque', 'Puma'),
(11, 'Ponte Preta', 'Campinas', 'Moisés Lucarelli', '1900 (Marca Própria)'),
(12, 'Red Bull Bragantino', 'Bragança Paulista', 'Nabi Abi Chedid', 'Nike'),
(13, 'Santo Andre', 'Santo André', 'Bruno José Daniel', 'Icone Sports'),
(14, 'Santos', 'Santos', 'Vila Belmiro', 'Umbro'),
(15, 'Sao Bernardo', 'São Bernardo do Campo', 'Primeiro de Maio', 'Magnum Group'),
(16, 'Sao Paulo', 'São Paulo', 'Morumbi', 'Adidas')
GO




-- procedure de separa os times nos grupos
-- (Coritnthians - 3, Palmeiras - 10 , Santos - 14 e São Paulo - 16 NÃO PODEM estar no mesmo grupo
CREATE PROCEDURE p_sorteio
AS 
BEGIN
DELETE Grupos

DECLARE @query VARCHAR(MAX),
        @quantidade_Times INT,
		@codigoTime INT,
		@verficarTime INT,
		@verificarGrupo INT,
		@grupo CHAR(1),
		@valor_aleatorio INT

		SELECT @quantidade_Times = COUNT(CodigoTime) FROM Grupos
		SET @query = 'INSERT INTO Grupos VALUES (''A'', 3),
		                                        (''B'', 10),
												(''C'', 14),
												(''D'', 16)'
		EXEC (@query)
	SET @codigoTime = 0
	WHILE @codigoTime < 16
	BEGIN
	     SET @codigoTime += 1
		 SELECT @verficarTime = (SELECT CodigoTime FROM Grupos WHERE CodigoTime = @codigoTime)
		 IF(@verficarTime IS NULL)
		 BEGIN
		      SET @valor_aleatorio = RAND() * 4 + 1
			  IF(@valor_aleatorio = 1) 
			          SET @grupo = 'A'
			  ELSE IF(@valor_aleatorio = 2)
			          SET @grupo = 'B'
		      ELSE IF(@valor_aleatorio = 3)
			          SET @grupo = 'C'
			  ELSE IF(@valor_aleatorio = 4)
			          SET @grupo = 'D'
              SELECT @verificarGrupo = (SELECT COUNT(Grupo) FROM Grupos WHERE Grupo = @grupo)
			  WHILE @verificarGrupo > 3
			  BEGIN
			       SET @valor_aleatorio = RAND() * 4 + 1
				   IF(@valor_aleatorio = 1) 
				       SET @grupo = 'A'
				   ELSE IF(@valor_aleatorio = 2)
				       SET @grupo = 'B'
				   ELSE IF(@valor_aleatorio = 3)
				       SET @grupo = 'C'
				   ELSE IF(@valor_aleatorio = 4)
				       SET @grupo = 'D'
                   SELECT @verificarGrupo = (SELECT COUNT(Grupo) FROM Grupos WHERE Grupo = @grupo)
			 END
			 SET @query = 'INSERT INTO Grupos VALUES ('''+@grupo+''', '+CAST(@codigoTime AS VARCHAR)+')'
			 EXEC(@query)
		END
	END
END

EXEC p_sorteio

 
 -- Procedure que cria os jogos seguindo as regras 
CREATE PROCEDURE p_gerar_rodadas  
AS
	DELETE FROM Jogos
	DECLARE @I AS INT,
			@Data_jogosDT AS DATE,
			@A AS INT,
			@B AS INT,
			@F AS INT,
			@RA AS INT,
			@RB AS INT,
			@ID AS INT,
			@J AS INT,
			@FLAG AS INT,
			@DTJOGO AS DATE

	CREATE TABLE #Todos_Jogos(
	ID INT,
	TimeA INT,
	TimeB INT)

	CREATE TABLE #Referencias(
	ID INT,
	R INT)

	CREATE TABLE #Todas_Datas(
	ID INT,
	Data_Jogo DATE UNIQUE)

	SET @I = 0
	SET @Data_jogosDT = '2021-02-28'

	WHILE(@I < 12)
	BEGIN
		IF (@I <> 0 AND @I % 2 <> 0)
		BEGIN 
			SET @Data_jogosDT = (DATEADD(DAY, 3, @Data_jogosDT))
		END
		IF (@I <> 0 AND @I % 2 = 0)
		BEGIN
			SET @Data_jogosDT = (DATEADD(DAY, 4, @Data_jogosDT))
		END
	
		INSERT INTO #Todas_Datas VALUES
		((@I + 1),(@Data_jogosDT))

		SET @I = @I + 1
	END
	
	INSERT INTO #Referencias VALUES
	(1,1), (2,5), (3,9), (4,13),
	(5,1), (6,9), (7,5), (8,13),
	(9,1), (10,13), (11,5), (12,9)

	DELETE FROM #TODOS_JOGOS	
		
	SET @I = 1
	SET @ID = 1
	
	WHILE(@I < 12)
	BEGIN
		SET @RA = (SELECT R.R FROM #Referencias R WHERE R.ID = @I)
		SET @RB = (SELECT R.R FROM #Referencias R WHERE R.ID = @I + 1)
		SET @F = 1
		SET @A = @RA
		SET @B = @RB
	
		WHILE(@F < 17)
		BEGIN
			INSERT INTO #Todos_Jogos VALUES
			(@ID, @A, @B)
			SET @ID = @ID + 1
	
			IF(@B = (@RB + 3))
			BEGIN
				SET @B = @RB
			END
			ELSE
			BEGIN
				SET @B =  @B + 1
			END
	
			IF(@A = (@RA + 3))
			BEGIN
				SET @A =  @RA
				SET @B =  @B + 1
			END
			ELSE
			BEGIN
				SET @A = @A +1	
			END
			SET @F = @F + 1	
		END
		SET @I = @I + 2
	END

	SET @FLAG = 0
	SET @J = 1

	SET @DTJOGO = (SELECT TOP 1 t.Data_Jogo FROM #Todas_Datas t ORDER BY NEWID())
	DELETE FROM #Todas_Datas WHERE #Todas_Datas.Data_Jogo = @DTJOGO
	WHILE(@J < 92)
	BEGIN
		IF(@FLAG = 0)
		BEGIN
			INSERT INTO Jogos VALUES
			((SELECT J.TimeA FROM #Todos_Jogos J WHERE J.ID = @J) , (SELECT J.TimeB FROM #Todos_Jogos J WHERE J.ID = @J), Rand() * 5, Rand() * 5, @DTJOGO),
			((SELECT J.TimeA FROM #Todos_Jogos J WHERE J.ID = (@J + 16)) , (SELECT J.TimeB FROM #Todos_Jogos J WHERE J.ID = (@J + 16)), Rand() * 5, Rand() * 5, @DTJOGO)
		END
		ELSE
		BEGIN
			INSERT INTO Jogos VALUES
			((SELECT J.TimeB FROM #Todos_Jogos J WHERE J.ID = @J) , (SELECT J.TimeA FROM #Todos_Jogos J WHERE J.ID = @J),Rand() * 5, Rand() * 5, @DTJOGO),
			((SELECT J.TimeB FROM #Todos_Jogos J WHERE J.ID = (@J + 16)) , (SELECT J.TimeA FROM #Todos_Jogos J WHERE J.ID = (@J + 16)), Rand() * 5, Rand() * 5, @DTJOGO)
		END
		IF(@J % 16 = 0)
		BEGIN
			SET @J = @J + 16
		END

		IF(@J % 4 = 0)
		BEGIN
			SET @DTJOGO = (SELECT TOP 1 t.Data_Jogo FROM #Todas_Datas t ORDER BY NEWID())
			DELETE FROM #Todas_Datas WHERE #Todas_Datas.Data_Jogo = @DTJOGO
			IF(@FLAG = 0)
			BEGIN
				SET @FLAG = 1
			END
			ELSE
			BEGIN
				SET @FLAG = 0
			END
		END
		SET @J = @J +1
	END

EXEC p_gerar_rodadas
 

 -- select da telas das tabelas dos grupos A, B, C e D com cores diferentes
SELECT t.NomeTime,
       g.Grupo
FROM Grupos g, Times t
WHERE t.CodigoTime = g.CodigoTime
  AND g.Grupo = 'A'

SELECT t.NomeTime,
       g.Grupo
FROM Grupos g, Times t
WHERE t.CodigoTime = g.CodigoTime
  AND g.Grupo = 'B'

SELECT t.NomeTime,
       g.Grupo
FROM Grupos g, Times t
WHERE t.CodigoTime = g.CodigoTime
  AND g.Grupo = 'C'

SELECT t.NomeTime,
       g.Grupo
FROM Grupos g, Times t
WHERE t.CodigoTime = g.CodigoTime
  AND g.Grupo = 'D'


 -- select da tela de exibicao dos nomes dos times em ordenados pelo nome
 SELECT CodigoTime,
        NomeTime,
		Cidade,
		Estadio,
		MaterialEsportivo
 FROM Times
 ORDER BY NomeTime

-- select da tela de exibicao dos jogos pela pequisa de data

 SELECT ta.NomeTime AS NomeTimeA,
        j.GolsTimeA,
        j.GolsTimeB,
		tb.NomeTime AS NomeTimeB,
		j.Data 
 FROM Jogos j, Times ta, Times tb
 WHERE j.CodigoTimeA = ta.CodigoTime
   AND j.CodigoTimeB = tb.CodigoTime

-- a)criar uma Trigger que não permita INSERT, UPDATE ou DELETE nas tabelas TIMES e GRUPOS e uma Trigger
-- semelhante, mas apenas para INSERT e DELETE na tabela jogos. 

-- Gatinho/TRIGGER que não permite INSERT, UPDATE e DELETE dos Times -- !!! Executar apenas depois criar e inserir os Times
CREATE TRIGGER t_naopermitirnoTimes_INSERT_UPADATE_DELETE ON Times
FOR INSERT, UPDATE, DELETE
AS
BEGIN
     ROLLBACK TRANSACTION
	 RAISERROR('Não pode mais adicionar ou modificar os Times', 16, 1)
END



-- Gatinho/TRIGGER que não permite INSERT, UPDATE e DELETE dos Grupos --!!! Executar apenas depois criar e inserir os Grupos
CREATE TRIGGER t_naopermitirnoGrupos_INSERT_UPADATE_DELETE ON Grupos
FOR INSERT, UPDATE, DELETE
AS
BEGIN
     ROLLBACK TRANSACTION
	 RAISERROR('Não pode mais adicionar ou modificar os Grupos', 16, 1)
END



--Gatilho/TRIGGER que não permite INSERT e DELETE nos Jogos -- !!! Executar apenas depois criar e inserir os Jogos
CREATE TRIGGER t_naopermitenosJogos_INSERT_DELETE ON Jogos
FOR INSERT, DELETE
AS
BEGIN
     ROLLBACK TRANSACTION
	 RAISERROR('Não se pode adicionar ou excluir os Jogos', 16 ,1)
END



-- b) Fazer uma tela que, pelas datas dos jogos, seja possível inserir os resultados dos jogos, que fará um UPDATE
-- na tabela jogos, que já terá os times e data, com os gols marcados por cada time.


-- Procedure que permite atualizar os gols dos jogos usando os nomes dos dois times e data do jogo como parametro 
CREATE PROCEDURE p_alterar_gols (@nome_timeA VARCHAR(20), 
								 @nome_timeB VARCHAR(20),
								 @gols_timeA INT,
								 @gols_timeB INT, 
								 @data_jogo DATE) 
AS
BEGIN
		DECLARE @codigo_timeA INT,
				@codigo_timeB INT
	 
			SET @codigo_timeA = (SELECT CodigoTime FROM Times WHERE NomeTime LIKE '%'+@nome_timeA+'%')
                     
			SET @codigo_timeB = (SELECT CodigoTime FROM Times WHERE NomeTime LIKE '%'+@nome_timeB+'%')


			 UPDATE Jogos
			 SET GolsTimeA = @gols_timeA,
				 GolsTimeB = @gols_timeB
			 WHERE CodigoTimeA = @codigo_timeA
			   AND CodigoTimeB = @codigo_timeB
			   AND Data = @data_jogo
END	 


EXEC p_alterar_gols 'Botafogo', 'Inter de Limeira', 10, 10, '2021-03-28'

EXEC p_gerar_rodadas

EXEC p_achar_rebaixados




SELECT ta.NomeTime AS NomeTimeA,
       j.GolsTimeA,
       j.GolsTimeB,
	   tb.NomeTime AS NomeTimeB,
	   j.Data 
FROM Jogos j, Times ta, Times tb
WHERE j.CodigoTimeA = ta.CodigoTime
  AND j.CodigoTimeB = tb.CodigoTime


-- c) Fazer uma tela de consulta com os 4 grupos e 4 Tabelas, que mostrem a saída (para cada Tabela) de uma
-- UDF (User Defined FUNCTION), que receba o nome do grupo, valide-o e dê a seguinte saída:
-- GRUPO (nome_time, num_jogos_disputados*, vitorias, empates, derrotas, gols_marcados, gols_sofridos,
-- saldo_gols**,pontos***) 

-- Procedure que cria a tabela Quartas_temporaria que define os jogos das quartas de final

CREATE PROCEDURE p_tabela_temporaria_quartas
AS
BEGIN
     DROP TABLE Quartas_Temporario

     CREATE TABLE Quartas_Temporario (
     Codigo_TimeA_Quartas    INT,
     Codigo_TimeB_Quartas    INT
     )

     INSERT INTO Quartas_Temporario VALUES
       (1, 2),
       (3, 4),
       (5, 6),
       (7, 8) 
END

EXEC p_tabela_temporaria_quartas

-- Procedure que ajuda a criar as Functions CAMPEONATO e GRUPOS
-- Precisa que a Procedure p_tabela_temporaria_quartas tenha sido criada e executada primeiro

DROP PROCEDURE p_atualizar_tabela

CREATE PROCEDURE p_atualizar_tabela
AS 
DROP TABLE tabela_auxiliar

CREATE TABLE tabela_auxiliar (
codigo_time INT,
nome_time VARCHAR(20), 
num_jogos_disputados INT , 
vitorias INT, 
empates INT, 
derrotas INT, 
gols_marcados INT, 
gols_sofridos INT,
saldo_gols INT,
pontos INT
)
	DECLARE	@codigo_time INT,
	        @nome_time VARCHAR(20),
			@num_jogos_disputados INT,
			@vitorias INT,
			@empates INT,
			@derrotas INT,
			@golsMarcados INT,
			@golsSofridos INT,
			@saldoGols INT,
			@pontos INT
			SET @codigo_time = 1
    
	 WHILE((SELECT COUNT(*) FROM tabela_auxiliar) < 16)
	 BEGIN
	 SET @nome_time = (SELECT NomeTime FROM Times WHERE CodigoTime = @codigo_time)

	 SET @num_jogos_disputados = (SELECT COUNT(*) FROM Jogos
								  WHERE (CodigoTimeA = @codigo_time OR CodigoTimeB = @codigo_time) AND
								        (GolsTimeA IS NOT NULL AND GolsTimeB IS NOT NULL) AND NOT (GolsTimeA = 0 AND GolsTimeB = 0))

	 SET @vitorias = (SELECT COUNT(*) FROM Jogos WHERE (CodigoTimeA = @codigo_time AND GolsTimeA > GolsTimeB) OR 
	                                                   (CodigoTimeB = @codigo_time AND GolsTimeA < GolsTimeB))

     SET @empates = (SELECT COUNT(*) FROM Jogos WHERE (CodigoTimeA = @codigo_time AND GolsTimeA = GolsTimeB) OR 
	                                                  (CodigoTimeB = @codigo_time AND GolsTimeA = GolsTimeB))

     SET @derrotas = (SELECT COUNT(*) FROM Jogos WHERE (CodigoTimeA = @codigo_time AND GolsTimeA < GolsTimeB) OR 
	                                                   (CodigoTimeB = @codigo_time AND GolsTimeA > GolsTimeB))

     SET @golsMarcados = (SELECT ISNULL(SUM(GolsTimeA), 0) FROM Jogos WHERE CodigoTimeA = @codigo_time AND GolsTimeA IS NOT NULL) +
	                     (SELECT ISNULL(SUM(GolsTimeB), 0) FROM Jogos WHERE CodigoTimeB = @codigo_time AND GolsTimeB IS NOT NULL)

     SET @golsSofridos = (SELECT ISNULL(SUM(GolsTimeB), 0) FROM Jogos WHERE CodigoTimeA = @codigo_time AND GolsTimeB IS NOT NULL) +
	                     (SELECT ISNULL(SUM(GolsTimeA), 0) FROM Jogos WHERE CodigoTimeB = @codigo_time AND GolsTimeB IS NOT NULL)

	 SET @saldoGols = @golsMarcados - @golsSofridos
	 SET @pontos = (@vitorias * 3) + @empates

	 INSERT INTO tabela_auxiliar VALUES
	 (@codigo_time, @nome_time, @num_jogos_disputados, @vitorias, @empates, @derrotas, @golsMarcados, @golsSofridos, @saldoGols, @pontos) 
	
	 SET @codigo_time = @codigo_time + 1

	 EXEC p_tabela_temporaria_quartas

	 END

EXEC p_atualizar_tabela

SELECT * FROM tabela_auxiliar

-- Procedure que junto com a p_atualizar_tabela ajuda a criar a Function GRUPOS com estados dos times 
-- sobre se estao rebaixados ou não.  

CREATE PROCEDURE p_achar_rebaixados
AS
BEGIN

DROP TABLE tabela_com_estado
DROP TABLE rebaixados

CREATE TABLE tabela_com_estado (
codigo_time INT,
nome_time VARCHAR(20), 
num_jogos_disputados INT , 
vitorias INT, 
empates INT, 
derrotas INT, 
gols_marcados INT, 
gols_sofridos INT,
saldo_gols INT,
pontos INT,
estado VARCHAR(20)
)

CREATE TABLE rebaixados (
codigo_rebaixado  INT
)

INSERT INTO rebaixados
SELECT TOP 2 codigo_time 
FROM tabela_auxiliar 
ORDER BY pontos ASC, vitorias ASC, gols_marcados ASC, saldo_gols ASC
    
	EXEC p_atualizar_tabela
	DECLARE	@estado VARCHAR(20),
			@rebaixado1  INT,
			@rebaixado2 INT
        SET @rebaixado1 = (SELECT MAX(codigo_rebaixado) FROM rebaixados)
        SET @rebaixado2 = (SELECT MIN(codigo_rebaixado) FROM rebaixados)

		INSERT INTO tabela_com_estado
		SELECT codigo_time, nome_time, num_jogos_disputados, vitorias, 
		CASE WHEN num_jogos_disputados = 0
		THEN 0
		ELSE empates 
		END AS empates, 
		derrotas, gols_marcados, gols_sofridos, saldo_gols, pontos,
		CASE WHEN codigo_time = @rebaixado1 OR codigo_time = @rebaixado2 OR num_jogos_disputados = 0
		THEN 'Rebaixado'

		ELSE 'Permanece'
		END AS Estado 
		FROM tabela_auxiliar
		
END

SELECT * FROM tabela_auxiliar

----------------------------------
UPDATE Jogos
SET GolsTimeA = 0,
    GolsTimeB = 0
WHERE Data = '2021-03-28'

----------------------------------
EXEC p_achar_rebaixados

SELECT * FROM tabela_com_estado

-- Function que exibira os grupos pos jogos precisa que as procedures p_atualizar_tabela e p_achar_rebaixados 
-- tenham sido criadas e executadas primeiro

EXEC p_achar_rebaixados

CREATE FUNCTION GRUPO(@grupo CHAR(1))
RETURNS @tabela TABLE (
codigo_time INT,
nome_time VARCHAR(20), 
num_jogos_disputados INT , 
vitorias INT, 
empates INT, 
derrotas INT, 
gols_marcados INT, 
gols_sofridos INT,
saldo_gols INT,
pontos INT,
estado VARCHAR(20)
)
AS
BEGIN
           INSERT INTO @tabela (codigo_time, nome_time, num_jogos_disputados, vitorias, empates, derrotas, gols_marcados, gols_sofridos, saldo_gols, pontos, estado)
                     (SELECT t.codigo_time ,t.nome_time, t.num_jogos_disputados, t.vitorias, t.empates, t.derrotas, t.gols_marcados, t.gols_sofridos, t.saldo_gols, t.pontos, t.estado
                      FROM tabela_com_estado t ,Grupos g
					  WHERE t.codigo_time = g.CodigoTime
					    AND g.Grupo = @grupo)		
    RETURN
END

SELECT * FROM dbo.GRUPO('A') 
SELECT * FROM dbo.GRUPO('B') 
SELECT * FROM dbo.GRUPO('C') 
SELECT * FROM dbo.GRUPO('D') 



-- O  campeão  de  cada  grupo  se  dará  por  aquele  que  tiver  maior  número  de  pontos. 
-- Em  caso  de  empate,  a  ordem  de desempate é por número de vitórias, depois por gols marcados e por fim,
-- por saldo de gols.

SELECT TOP 1 * FROM dbo.GRUPO('A') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC
SELECT TOP 1 * FROM dbo.GRUPO('B') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC
SELECT TOP 1 * FROM dbo.GRUPO('C') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC
SELECT TOP 1 * FROM dbo.GRUPO('D') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC

 

-- O critério de rebaixamento também é pouco convencional. 
-- Para  definir  os  2  rebaixados, se  considera  os  times  que  tem  menor  pontuação  dentre  todos os times, 
-- independente de qual grupo que pertença.

SELECT TOP 2 * FROM dbo.CAMPEONATO() ORDER BY pontos ASC

-- Na tela com  as 4 Tabelas, deve-se criar uma identificaçãoda  linha  dos times que  estiveremem condição de rebaixamento.



SELECT * FROM dbo.GRUPO('A') 
UNION
SELECT * FROM dbo.GRUPO('B') 
UNION
SELECT * FROM dbo.GRUPO('C')
UNION 
SELECT * FROM dbo.GRUPO('D') ORDER BY pontos DESC

/*
Deve-se  fazer,  para  melhor  visualização  dos  resultados,  uma  tela  com a  classificação  geral,
numa  UDF  (User  Defined  FUNCTION),  que  receba  o  nome  do  grupo,  valide-o  e  dê  a  seguinte saída,
para todos os times do campeonato:
CAMPEONATO (nome_time, num_jogos_disputados*, vitorias, empates, derrotas, gols_marcados, gols_sofridos, saldo_gols**,pontos***)
A ordenação da saída se dá pelo mesmo critério anterior. 
 */
EXEC p_achar_rebaixados

CREATE FUNCTION CAMPEONATO()
RETURNS @tabela TABLE (
codigo_time INT,
nome_time VARCHAR(20), 
num_jogos_disputados INT , 
vitorias INT, 
empates INT, 
derrotas INT, 
gols_marcados INT, 
gols_sofridos INT,
saldo_gols INT,
pontos INT,
classificacao VARCHAR(20)
)
AS
BEGIN
           INSERT INTO @tabela (codigo_time, nome_time, num_jogos_disputados, vitorias, empates, derrotas, gols_marcados, gols_sofridos, saldo_gols, pontos, classificacao)
				(SELECT  t.codigo_time ,t.nome_time, t.num_jogos_disputados, t.vitorias, t.empates, t.derrotas, t.gols_marcados, t.gols_sofridos, t.saldo_gols, t.pontos,
						CASE WHEN t.nome_time = fntq.nome_times_quartas
						THEN 'Classificado'
						ELSE 'Não Classificado'
						END AS classificacao
						FROM tabela_auxiliar t LEFT OUTER JOIN fn_nomes_times_quartas() fntq
						ON t.nome_time = fntq.nome_times_quartas)
    RETURN
END



SELECT * FROM dbo.CAMPEONATO() ORDER BY classificacao

-- Por fim, uma tela deverá ser criada para ver a projeção das quartas de final. 
-- As quartas de final serão disputadas entre o 1º e o 2º de cada grupo. Gerá-las a partir de UDF.
-- Function que exibe o nome dos times das quartas de final com ajuda da Function GRUPOS usando ordernaÇao por pontos DECENDENTE

CREATE FUNCTION fn_nomes_times_quartas()
RETURNS @tabela TABLE (
codigo_times_quartas INT IDENTITY(1, 1),
nome_times_quartas VARCHAR(20)
)
BEGIN
INSERT INTO @tabela 
SELECT TOP 2 nome_time FROM dbo.GRUPO('A') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC
INSERT INTO @tabela 
SELECT TOP 2 nome_time FROM dbo.GRUPO('B') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC
INSERT INTO @tabela 
SELECT TOP 2 nome_time FROM dbo.GRUPO('C') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC
INSERT INTO @tabela 
SELECT TOP 2 nome_time FROM dbo.GRUPO('D') ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC
   RETURN
END 

SELECT * FROM fn_nomes_times_quartas()

-- A tela que apresenta a saída da Function Campeonato também deverá deixar uma identificação para os que,
-- no momento da consulta, estão classificados para as quartas de final.
SELECT * FROM dbo.CAMPEONATO() ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC

-- A qualquer momento, deve ser possível ver as tabelas e a projeção das quartas de final. 
-- Function que exibe as quartas de final precisa que a Function fn_nomes_times_quartas tenha sido criada antes de ser executada

CREATE FUNCTION fn_Quarta_de_final()
RETURNS @tabela TABLE (
NomeTimeA VARCHAR(20),
NomeTimeB VARCHAR(20) 
)
AS
BEGIN 
        INSERT INTO @tabela (NomeTimeA, NomeTimeB)
		SELECT ftA.nome_times_quartas AS NomeTimeA, ftB.nome_times_quartas AS NomeTimeB 
		FROM fn_nomes_times_quartas() ftA, fn_nomes_times_quartas() ftB, Quartas_Temporario qt
		WHERE ftA.codigo_times_quartas = qt.Codigo_TimeA_Quartas
		  AND ftB.codigo_times_quartas = qt.Codigo_TimeB_Quartas
   RETURN
END

SELECT * FROM fn_Quarta_de_final()


SELECT * FROM Grupos
SELECT * FROM Times
SELECT * FROM Jogos
SELECT * FROM tabela_auxiliar
SELECT * FROM tabela_com_estado

SELECT * FROM fn_nomes_times_quartas()

SELECT DISTINCT Data FROM Jogos


 

  


