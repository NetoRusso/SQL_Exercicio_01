
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




