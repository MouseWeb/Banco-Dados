-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 04-Maio-2018 às 01:30
-- Versão do servidor: 10.1.30-MariaDB
-- PHP Version: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fgv`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbl_relatos`
--

CREATE TABLE `tbl_relatos` (
  `idrelato` int(11) NOT NULL,
  `rel_marca` varchar(100) NOT NULL,
  `rel_nome` varchar(100) NOT NULL,
  `rel_dosagem` varchar(100) NOT NULL,
  `rel_qd_med_ini` datetime NOT NULL,
  `rel_qd_med_inter` datetime NOT NULL,
  `rel_descricao` varchar(100) NOT NULL,
  `rel_gravidade` varchar(100) NOT NULL,
  `rel_edv_desap` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tbl_relatos`
--

INSERT INTO `tbl_relatos` (`idrelato`, `rel_marca`, `rel_nome`, `rel_dosagem`, `rel_qd_med_ini`, `rel_qd_med_inter`, `rel_descricao`, `rel_gravidade`, `rel_edv_desap`) VALUES
(2, 'marca', 'nome', 'dosagem', '2018-05-01 00:00:00', '2018-05-02 00:00:00', 'descricao', 'gravidade', '1'),
(3, 'MARCA', 'MAR_NOME', 'DOSAGEM', '2018-04-01 00:00:00', '2018-04-30 00:00:00', 'DESC', 'GRAVIDADE', 'D');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tbl_usuarios`
--

CREATE TABLE `tbl_usuarios` (
  `idusuario` int(11) NOT NULL,
  `usu_nome` varchar(100) NOT NULL,
  `usu_login` varchar(50) NOT NULL,
  `usu_senha` varchar(50) DEFAULT NULL,
  `usu_telefone` varchar(20) NOT NULL,
  `usu_email` varchar(50) NOT NULL,
  `usu_logradouro` varchar(100) NOT NULL,
  `usu_bairro` varchar(100) NOT NULL,
  `usu_cidade` varchar(100) NOT NULL,
  `usu_cep` varchar(20) NOT NULL,
  `usu_estado` varchar(100) NOT NULL,
  `usu_num` varchar(50) NOT NULL,
  `usu_complemento` varchar(100) DEFAULT NULL,
  `usu_nivel` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `tbl_usuarios`
--

INSERT INTO `tbl_usuarios` (`idusuario`, `usu_nome`, `usu_login`, `usu_senha`, `usu_telefone`, `usu_email`, `usu_logradouro`, `usu_bairro`, `usu_cidade`, `usu_cep`, `usu_estado`, `usu_num`, `usu_complemento`, `usu_nivel`) VALUES
(1, 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'A'),
(3, 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'M'),
(4, 'NOME', 'LOGIN', 'SENHA', 'TEL', 'EMAIL', 'LOGRADOURO', 'BAIRRO', 'CIDADE', 'CEP', 'ESTADO', 'NUM', 'COMPL.', 'A');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_relatos`
--
ALTER TABLE `tbl_relatos`
  ADD PRIMARY KEY (`idrelato`);

--
-- Indexes for table `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  ADD PRIMARY KEY (`idusuario`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_relatos`
--
ALTER TABLE `tbl_relatos`
  MODIFY `idrelato` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_usuarios`
--
ALTER TABLE `tbl_usuarios`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
