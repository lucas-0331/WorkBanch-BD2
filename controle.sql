-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema controle
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema controle
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `controle` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `controle` ;

-- -----------------------------------------------------
-- Table `controle`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle`.`Categoria` (
  `id_categoria` INT NOT NULL,
  `tipo_categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `controle`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle`.`Cliente` (
  `id_cliente` INT NOT NULL,
  `nome_cliente` VARCHAR(45) NULL DEFAULT NULL,
  `cpf_cliente` VARCHAR(11) NULL DEFAULT NULL,
  `data_nascimento_cliente` DATE NULL DEFAULT NULL,
  `rua_endereco_cliente` VARCHAR(45) NULL DEFAULT NULL,
  `numero_endereco_cliente` VARCHAR(7) NULL DEFAULT NULL,
  `bairro_endereco_cliente` VARCHAR(45) NULL DEFAULT NULL,
  `cep_endreco_cliente` VARCHAR(8) NULL DEFAULT NULL,
  `cidade_endereco_cliente` VARCHAR(45) NULL DEFAULT NULL,
  `estado_endereco_cliente` CHAR(2) NULL DEFAULT NULL,
  `complemento_endereco_cliente` VARCHAR(45) NULL DEFAULT NULL,
  `ddd_telefone_cliente` VARCHAR(3) NULL DEFAULT NULL,
  `numero_telefone_cliente` VARCHAR(9) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `controle`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle`.`Fornecedor` (
  `id_fornecedor` INT NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  `razao_social` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_fornecedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `controle`.`Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle`.`Compra` (
  `id_compra` INT NOT NULL,
  `quantidade_compra` INT NOT NULL,
  `data_compra` DATE NOT NULL,
  `valor_compra` DECIMAL(7,2) NULL DEFAULT NULL,
  `compra_id_fornecedor` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_compra`),
  INDEX `compra_id_fornecedor` (`compra_id_fornecedor` ASC) VISIBLE,
  CONSTRAINT `Compra_ibfk_1`
    FOREIGN KEY (`compra_id_fornecedor`)
    REFERENCES `controle`.`Fornecedor` (`id_fornecedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `controle`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle`.`Produto` (
  `id_produto` INT NOT NULL,
  `nome_produto` VARCHAR(45) NOT NULL,
  `codigo_produto` VARCHAR(45) NOT NULL,
  `valor_produto` DECIMAL(6,2) NOT NULL,
  `quantidade_produto` INT NULL DEFAULT NULL,
  `disponivel_produto` TINYINT(1) NULL DEFAULT '0',
  `imagem_produto` VARCHAR(45) NULL DEFAULT NULL,
  `produto_id_categoria` INT NOT NULL,
  PRIMARY KEY (`id_produto`),
  INDEX `produto_id_categoria` (`produto_id_categoria` ASC) VISIBLE,
  CONSTRAINT `Produto_ibfk_1`
    FOREIGN KEY (`produto_id_categoria`)
    REFERENCES `controle`.`Categoria` (`id_categoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `controle`.`Compra_Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle`.`Compra_Produto` (
  `compra_id_compra` INT NOT NULL,
  `produto_id_produto` INT NOT NULL,
  `valor_compra_produto` DECIMAL(11,2) NOT NULL,
  `quantidade_compra_produto` INT NOT NULL,
  INDEX `compra_id_compra` (`compra_id_compra` ASC) VISIBLE,
  INDEX `produto_id_produto` (`produto_id_produto` ASC) VISIBLE,
  CONSTRAINT `Compra_Produto_ibfk_1`
    FOREIGN KEY (`compra_id_compra`)
    REFERENCES `controle`.`Compra` (`id_compra`),
  CONSTRAINT `Compra_Produto_ibfk_2`
    FOREIGN KEY (`produto_id_produto`)
    REFERENCES `controle`.`Produto` (`id_produto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `controle`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle`.`Venda` (
  `id_venda` INT NOT NULL,
  `quantidade_venda` INT NOT NULL,
  `data_venda` DATE NOT NULL,
  `valor_venda` DECIMAL(7,2) NOT NULL,
  `venda_id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_venda`),
  INDEX `venda_id_cliente` (`venda_id_cliente` ASC) VISIBLE,
  CONSTRAINT `Venda_ibfk_1`
    FOREIGN KEY (`venda_id_cliente`)
    REFERENCES `controle`.`Cliente` (`id_cliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `controle`.`Venda_Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `controle`.`Venda_Produto` (
  `venda_id_venda` INT NOT NULL,
  `produto_id_produto` INT NOT NULL,
  `valor_venda_produto` DECIMAL(11,2) NOT NULL,
  `quantidade_venda_produto` INT NOT NULL,
  INDEX `venda_id_venda` (`venda_id_venda` ASC) VISIBLE,
  INDEX `produto_id_produto` (`produto_id_produto` ASC) VISIBLE,
  CONSTRAINT `Venda_Produto_ibfk_1`
    FOREIGN KEY (`venda_id_venda`)
    REFERENCES `controle`.`Venda` (`id_venda`),
  CONSTRAINT `Venda_Produto_ibfk_2`
    FOREIGN KEY (`produto_id_produto`)
    REFERENCES `controle`.`Produto` (`id_produto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Populando a tabela Fornecedor
INSERT INTO Fornecedor (id_fornecedor, cnpj, razao_social) VALUES
(1, '12345678901234', 'Fornecedor A'),
(2, '23456789012345', 'Fornecedor B'),
(3, '34567890123456', 'Fornecedor C'),
(4, '45678901234567', 'Fornecedor D'),
(5, '56789012345678', 'Fornecedor E'),
(6, '67890123456789', 'Fornecedor F'),
(7, '78901234567890', 'Fornecedor G'),
(8, '89012345678901', 'Fornecedor H'),
(9, '90123456789012', 'Fornecedor I'),
(10, '01234567890123', 'Fornecedor J'),
(11, '98765432109876', 'Fornecedor K'),
(12, '87654321098765', 'Fornecedor L'),
(13, '76543210987654', 'Fornecedor M'),
(14, '65432109876543', 'Fornecedor N'),
(15, '54321098765432', 'Fornecedor O');

-- Populando a tabela Produto
INSERT INTO Produto (id_produto, nome_produto, codigo_produto, valor_produto, quantidade_produto, disponivel_produto, imagem_produto, produto_id_categoria) VALUES
(1, 'Produto A', 'ABC123', 10.99, 100, 1, 'imagem_produto_A.jpg', 1),
(2, 'Produto B', 'DEF456', 20.49, 75, 1, 'imagem_produto_B.jpg', 1),
(3, 'Produto C', 'GHI789', 15.29, 120, 1, 'imagem_produto_C.jpg', 2),
(4, 'Produto D', 'JKL012', 30.99, 50, 1, 'imagem_produto_D.jpg', 2),
(5, 'Produto E', 'MNO345', 25.79, 90, 1, 'imagem_produto_E.jpg', 3),
(6, 'Produto F', 'PQR678', 12.99, 110, 1, 'imagem_produto_F.jpg', 3),
(7, 'Produto G', 'STU901', 18.49, 80, 1, 'imagem_produto_G.jpg', 4),
(8, 'Produto H', 'VWX234', 22.99, 65, 1, 'imagem_produto_H.jpg', 4),
(9, 'Produto I', 'YZA567', 28.99, 55, 1, 'imagem_produto_I.jpg', 5),
(10, 'Produto J', 'BCD890', 14.99, 85, 1, 'imagem_produto_J.jpg', 5),
(11, 'Produto K', 'EFG123', 19.99, 70, 1, 'imagem_produto_K.jpg', 1),
(12, 'Produto L', 'HIJ456', 23.49, 60, 1, 'imagem_produto_L.jpg', 1),
(13, 'Produto M', 'KLM789', 32.29, 45, 1, 'imagem_produto_M.jpg', 2),
(14, 'Produto N', 'OPQ012', 27.99, 95, 1, 'imagem_produto_N.jpg', 2),
(15, 'Produto O', 'RST345', 11.79, 105, 1, 'imagem_produto_O.jpg', 3),
(16, 'Produto P', 'UVW678', 17.99, 75, 1, 'imagem_produto_P.jpg', 3),
(17, 'Produto Q', 'XYZ901', 21.49, 80, 1, 'imagem_produto_Q.jpg', 4),
(18, 'Produto R', 'ABC234', 26.99, 70, 1, 'imagem_produto_R.jpg', 4),
(19, 'Produto S', 'DEF567', 29.99, 65, 1, 'imagem_produto_S.jpg', 5),
(20, 'Produto T', 'GHI890', 13.99, 90, 1, 'imagem_produto_T.jpg', 5),
(21, 'Produto U', 'JKL123', 16.49, 85, 1, 'imagem_produto_U.jpg', 1),
(22, 'Produto V', 'MNO456', 31.29, 50, 1, 'imagem_produto_V.jpg', 1),
(23, 'Produto W', 'PQR789', 20.99, 75, 1, 'imagem_produto_W.jpg', 2),
(24, 'Produto X', 'STU012', 24.49, 60, 1, 'imagem_produto_X.jpg', 2),
(25, 'Produto Y', 'VWX345', 33.29, 40, 1, 'imagem_produto_Y.jpg', 3),
(26, 'Produto Z', 'YZA678', 28.99, 55, 1, 'imagem_produto_Z.jpg', 3),
(27, 'Produto AA', 'BCD901', 12.79, 95, 1, 'imagem_produto_AA.jpg', 4),
(28, 'Produto BB', 'EFG234', 18.99, 80, 1, 'imagem_produto_BB.jpg', 4),
(29, 'Produto CC', 'HIJ567', 22.49, 70, 1, 'imagem_produto_CC.jpg', 5),
(30, 'Produto DD', 'KLM890', 30.29, 45, 1, 'imagem_produto_DD.jpg', 5),
(31, 'Produto EE', 'OPQ123', 15.99, 85, 1, 'imagem_produto_EE.jpg', 1),
(32, 'Produto FF', 'RST456', 19.49, 65, 1, 'imagem_produto_FF.jpg', 1),
(33, 'Produto GG', 'UVW789', 25.29, 60, 1, 'imagem_produto_GG.jpg', 2),
(34, 'Produto HH', 'XYZ012', 32.49, 45, 1, 'imagem_produto_HH.jpg', 2),
(35, 'Produto II', 'ABC345', 27.99, 70, 1, 'imagem_produto_II.jpg', 3),
(36, 'Produto JJ', 'DEF678', 29.99, 65, 1, 'imagem_produto_JJ.jpg', 3),
(37, 'Produto KK', 'GHI901', 13.99, 90, 1, 'imagem_produto_KK.jpg', 4),
(38, 'Produto LL', 'JKL234', 16.49, 85, 1, 'imagem_produto_LL.jpg', 4),
(39, 'Produto MM', 'MNO567', 19.99, 75, 1, 'imagem_produto_MM.jpg', 5),
(40, 'Produto NN', 'PQR890', 32.29, 50, 1, 'imagem_produto_NN.jpg', 5),
(41, 'Produto OO', 'STU123', 21.99, 80, 1, 'imagem_produto_OO.jpg', 1),
(42, 'Produto PP', 'VWX456', 26.49, 70, 1, 'imagem_produto_PP.jpg', 1),
(43, 'Produto QQ', 'YZA789', 28.99, 55, 1, 'imagem_produto_QQ.jpg', 2),
(44, 'Produto RR', 'BCD012', 12.79, 95, 1, 'imagem_produto_RR.jpg', 2),
(45, 'Produto SS', 'EFG345', 18.99, 80, 1, 'imagem_produto_SS.jpg', 3),
(46, 'Produto TT', 'HIJ678', 22.49, 70, 1, 'imagem_produto_TT.jpg', 3),
(47, 'Produto UU', 'KLM901', 30.29, 45, 1, 'imagem_produto_UU.jpg', 4),
(48, 'Produto VV', 'OPQ234', 15.99, 85, 1, 'imagem_produto_VV.jpg', 4),
(49, 'Produto WW', 'RST567', 19.49, 65, 1, 'imagem_produto_WW.jpg', 5),
(50, 'Produto XX', 'UVW890', 25.29, 60, 1, 'imagem_produto_XX.jpg', 5);

-- Populando a tabela Categoria
INSERT INTO Categoria (id_categoria, tipo_categoria) VALUES
(1, 'Eletrônicos'),
(2, 'Roupas'),
(3, 'Acessórios'),
(4, 'Alimentos'),
(5, 'Bebidas'),
(6, 'Casa e Jardim'),
(7, 'Saúde e Beleza'),
(8, 'Livros'),
(9, 'Brinquedos'),
(10, 'Esportes'),
(11, 'Automóveis'),
(12, 'Ferramentas'),
(13, 'Móveis'),
(14, 'Instrumentos Musicais'),
(15, 'Jogos');