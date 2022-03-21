CREATE DATABASE IF NOT EXISTS `ROTTEN_TOMATOES` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `ROTTEN_TOMATOES`;

CREATE TABLE `COMPAGNIES` (
  `id_compagnie` int(11) not null auto_increment,
  `identite_compagnie` varchar(40) unique,
  PRIMARY KEY (`id_compagnie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `PERSONNES` (
  `id_personne` int(11) not null auto_increment,
  `identite_personne` varchar(40) unique not null,
  PRIMARY KEY (`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `AUTEUR` (
  `id_film` int(11),
  `id_personne` int(11),
  PRIMARY KEY (`id_film`, `id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ACTEUR` (
  `id_film` int(11),
  `id_personne` int(11),
  PRIMARY KEY (`id_film`, `id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `REALISATEUR` (
  `id_film` int(11),
  `id_personne` int(11),
  PRIMARY KEY (`id_film`, `id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `GENRES` (
  `id_genre` int(11) not null auto_increment,
  `label_genre` varchar(40) unique not null,
  PRIMARY KEY (`id_genre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `GENRE` (
  `id_film` int(11),
  `id_genre` int(11),
  PRIMARY KEY (`id_film`, `id_genre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `FILMS` (
  `id_film` int(11) not null auto_increment,
  `titre` varchar(125),
  `url` varchar(125),
  `info` varchar(510),
  `critique` varchar(530),
  `durée` int(11),
  `tomatometer_count` int(11),
  `audience_rating` int(11),
  `audience_count` int(11),
  `id_tm_stat` int(11),
  `id_cal` int(11),
  `id_rating` int(11),
  `id_cal_1` int(11),
  `id_audience_stat` int(11),
  `id_compagnie` int(11),
  PRIMARY KEY (`id_film`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `RATINGS` (
  `id_rating` int(11) not null auto_increment,
  `label_rating` varchar(40) unique not null,
  PRIMARY KEY (`id_rating`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `TOMATOMETER_STATS` (
  `id_tm_stat` int(11) not null auto_increment,
  `label_tm_stat` varchar(40) unique not null,
  PRIMARY KEY (`id_tm_stat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `CALENDRIER` (
  `id_cal` int(11) not null auto_increment,
  `date_cal` date unique not null,
  PRIMARY KEY (`id_cal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `AUDIENCE_STATS` (
  `id_audience_stat` int(11) not null auto_increment,
  `label_audience_stat` varchar(40) unique not null,
  PRIMARY KEY (`id_audience_stat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `AUTEUR` ADD FOREIGN KEY (`id_personne`) REFERENCES `PERSONNES` (`id_personne`);
ALTER TABLE `AUTEUR` ADD FOREIGN KEY (`id_film`) REFERENCES `FILMS` (`id_film`);
ALTER TABLE `ACTEUR` ADD FOREIGN KEY (`id_personne`) REFERENCES `PERSONNES` (`id_personne`);
ALTER TABLE `ACTEUR` ADD FOREIGN KEY (`id_film`) REFERENCES `FILMS` (`id_film`);
ALTER TABLE `REALISATEUR` ADD FOREIGN KEY (`id_personne`) REFERENCES `PERSONNES` (`id_personne`);
ALTER TABLE `REALISATEUR` ADD FOREIGN KEY (`id_film`) REFERENCES `FILMS` (`id_film`);
ALTER TABLE `GENRE` ADD FOREIGN KEY (`id_genre`) REFERENCES `GENRES` (`id_genre`);
ALTER TABLE `GENRE` ADD FOREIGN KEY (`id_film`) REFERENCES `FILMS` (`id_film`);
ALTER TABLE `FILMS` ADD FOREIGN KEY (`id_compagnie`) REFERENCES `COMPAGNIES` (`id_compagnie`);
ALTER TABLE `FILMS` ADD FOREIGN KEY (`id_audience_stat`) REFERENCES `AUDIENCE_STATS` (`id_audience_stat`);
ALTER TABLE `FILMS` ADD FOREIGN KEY (`id_rating`) REFERENCES `RATINGS` (`id_rating`);
ALTER TABLE `FILMS` ADD FOREIGN KEY (`id_cal_1`) REFERENCES `CALENDRIER` (`id_cal`);
ALTER TABLE `FILMS` ADD FOREIGN KEY (`id_cal`) REFERENCES `CALENDRIER` (`id_cal`);
ALTER TABLE `FILMS` ADD FOREIGN KEY (`id_tm_stat`) REFERENCES `TOMATOMETER_STATS` (`id_tm_stat`);
