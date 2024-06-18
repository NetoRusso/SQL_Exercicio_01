
-- Crie uma tabela chamada clientes com as colunas: id, nome, email e telefone, idade.

CREATE TABLE IF NOT EXISTS clientes(
	id SERIAL NOT NULL,
	nome_cliente VARCHAR(120) NOT NULL,
	email_cliente varchar(50) NOT NULL,
	telefone_cliente varchar(20) NOT NULL,
	idade INT NOT NULL,
	CONSTRAINT cliente_PK PRIMARY KEY (id)
);


-- Adicione cinco registros à tabela clientes com informações fictícias, garantindo que cada registro tenha um valor único para o campo id.

insert into clientes (nome_cliente, email_cliente, telefone_cliente, idade) values ('Dante Bladen', 'dbladen0@ocn.ne.jp', '(86)97992-6321', 23);
insert into clientes (nome_cliente, email_cliente, telefone_cliente, idade) values ('Federico Turbat', 'fturbat1@thetimes.co.uk', '(46)99679-1537', 19);
insert into clientes (nome_cliente, email_cliente, telefone_cliente, idade) values ('Brantley Castagne', 'bcastagne2@patch.com', '(42)95661-47781', 35);
insert into clientes (nome_cliente, email_cliente, telefone_cliente, idade) values ('Marchall Boshell', 'mboshell3@marriott.com', '(86)99837-2876', 29);
insert into clientes (nome_cliente, email_cliente, telefone_cliente, idade) values ('Malynda Basindale', 'mbasindale4@typepad.com', '(63)98436-4364', 47);

SELECT * FROM clientes;

-- Crie uma tabela chamada produtos com as colunas: codigo, nome, preco e quantidade.

CREATE TABLE IF NOT EXISTS produtos (
	codigo serial NOT NULL,
	nome_produto VARCHAR(100) NOT NULL,
	preco DECIMAL(10,2) NOT NULL,
	quantidade INT NOT NULL,
	CONSTRAINT codigo_pk PRIMARY KEY (codigo)
)

ALTER SEQUENCE produtos_codigo_seq RESTART WITH 1000;

-- Insira três registros na tabela produtos com informações fictícias.

insert into produtos (nome_produto, preco, quantidade) values ('Playstation 5', '3639.90', 4);
insert into produtos (nome_produto, preco, quantidade) values ('Controle DualSense', '379.90', 15);
insert into produtos (nome_produto, preco, quantidade) values ('Jogo Dragons Dogma 2', '323.52', 32);

SELECT * FROM produtos;

-- Crie uma tabela chamada itens com as colunas: id, codigo_produto, id_cliente e quantidade.

