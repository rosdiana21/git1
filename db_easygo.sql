-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u8
-- http://www.phpmyadmin.net
--
-- Host: 192.168.210.235:3306
-- Generation Time: Oct 31, 2017 at 06:45 PM
-- Server version: 5.5.57
-- PHP Version: 5.4.45-0+deb7u11

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db_easygo`
--

-- --------------------------------------------------------

--
-- Table structure for table `akun`
--

CREATE TABLE IF NOT EXISTS `akun` (
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `level` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `akun`
--

INSERT INTO `akun` (`username`, `password`, `level`) VALUES
('cin', 'cin', 1),
('ferra', 'ferra', 2),
('haswan', 'haswan', 2),
('ros', 'ros', 1);

-- --------------------------------------------------------

--
-- Table structure for table `car`
--

CREATE TABLE IF NOT EXISTS `car` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plat` varchar(45) DEFAULT NULL,
  `merk` varchar(45) DEFAULT NULL,
  `kapasitas` varchar(45) DEFAULT NULL,
  `desc` varchar(45) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `customer_akun_username` varchar(45) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `owner_akun_username` varchar(45) NOT NULL,
  PRIMARY KEY (`id`,`customer_id`,`customer_akun_username`,`owner_id`,`owner_akun_username`),
  KEY `fk_car_customer1_idx` (`customer_id`,`customer_akun_username`),
  KEY `fk_car_owner1_idx` (`owner_id`,`owner_akun_username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email_cstm` varchar(45) NOT NULL,
  `nama_cstm` varchar(45) NOT NULL,
  `alamat_cstm` varchar(45) DEFAULT NULL,
  `akun_username` varchar(45) NOT NULL,
  PRIMARY KEY (`id`,`akun_username`),
  KEY `fk_customer_akun1_idx` (`akun_username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `email_cstm`, `nama_cstm`, `alamat_cstm`, `akun_username`) VALUES
(1, 'h.kaze@gmail.com', 'Hasbullah Marwan', 'Jl. Bontobilla No. 1', 'haswan'),
(2, 'ferraandriani@gmail.com', 'Ferra Andriani', 'Workshop', 'ferra');

-- --------------------------------------------------------

--
-- Table structure for table `owner`
--

CREATE TABLE IF NOT EXISTS `owner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email_owner` varchar(45) NOT NULL,
  `nama_owner` varchar(45) NOT NULL,
  `alamat_owner` varchar(45) DEFAULT NULL,
  `akun_username` varchar(45) NOT NULL,
  PRIMARY KEY (`id`,`akun_username`),
  KEY `fk_owner_akun1_idx` (`akun_username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `owner`
--

INSERT INTO `owner` (`id`, `email_owner`, `nama_owner`, `alamat_owner`, `akun_username`) VALUES
(1, 'riyanti.cindy@gmail.com', 'Cindy Riyanti', 'Perumnas Sudiang', 'cin'),
(2, 'r@gmail.com', 'Rosdiana', 'Nusa Harapan Permai', 'ros');

-- --------------------------------------------------------

--
-- Table structure for table `trayek`
--

CREATE TABLE IF NOT EXISTS `trayek` (
  `id` int(11) NOT NULL,
  `daerah_asal` varchar(45) DEFAULT NULL,
  `daerah_tujuan` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `trayek_has_car`
--

CREATE TABLE IF NOT EXISTS `trayek_has_car` (
  `trayek_id` int(11) NOT NULL,
  `car_id` int(11) NOT NULL,
  `car_customer_id` int(11) NOT NULL,
  `car_owner_id` int(11) NOT NULL,
  `lokasi` varchar(45) DEFAULT NULL,
  `jam` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`trayek_id`,`car_id`,`car_customer_id`,`car_owner_id`),
  KEY `fk_trayek_has_car_car1_idx` (`car_id`,`car_customer_id`,`car_owner_id`),
  KEY `fk_trayek_has_car_trayek1_idx` (`trayek_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `car`
--
ALTER TABLE `car`
  ADD CONSTRAINT `fk_car_customer1` FOREIGN KEY (`customer_id`, `customer_akun_username`) REFERENCES `customer` (`id`, `akun_username`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_car_owner1` FOREIGN KEY (`owner_id`, `owner_akun_username`) REFERENCES `owner` (`id`, `akun_username`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `fk_customer_akun1` FOREIGN KEY (`akun_username`) REFERENCES `akun` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `owner`
--
ALTER TABLE `owner`
  ADD CONSTRAINT `fk_owner_akun1` FOREIGN KEY (`akun_username`) REFERENCES `akun` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `trayek_has_car`
--
ALTER TABLE `trayek_has_car`
  ADD CONSTRAINT `fk_trayek_has_car_trayek1` FOREIGN KEY (`trayek_id`) REFERENCES `trayek` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_trayek_has_car_car1` FOREIGN KEY (`car_id`) REFERENCES `car` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
