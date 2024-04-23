-- TABLE
CREATE TABLE demo (ID integer primary key, Name varchar(20), Hint text );
CREATE TABLE marcas (

mrc_id int auto_increment primary key,
mrc_none varchar(50) not null,
mrc_nacionalidade varchar(50)

);
 
-- INDEX
 
-- TRIGGER
 
-- VIEW
CREATE VIEW view_produtos_estoque_minimo AS
SELECT prd.prd_id, prd.prd_nome, prd.prd_qtd_estoque, prd.prd_estoque_min, mrc.mrc_nome AS marca_nome
FROM produtos prd
JOIN marcas mrc ON prd.prd_marca_id = mrc.mrc_id
WHERE prd.prd_qtd_estoque < prd.prd_estoque_min;
CREATE VIEW view_produtos_fornecedores AS
SELECT prd.prd_id, prd.prd_nome, forn.frn_nome AS fornecedor_nome
FROM produtos prd
JOIN produto_fornecedor pf ON prd.prd_id = pf.pf_prod_id
JOIN fornecedores forn ON pf.pf_forn_id = forn.frn_id;
CREATE VIEW view_produtos_fornecedores_marcas AS
SELECT prd.prd_id, prd.prd_nome, forn.frn_nome AS fornecedor_nome, mrc.mrc_nome AS marca_nome
FROM produtos prd
JOIN produto_fornecedor pf ON prd.prd_id = pf.pf_prod_id
JOIN fornecedores forn ON pf.pf_forn_id = forn.frn_id
JOIN marcas mrc ON prd.prd_marca_id = mrc.mrc_id;
CREATE VIEW view_produtos_marcas AS
SELECT prd.prd_id, prd.prd_nome, mrc.mrc_nome AS marca_nome
FROM produtos prd
JOIN marcas mrc ON prd.prd_marca_id = mrc.mrc_id;
 