CREATE TABLE IF NOT EXISTS itens (
	id_item serial NOT NULL,
	codigo_produto INT NOT NULL,
	id_cliente INT NOT NULL,
	quantidade INT,
	CONSTRAINT id_item_pk PRIMARY KEY (id_item),
	CONSTRAINT codigo_produto_FK FOREIGN KEY (codigo_produto) REFERENCES produtos(codigo),
	CONSTRAINT id_cliente_FK FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

-- Adicione cinco itens à tabela itens, relacionando-os a clientes existentes e produtos disponíveis.

insert into itens (codigo_produto, id_cliente, quantidade) values (1000, 2, 1);
insert into itens (codigo_produto, id_cliente, quantidade) values (1002, 1, 3);
insert into itens (codigo_produto, id_cliente, quantidade) values (1001, 4, 4);
insert into itens (codigo_produto, id_cliente, quantidade) values (1001, 5, 2);
insert into itens (codigo_produto, id_cliente, quantidade) values (1000, 3, 1);

SELECT * FROM itens;


-- Criar no mínimo duas Views com propostas interessantes ao usuário visualizar

CREATE OR REPLACE VIEW compras AS
	SELECT
	p.nome_produto,
	c.nome_cliente,
	p.preco,
	i.quantidade
	FROM
		itens i
	JOIN
		produtos p ON p.codigo = i.codigo_produto
	JOIN
		clientes c ON c.id = i.id_cliente; 
	


SELECT * FROM compras;

CREATE OR REPLACE VIEW compras_checkout AS
	SELECT
		p.nome_produto,
		c.nome_cliente,
		p.preco,
		i.quantidade,
		SUM(i.quantidade * p.preco) AS Total
	FROM
		itens i
	JOIN
		produtos p ON p.codigo = i.codigo_produto
	JOIN
		clientes c ON c.id = i.id_cliente
	GROUP BY
		c.nome_cliente,
		p.nome_produto,
		p.preco,
		i.quantidade;

SELECT * FROM compras_checkout;



-- 



--EXERCICIO 18/06/2024

--1. Adicionar um novo cliente*:
-- Adicione um novo cliente com os seguintes dados: nome, email, telefone e idade.

INSERT INTO clientes ( nome_cliente, email_cliente, telefone_cliente, idade)
	VALUES ('DENNYS', 'DENNYSDJ@GMAIL.COM', '33333333', 56);

SELECT * FROM clientes;

--2. Adicionar um novo produto*:
--Adicione um novo produto com os seguintes dados: nome, preço e quantidade. 

INSERT INTO produtos (nome_produto, preco, quantidade) VALUES
('Marvels Spider-Man 2 ', 311.21, 40);

SELECT * FROM produtos;

--3. adicionar um novo item de venda*:
--Adicione um novo item de venda relacionando um produto e um cliente existentes com uma quantidade específica.

insert into itens (codigo_produto, id_cliente, quantidade) values (1003, 6, 1);

SELECT * FROM itens;
SELECT * FROM compras;

--4. Atualizar o telefone de um cliente*:
-- Atualize o telefone de um cliente específico usando seu email como referência.

UPDATE clientes
SET telefone_cliente = '(81)98666-2414'
WHERE  email_cliente = 'DENNYSDJ@GMAIL.COM';


--5. Atualizar o preço e a quantidade de um produto:
-- Atualize o preço e a quantidade de um produto específico usando o nome do produto como referência.

UPDATE produtos
SET preco = 3599.90, 
	quantidade = 8
WHERE nome_produto = 'Playstation 5';

SELECT * FROM produtos ORDER BY codigo;

--6. Atualizar a quantidade de um item de venda:
-- Atualize a quantidade de um item de venda específico usando seu ID como referência.

UPDATE itens 
SET quantidade = 3
WHERE id_item = 5;


SELECT * FROM itens;

-- 7. **Deletar um cliente específico**:
--    - Delete um cliente específico usando seu email como referência.

DELETE FROM itens WHERE id_cliente = 5;

DELETE FROM clientes WHERE email_cliente ='mbasindale4@typepad.com';


SELECT * FROM clientes;

-- 8. **Deletar um produto específico**:
--    - Delete um produto específico usando o nome do produto como referência.

DELETE FROM itens WHERE codigo_produto = 1002;

DELETE FROM produtos WHERE nome_produto = 'Jogo Dragons Dogma 2';

SELECT * FROM produtos;

-- 9. **Deletar um item de venda específico**:
--    - Delete um item de venda específico usando seu ID como referência.

DELETE FROM itens WHERE id_item = 1;

SELECT * FROM itens;

-- ### Desafios de Criação de `VIEWS`

-- 10. **Criar uma view que exibe todos os clientes com suas respectivas idades e telefones**:
--     - Crie uma view que mostra o nome, idade e telefone de todos os clientes.

CREATE OR REPLACE VIEW cliente_idade_telefone AS
	SELECT
	c.nome_cliente AS Cliente,
	c.idade AS Idade,
	c.telefone_cliente AS Telefone 
	FROM clientes c
	GROUP BY
		Cliente,
		Idade,
		Telefone;

SELECT * FROM cliente_idade_telefone;

-- 11. **Criar uma view que exibe todos os produtos com seus preços e quantidades em estoque**:
--     - Crie uma view que mostra o nome, preço e quantidade de todos os produtos.

CREATE OR REPLACE VIEW produto_preco_estoque AS
	SELECT
	p.nome_produto AS Produto,
	p.preco AS Preço,
	p.quantidade AS Estoque
FROM produtos p
	GROUP BY
		Produto,
		Preço,
		Estoque;

SELECT * FROM produto_preco_estoque;

-- 12. **Criar uma view que exibe o total vendido por cada cliente**:
--     - Crie uma view que mostra o nome do cliente e o total vendido por ele.

CREATE OR REPLACE VIEW cliente_total AS
	SELECT
	c.nome_cliente AS Comprador,
	SUM(i.quantidade * p.preco) AS Total
	FROM itens i
	JOIN produtos p ON p.codigo = i.codigo_produto
	JOIN clientes c ON c.id = id_cliente
	GROUP BY
		c.nome_cliente;

SELECT * FROM cliente_total ORDER BY Total;


-- ### Desafios Adicionais

-- 13. **Adicionar um novo cliente e uma nova compra para esse cliente**:
--     - Adicione um novo cliente com dados fictícios.
--     - Adicione um novo item de venda para esse cliente relacionando um produto existente.

INSERT INTO clientes (nome_cliente, email_cliente, telefone_cliente, idade) VALUES 
	('Devland Hanrott', 'dhanrott0@com.com', '(57)98765-4321', 24);

INSERT INTO itens (codigo_produto, id_cliente, quantidade) VALUES (1000, 8, 3);

-- 14. **Atualizar o nome e o email de um cliente específico**:
--     - Atualize o nome e o email de um cliente usando seu ID como referência.

UPDATE clientes
	SET nome_cliente = 'Thiago Disel',
		email_cliente = 'thiago_family@boracodar.com'
	WHERE id = 8;

SELECT 	* FROM clientes;

-- 15. **Deletar todos os itens de venda de um produto específico**:
--     - Delete todos os itens de venda de um produto específico usando o código do produto como referência.

DELETE FROM itens WHERE codigo_produto = 1003;

-- ***** LISTA 02 - VALENDO ************

-- 16. **Adicionar múltiplos clientes**:
--    - Adicione três novos clientes com dados fictícios em uma única instrução `INSERT`.

INSERT INTO clientes (nome_cliente, email_cliente, telefone_cliente, idade) VALUES 
	('Nicholle Mc Gee', 'nmc0@mapy.cz', '(41)94292-4224', 49),
	('Rosemary Harriagn', 'rharriagn1@bandcamp.com', '(73)95108-6812', 60),
	('Trude Ebanks', 'tebanks2@sina.com.cn', '(33)97246-5462', 36);

SELECT * FROM clientes;

-- 17. **Adicionar múltiplos produtos**:
--    - Adicione dois novos produtos com dados fictícios em uma única instrução `INSERT`.

INSERT INTO produtos (nome_produto, preco, quantidade) VALUES
	('Hogwarts Legacy', 223.86, 100),
	('EA Sports FC 24', 296.10, 76);

SELECT * FROM produtos ORDER BY codigo;

-- 18. **Adicionar múltiplos itens de venda**:
--    - Adicione três novos itens de venda relacionando diferentes produtos e clientes existentes em uma única instrução `INSERT`.


INSERT INTO itens (codigo_produto, id_cliente, quantidade) VALUES
	(1000, 11, 1),
	(1006, 9, 2),
	(1005, 8, 1);

SELECT * FROM itens;

-- ### Desafios de `UPDATE`

-- 19. **Atualizar a idade de todos os clientes acima de 30 anos**:
--    - Aumente a idade de todos os clientes que têm mais de 30 anos em 1 ano.


UPDATE clientes
	SET idade = (idade + 1)
	WHERE idade >= 30;

SELECT idade FROM clientes ORDER BY idade;

-- 20. **Atualizar o preço de todos os produtos com quantidade menor que 10**:
--    - Aumente o preço de todos os produtos com quantidade menor que 10 em 10%.

UPDATE produtos
	SET preco = preco * 1.1
	WHERE quantidade < 10;

SELECT preco FROM produtos ORDER BY preco;

-- 21. **Atualizar o nome de todos os produtos para incluir uma palavra-chave**:
--    - Adicione a palavra "Promoção" ao início do nome de todos os produtos.

UPDATE produtos
	SET nome_produto = CONCAT('PROMOÇÃO ', nome_produto);

SELECT nome_produto FROM produtos;

-- ### Desafios de `DELETE`

-- 22. **Deletar todos os clientes com idade menor que 18 anos**:
--    - Delete todos os clientes que têm menos de 18 anos.

DELETE FROM clientes 
	WHERE idade < 18;

select * from clientes;

-- 23. **Deletar todos os produtos com preço maior que 50**:
--    - Delete todos os produtos cujo preço é maior que 50.

DELETE FROM produtos 
	WHERE preco > 50;

-- 24. **Deletar todos os itens de venda de clientes específicos**:
--    - Delete todos os itens de venda de clientes com email específico.

DELETE FROM itens
	WHERE id_cliente IN (select id from clientes WHERE email_cliente =  'DENNYSDJ@GMAIL.COM');


select * from itens;
select * from clientes;

-- ### Desafios de Criação de `VIEWS`

-- 25. **Criar uma view que exibe o estoque total de produtos vendidos**:
--     - Crie uma view que mostra o nome do produto e o total vendido em relação ao estoque.

CREATE OR REPLACE VIEW produto_total_estoque AS
	SELECT
		p.nome_produto AS Produto,
		p.quantidade,
		SUM(i.quantidade) AS Total_Vendido,
		MIN(p.quantidade - i.quantidade) AS Estoque
		FROM produtos p
		JOIN itens i ON p.codigo = i.codigo_produto
		GROUP BY p.nome_produto, p.quantidade;

SELECT * FROM produto_total_estoque;

-- 26. **Criar uma view que exibe os clientes que não fizeram compras**:
--     - Crie uma view que mostra o nome e email dos clientes que não têm itens de venda associados.

CREATE OR REPLACE VIEW clientes_sem_compras AS
SELECT 
    c.nome_cliente,
    c.email_cliente
FROM 
    clientes c
LEFT JOIN 
    itens i ON c.id = i.id_cliente
WHERE 
    i.id_cliente IS NULL;

SELECT * FROM clientes_sem_compras;

-- 27. **Criar uma view que exibe os produtos não vendidos**:
--     - Crie uma view que mostra o nome e preço dos produtos que não foram vendidos (quantidade de vendas igual a zero).

CREATE OR REPLACE VIEW produtos_nao_vendidos AS
SELECT 
    p.nome_produto,
    p.preco
FROM 
    produtos p
LEFT JOIN 
    itens i ON p.codigo = i.codigo_produto
WHERE 
    i.codigo_produto IS NULL;

SELECT * FROM produtos_nao_vendidos;

-- ### Desafios Adicionais

-- 28. **Adicionar uma nova coluna em uma tabela e atualizar dados**:
--     - Adicione uma nova coluna `data_de_cadastro` à tabela `clientes` e preencha-a com a data atual para todos os clientes.


ALTER TABLE clientes
ADD COLUMN data_de_cadastro DATE;


UPDATE clientes
SET data_de_cadastro = CURRENT_DATE;

SELECT * FROM clientes;

-- 29. **Atualizar o preço dos produtos com base em uma condição**:
--     - Aumente o preço de todos os produtos em 5% se a quantidade em estoque for menor que 20.

UPDATE produtos
SET preco = preco * 1.05
WHERE quantidade < 20;

SELECT * FROM produtos;

-- 30. **Deletar registros duplicados em uma tabela**:
--     - Encontre e delete registros duplicados na tabela `clientes`, mantendo apenas um registro por cliente com base no email.


DELETE FROM clientes
WHERE id NOT IN (
    SELECT MIN(id)
    FROM clientes
    GROUP BY email_cliente
);

SELECT * FROM clientes;

-- 31. **Criar uma view que exibe a média de vendas por produto**:
--     - Crie uma view que mostra o nome do produto e a média de itens vendidos por produto.


CREATE OR REPLACE VIEW media_vendas_produto AS
SELECT 
    p.nome_produto,
	ROUND(AVG(i.quantidade)) AS media_itens_vendidos
FROM 
    produtos p
JOIN 
    itens i ON p.codigo = i.codigo_produto
GROUP BY 
    p.nome_produto;

SELECT * FROM media_vendas_produto;


-- 32. **Adicionar um novo cliente e realizar múltiplas compras para esse cliente**:
--     - Adicione um novo cliente com dados fictícios.
--     - Adicione três novos itens de venda para esse cliente, relacionando diferentes produtos.

INSERT INTO clientes (nome_cliente, email_cliente, telefone_cliente, idade) 
VALUES ('Ana Silva', 'ana.silva@email.com', '(11) 99999-9999', 30);

SELECT id FROM clientes WHERE email_cliente = 'ana.silva@email.com';



INSERT INTO itens (codigo_produto, id_cliente, quantidade) VALUES
(1000, (SELECT id FROM clientes WHERE email_cliente = 'ana.silva@email.com'), 2),
(1001, (SELECT id FROM clientes WHERE email_cliente = 'ana.silva@email.com'), 1), 
(1003, (SELECT id FROM clientes WHERE email_cliente = 'ana.silva@email.com'), 3); 

SELECT * FROM itens;



-- 33. **Atualizar o email de todos os clientes para um novo domínio**:
--     - Atualize o email de todos os clientes para um novo domínio, por exemplo, mude `@example.com` para `@novodominio.com`.


UPDATE clientes
SET email_cliente = REPLACE(email_cliente, '@bandcamp.com', '@novodominio.com');

SELECT * FROM clientes;


-- 34. **Deletar produtos que não foram vendidos nos últimos 6 meses**:
-- Delete todos os produtos que não têm itens de venda associados nos últimos 6 meses.

DELETE FROM produtos
WHERE codigo NOT IN (
    SELECT DISTINCT codigo_produto
    FROM itens
    WHERE data_venda >= CURRENT_DATE - INTERVAL '6 months'
);

-- 35. **Criar uma view que exibe a proporção de vendas por cliente**:
--     - Crie uma view que mostra o nome do cliente e a proporção do total de vendas em relação ao total de vendas de todos os clientes.

CREATE OR REPLACE VIEW proporcao_vendas_cliente AS
SELECT 
    c.nome_cliente,
    TO_CHAR((SUM(i.quantidade * p.preco)::decimal * 100 / (
      SELECT SUM(i2.quantidade * p2.preco)
    FROM itens i2
    JOIN produtos p2 ON i2.codigo_produto = p2.codigo
    )), '99.99%') AS proporcao_vendas
FROM clientes c
JOIN itens i ON c.id = i.id_cliente
JOIN produtos p ON i.codigo_produto = p.codigo
GROUP BY c.nome_cliente;

SELECT * FROM proporcao_vendas_cliente;