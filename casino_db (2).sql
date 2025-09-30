-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 30, 2025 at 03:38 PM
-- Server version: 8.3.0
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `casino_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `access_logs`
--

DROP TABLE IF EXISTS `access_logs`;
CREATE TABLE IF NOT EXISTS `access_logs` (
  `access_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `entry_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `exit_time` timestamp NULL DEFAULT NULL,
  `area_accessed` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`access_id`),
  KEY `fk_access_employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `access_logs`
--

INSERT INTO `access_logs` (`access_id`, `employee_id`, `entry_time`, `exit_time`, `area_accessed`) VALUES
(1, 3, '2025-09-25 15:46:49', '2025-09-25 18:00:00', 'Slot area 4'),
(2, NULL, '2025-09-25 15:49:14', '2025-09-25 18:00:00', 'Slot area 1');

-- --------------------------------------------------------

--
-- Table structure for table `app_users`
--

DROP TABLE IF EXISTS `app_users`;
CREATE TABLE IF NOT EXISTS `app_users` (
  `app_user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_role` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `employee_id` int DEFAULT NULL,
  PRIMARY KEY (`app_user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_appuser_employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_users`
--

INSERT INTO `app_users` (`app_user_id`, `username`, `email`, `password_hash`, `employee_role`, `is_active`, `created_at`, `employee_id`) VALUES
(1, 'Precious m', NULL, '1234', 'Admin', 1, '2025-09-15 06:02:26', NULL),
(2, 'pabz', NULL, 'cashier', 'Cashier', 1, '2025-09-15 06:09:26', NULL),
(8, 'mikey ', NULL, 'mike', 'Cashier', 1, '2025-09-15 06:13:05', NULL),
(15, 'baluku', NULL, 'password', 'Security', 1, '2025-09-19 19:35:35', NULL),
(16, 'foodie', NULL, 'food', 'Restuarant Manager', 1, '2025-09-19 21:22:24', NULL),
(17, 'Poker', NULL, 'games', 'Game Manager', 1, '2025-09-21 05:54:38', NULL),
(18, '', '', '', 'Cashier', 1, '2025-09-21 06:08:49', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bets`
--

DROP TABLE IF EXISTS `bets`;
CREATE TABLE IF NOT EXISTS `bets` (
  `bet_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `game_id` int DEFAULT NULL,
  `table_id` int DEFAULT NULL,
  `slot_id` int DEFAULT NULL,
  `transaction_id` int DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL,
  `bet_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `outcome` enum('Win','Lose','Draw','Pending') COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  `payout_amount` decimal(14,2) DEFAULT '0.00',
  PRIMARY KEY (`bet_id`),
  KEY `fk_bet_customer` (`customer_id`),
  KEY `fk_bet_game` (`game_id`),
  KEY `fk_bet_table` (`table_id`),
  KEY `fk_bet_slot` (`slot_id`),
  KEY `fk_bet_txn` (`transaction_id`),
  KEY `bet_time` (`bet_time`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bets`
--

INSERT INTO `bets` (`bet_id`, `customer_id`, `game_id`, `table_id`, `slot_id`, `transaction_id`, `amount`, `bet_time`, `outcome`, `payout_amount`) VALUES
(1, 2, NULL, NULL, NULL, NULL, 6000.00, '2025-09-24 20:49:10', 'Win', 12000.00),
(2, 3, NULL, NULL, NULL, NULL, 47000.00, '2025-09-24 20:58:47', 'Lose', 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `casino_tables`
--

DROP TABLE IF EXISTS `casino_tables`;
CREATE TABLE IF NOT EXISTS `casino_tables` (
  `table_id` int NOT NULL AUTO_INCREMENT,
  `game_id` int DEFAULT NULL,
  `seating_capacity` int DEFAULT '7',
  `dealer_id` int DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Active','Closed','Maintenance') COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  PRIMARY KEY (`table_id`),
  KEY `fk_table_game` (`game_id`),
  KEY `fk_table_dealer` (`dealer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `casino_tables`
--

INSERT INTO `casino_tables` (`table_id`, `game_id`, `seating_capacity`, `dealer_id`, `location`, `status`) VALUES
(10001, NULL, 10, 1, 'Left Wing', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('Male','Female','Other') COLLATE utf8mb4_unicode_ci DEFAULT 'Other',
  `national_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `loyalty_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `customer_rewards` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`),
  KEY `phone` (`phone`),
  KEY `fk_customers_loyalty` (`loyalty_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `dob`, `gender`, `national_id`, `phone`, `email`, `address`, `loyalty_id`, `created_at`, `updated_at`, `customer_rewards`) VALUES
(2, 'Mulungi ', 'Precious ', '2003-11-29', 'Male', 'CM030504242K100GH', '0779669429', 'mulungi@gmail.com', 'mile 3', NULL, '2025-09-22 11:58:01', '2025-09-22 12:23:15', NULL),
(3, 'Namatta ', 'Sharifah', '2004-05-11', 'Female', 'CF0342444343JK23F', '0758342121', 'sharifah11@gmail.com', 'kampala', NULL, '2025-09-22 11:58:53', '2025-09-22 12:24:25', NULL),
(4, 'Nalukenge', 'Shamimu', '2000-12-08', 'Female', 'CF089387FGHG10', '0778434232', 'nalukenges@gmail.com', 'Mbarara Taso', NULL, '2025-09-30 15:23:04', '2025-09-30 15:23:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_name` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salary` decimal(12,2) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `first_name`, `last_name`, `role_name`, `hire_date`, `phone`, `email`, `salary`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Gamer', 'Kevin', 'Game Manager', '2025-09-22', '07734123457', 'gamerk@gmail.com', 5000000.00, 1, '2025-09-10 16:49:14', '2025-09-22 14:11:58'),
(2, 'Festo', 'Mwiru', 'Pit Boss', '2024-09-07', '04942348932', 'mwirufesto@gmail.com', 3000500.00, 1, '2025-09-10 16:49:14', '2025-09-22 18:11:33'),
(3, 'Pabire', 'pabz', 'Cashier', '2023-09-11', '0758430915', 'pabzpabire@std.casino.org.ug', 6000000.00, 1, '2025-09-10 16:49:14', '2025-09-22 18:14:00'),
(4, 'Baluku', 'kabale', 'Security', '2020-05-12', '01248923453', 'balukus12@gmail.com', 1050000.00, 1, '2025-09-10 16:49:14', '2025-09-22 18:16:23'),
(8, 'precious ', 'mulungi', 'Admin', '2003-11-29', '01133453425', 'mulungiprecious@gmail.com', 2000000.00, 1, '2025-09-10 16:49:14', '2025-09-22 18:17:45');

-- --------------------------------------------------------

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
CREATE TABLE IF NOT EXISTS `games` (
  `game_id` int NOT NULL AUTO_INCREMENT,
  `game_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_bet` decimal(12,2) DEFAULT '0.00',
  `max_bet` decimal(12,2) DEFAULT '0.00',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`game_id`),
  UNIQUE KEY `game_name` (`game_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1005 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `games`
--

INSERT INTO `games` (`game_id`, `game_name`, `min_bet`, `max_bet`, `description`, `created_at`) VALUES
(1001, 'Slots', 500.00, 10000.00, NULL, '2025-09-25 07:01:44'),
(1002, 'Blackjack', 15000.00, 100000.00, NULL, '2025-09-25 07:02:43'),
(1003, 'Roulette', 15000.00, 100000.00, NULL, '2025-09-25 07:03:04'),
(1004, 'Poker', 4000.00, 1000000.00, NULL, '2025-09-25 07:03:42');

-- --------------------------------------------------------

--
-- Table structure for table `loyalty_programs`
--

DROP TABLE IF EXISTS `loyalty_programs`;
CREATE TABLE IF NOT EXISTS `loyalty_programs` (
  `loyalty_id` int NOT NULL AUTO_INCREMENT,
  `tier_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `points_required` int DEFAULT '0',
  `benefits` text COLLATE utf8mb4_unicode_ci,
  `points_balance` int DEFAULT NULL,
  PRIMARY KEY (`loyalty_id`),
  UNIQUE KEY `tier_name` (`tier_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loyalty_programs`
--

INSERT INTO `loyalty_programs` (`loyalty_id`, `tier_name`, `points_required`, `benefits`, `points_balance`) VALUES
(10001, 'Basic', 1000, 'Points are converted into Cash', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
CREATE TABLE IF NOT EXISTS `menu_items` (
  `menu_item_id` int NOT NULL AUTO_INCREMENT,
  `restaurant_id` int NOT NULL,
  `item_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`menu_item_id`),
  KEY `fk_menu_restaurant` (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`menu_item_id`, `restaurant_id`, `item_name`, `price`, `category`, `is_active`) VALUES
(1, 1, 'coffee', 15000.00, 'Drinks and Beverages', 1),
(2, 1, 'Soda', 3000.00, 'Drinks and Beverages', 1),
(3, 1, 'water', 1000.00, 'Drinks and Beverages', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `restaurant_id` int NOT NULL,
  `employee_id` int DEFAULT NULL,
  `order_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(12,2) DEFAULT '0.00',
  `status` enum('Placed','Preparing','Served','Cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'Placed',
  `quantity` int DEFAULT NULL,
  `menu_item_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_order_customer` (`customer_id`),
  KEY `fk_order_restaurant` (`restaurant_id`),
  KEY `fk_order_employee` (`employee_id`),
  KEY `fk_menu_item` (`menu_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `restaurant_id`, `employee_id`, `order_time`, `total_amount`, `status`, `quantity`, `menu_item_id`) VALUES
(1, NULL, 1, NULL, '2025-09-25 20:30:08', 6000.00, 'Placed', 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `restaurants`
--

DROP TABLE IF EXISTS `restaurants`;
CREATE TABLE IF NOT EXISTS `restaurants` (
  `restaurant_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `restaurants`
--

INSERT INTO `restaurants` (`restaurant_id`, `name`, `location`, `capacity`, `phone`) VALUES
(1, 'Paradise Hotel inc', '2nd floor', 1000, '0777713121'),
(2, 'MexicaNo Restaurant', '2nd floor', 100, '0776713199');

-- --------------------------------------------------------

--
-- Table structure for table `rewards`
--

DROP TABLE IF EXISTS `rewards`;
CREATE TABLE IF NOT EXISTS `rewards` (
  `reward_id` int NOT NULL AUTO_INCREMENT,
  `reward_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `points_required` int NOT NULL,
  PRIMARY KEY (`reward_id`),
  UNIQUE KEY `reward_name` (`reward_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rewards`
--

INSERT INTO `rewards` (`reward_id`, `reward_name`, `description`, `points_required`) VALUES
(1, 'Free spins', 'You get a free spin on specific slots', 1000);

-- --------------------------------------------------------

--
-- Table structure for table `security_logs`
--

DROP TABLE IF EXISTS `security_logs`;
CREATE TABLE IF NOT EXISTS `security_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int DEFAULT NULL,
  `event_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `description` text COLLATE utf8mb4_unicode_ci,
  `Camera_no` int DEFAULT NULL,
  `Status` enum('Online','Offline') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `fk_security_employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1012 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `security_logs`
--

INSERT INTO `security_logs` (`log_id`, `employee_id`, `event_type`, `event_time`, `description`, `Camera_no`, `Status`) VALUES
(1001, NULL, 'Breach of the Accounting room', '2025-09-25 15:38:08', 'One of the accountants lost their key cards on their way to work and had to break down the door', NULL, NULL),
(1002, NULL, NULL, '2025-09-25 15:41:36', NULL, 1, 'Online'),
(1003, NULL, NULL, '2025-09-25 15:41:36', NULL, 2, 'Online'),
(1004, NULL, NULL, '2025-09-25 15:41:36', NULL, 3, 'Offline'),
(1005, NULL, NULL, '2025-09-25 15:41:49', NULL, 4, 'Online'),
(1006, NULL, NULL, '2025-09-25 15:41:49', NULL, 5, 'Offline'),
(1007, NULL, NULL, '2025-09-25 15:41:49', NULL, 6, 'Online'),
(1008, NULL, NULL, '2025-09-25 15:41:49', NULL, 7, 'Online'),
(1009, NULL, NULL, '2025-09-25 15:41:49', NULL, 8, 'Online'),
(1010, NULL, NULL, '2025-09-25 15:41:49', NULL, 9, 'Offline'),
(1011, NULL, NULL, '2025-09-25 15:41:49', NULL, 10, 'Online');

-- --------------------------------------------------------

--
-- Table structure for table `slot_machines`
--

DROP TABLE IF EXISTS `slot_machines`;
CREATE TABLE IF NOT EXISTS `slot_machines` (
  `slot_id` int NOT NULL AUTO_INCREMENT,
  `game_id` int DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Active','Maintenance','Out of Order') COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  `last_maintenance` date DEFAULT NULL,
  PRIMARY KEY (`slot_id`),
  KEY `fk_slot_game` (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `slot_machines`
--

INSERT INTO `slot_machines` (`slot_id`, `game_id`, `location`, `status`, `last_maintenance`) VALUES
(1001, NULL, 'Left wing', 'Active', '2025-09-29');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `amount` decimal(14,2) NOT NULL,
  `transaction_type` enum('Deposit','Withdrawal','Bet','Payout','Purchase','Adjustment') COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_txn_customer` (`customer_id`),
  KEY `fk_txn_employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `customer_id`, `employee_id`, `amount`, `transaction_type`, `transaction_time`, `notes`) VALUES
(1, 3, 3, 2900000.00, 'Payout', '2025-09-22 20:04:07', NULL),
(3, 3, 3, 43002.00, 'Bet', '2025-09-26 15:23:47', NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `access_logs`
--
ALTER TABLE `access_logs`
  ADD CONSTRAINT `fk_access_employee` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `app_users`
--
ALTER TABLE `app_users`
  ADD CONSTRAINT `fk_appuser_employee` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;

--
-- Constraints for table `bets`
--
ALTER TABLE `bets`
  ADD CONSTRAINT `fk_bet_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_bet_game` FOREIGN KEY (`game_id`) REFERENCES `games` (`game_id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `fk_bet_slot` FOREIGN KEY (`slot_id`) REFERENCES `slot_machines` (`slot_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_bet_table` FOREIGN KEY (`table_id`) REFERENCES `casino_tables` (`table_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_bet_txn` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`) ON DELETE SET NULL;

--
-- Constraints for table `casino_tables`
--
ALTER TABLE `casino_tables`
  ADD CONSTRAINT `fk_table_dealer` FOREIGN KEY (`dealer_id`) REFERENCES `employees` (`employee_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_table_game` FOREIGN KEY (`game_id`) REFERENCES `games` (`game_id`) ON DELETE CASCADE;

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `fk_customers_loyalty` FOREIGN KEY (`loyalty_id`) REFERENCES `loyalty_programs` (`loyalty_id`);

--
-- Constraints for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `fk_menu_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_menu_item` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`menu_item_id`),
  ADD CONSTRAINT `fk_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_order_employee` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_order_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurants` (`restaurant_id`) ON DELETE CASCADE;

--
-- Constraints for table `security_logs`
--
ALTER TABLE `security_logs`
  ADD CONSTRAINT `fk_security_employee` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE SET NULL;

--
-- Constraints for table `slot_machines`
--
ALTER TABLE `slot_machines`
  ADD CONSTRAINT `fk_slot_game` FOREIGN KEY (`game_id`) REFERENCES `games` (`game_id`) ON DELETE RESTRICT;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_txn_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_txn_employee` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
