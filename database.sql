-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 09, 2015 at 01:38 AM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cv_manager`
--

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE IF NOT EXISTS `companies` (
`companyID` int(11) NOT NULL,
  `companyName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from` int(10) NOT NULL,
  `until` int(10) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`companyID`, `companyName`, `from`, `until`) VALUES
(3, 'Alexus Art Agency', 1351724400, 1398895200);

-- --------------------------------------------------------

--
-- Table structure for table `cvs`
--

CREATE TABLE IF NOT EXISTS `cvs` (
`cvID` int(11) NOT NULL,
  `personID` int(11) NOT NULL,
  `dateline` int(10) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cvs`
--

INSERT INTO `cvs` (`cvID`, `personID`, `dateline`) VALUES
(3, 3, 1420763638),
(4, 4, 1420763696);

-- --------------------------------------------------------

--
-- Table structure for table `institutions`
--

CREATE TABLE IF NOT EXISTS `institutions` (
`institutionID` int(11) NOT NULL,
  `institutionName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `period` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `institutions`
--

INSERT INTO `institutions` (`institutionID`, `institutionName`, `period`) VALUES
(5, 'Liceul+Emil+Racovi%C8%9B%C4%83', '2008-2012'),
(6, 'UAIC+Info', '2012-2014');

-- --------------------------------------------------------

--
-- Table structure for table `persons`
--

CREATE TABLE IF NOT EXISTS `persons` (
`personID` int(11) NOT NULL,
  `personName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthdate` int(10) NOT NULL,
  `hobbies` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `institutions` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `companies` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `persons`
--

INSERT INTO `persons` (`personID`, `personName`, `phone`, `location`, `birthdate`, `hobbies`, `institutions`, `companies`) VALUES
(3, 'Edi+Duluman', '0748 891 241', 'Vaslui', 765496800, '%5B%22%5Cu00cennot%22%2C%22Tenis%22%5D', '5,6', '3'),
(4, 'Test', '0123456789', 'Ia%C8%99i%2C+Rom%C3%A2nia', 480380400, '%5B%5D', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
 ADD PRIMARY KEY (`companyID`);

--
-- Indexes for table `cvs`
--
ALTER TABLE `cvs`
 ADD PRIMARY KEY (`cvID`);

--
-- Indexes for table `institutions`
--
ALTER TABLE `institutions`
 ADD PRIMARY KEY (`institutionID`);

--
-- Indexes for table `persons`
--
ALTER TABLE `persons`
 ADD PRIMARY KEY (`personID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
MODIFY `companyID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `cvs`
--
ALTER TABLE `cvs`
MODIFY `cvID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `institutions`
--
ALTER TABLE `institutions`
MODIFY `institutionID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `persons`
--
ALTER TABLE `persons`
MODIFY `personID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
