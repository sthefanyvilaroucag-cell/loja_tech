use loja_tech;

-- ----- 10 pesquisas ----- --

select nome, email 
from clientes;

select nome, preco 
from produtos 
where preco < 500.00;

select * from pedidos 
where status = 'pendente';

select nome, preco 
from produtos 
order by preco desc;

select id_produto, nome, preco 
from produtos 
where nome like '%Monitor%';

select nome, estoque 
from produtos 
where id_categoria = 3 
  and estoque > 40;
  
select count(id_cliente) as total_clientes 
from clientes;

select sum(valor_total) as faturamento_bruto
from pedidos;

select produtos.nome, categorias.nome
from produtos
join categorias on produtos.id_categoria = categorias.id_categoria;

select id_pedido, status, valor_total
from pedidos
join clientes on pedidos.id_cliente = clientes.id_cliente
where clientes.nome = 'Ana Silva';

-- ----- Stored Procedures ----- --

-- Procedure sem parâmetros (Consulta simples) --
drop procedure if exists listar_categorias_ativas;
DELIMITER //

create procedure listar_categorias_ativas()
begin
    select id_categoria, nome, descricao
    from categorias
    where ativo = true
    ORDER BY nome asc;
    end //

DELIMITER ;

call listar_categorias_ativas();


-- Procedure com parâmetro IN (Filtro) --

drop procedure if exists buscar_pedidos_por_status;
DELIMITER //

create procedure buscar_pedidos_por_status(
    in p_status varchar(20)
)
begin
    select id_pedido, id_cliente, data_pedido, valor_total
    from pedidos
    where status = p_status;
end //

DELIMITER ;

call buscar_pedidos_por_status('pendente');


-- Procedure com parâmetros IN (Inserção de dados) --

drop procedure if exists inserir_categoria;
DELIMITER //

create procedure inserir_categoria(
    in p_nome varchar(100),
    in p_descricao text
)
begin
    insert into categorias (nome, descricao)
    values (p_nome, p_descricao);
end //

DELIMITER ;

call inserir_categoria('Acessórios', 'Cabos, adaptadores e suportes');
select * from categorias;


-- Procedure com parâmetros IN (Atualização de dados) --

drop procedure if exists atualizar_telefone_cliente;
DELIMITER //

create procedure atualizar_telefone_cliente(
    in p_id_cliente int,
    in p_telefone varchar(15)
)
begin
    update clientes
    set telefone = p_telefone
    where id_cliente = p_id_cliente;
end //

DELIMITER ;

call atualizar_telefone_cliente(1, '11999998888');
select id_cliente, nome, telefone from clientes where id_cliente = 1;

-- Procedure com parâmetros IN e OUT (Contagem) --

drop procedure if exists contar_produtos_categoria;
DELIMITER //

create procedure contar_produtos_categoria(
    in p_id_categoria int,
    out p_total int
)
begin
    select COUNT(*)
    into p_total
    from produtos
    where id_categoria = p_id_categoria;
end //

DELIMITER ;

call contar_produtos_categoria(3, @total_produtos);
select @total_produtos as quantidade_produtos;