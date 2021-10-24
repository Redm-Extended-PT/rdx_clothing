USE `redm_extended`;

CREATE TABLE `clothes` (
  `identifier` varchar(40) NOT NULL,
  `clothes` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `outfits` (
  `identifier` varchar(40) NOT NULL,
  `name` varchar(255) NOT NULL,
  `clothes` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


