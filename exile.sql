-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.26-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.2.0.4970
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for exile
CREATE DATABASE IF NOT EXISTS `exile` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `exile`;


-- Dumping structure for table exile.account
CREATE TABLE IF NOT EXISTS `account` (
  `uid` varchar(32) NOT NULL,
  `clan_id` int(11) unsigned DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `money` double NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL DEFAULT '0',
  `kills` int(11) unsigned NOT NULL DEFAULT '0',
  `deaths` int(11) unsigned NOT NULL DEFAULT '0',
  `first_connect_at` datetime DEFAULT NULL,
  `last_connect_at` datetime DEFAULT NULL,
  `last_disconnect_at` datetime DEFAULT NULL,
  `total_connections` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`uid`),
  KEY `clan_id` (`clan_id`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`clan_id`) REFERENCES `clan` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table exile.clan
CREATE TABLE IF NOT EXISTS `clan` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `leader_uid` varchar(32) NOT NULL,
  `created_at` datetime NOT NULL,
  `insignia_texture` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `leader_uid` (`leader_uid`),
  CONSTRAINT `clan_ibfk_1` FOREIGN KEY (`leader_uid`) REFERENCES `account` (`uid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table exile.construction
CREATE TABLE IF NOT EXISTS `construction` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(64) NOT NULL,
  `account_uid` varchar(32) NOT NULL,
  `spawned_at` datetime NOT NULL,
  `maintained_at` datetime DEFAULT NULL,
  `position_x` double NOT NULL,
  `position_y` double NOT NULL,
  `position_z` double NOT NULL,
  `direction_x` double NOT NULL,
  `direction_y` double NOT NULL,
  `direction_z` double NOT NULL,
  `up_x` double NOT NULL,
  `up_y` double NOT NULL,
  `up_z` double NOT NULL,
  `is_locked` tinyint(1) NOT NULL,
  `pin_code` varchar(6) NOT NULL DEFAULT '000000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table exile.container
CREATE TABLE IF NOT EXISTS `container` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(64) NOT NULL,
  `spawned_at` datetime NOT NULL,
  `account_uid` varchar(32) DEFAULT NULL,
  `last_accessed` datetime NOT NULL,
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `position_x` double NOT NULL DEFAULT '0',
  `position_y` double NOT NULL DEFAULT '0',
  `position_z` double NOT NULL DEFAULT '0',
  `direction_x` double NOT NULL DEFAULT '0',
  `direction_y` double NOT NULL DEFAULT '0',
  `direction_z` double NOT NULL DEFAULT '0',
  `up_x` double NOT NULL DEFAULT '0',
  `up_y` double NOT NULL DEFAULT '0',
  `up_z` double NOT NULL DEFAULT '1',
  `cargo_items` text NOT NULL,
  `cargo_magazines` text NOT NULL,
  `cargo_weapons` text NOT NULL,
  `cargo_container` text NOT NULL,
  `pin_code` varchar(6) NOT NULL DEFAULT '000000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.


-- Dumping structure for table exile.player
CREATE TABLE IF NOT EXISTS `player` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `account_uid` varchar(32) NOT NULL,
  `is_alive` tinyint(1) NOT NULL DEFAULT '1',
  `damage` double unsigned NOT NULL DEFAULT '0',
  `fatigue` double unsigned NOT NULL DEFAULT '0',
  `hunger` double unsigned NOT NULL DEFAULT '100',
  `thirst` double unsigned NOT NULL DEFAULT '100',
  `alcohol` double unsigned NOT NULL DEFAULT '0',
  `oxygen_remaining` double unsigned NOT NULL DEFAULT '1',
  `bleeding_remaining` double unsigned NOT NULL DEFAULT '0',
  `hitpoint_head` double unsigned NOT NULL,
  `hitpoint_body` double unsigned NOT NULL DEFAULT '0',
  `hitpoint_hands` double unsigned NOT NULL DEFAULT '0',
  `hitpoint_legs` double unsigned NOT NULL DEFAULT '0',
  `direction` double NOT NULL DEFAULT '0',
  `position_x` double NOT NULL DEFAULT '0',
  `position_y` double NOT NULL DEFAULT '0',
  `position_z` double NOT NULL DEFAULT '0',
  `spawned_at` datetime NOT NULL,
  `died_at` datetime DEFAULT NULL,
  `assigned_items` text NOT NULL,
  `backpack` varchar(64) NOT NULL,
  `backpack_items` text NOT NULL,
  `backpack_magazines` text NOT NULL,
  `backpack_weapons` text NOT NULL,
  `current_weapon` varchar(64) NOT NULL,
  `goggles` varchar(64) NOT NULL,
  `handgun_items` varchar(255) NOT NULL,
  `handgun_weapon` varchar(64) NOT NULL,
  `headgear` varchar(64) NOT NULL,
  `binocular` varchar(64) NOT NULL,
  `loaded_magazines` varchar(255) NOT NULL,
  `primary_weapon` varchar(64) NOT NULL,
  `primary_weapon_items` varchar(255) NOT NULL,
  `secondary_weapon` varchar(64) NOT NULL,
  `secondary_weapon_items` varchar(255) NOT NULL,
  `uniform` varchar(64) NOT NULL,
  `uniform_items` text NOT NULL,
  `uniform_magazines` text NOT NULL,
  `uniform_weapons` text NOT NULL,
  `vest` varchar(64) NOT NULL,
  `vest_items` text NOT NULL,
  `vest_magazines` text NOT NULL,
  `vest_weapons` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `player_uid` (`account_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table exile.territory
CREATE TABLE IF NOT EXISTS `territory` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `owner_uid` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `position_x` double NOT NULL,
  `position_y` double NOT NULL,
  `position_z` double NOT NULL,
  `radius` double NOT NULL,
  `level` int(11) NOT NULL,
  `flag_texture` varchar(255) NOT NULL,
  `flag_stolen` tinyint(1) NOT NULL DEFAULT '0',
  `flag_stolen_by_uid` varchar(32) DEFAULT NULL,
  `flag_stolen_at` datetime DEFAULT NULL,
  `flag_steal_message` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `last_payed_at` datetime DEFAULT NULL,
  `build_rights` varchar(640) NOT NULL DEFAULT '0',
  `moderators` varchar(320) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.


-- Dumping structure for table exile.vehicle
CREATE TABLE IF NOT EXISTS `vehicle` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(64) NOT NULL,
  `spawned_at` datetime NOT NULL,
  `account_uid` varchar(32) DEFAULT NULL,
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `fuel` double unsigned NOT NULL DEFAULT '0',
  `damage` double unsigned NOT NULL DEFAULT '0',
  `hitpoints` text NOT NULL,
  `position_x` double NOT NULL DEFAULT '0',
  `position_y` double NOT NULL DEFAULT '0',
  `position_z` double NOT NULL DEFAULT '0',
  `direction_x` double NOT NULL DEFAULT '0',
  `direction_y` double NOT NULL DEFAULT '0',
  `direction_z` double NOT NULL DEFAULT '0',
  `up_x` double NOT NULL DEFAULT '0',
  `up_y` double NOT NULL DEFAULT '0',
  `up_z` double NOT NULL DEFAULT '1',
  `cargo_items` text NOT NULL,
  `cargo_magazines` text NOT NULL,
  `cargo_weapons` text NOT NULL,
  `cargo_container` text NOT NULL,
  `pin_code` varchar(6) NOT NULL DEFAULT '000000',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
