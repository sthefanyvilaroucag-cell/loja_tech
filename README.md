#  TechStore (`loja_tech`) — Prática de Consultas SQL e Stored Procedures

Repositório dedicado à prática de fundamentos de Banco de Dados Relacional no **MySQL Workbench**, utilizando o contexto de um e-commerce de produtos de tecnologia (**TechStore**). 

O objetivo deste projeto é consolidar a leitura de esquemas, consultas básicas (`SELECT`, filtros, agregações e `JOIN`) e a criação de **Stored Procedures** (`IN`, `OUT`, manipulação de dados e boas práticas com `DELIMITER`).

---

##  Estrutura do Banco de Dados

O banco `loja_tech` é composto por **6 tabelas principais**:

- **`categorias`**: Agrupa os produtos (Notebooks, Smartphones, Periféricos, Monitores, Armazenamento).
- **`produtos`**: Catálogo de itens à venda, com controle de preço, estoque atual e estoque mínimo.
- **`clientes`**: Cadastro de consumidores da loja.
- **`pedidos`**: Cabeçalho das compras realizadas, com status e valor total.
- **`itens_pedido`**: Detalhamento dos produtos, quantidades e subtotais de cada pedido.
- **`log_operacoes`**: Tabela de auditoria para registrar ações executadas via Stored Procedures.

 ##  Como Executar o Projeto 
Abra o MySQL Workbench e conecte-se à sua instância local.

Execute o script de criação do banco (CREATE DATABASE loja_tech), 
das tabelas e da carga inicial de dados.

Certifique-se de selecionar o banco ativo antes de rodar os exercícios:


USE loja_tech;

## Parte 1: 10 Consultas SQL 

 
1. Listagem básica de clientes
Exibe o nome e o e-mail de todos os clientes cadastrados.

SQL
SELECT nome, email 
FROM clientes;


2. Filtro por faixa de preço
Lista produtos que custam menos de R$ 500,00.

SELECT nome, preco 
FROM produtos 
WHERE preco < 500.00;


3. Filtro por status de pedido
Exibe todos os dados dos pedidos com status 'pendente'.

SELECT * 
FROM pedidos 
WHERE status = 'pendente';


4. Ordenação de catálogo
Lista nome e preço dos produtos ordenados do mais caro para o mais barato.

SELECT nome, preco 
FROM produtos 
ORDER BY preco DESC;


5. Busca textual parcial
Busca produtos que contenham a palavra Monitor no nome.

SELECT id_produto, nome, preco 
FROM produtos 
WHERE nome LIKE '%Monitor%';


6. Filtro composto (Categoria e Estoque)
Lista periféricos (id_categoria = 3) com mais de 40 unidades em estoque.

SELECT nome, estoque 
FROM produtos 
WHERE id_categoria = 3 
  AND estoque > 40;

  
7. Contagem total de registros
Retorna a quantidade total de clientes cadastrados.

SELECT COUNT(id_cliente) AS total_clientes 
FROM clientes;


8. Soma de valores
Calcula o faturamento bruto somando todos os pedidos.

SELECT SUM(valor_total) AS faturamento_bruto 
FROM pedidos;


10. Junção simples entre duas tabelas (JOIN)
Exibe o nome do produto junto ao nome de sua categoria.

SELECT produtos.nome, categorias.nome
FROM produtos
JOIN categorias ON produtos.id_categoria = categorias.id_categoria;


10. Junção com filtro por cliente
Lista os pedidos realizados pela cliente Ana Silva.

SELECT id_pedido, status, valor_total
FROM pedidos
JOIN clientes ON pedidos.id_cliente = clientes.id_cliente
WHERE clientes.nome = 'Ana Silva';


 ## Parte 2: 5 Exercícios de Stored Procedures 
Todas as procedures foram construídas seguindo boas práticas: remoção prévia 
(DROP PROCEDURE IF EXISTS), controle de delimitador (DELIMITER //)
e prefixo p_ para parâmetros.


1. Listar categorias ativas (Sem parâmetros)

DROP PROCEDURE IF EXISTS listar_categorias_ativas;
DELIMITER //

CREATE PROCEDURE listar_categorias_ativas()
BEGIN
    SELECT id_categoria, nome, descricao
    FROM categorias
    WHERE ativo = TRUE
    ORDER BY nome ASC;
END //

DELIMITER ;

-- Teste:
CALL listar_categorias_ativas();

2. Buscar pedidos por status (Parâmetro IN)

DROP PROCEDURE IF EXISTS buscar_pedidos_por_status;
DELIMITER //

CREATE PROCEDURE buscar_pedidos_por_status(
    IN p_status VARCHAR(20)
)
BEGIN
    SELECT id_pedido, id_cliente, data_pedido, valor_total
    FROM pedidos
    WHERE status = p_status;
END //

DELIMITER ;

-- Teste:
CALL buscar_pedidos_por_status('pendente');


3. Inserir nova categoria (Parâmetros IN)

DROP PROCEDURE IF EXISTS inserir_categoria;
DELIMITER //

CREATE PROCEDURE inserir_categoria(
    IN p_nome VARCHAR(100),
    IN p_descricao TEXT
)
BEGIN
    INSERT INTO categorias (nome, descricao)
    VALUES (p_nome, p_descricao);
END //

DELIMITER ;

-- Teste:
CALL inserir_categoria('Acessórios', 'Cabos, adaptadores e suportes');


4. Atualizar telefone do cliente (Parâmetros IN)
   
DROP PROCEDURE IF EXISTS atualizar_telefone_cliente;
DELIMITER //

CREATE PROCEDURE atualizar_telefone_cliente(
    IN p_id_cliente INT,
    IN p_telefone VARCHAR(15)
)
BEGIN
    UPDATE clientes
    SET telefone = p_telefone
    WHERE id_cliente = p_id_cliente;
END //

DELIMITER ;

-- Teste:
CALL atualizar_telefone_cliente(1, '11999998888');


5. Contar produtos por categoria (Parâmetros IN e OUT)

DROP PROCEDURE IF EXISTS contar_produtos_categoria;
DELIMITER //

CREATE PROCEDURE contar_produtos_categoria(
    IN p_id_categoria INT,
    OUT p_total INT
)
BEGIN
    SELECT COUNT(id_produto)
    INTO p_total
    FROM produtos
    WHERE id_categoria = p_id_categoria;
END //

DELIMITER ;

-- Teste:
CALL contar_produtos_categoria(3, @total_produtos);
SELECT @total_produtos 
AS quantidade_produtos;

🛠️ Tecnologias Utilizadas
MySQL 8.0+

MySQL Workbench
