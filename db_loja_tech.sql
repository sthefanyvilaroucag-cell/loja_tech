USE loja_tech;
-- ------------------------------------------------------------
-- TABELA: categorias
-- Agrupa os produtos (ex: Notebooks, Smartphones, Periféricos)
-- ------------------------------------------------------------
CREATE TABLE categorias (
id_categoria INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
descricao TEXT,
ativo BOOLEAN DEFAULT TRUE,
criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- ------------------------------------------------------------
-- TABELA: produtos
-- Catálogo de produtos à venda
-- ------------------------------------------------------------
CREATE TABLE produtos (
id_produto INT AUTO_INCREMENT PRIMARY KEY,
id_categoria INT NOT NULL,
nome VARCHAR(200) NOT NULL,
descricao TEXT,
preco DECIMAL(10,2) NOT NULL,
estoque INT NOT NULL DEFAULT 0,
estoque_minimo INT NOT NULL DEFAULT 5,
ativo BOOLEAN DEFAULT TRUE,
criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE
CURRENT_TIMESTAMP,
CONSTRAINT fk_produto_categoria
FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);
-- ------------------------------------------------------------
-- TABELA: clientes
-- Cadastro de clientes da loja

-- ------------------------------------------------------------
CREATE TABLE clientes (
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
email VARCHAR(200) NOT NULL UNIQUE,
cpf CHAR(11) NOT NULL UNIQUE,
telefone VARCHAR(15),
data_nascimento DATE,
ativo BOOLEAN DEFAULT TRUE,
criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- ------------------------------------------------------------
-- TABELA: pedidos
-- Registro de pedidos realizados
-- ------------------------------------------------------------
CREATE TABLE pedidos (
id_pedido INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT NOT NULL,
data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
status
ENUM('pendente','processando','enviado','entregue','cancelado')
DEFAULT 'pendente',
valor_total DECIMAL(10,2) DEFAULT 0.00,
observacao TEXT,
criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
atualizado_em DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE
CURRENT_TIMESTAMP,
CONSTRAINT fk_pedido_cliente
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);
-- ------------------------------------------------------------
-- TABELA: itens_pedido
-- Produtos de cada pedido (detalhe)
-- ------------------------------------------------------------
CREATE TABLE itens_pedido (
id_item INT AUTO_INCREMENT PRIMARY KEY,
id_pedido INT NOT NULL,
id_produto INT NOT NULL,
quantidade INT NOT NULL DEFAULT 1,
preco_unitario DECIMAL(10,2) NOT NULL,
subtotal DECIMAL(10,2) GENERATED ALWAYS AS (quantidade *
preco_unitario) STORED,
CONSTRAINT fk_item_pedido
FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
CONSTRAINT fk_item_produto
FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);
-- ------------------------------------------------------------
-- TABELA: log_operacoes
-- Auditoria de operações realizadas via stored procedures
-- ------------------------------------------------------------
CREATE TABLE log_operacoes (
id_log INT AUTO_INCREMENT PRIMARY KEY,
tabela_afetada VARCHAR(100),
operacao VARCHAR(50),
descricao TEXT,
usuario VARCHAR(100) DEFAULT (CURRENT_USER()),
data_operacao DATETIME DEFAULT CURRENT_TIMESTAMP
);