-- --------------------------------------------------------
-- Servidor:                     mutant.mysql.dbaas.com.br
-- Versão do servidor:           5.7.17-13-log - Percona Server (GPL), Release 13, Revision fd33d43
-- OS do Servidor:               Linux
-- HeidiSQL Versão:              11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para mutant
CREATE DATABASE IF NOT EXISTS `mutant` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci */;
USE `mutant`;

-- Copiando estrutura para tabela mutant.countryInfo
CREATE TABLE IF NOT EXISTS `countryInfo` (
  `ISOCode` char(2) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Código ISO país',
  `name` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Nome do país',
  `capitalCity` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Nome da capital',
  `phoneCode` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Código telefonico DDI',
  `continentalCode` char(2) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Código do continente',
  `currencyISOCode` char(3) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Código ISo da moeda',
  `countryFlag` varchar(300) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'URL de imagem da bandeira',
  PRIMARY KEY (`ISOCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Informações gerais de países';

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela mutant.countryLanguages
CREATE TABLE IF NOT EXISTS `countryLanguages` (
  `languageISOCode` char(3) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Código ISO da linguagem',
  `countryISOCode` char(2) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Código ISO do país',
  `name` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Nome da linguagem',
  KEY `language_country` (`countryISOCode`),
  CONSTRAINT `language_country` FOREIGN KEY (`countryISOCode`) REFERENCES `countryInfo` (`ISOCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Linguagens praticadas pelo país';

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela mutant.userAddress
CREATE TABLE IF NOT EXISTS `userAddress` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Chave primária',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Chave do usuário',
  `street` varchar(100) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Nome do logradouro',
  `suite` varchar(20) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Apartamento ou suite',
  `city` varchar(50) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Nome da cidade',
  `zipCode` varchar(15) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Código de postagem',
  `geoLat` varchar(15) COLLATE latin1_general_ci NOT NULL DEFAULT '0.000000' COMMENT 'Latitude posição GPS',
  `geoLng` varchar(15) COLLATE latin1_general_ci NOT NULL DEFAULT '0.000000' COMMENT 'Logitude posição GPS',
  PRIMARY KEY (`id`),
  KEY `user_address` (`userId`),
  CONSTRAINT `user_address` FOREIGN KEY (`userId`) REFERENCES `userInfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Endereços do usuário';

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela mutant.userCompany
CREATE TABLE IF NOT EXISTS `userCompany` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Chave primária',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Chave do usuário',
  `name` varchar(100) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Nome da empresa',
  `catchPhrase` varchar(200) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Frase de efeito',
  `bs` varchar(500) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Palavras chave',
  PRIMARY KEY (`id`),
  KEY `company_user` (`userId`),
  CONSTRAINT `company_user` FOREIGN KEY (`userId`) REFERENCES `userInfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Dados de empresas relacionadas';

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela mutant.userContact
CREATE TABLE IF NOT EXISTS `userContact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Chave primária',
  `userId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Chave do usuário',
  `email` varchar(100) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Endereço de e-mail',
  `phone` varchar(30) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Telefone',
  `website` varchar(150) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'URL website',
  PRIMARY KEY (`id`),
  KEY `contact_user` (`userId`),
  CONSTRAINT `contact_user` FOREIGN KEY (`userId`) REFERENCES `userInfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Dados de contato do usuário';

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela mutant.userInfo
CREATE TABLE IF NOT EXISTS `userInfo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Chave primária',
  `name` varchar(100) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Nome do usuário',
  `username` varchar(20) COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Identificação de conexão',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Dados do usuário';

-- Exportação de dados foi desmarcado.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
