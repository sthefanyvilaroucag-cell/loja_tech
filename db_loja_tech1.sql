-- ============================================================
-- CARGA DE DADOS INICIAIS
-- ============================================================
INSERT INTO categorias (nome, descricao) VALUES
('Notebooks', 'Notebooks e laptops'),
('Smartphones', 'Celulares e smartphones'),
('Periféricos', 'Teclados, mouses, headsets'),
('Monitores', 'Monitores e telas'),

('Armazenamento','HDs, SSDs e pen drives');
INSERT INTO produtos (id_categoria, nome, preco, estoque, estoque_minimo) VALUES
(1, 'Notebook Dell Inspiron 15', 3499.90, 25, 5),
(1, 'Notebook Lenovo IdeaPad 3', 2899.00, 18, 5),
(2, 'Samsung Galaxy S24', 4299.00, 40, 10),
(2, 'iPhone 15', 6499.00, 15, 5),
(3, 'Teclado Mecânico Redragon', 249.90, 60, 10),
(3, 'Mouse Logitech G502', 349.90, 45, 10),
(3, 'Headset HyperX Cloud II', 499.90, 30, 8),
(4, 'Monitor LG UltraWide 29"', 1599.00, 12, 3),
(4, 'Monitor Samsung Curvo 27"', 1899.00, 10, 3),
(5, 'SSD Kingston 480GB', 219.90, 80, 15),
(5, 'HD Externo Seagate 1TB', 329.90, 35, 8);
INSERT INTO clientes (nome, email, cpf, telefone, data_nascimento) VALUES
('Ana Silva', 'ana.silva@email.com', '12345678901', '11987654321',
'1995-03-15'),
('Bruno Oliveira', 'bruno.oliveira@email.com', '23456789012', '11976543210',
'1990-07-22'),
('Carla Santos', 'carla.santos@email.com', '34567890123', '21965432109',
'1988-11-08'),
('Daniel Costa', 'daniel.costa@email.com', '45678901234', '31954321098',
'2000-01-30'),
('Elena Ferreira', 'elena.ferreira@email.com', '56789012345', '41943210987',
'1998-06-12');
INSERT INTO pedidos (id_cliente, status, valor_total) VALUES
(1, 'entregue', 3749.80),
(2, 'enviado', 4299.00),
(3, 'pendente', 1099.70),
(1, 'processando', 6499.00),
(4, 'cancelado', 249.90);
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario)
VALUES
(1, 1, 1, 3499.90),
(1, 5, 1, 249.90),
(2, 3, 1, 4299.00),
(3, 6, 1, 349.90),
(3, 5, 3, 249.90),
(4, 4, 1, 6499.00),
(5, 5, 1, 249.90);