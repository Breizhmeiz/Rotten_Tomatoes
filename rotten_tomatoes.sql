-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8081
-- Generation Time: Mar 18, 2022 at 10:05 PM
-- Server version: 5.7.24
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rotten_tomatoes`
--

-- --------------------------------------------------------

--
-- Table structure for table `acteurs`
--

CREATE TABLE `acteurs` (
  `id_film` int(11) NOT NULL,
  `id_personne` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `auteurs`
--

CREATE TABLE `auteurs` (
  `id_film` int(11) NOT NULL,
  `id_personne` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `calendrier`
--

CREATE TABLE `calendrier` (
  `id_date` int(11) NOT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `categorie_public`
--

CREATE TABLE `categorie_public` (
  `id_categorie` int(11) NOT NULL,
  `categorie` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `films`
--

CREATE TABLE `films` (
  `id_film` int(11) NOT NULL,
  `titre` varchar(125) DEFAULT NULL,
  `duree` int(11) DEFAULT NULL,
  `tomatometer_count` int(11) DEFAULT NULL,
  `audience_rating` int(11) DEFAULT NULL,
  `audience_count` int(15) DEFAULT NULL,
  `id_tomatometer_status` int(11) DEFAULT NULL,
  `id_date_sortie` int(11) DEFAULT NULL,
  `id_categorie` int(11) DEFAULT NULL,
  `id_date_stream` int(11) DEFAULT NULL,
  `id_audience_status` int(11) DEFAULT NULL,
  `id_societe_production` int(11) DEFAULT NULL,
  `tomatometer_rating` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `genre_film`
--

CREATE TABLE `genre_film` (
  `id_film` int(11) NOT NULL,
  `id_genre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `note_audience`
--

CREATE TABLE `note_audience` (
  `id_audience` int(11) NOT NULL,
  `label_audience` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `personnes`
--

CREATE TABLE `personnes` (
  `id_personne` int(11) NOT NULL,
  `identite_personne` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `realisateurs`
--

CREATE TABLE `realisateurs` (
  `id_film` int(11) NOT NULL,
  `id_personne` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `societe_production`
--

CREATE TABLE `societe_production` (
  `id_societe` int(11) NOT NULL,
  `nom_societe_production` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tomatometer_status`
--

CREATE TABLE `tomatometer_status` (
  `id_tomatometer_status` int(11) NOT NULL,
  `tomatometer` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `type_genre`
--

CREATE TABLE `type_genre` (
  `id_genre` int(11) NOT NULL,
  `genre` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acteurs`
--
ALTER TABLE `acteurs`
  ADD PRIMARY KEY (`id_film`,`id_personne`),
  ADD KEY `id_personne` (`id_personne`);

--
-- Indexes for table `auteurs`
--
ALTER TABLE `auteurs`
  ADD PRIMARY KEY (`id_film`,`id_personne`),
  ADD KEY `id_personne` (`id_personne`);

--
-- Indexes for table `calendrier`
--
ALTER TABLE `calendrier`
  ADD PRIMARY KEY (`id_date`);

--
-- Indexes for table `categorie_public`
--
ALTER TABLE `categorie_public`
  ADD PRIMARY KEY (`id_categorie`);

--
-- Indexes for table `films`
--
ALTER TABLE `films`
  ADD PRIMARY KEY (`id_film`),
  ADD KEY `id_compagnie` (`id_societe_production`),
  ADD KEY `id_audience_stat` (`id_audience_status`),
  ADD KEY `id_rating` (`id_categorie`),
  ADD KEY `id_cal_1` (`id_date_stream`),
  ADD KEY `id_cal` (`id_date_sortie`),
  ADD KEY `id_tm_stat` (`id_tomatometer_status`);

--
-- Indexes for table `genre_film`
--
ALTER TABLE `genre_film`
  ADD PRIMARY KEY (`id_film`,`id_genre`),
  ADD KEY `id_genre` (`id_genre`);

--
-- Indexes for table `note_audience`
--
ALTER TABLE `note_audience`
  ADD PRIMARY KEY (`id_audience`);

--
-- Indexes for table `personnes`
--
ALTER TABLE `personnes`
  ADD PRIMARY KEY (`id_personne`);

--
-- Indexes for table `realisateurs`
--
ALTER TABLE `realisateurs`
  ADD PRIMARY KEY (`id_film`,`id_personne`),
  ADD KEY `id_personne` (`id_personne`);

--
-- Indexes for table `societe_production`
--
ALTER TABLE `societe_production`
  ADD PRIMARY KEY (`id_societe`);

--
-- Indexes for table `tomatometer_status`
--
ALTER TABLE `tomatometer_status`
  ADD PRIMARY KEY (`id_tomatometer_status`);

--
-- Indexes for table `type_genre`
--
ALTER TABLE `type_genre`
  ADD PRIMARY KEY (`id_genre`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `acteurs`
--
ALTER TABLE `acteurs`
  ADD CONSTRAINT `acteurs_ibfk_1` FOREIGN KEY (`id_personne`) REFERENCES `personnes` (`id_personne`),
  ADD CONSTRAINT `acteurs_ibfk_2` FOREIGN KEY (`id_film`) REFERENCES `films` (`id_film`);

--
-- Constraints for table `auteurs`
--
ALTER TABLE `auteurs`
  ADD CONSTRAINT `auteurs_ibfk_1` FOREIGN KEY (`id_personne`) REFERENCES `personnes` (`id_personne`),
  ADD CONSTRAINT `auteurs_ibfk_2` FOREIGN KEY (`id_film`) REFERENCES `films` (`id_film`);

--
-- Constraints for table `films`
--
ALTER TABLE `films`
  ADD CONSTRAINT `films_ibfk_1` FOREIGN KEY (`id_societe_production`) REFERENCES `societe_production` (`id_societe`),
  ADD CONSTRAINT `films_ibfk_2` FOREIGN KEY (`id_audience_status`) REFERENCES `note_audience` (`id_audience`),
  ADD CONSTRAINT `films_ibfk_3` FOREIGN KEY (`id_categorie`) REFERENCES `categorie_public` (`id_categorie`),
  ADD CONSTRAINT `films_ibfk_4` FOREIGN KEY (`id_date_stream`) REFERENCES `calendrier` (`id_date`),
  ADD CONSTRAINT `films_ibfk_5` FOREIGN KEY (`id_date_sortie`) REFERENCES `calendrier` (`id_date`),
  ADD CONSTRAINT `films_ibfk_6` FOREIGN KEY (`id_tomatometer_status`) REFERENCES `tomatometer_status` (`id_tomatometer_status`);

--
-- Constraints for table `genre_film`
--
ALTER TABLE `genre_film`
  ADD CONSTRAINT `genre_film_ibfk_1` FOREIGN KEY (`id_genre`) REFERENCES `type_genre` (`id_genre`),
  ADD CONSTRAINT `genre_film_ibfk_2` FOREIGN KEY (`id_film`) REFERENCES `films` (`id_film`);

--
-- Constraints for table `realisateurs`
--
ALTER TABLE `realisateurs`
  ADD CONSTRAINT `realisateurs_ibfk_1` FOREIGN KEY (`id_personne`) REFERENCES `personnes` (`id_personne`),
  ADD CONSTRAINT `realisateurs_ibfk_2` FOREIGN KEY (`id_film`) REFERENCES `films` (`id_film`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
