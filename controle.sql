-- Cria o database controle e utiliza ela
CREATE DATABASE IF NOT EXISTS controle;
USE controle;

CREATE TABLE IF NOT EXISTS Fornecedor (
	id_fornecedor INTEGER NOT NULL PRIMARY KEY,
	cnpj VARCHAR(14) NOT NULL,
    razao_social VARCHAR(45)    
);

CREATE TABLE IF NOT EXISTS Categoria (
	id_categoria INTEGER NOT NULL PRIMARY KEY,
    tipo_categoria VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS Produto (
	id_produto INTEGER NOT NULL PRIMARY KEY,
    nome_produto VARCHAR(45) NOT NULL,
    codigo_produto VARCHAR(45) NOT NULL,
    valor_produto DECIMAL(6,2) NOT NULL,
    quantidade_produto INTEGER,
    disponivel_produto BOOL DEFAULT FALSE,
    imagem_produto VARCHAR(45),
    produto_id_categoria INTEGER NOT NULL,
    FOREIGN KEY (produto_id_categoria) REFERENCES Categoria (id_categoria),
    produto_id_fornecedor INTEGER NOT NULL,
    FOREIGN KEY (produto_id_fornecedor) REFERENCES Fornecedor (id_fornecedor)
);

CREATE TABLE IF NOT EXISTS Cliente (
	id_cliente INTEGER NOT NULL PRIMARY KEY,
    nome_cliente VARCHAR(45),
    cpf_cliente VARCHAR(11),
    data_nascimento_cliente DATE,
    rua_endereco_cliente VARCHAR(45),
    numero_endereco_cliente VARCHAR(7),
    bairro_endereco_cliente VARCHAR(45),
    cep_endreco_cliente VARCHAR(8),
    cidade_endereco_cliente VARCHAR(45),
    estado_endereco_cliente CHAR(2),
    complemento_endereco_cliente VARCHAR(45),
    ddd_telefone_cliente VARCHAR(3),
    numero_telefone_cliente VARCHAR(9)
);

CREATE TABLE IF NOT EXISTS Venda (
	id_venda INTEGER NOT NULL PRIMARY KEY,
    quantidade_venda INTEGER NOT NULL,
    data_venda DATE NOT NULL,
    valor_venda DECIMAL(7,2) NOT NULL,
    venda_id_cliente INTEGER NOT NULL,
    FOREIGN KEY (venda_id_cliente) REFERENCES Cliente (id_cliente)
);

CREATE TABLE IF NOT EXISTS Compra (
	id_compra INTEGER NOT NULL PRIMARY KEY,
    quantidade_compra INTEGER NOT NULL,
    data_compra DATE NOT NULL,
    valor_compra DECIMAL(7,2),
    compra_id_fornecedor INTEGER,
    FOREIGN KEY (compra_id_fornecedor) REFERENCES Fornecedor (id_fornecedor)
);

CREATE TABLE IF NOT EXISTS Venda_Produto (
	venda_id_venda INTEGER NOT NULL,
    produto_id_produto INTEGER NOT NULL,
    valor_venda_produto DECIMAL(11,2) NOT NULL,
    quantidade_venda_produto INTEGER NOT NULL,
    FOREIGN KEY (venda_id_venda) REFERENCES Venda (id_venda),
    FOREIGN KEY (produto_id_produto) REFERENCES Produto (id_produto)
);

CREATE TABLE IF NOT EXISTS Compra_Produto (
	compra_id_compra INTEGER NOT NULL,
    produto_id_produto INTEGER NOT NULL,
    valor_compra_produto DECIMAL(11,2) NOT NULL,
    quantidade_compra_produto INTEGER NOT NULL,
    FOREIGN KEY (compra_id_compra) REFERENCES Compra (id_compra),
    FOREIGN KEY (produto_id_produto) REFERENCES Produto (id_produto)
);

INSERT INTO Fornecedor (id_fornecedor,
                        cnpj,
                        razao_social) VALUES
(1, '80600947000172', 'Natura'),
(2, '87435219000100', 'Boticario'),
(3, '41675162000107', 'Avon'),
(4, '97614603000115', 'Jequeti');


INSERT INTO Categoria (id_categoria,
                        tipo_categoria) VALUES
(1, 'Perfume'),
(2, 'Maquiagem'),
(3, 'Cabelo'),
(4, 'Pele'),
(5, 'Produto Infantil');


INSERT INTO Produto (id_produto,
                        nome_produto,
                        codigo_produto,
                        valor_produto,
                        quantidade_produto,
                        disponivel_produto,
                        imagem_produto,
                        produto_id_categoria,
                        produto_id_fornecedor) VALUES
(1, 'Perfume Floral', 'PFL123', 100.00, 50, 1, 'imagem_perfume.jpg', 1, 1),
(2, 'Batom Matte', 'BMT456', 25.00, 0, 1, 'imagem_batom.jpg', 2, 2),
(3, 'Shampoo Nutritivo', 'SN789', 30.00, 75, 1, 'imagem_shampoo.jpg', 3, 3),
(4, 'Creme Hidratante Facial', 'CHF567', 50.00, 40, 1, 'imagem_creme.jpg', 4, 4),
(5, 'Sabonete Infantil', 'SBI234', 15.00, 120, 1, 'imagem_sabonete.jpg', 5, 1),
(6, 'Eau de Parfum Amadeirado', 'EDP789', 120.00, 30, 1, 'imagem_perfume_amadeirado.jpg', 1, 2),
(7, 'Paleta de Sombras Neutras', 'PSN567', 50.00, 60, 1, 'imagem_paleta_sombras.jpg', 2, 3),
(8, 'Condicionador Reparador', 'CR123', 35.00, 80, 1, 'imagem_condicionador.jpg', 3, 4),
(9, 'Sérum Antienvelhecimento', 'SEA456', 75.00, 25, 1, 'imagem_serum.jpg', 4, 1),
(10, 'Kit Shampoo e Condicionador Infantil', 'KSCI789', 18.00, 90, 1, 'imagem_kit_infantil.jpg', 5, 2);


INSERT INTO Cliente (id_cliente,
                        nome_cliente,
                        cpf_cliente,
                        data_nascimento_cliente,
                        rua_endereco_cliente,
                        numero_endereco_cliente,
                        bairro_endereco_cliente,
                        cep_endreco_cliente,
                        cidade_endereco_cliente,
                        estado_endereco_cliente,
                        complemento_endereco_cliente,
                        ddd_telefone_cliente,
                        numero_telefone_cliente) VALUES
(1, 'Maria Silva', '12345678901', '1990-05-15', 'Rua Flores', '123', 'Centro', '12345678', 'Cidade A', 'SP', 'Apto 101', '11', '987654321'),
(2, 'José Oliveira', '98765432102', '1985-08-20', 'Avenida Principal', '456', 'Bairro Verde', '54321876', 'Cidade B', 'MG', 'Casa 202', '21', '999876543'),
(3, 'Ana Souza', '45678901203', '1995-02-10', 'Rua das Palmeiras', '789', 'Jardim Azul', '98765432', 'Cidade C', 'SP', 'Bloco B', '31', '987654123'),
(4, 'Carlos Santos', '32165498704', '1980-11-25', 'Travessa das Ruas', '101', 'Vila Amarela', '87654321', 'Cidade D', 'MG', 'Casa 55', '41', '999123456'),
(5, 'Juliana Lima', '78901234505', '1998-07-03', 'Alameda das Praias', '234', 'Praia do Sol', '23456789', 'Cidade E', 'RJ', 'Apartamento 303', '51', '998765432');


INSERT INTO Venda (id_venda,
                        quantidade_venda,
                        data_venda,
                        valor_venda,
                        venda_id_cliente) VALUES
(1, 3, '2023-10-05', 150.00, 1),
(2, 2, '2023-09-20', 90.50, 2),
(3, 5, '2023-11-02', 220.75, 3);


INSERT INTO Compra (id_compra,
                        quantidade_compra,
                        data_compra,
                        valor_compra,
                        compra_id_fornecedor) VALUES
(1, 100, '2023-10-10', 1000.00, 1),
(2, 50, '2023-09-25', 500.50, 2),
(3, 75, '2023-11-05', 750.75, 3);


INSERT INTO Venda_Produto (venda_id_venda,
                            produto_id_produto,
                            valor_venda_produto,
                            quantidade_venda_produto) VALUES
(1, 1, 20.00, 1),
(1, 2, 30.00, 2),
(2, 3, 40.25, 1),
(3, 4, 30.00, 3),
(3, 5, 60.75, 2);


INSERT INTO Compra_Produto (compra_id_compra,
                            produto_id_produto,
                            valor_compra_produto,
                            quantidade_compra_produto) VALUES
(1, 1, 9.00, 50),
(1, 2, 15.50, 25),
(2, 3, 12.00, 30),
(2, 4, 29.50, 15),
(3, 5, 18.75, 25);

INSERT INTO Venda (id_venda, quantidade_venda, data_venda, valor_venda, venda_id_cliente)
SELECT 4, SUM(vp.quantidade_venda_produto), CURDATE(), SUM(vp.quantidade_venda_produto * p.valor_produto), 1
FROM Venda_Produto vp
JOIN Produto p ON vp.produto_id_produto = p.id_produto;


SELECT 
    Cliente.nome_cliente, 
    Produto.nome_produto, 
    Venda_Produto.valor_venda_produto
FROM 
    Cliente
JOIN 
    Venda ON Cliente.id_cliente = Venda.venda_id_cliente
JOIN 
    Venda_Produto ON Venda.id_venda = Venda_Produto.venda_id_venda
JOIN 
    Produto ON Produto.id_produto = Venda_Produto.produto_id_produto;


SELECT nome_produto FROM Produto WHERE disponivel_produto = 1;

UPDATE Produto SET disponivel_produto = 0 WHERE id_produto = 5;

SELECT nome_produto FROM Produto WHERE disponivel_produto = 0;

SELECT nome_produto, valor_produto, valor_produto * 0.10 FROM Produto;

SELECT nome_cliente, cpf_cliente, data_nascimento_cliente, ddd_telefone_cliente, numero_telefone_cliente FROM Cliente WHERE nome_cliente LIKE '%Lima';

SELECT nome_produto, valor_produto, quantidade_produto FROM Produto WHERE valor_produto > 50 AND valor_produto < 200;

SELECT nome_produto, valor_produto, quantidade_produto FROM Produto WHERE produto_id_categoria = 2;

SELECT nome_cliente, cidade_endereco_cliente FROM Cliente WHERE estado_endereco_cliente = 'MG';

SELECT nome_produto AS 'produto'
FROM Produto
INNER JOIN Categoria ON produto_id_categoria = id_categoria
WHERE tipo_categoria = 'perfume';

SELECT SUM(valor_venda) AS 'valor total'
FROM Venda
INNER JOIN Venda_Produto ON venda_id_venda = id_venda
INNER JOIN Produto ON produto_id_produto = id_produto
INNER JOIN Categoria ON produto_id_categoria = id_categoria
WHERE tipo_categoria = 'maquiagem';

SELECT nome_produto, data_compra 
FROM produto
INNER JOIN Compra_Produto ON produto_id_produto = id_produto
INNER JOIN Compra ON compra_id_compra = id_compra
WHERE quantidade_produto = 0;

SELECT (v.valor_venda) AS 'Quantidade Vendida', f.razao_social AS 'Fornecedor'
FROM Venda AS v 
INNER JOIN Venda_Produto AS vp ON vp.venda_id_venda = v.id_venda
INNER JOIN Produto AS p ON vp.produto_id_produto = p.id_produto
INNER JOIN Fornecedor as f ON p.produto_id_fornecedor = f.id_fornecedor;