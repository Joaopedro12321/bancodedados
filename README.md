# bancodedados

  PARA ESTA ATIVIDADE VEJA O CONTEÚDO DISPONIBILIZADO NO DIA 15/04/24

Crie uma view que mostra todos os produtos e suas respectivas marcas;

Crie uma view que mostra todos os produtos e seus respectivos fornecedores;

Crie uma view que mostra todos os produtos e seus respectivos fornecedores e marcas;

Crie uma view que mostra todos os produtos com estoque abaixo do mínimo;

Adicione o campo data de validade. Insira novos produtos com essa informação;

Crie uma view que mostra todos os produtos e suas respectivas marcas com validade vencida;

Selecionar os produtos com preço acima da média.

João pedro de Avila Bento 
Ra:223996

create table marcas (
  mrc_id int auto_increment primary key,
  mrc_nome varchar(50) not null,
  mrc_nacionalidade varchar(50)
);

create table produtos (
  prd_id int auto_increment primary key,
  prd_nome varchar(50) not null,
  prd_qtd_estoque int not null default 0,
  prd_estoque_min int not null default 0,
  prd_data_fabricacao timestamp default now(),
  prd_perecivel boolean,
  prd_valor decimal(19,2),
  prd_marca_id int,
  constraint fk_marcas foreign key(prd_marca_id) references marcas(mrc_id)
);

create table fornecedores (
  frn_id int auto_increment primary key,
  frn_nome varchar(50) not null,
  frn_email varchar(50)
);

create table produto_fornecedor (
  pf_prod_id int,
  pf_forn_id int,
  primary key (pf_prod_id, pf_forn_id),
  foreign key (pf_prod_id) references produtos(prd_id),
  foreign key (pf_forn_id) references fornecedores(frn_id)
);
INSERT INTO marcas (mrc_nome, mrc_nacionalidade) VALUES
  ('Marca A', 'Nacionalidade A'),
  ('Marca B', 'Nacionalidade B'),
  ('Marca C', 'Nacionalidade C'),
  ('Marca D', 'Nacionalidade D'),
  ('Marca E', 'Nacionalidade E'),
  ('Marca F', 'Nacionalidade F'),
  ('Marca G', 'Nacionalidade G'),
  ('Marca H', 'Nacionalidade H'),
  ('Marca I', 'Nacionalidade I'),
  ('Marca J', 'Nacionalidade J');

-- Tabela produtos
INSERT INTO produtos (prd_nome, prd_qtd_estoque, prd_estoque_min, prd_perecivel, prd_valor, prd_marca_id) VALUES
  ('Produto A', 10, 5, true, 10.99, 1),
  ('Produto B', 20, 8, false, 15.50, 2),
  ('Produto C', 5, 2, true, 7.99, 3),
  ('Produto D', 15, 10, false, 12.75, 4),
  ('Produto E', 8, 3, true, 9.99, 5),
  ('Produto F', 12, 6, false, 18.25, 6),
  ('Produto G', 6, 1, true, 6.49, 7),
  ('Produto H', 18, 12, false, 14.50, 8),
  ('Produto I', 3, 1, true, 8.99, 9),
  ('Produto J', 7, 4, false, 11.75, 10);

-- Tabela fornecedores
INSERT INTO fornecedores (frn_nome, frn_email) VALUES
  ('Fornecedor A', 'fornecedorA@example.com'),
  ('Fornecedor B', 'fornecedorB@example.com'),
  ('Fornecedor C', 'fornecedorC@example.com'),
  ('Fornecedor D', 'fornecedorD@example.com'),
  ('Fornecedor E', 'fornecedorE@example.com'),
  ('Fornecedor F', 'fornecedorF@example.com'),
  ('Fornecedor G', 'fornecedorG@example.com'),
  ('Fornecedor H', 'fornecedorH@example.com'),
  ('Fornecedor I', 'fornecedorI@example.com'),
  ('Fornecedor J', 'fornecedorJ@example.com');

-- Tabela produto_fornecedor
INSERT INTO produto_fornecedor (pf_prod_id, pf_forn_id) VALUES
  (1, 1),
  (1, 2),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5),
  (6, 6),
  (7, 7),
  (8, 8),
  (9, 9),
  (10, 10);
  select * from marcas;
  
  --1

CREATE VIEW view_produtos_marcas AS
SELECT prd.prd_id, prd.prd_nome, mrc.mrc_nome AS marca_nome
FROM produtos prd
JOIN marcas mrc ON prd.prd_marca_id = mrc.mrc_id;

--2
CREATE VIEW view_produtos_fornecedores AS
SELECT prd.prd_id, prd.prd_nome, forn.frn_nome AS fornecedor_nome
FROM produtos prd
JOIN produto_fornecedor pf ON prd.prd_id = pf.pf_prod_id
JOIN fornecedores forn ON pf.pf_forn_id = forn.frn_id;

--3
CREATE VIEW view_produtos_fornecedores_marcas AS
SELECT prd.prd_id, prd.prd_nome, forn.frn_nome AS fornecedor_nome, mrc.mrc_nome AS marca_nome
FROM produtos prd
JOIN produto_fornecedor pf ON prd.prd_id = pf.pf_prod_id
JOIN fornecedores forn ON pf.pf_forn_id = forn.frn_id
JOIN marcas mrc ON prd.prd_marca_id = mrc.mrc_id;

--4
CREATE VIEW view_produtos_estoque_minimo AS
SELECT prd.prd_id, prd.prd_nome, prd.prd_qtd_estoque, prd.prd_estoque_min, mrc.mrc_nome AS marca_nome
FROM produtos prd
JOIN marcas mrc ON prd.prd_marca_id = mrc.mrc_id
WHERE prd.prd_qtd_estoque < prd.prd_estoque_min;

--5
ALTER TABLE produtos
ADD prd_data_validade DATE;

--6
CREATE VIEW view_produtos_validade_vencida AS
SELECT prd.prd_id, prd.prd_nome, mrc.mrc_nome AS marca_nome, prd.prd_data_validade
FROM produtos prd
JOIN marcas mrc ON prd.prd_marca_id = mrc.mrc_id
WHERE prd.prd_data_validade < CURRENT_DATE;

--7
SELECT prd.prd_id, prd.prd_nome, prd.prd_preco, AVG(prd.prd_preco) AS media_precos
FROM produtos prd
WHERE prd.prd_preco > (SELECT AVG(prd_preco) FROM produtos)
GROUP BY prd.prd_id, prd.prd_nome, prd.prd_preco;
  
  
