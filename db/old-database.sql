-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 22, 2025 at 06:53 PM
-- Server version: 10.11.10-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u824341227_u824341227_pos`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `account_num` varchar(192) NOT NULL,
  `account_name` varchar(192) NOT NULL,
  `initial_balance` decimal(10,2) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `account_num`, `account_name`, `initial_balance`, `note`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '01456478521466', 'Kashan', 9702.75, '', '2025-04-26 06:15:52.000000', '2025-05-20 15:03:51.000000', '2025-05-20 15:03:51'),
(2, '01456478521466', 'Hassan', 159743.50, '', '2025-04-26 10:51:31.000000', '2025-05-20 15:03:45.000000', '2025-05-20 15:03:45'),
(3, '01180111305947', 'Hassan Arshad khan', 1305468.00, '', '2025-05-26 21:05:02.000000', '2025-05-26 21:05:02.000000', NULL),
(4, '6013420311714116766', 'Hassan Arshad khan - HMB', 26980.00, '', '2025-05-26 21:07:51.000000', '2025-05-26 21:07:51.000000', NULL),
(5, '0325-7626846', 'Hassan Arshad - Jazz cash', 111058.00, '', '2025-05-27 09:35:13.000000', '2025-05-27 16:48:02.000000', NULL),
(6, '267', 'Cash at shop', 1447326.00, '', '2025-05-27 09:40:06.000000', '2025-06-22 14:56:56.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `account_ledgers`
--

CREATE TABLE `account_ledgers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `date` date NOT NULL,
  `debit` decimal(15,2) NOT NULL DEFAULT 0.00,
  `credit` decimal(15,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account_ledgers`
--

INSERT INTO `account_ledgers` (`id`, `account_id`, `type`, `reference`, `date`, `debit`, `credit`, `balance`, `created_at`, `updated_at`) VALUES
(1, 6, 'pos_payment', 'SO-20250622-165', '2025-06-22', 0.00, 115.00, 115.00, '2025-06-22 14:56:56', '2025-06-22 14:56:56');

-- --------------------------------------------------------

--
-- Table structure for table `adjustments`
--

CREATE TABLE `adjustments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `items` double DEFAULT 0,
  `notes` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `adjustments`
--

INSERT INTO `adjustments` (`id`, `user_id`, `date`, `Ref`, `warehouse_id`, `items`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '2025-04-26 16:09:00', 'AD_1111', 1, 1, '', '2025-04-26 06:10:29.000000', '2025-04-26 06:10:29.000000', NULL),
(2, 1, '2025-04-26 16:31:00', 'AD_1112', 2, 1, '', '2025-04-26 06:32:07.000000', '2025-04-26 06:32:07.000000', NULL),
(3, 1, '2025-04-26 16:32:00', 'AD_1113', 2, 1, '', '2025-04-26 06:32:46.000000', '2025-04-26 06:32:46.000000', NULL),
(4, 1, '2025-04-26 20:42:00', 'AD_1114', 1, 3, '', '2025-04-26 10:44:24.000000', '2025-04-26 10:44:24.000000', NULL),
(5, 1, '2025-04-26 20:48:00', 'AD_1115', 3, 1, '', '2025-04-26 10:49:28.000000', '2025-04-26 10:49:28.000000', NULL),
(6, 1, '2025-04-26 20:54:00', 'AD_1116', 3, 3, '', '2025-04-26 10:54:59.000000', '2025-04-26 10:54:59.000000', NULL),
(7, 1, '2025-04-26 22:26:00', 'AD_1117', 2, 4, '', '2025-04-26 12:27:29.000000', '2025-04-26 12:27:29.000000', NULL),
(8, 1, '2025-04-26 23:03:00', 'AD_1118', 2, 1, 'costum raid', '2025-04-26 13:03:41.000000', '2025-04-26 13:03:41.000000', NULL),
(9, 1, '2025-04-26 23:03:00', 'AD_1119', 2, 1, '', '2025-04-26 13:04:13.000000', '2025-04-26 13:04:13.000000', NULL),
(10, 1, '2025-05-05 15:31:00', 'AD_1120', 1, 1, '', '2025-05-05 05:31:36.000000', '2025-05-05 05:31:36.000000', NULL),
(13, 1, '0000-00-00 00:00:00', '', 1, 0, NULL, '2025-05-05 05:37:30.000000', '2025-05-05 05:37:30.000000', NULL),
(14, 1, '0000-00-00 00:00:00', '', 1, 0, NULL, '2025-05-05 05:38:57.000000', '2025-05-05 05:38:57.000000', NULL),
(15, 1, '0000-00-00 00:00:00', '', 1, 0, NULL, '2025-05-05 05:40:11.000000', '2025-05-05 05:40:11.000000', NULL),
(16, 1, '0000-00-00 00:00:00', '', 1, 0, NULL, '2025-05-05 05:40:13.000000', '2025-05-05 05:40:13.000000', NULL),
(17, 1, '0000-00-00 00:00:00', '', 1, 0, NULL, '2025-05-05 05:41:23.000000', '2025-05-05 05:41:23.000000', NULL),
(18, 1, '0000-00-00 00:00:00', '', 1, 0, NULL, '2025-05-05 05:41:29.000000', '2025-05-05 05:41:29.000000', NULL),
(19, 1, '0000-00-00 00:00:00', '', 1, 0, NULL, '2025-05-05 05:41:57.000000', '2025-05-05 05:41:57.000000', NULL),
(20, 1, '0000-00-00 00:00:00', '', 1, 0, NULL, '2025-05-05 05:42:18.000000', '2025-05-05 05:42:18.000000', NULL),
(21, 1, '2025-05-05 16:01:00', 'AD_1112', 2, 1, '', '2025-05-05 06:02:04.000000', '2025-05-05 06:02:04.000000', NULL),
(22, 1, '2025-05-05 16:06:00', 'AD_1113', 1, 1, '', '2025-05-05 06:07:07.000000', '2025-05-05 06:07:07.000000', NULL),
(23, 1, '2025-05-05 16:11:00', 'AD_1114', 2, 2, '', '2025-05-05 06:11:34.000000', '2025-05-05 06:11:34.000000', NULL),
(24, 1, '2025-05-10 16:26:00', 'AD_1115', 1, 3, '', '2025-05-10 06:27:17.000000', '2025-05-10 06:27:17.000000', NULL),
(25, 1, '2025-05-18 20:15:00', 'AD_1116', 4, 1, '', '2025-05-18 10:15:24.000000', '2025-05-20 15:02:14.000000', '2025-05-20 15:02:14'),
(26, 1, '2025-05-18 21:00:00', 'AD_1117', 4, 1, '', '2025-05-18 11:00:39.000000', '2025-05-20 15:02:17.000000', '2025-05-20 15:02:17'),
(27, 5, '2025-05-21 19:10:00', 'AD_1118', 4, 3, 'OPENING STOCK - WITH TAKING PHYSICAL STOCK', '2025-05-21 14:11:57.000000', '2025-05-21 14:11:57.000000', NULL),
(28, 5, '2025-05-21 19:30:00', 'AD_1119', 4, 2, 'OPENING - WITHOUT STOCK COUNT', '2025-05-21 14:32:09.000000', '2025-05-21 14:32:09.000000', NULL),
(29, 5, '2025-05-21 19:38:00', 'AD_1120', 4, 2, '', '2025-05-21 14:42:00.000000', '2025-05-21 14:42:00.000000', NULL),
(30, 5, '2025-05-22 17:00:00', 'AD_1121', 4, 1, 'OPENING QTY - WITHOUT STOCK COUNT', '2025-05-22 12:00:52.000000', '2025-05-22 12:00:52.000000', NULL),
(31, 5, '2025-05-22 19:12:00', 'AD_1122', 4, 2, '', '2025-05-22 14:15:12.000000', '2025-05-22 14:15:12.000000', NULL),
(32, 5, '2025-05-23 19:09:00', 'AD_1123', 4, 1, '', '2025-05-23 14:21:34.000000', '2025-05-23 14:21:34.000000', NULL),
(33, 5, '2025-05-23 19:27:00', 'AD_1124', 4, 1, '', '2025-05-23 14:29:12.000000', '2025-05-23 14:29:12.000000', NULL),
(34, 5, '2025-05-23 19:32:00', 'AD_1125', 4, 1, '', '2025-05-23 14:32:50.000000', '2025-05-23 14:32:50.000000', NULL),
(35, 5, '2025-05-23 21:32:00', 'AD_1126', 4, 1, '', '2025-05-23 16:32:46.000000', '2025-05-23 16:32:46.000000', NULL),
(36, 5, '2025-05-24 21:39:00', 'AD_1127', 4, 1, '', '2025-05-26 12:40:25.000000', '2025-05-26 12:40:25.000000', NULL),
(37, 5, '2025-05-24 10:56:00', 'AD_1128', 4, 1, '', '2025-05-26 12:56:45.000000', '2025-05-26 12:56:45.000000', NULL),
(38, 5, '2025-05-26 20:25:00', 'AD_1129', 4, 1, '', '2025-05-26 15:26:24.000000', '2025-05-26 15:26:24.000000', NULL),
(39, 5, '2025-05-26 20:26:00', 'AD_1130', 4, 2, '', '2025-05-26 15:27:54.000000', '2025-05-26 15:27:54.000000', NULL),
(40, 5, '2025-05-26 22:23:00', 'AD_1131', 4, 1, '', '2025-05-26 17:23:50.000000', '2025-05-26 17:23:50.000000', NULL),
(41, 5, '2025-05-27 14:01:00', 'AD_1132', 4, 1, '', '2025-05-27 09:01:34.000000', '2025-05-27 09:01:34.000000', NULL),
(42, 5, '2025-05-27 18:19:00', 'AD_1133', 4, 4, '', '2025-05-27 13:21:25.000000', '2025-05-27 13:21:25.000000', NULL),
(43, 5, '2025-05-27 18:24:00', 'AD_1134', 4, 1, '', '2025-05-27 13:24:26.000000', '2025-05-27 13:24:26.000000', NULL),
(44, 5, '2025-05-27 18:27:00', 'AD_1135', 4, 1, '', '2025-05-27 13:28:13.000000', '2025-05-27 13:28:13.000000', NULL),
(45, 5, '2025-05-27 20:31:00', 'AD_1136', 4, 1, '', '2025-05-27 15:31:53.000000', '2025-05-27 15:31:53.000000', NULL),
(46, 5, '2025-05-27 21:46:00', 'AD_1137', 4, 1, '', '2025-05-27 16:46:38.000000', '2025-05-27 16:46:38.000000', NULL),
(47, 5, '2025-05-27 22:24:00', 'AD_1138', 4, 2, '', '2025-05-27 17:24:43.000000', '2025-05-27 17:24:43.000000', NULL),
(48, 5, '2025-05-27 22:35:00', 'AD_1139', 4, 1, '', '2025-05-27 17:35:43.000000', '2025-05-27 17:35:43.000000', NULL),
(49, 5, '2025-05-29 20:37:00', 'AD_1140', 4, 1, '', '2025-05-29 15:37:49.000000', '2025-05-29 15:37:49.000000', NULL),
(50, 5, '2025-05-29 21:51:00', 'AD_1141', 4, 1, '', '2025-05-29 16:51:35.000000', '2025-05-29 16:51:35.000000', NULL),
(51, 5, '2025-05-29 21:59:00', 'AD_1142', 4, 4, '', '2025-05-29 17:00:33.000000', '2025-05-29 17:00:33.000000', NULL),
(52, 5, '2025-05-28 22:02:00', 'AD_1143', 4, 1, '', '2025-05-29 17:02:44.000000', '2025-05-29 17:02:44.000000', NULL),
(53, 5, '2025-05-29 22:14:00', 'AD_1144', 4, 2, '', '2025-05-29 17:14:46.000000', '2025-05-29 17:14:46.000000', NULL),
(54, 1, '2025-05-30 00:09:00', 'AD_1145', 4, 1, '', '2025-05-29 19:09:51.000000', '2025-05-29 19:19:54.000000', '2025-05-29 19:19:54'),
(55, 5, '2025-05-30 20:20:00', 'AD_1146', 4, 1, '', '2025-05-30 15:20:38.000000', '2025-05-30 15:20:38.000000', NULL),
(56, 1, '2025-06-15 17:40:00', 'AD_1147', 4, 1, '', '2025-06-15 12:40:42.000000', '2025-06-15 12:40:42.000000', NULL),
(57, 1, '2025-06-20 11:32:00', 'AD_1148', 4, 1, '', '2025-06-20 06:37:57.000000', '2025-06-20 06:37:57.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `adjustment_details`
--

CREATE TABLE `adjustment_details` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `adjustment_id` int(11) NOT NULL,
  `product_variant_id` int(11) DEFAULT NULL,
  `quantity` double NOT NULL,
  `type` varchar(192) NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `adjustment_details`
--

INSERT INTO `adjustment_details` (`id`, `product_id`, `adjustment_id`, `product_variant_id`, `quantity`, `type`, `created_at`, `updated_at`) VALUES
(1, 3, 1, NULL, 40, 'add', NULL, NULL),
(2, 1, 2, NULL, 100, 'add', NULL, NULL),
(3, 3, 3, NULL, 100, 'add', NULL, NULL),
(4, 4, 4, 1, 15, 'add', NULL, NULL),
(5, 4, 4, 3, 15, 'add', NULL, NULL),
(6, 4, 4, 2, 15, 'add', NULL, NULL),
(7, 1, 5, NULL, 45, 'add', NULL, NULL),
(8, 4, 6, 1, 155, 'add', NULL, NULL),
(9, 4, 6, 3, 15, 'add', NULL, NULL),
(10, 4, 6, 2, 45, 'add', NULL, NULL),
(11, 5, 7, 4, 10, 'add', NULL, NULL),
(12, 5, 7, 5, 10, 'add', NULL, NULL),
(13, 5, 7, 6, 10, 'add', NULL, NULL),
(14, 5, 7, 7, 10, 'add', NULL, NULL),
(15, 6, 8, NULL, 50, 'sub', NULL, NULL),
(16, 6, 9, NULL, 25, 'add', NULL, NULL),
(17, 3, 10, NULL, 150, 'add', NULL, NULL),
(18, 1, 14, NULL, 5, 'add', '2025-05-05 05:38:57.000000', '2025-05-05 05:38:57.000000'),
(19, 1, 15, NULL, 5, 'add', '2025-05-05 05:40:11.000000', '2025-05-05 05:40:11.000000'),
(20, 1, 16, NULL, 5, 'add', '2025-05-05 05:40:13.000000', '2025-05-05 05:40:13.000000'),
(21, 1, 17, NULL, 5, 'add', '2025-05-05 05:41:23.000000', '2025-05-05 05:41:23.000000'),
(22, 1, 18, NULL, 5, 'add', '2025-05-05 05:41:29.000000', '2025-05-05 05:41:29.000000'),
(23, 1, 19, NULL, 5, 'add', '2025-05-05 05:41:58.000000', '2025-05-05 05:41:58.000000'),
(24, 1, 20, NULL, 5, 'add', '2025-05-05 05:42:18.000000', '2025-05-05 05:42:18.000000'),
(25, 1, 21, NULL, 10, 'add', NULL, NULL),
(26, 1, 1, NULL, 10, 'add', '2025-05-05 06:05:42.000000', '2025-05-05 06:05:42.000000'),
(27, 3, 22, NULL, 10, 'add', NULL, NULL),
(28, 3, 23, NULL, 10, 'add', NULL, NULL),
(29, 1, 23, NULL, 2, 'sub', NULL, NULL),
(30, 10, 24, NULL, 100, 'add', NULL, NULL),
(31, 9, 24, 8, 15, 'add', NULL, NULL),
(32, 9, 24, 9, 15, 'add', NULL, NULL),
(35, 12, 27, NULL, 1500, 'add', NULL, NULL),
(36, 13, 27, NULL, 3500, 'add', NULL, NULL),
(37, 14, 27, NULL, 2000, 'add', NULL, NULL),
(38, 15, 28, NULL, 41, 'add', NULL, NULL),
(39, 16, 28, NULL, 3, 'add', NULL, NULL),
(40, 18, 29, NULL, 7, 'add', NULL, NULL),
(41, 17, 29, NULL, 23, 'add', NULL, NULL),
(42, 19, 30, NULL, 1000, 'add', NULL, NULL),
(43, 20, 31, NULL, 46, 'add', NULL, NULL),
(44, 22, 31, NULL, 37, 'add', NULL, NULL),
(45, 23, 32, NULL, 40, 'add', NULL, NULL),
(46, 24, 33, NULL, 21900, 'add', NULL, NULL),
(47, 25, 34, NULL, 9900, 'add', NULL, '2025-05-23 17:16:57.000000'),
(48, 26, 35, NULL, 18, 'add', NULL, NULL),
(49, 13, 36, NULL, 1593, 'add', NULL, NULL),
(50, 14, 37, NULL, 34, 'sub', NULL, NULL),
(51, 12, 38, NULL, 1462, 'add', NULL, NULL),
(52, 13, 39, NULL, 889, 'add', NULL, NULL),
(53, 14, 39, NULL, 235, 'add', NULL, NULL),
(54, 27, 40, NULL, 500, 'add', NULL, NULL),
(55, 28, 41, NULL, 300, 'add', NULL, NULL),
(56, 30, 42, NULL, 50, 'add', NULL, NULL),
(57, 31, 42, NULL, 300, 'add', NULL, NULL),
(58, 32, 42, NULL, 300, 'add', NULL, NULL),
(59, 29, 42, NULL, 100, 'add', NULL, NULL),
(60, 33, 43, NULL, 50, 'add', NULL, NULL),
(61, 34, 44, NULL, 40, 'add', NULL, NULL),
(62, 35, 45, NULL, 51, 'add', NULL, NULL),
(63, 36, 46, NULL, 500, 'add', NULL, NULL),
(64, 37, 47, NULL, 13, 'add', NULL, NULL),
(65, 38, 47, NULL, 22, 'add', NULL, NULL),
(66, 39, 48, NULL, 5, 'add', NULL, NULL),
(67, 41, 49, NULL, 1, 'add', NULL, NULL),
(68, 40, 50, NULL, 40, 'add', NULL, NULL),
(69, 42, 51, 10, 31, 'add', NULL, NULL),
(70, 42, 51, 11, 22, 'add', NULL, NULL),
(71, 42, 51, 12, 1, 'add', NULL, NULL),
(72, 42, 51, 13, 17, 'add', NULL, NULL),
(73, 43, 52, NULL, 82, 'add', NULL, NULL),
(74, 45, 53, NULL, 134, 'add', NULL, NULL),
(75, 44, 53, NULL, 10, 'add', NULL, NULL),
(77, 47, 55, NULL, 10, 'add', NULL, NULL),
(78, 48, 56, NULL, 100, 'add', NULL, NULL),
(79, 49, 57, NULL, 50, 'add', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(11) NOT NULL,
  `name` varchar(192) NOT NULL,
  `description` varchar(192) DEFAULT NULL,
  `image` varchar(192) DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `description`, `image`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Master', '', 'image_default.png', '2025-04-25 09:27:55.000000', '2025-05-21 13:53:56.000000', '2025-05-21 13:53:56'),
(2, 'Khadi', '', 'image_default.png', '2025-04-25 09:28:00.000000', '2025-05-21 13:53:53.000000', '2025-05-21 13:53:53'),
(3, 'Dhaga', '', 'image_default.png', '2025-04-25 09:28:08.000000', '2025-05-21 13:53:50.000000', '2025-05-21 13:53:50'),
(4, 'Gold', '', 'image_default.png', '2025-04-26 10:30:37.000000', '2025-05-21 13:53:47.000000', '2025-05-21 13:53:47'),
(5, 'MASTER HARD PLUS', '', 'image_default.png', '2025-04-26 12:13:51.000000', '2025-05-21 13:53:44.000000', '2025-05-21 13:53:44'),
(6, 'Master', '', '1747836110.jpg', '2025-05-21 14:01:50.000000', '2025-05-21 14:01:50.000000', NULL),
(7, 'GOLD', '', '1747836140.jpg', '2025-05-21 14:02:20.000000', '2025-05-21 14:02:20.000000', NULL),
(8, 'NALKI', '', '1747836161.jpg', '2025-05-21 14:02:41.000000', '2025-05-21 14:02:41.000000', NULL),
(9, 'GM', '', '1747837437.jpg', '2025-05-21 14:23:57.000000', '2025-05-21 14:23:57.000000', NULL),
(10, 'IZH', '', 'image_default.png', '2025-05-21 14:32:44.000000', '2025-05-21 14:32:44.000000', NULL),
(11, 'J.GUL', '', 'image_default.png', '2025-05-21 14:33:03.000000', '2025-05-21 14:33:03.000000', NULL),
(12, 'PRIME', '', 'image_default.png', '2025-05-22 11:58:17.000000', '2025-05-22 11:58:17.000000', NULL),
(13, 'DHARI', '', 'image_default.png', '2025-05-22 14:07:11.000000', '2025-05-22 14:07:11.000000', NULL),
(14, 'GN', '', 'image_default.png', '2025-05-26 17:19:22.000000', '2025-05-26 17:19:22.000000', NULL),
(15, 'ARK', '50/2', 'image_default.png', '2025-05-27 08:59:45.000000', '2025-05-27 08:59:45.000000', NULL),
(16, 'XD', 'PERFECT PLUS', 'image_default.png', '2025-05-27 13:21:57.000000', '2025-05-27 13:21:57.000000', NULL),
(17, '6201', 'SADIQ INTERLINNIG', 'image_default.png', '2025-05-27 15:27:58.000000', '2025-05-27 15:27:58.000000', NULL),
(18, 'CHINA', '', 'image_default.png', '2025-05-27 16:44:57.000000', '2025-05-27 16:44:57.000000', NULL),
(19, 'SADIQ INTERLINING', '', 'image_default.png', '2025-05-29 15:36:26.000000', '2025-05-29 15:36:26.000000', NULL),
(20, 'MUNDIA', '', 'image_default.png', '2025-05-29 15:36:32.000000', '2025-05-29 15:36:32.000000', NULL),
(21, 'STANFORD', '901', 'image_default.png', '2025-05-29 16:56:09.000000', '2025-05-29 16:56:09.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `code` varchar(192) NOT NULL,
  `name` varchar(192) NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `code`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '122', 'Laptops', '2025-04-25 08:47:09.000000', '2025-05-21 13:53:06.000000', '2025-05-21 13:53:06'),
(2, 'TH', 'Threads', '2025-04-26 10:30:10.000000', '2025-05-21 13:53:09.000000', '2025-05-21 13:53:09'),
(3, 'FU', 'FUSING', '2025-04-26 12:13:23.000000', '2025-05-21 13:53:12.000000', '2025-05-21 13:53:12'),
(4, '01', 'Sewing Threads', '2025-05-21 13:53:34.000000', '2025-05-21 13:53:34.000000', NULL),
(5, '02', 'ELASTIC', '2025-05-21 14:22:35.000000', '2025-05-21 14:22:35.000000', NULL),
(6, '03', 'PARTS', '2025-05-21 14:34:21.000000', '2025-05-21 14:34:21.000000', NULL),
(7, '4', 'Buttons', '2025-05-23 14:07:30.000000', '2025-05-23 14:07:30.000000', NULL),
(8, '05', 'FUSING', '2025-05-27 13:14:00.000000', '2025-05-27 13:14:00.000000', NULL),
(9, '06', 'ACCESSORIES', '2025-05-27 17:19:32.000000', '2025-05-27 17:19:32.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `username` varchar(191) NOT NULL,
  `code` varchar(192) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `photo` varchar(192) DEFAULT NULL,
  `email` varchar(192) DEFAULT NULL,
  `country` varchar(191) DEFAULT NULL,
  `city` varchar(191) DEFAULT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `opening_balance` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `user_id`, `username`, `code`, `status`, `photo`, `email`, `country`, `city`, `phone`, `address`, `created_at`, `updated_at`, `deleted_at`, `opening_balance`) VALUES
(1, 1, 'Walkin Customer', '1', 1, 'no_avatar.png', '', NULL, '', '', '', '2025-04-25 09:24:33.000000', '2025-04-25 09:24:33.000000', NULL, NULL),
(2, 1, 'Syed Kashan Abbas Naqvi', '2', 1, '1745591108.jpg', 'abbaskashan234@gmail.com', NULL, 'KARACHI SOUTH', '03140300572', 'Kashane Zainab Plot no 255, Flat no 102 , Soldier bazaar no 1 ,Karachi ,Pakistan', '2025-04-25 09:25:08.000000', '2025-05-20 12:55:52.000000', '2025-05-20 12:55:52', NULL),
(3, 1, 'Usama Shaikh', '3', 1, 'no_avatar.png', 'usama@gmai;.com', NULL, '', '', '', '2025-04-26 05:36:42.000000', '2025-05-20 12:55:56.000000', '2025-05-20 12:55:56', NULL),
(4, 1, 'John Doe', '4', 1, 'no_avatar.png', '', NULL, '', '', '', '2025-04-26 05:37:01.000000', '2025-05-20 12:56:04.000000', '2025-05-20 12:56:04', NULL),
(5, 1, 'HAssan', '5', 1, 'no_avatar.png', '', NULL, '', '', '', '2025-04-26 10:28:15.000000', '2025-05-20 12:56:00.000000', '2025-05-20 12:56:00', NULL),
(6, 1, 'Anas', '6', 1, 'no_avatar.png', '', NULL, '', '', '', '2025-05-13 12:35:51.000000', '2025-05-20 12:56:08.000000', '2025-05-20 12:56:08', NULL),
(7, 5, 'OWAIS', '7', 1, 'no_avatar.png', '', NULL, 'KARACHI', '03341330870', 'GULSHAN - E - MAYMAR, HIGHWAY.', '2025-05-21 14:15:30.000000', '2025-05-21 14:15:30.000000', NULL, NULL),
(8, 5, 'HASHIM ANSARI', '8', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0324-8086838', 'GULSHAN - E - MAYMAR, HIGHWAY.', '2025-05-21 14:16:31.000000', '2025-05-21 14:16:31.000000', NULL, NULL),
(9, 5, 'NEHA', '9', 1, 'no_avatar.png', '', NULL, 'KARACHI', '', 'RAINBOW TOWER, MAYMAR ROAD, HIGHWAY.', '2025-05-21 14:17:41.000000', '2025-05-21 14:17:41.000000', NULL, NULL),
(10, 5, 'BILAL', '10', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0306-2341650', 'BISMILLAH MARKET, HIGHWAY.', '2025-05-21 14:18:36.000000', '2025-05-21 14:18:36.000000', NULL, NULL),
(11, 5, 'DANISH', '11', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0315-3943492', 'GULSHAN - E - MAYMAR', '2025-05-21 14:50:43.000000', '2025-05-21 14:50:43.000000', NULL, NULL),
(12, 5, 'MUJAHID', '12', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0312-2981567', 'BILAWAL SHAH, NOORANI GOTH, MOSAMIYAT', '2025-05-21 15:57:44.000000', '2025-05-21 15:57:44.000000', NULL, NULL),
(13, 5, 'Raja bhai - Al-khair miyari', '13', 1, 'no_avatar.png', '', NULL, 'Karachi', '0312 1205184', 'Gulzar Bazar, Korangi.', '2025-05-22 08:19:35.000000', '2025-05-22 08:19:35.000000', NULL, NULL),
(14, 5, 'Imran', '14', 1, 'no_avatar.png', '', NULL, 'Karachi.', '0324 2166336', 'Bangali para, near coast guard, Korangi.', '2025-05-22 08:20:41.000000', '2025-05-22 08:20:41.000000', NULL, NULL),
(15, 5, 'Adnan bhai', '15', 1, 'no_avatar.png', '', NULL, 'Karachi.', '0315 2323294', 'Sector 33-e, Ghareeb  Nawaz, 2.5no. korangi.', '2025-05-22 08:23:45.000000', '2025-05-22 08:23:45.000000', NULL, NULL),
(16, 5, 'Zafran - Shakir cosmetics', '16', 1, 'no_avatar.png', '', NULL, 'Karachi.', '0343 5506479', 'Bilal colony, Karachi.', '2025-05-22 08:26:57.000000', '2025-05-22 08:26:57.000000', NULL, NULL),
(17, 5, 'Imran - Zain cosmetics.', '17', 1, 'no_avatar.png', '', NULL, 'Karachi', '0300 2060221', 'Bilal colony, Korangi.', '2025-05-22 08:28:13.000000', '2025-05-22 08:28:13.000000', NULL, NULL),
(18, 5, 'Mati ullah.', '18', 1, 'no_avatar.png', '', NULL, 'Karachi.', '0334 3434741', 'Gulzar Bazar, Korangi.', '2025-05-22 08:29:29.000000', '2025-05-22 08:30:04.000000', NULL, NULL),
(19, 5, 'Mati ullah - 3B cosmetics and gift center.', '19', 1, 'no_avatar.png', '', NULL, 'Karachi.', '0334 3434741', 'Gulzar Bazar, Korangi.', '2025-05-22 08:31:45.000000', '2025-05-22 08:31:45.000000', NULL, NULL),
(20, 5, 'FARHAN', '20', 1, 'no_avatar.png', '', NULL, 'KARACHI', '03102907077', 'MEHRAN TOWN, KORANGI.', '2025-05-22 11:34:09.000000', '2025-05-22 11:34:09.000000', NULL, NULL),
(21, 5, 'IMDAD', '21', 1, 'no_avatar.png', '', NULL, 'KARACHI', '03002785335', 'BAGH-E-KORANGI.', '2025-05-22 11:36:55.000000', '2025-05-22 11:36:55.000000', NULL, NULL),
(22, 5, 'ABDUL RAZZAQ', '22', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0302-3880907', 'JAILER QASAE WALI GALI, AL-ASIF SQUARE ,SOHRAB GOTH.', '2025-05-22 11:38:52.000000', '2025-05-22 11:38:52.000000', NULL, NULL),
(23, 5, 'ABDUL LATIF', '23', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0370-0281273', 'NEAR ARIF MILK, JAMSHED ROAD # 3.', '2025-05-22 11:40:05.000000', '2025-05-22 11:40:05.000000', NULL, NULL),
(24, 5, 'WASEEM', '24', 1, 'no_avatar.png', '', NULL, '', '0', '', '2025-05-22 11:40:40.000000', '2025-05-22 18:56:21.000000', '2025-05-22 18:56:21', NULL),
(25, 5, 'WASEEM', '25', 1, 'no_avatar.png', '', NULL, 'KARACHI.', '0308-2579912', 'NEAR TAJ PUMP, SOLDIER BAZAR # 2', '2025-05-22 11:40:40.000000', '2025-05-22 11:41:25.000000', NULL, NULL),
(26, 5, 'SHAKEEL BHAI.', '26', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0315-2964707', 'RIMJHIM TOWER, SAFORA.', '2025-05-22 11:42:36.000000', '2025-05-22 11:42:36.000000', NULL, NULL),
(27, 5, 'SAIFI ULLAH.', '27', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0310-0279079', 'SHAREEFABAD, KORANGI.', '2025-05-22 11:44:21.000000', '2025-05-22 11:44:21.000000', NULL, NULL),
(28, 5, 'KASHIF BHAI - HASSAN COSMETICS', '28', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0311-8107047', 'GULZAR BAZAR, KORANGI.', '2025-05-22 11:45:32.000000', '2025-05-22 11:45:32.000000', NULL, NULL),
(29, 5, 'MOIZ - ALI STORE.', '29', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0324-2519945', 'ALFALAH SOCIETY, P.E.C.H.S.', '2025-05-22 11:48:46.000000', '2025-05-22 11:48:46.000000', NULL, NULL),
(30, 5, 'TAHA PEKO', '30', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0300-2630133', 'GHAZI GOTH, NEAR SAFORA.', '2025-05-22 13:46:04.000000', '2025-05-22 13:46:04.000000', NULL, NULL),
(31, 5, 'ABID', '31', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0306-2059871', 'DHANI BAKSH GOTH, GULISTAN - E - JOHAR', '2025-05-22 13:46:57.000000', '2025-05-22 13:46:57.000000', NULL, NULL),
(32, 5, 'M,NABI', '32', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0313-1045405', 'DHANI BAKSH GOTH, GULISTAN - E - JOHAR', '2025-05-22 13:47:29.000000', '2025-05-22 13:47:29.000000', NULL, NULL),
(33, 5, 'ISHTIAQUE', '33', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0315-2791668', 'DHANI BAKSH GOTH, GULISTAN - E - JOHAR', '2025-05-22 13:48:45.000000', '2025-05-22 13:48:45.000000', NULL, NULL),
(34, 5, 'FAHAD', '34', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0344-2225721', 'BHITAI ABAD, GULISTAN - E - JOHAR', '2025-05-22 13:56:19.000000', '2025-05-22 13:56:19.000000', NULL, NULL),
(35, 5, 'M.NABI', '35', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0313-1045405', 'DHANI BAKSH GOTH, GULISTAN - E - JOHAR.', '2025-05-22 13:57:44.000000', '2025-05-22 13:57:44.000000', NULL, NULL),
(36, 5, 'SHAHID', '36', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0300-0365994', 'DHANI BAKSH GOTH, GULISTAN - E - JOHAR.', '2025-05-22 13:58:12.000000', '2025-05-22 13:58:12.000000', NULL, NULL),
(37, 5, 'ALI HASSAN - AYAT COSMETICS', '37', 1, 'no_avatar.png', '', NULL, 'KARACHI', '03063689669', 'GHAZI GOTH , NEAR SAFORA', '2025-05-22 14:01:02.000000', '2025-05-22 14:01:02.000000', NULL, NULL),
(38, 5, 'SHAHBAZ - KAJ OVERLOCK', '38', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0304-3399359', 'SAFORA.', '2025-05-22 15:18:29.000000', '2025-05-22 15:18:29.000000', NULL, NULL),
(39, 5, 'Qamar - Top star', '39', 1, 'no_avatar.png', '', NULL, 'Karachi', '0300-3450078', 'Q-3, Chota plaza, infront of kamran, Al-asif square.', '2025-05-23 14:27:45.000000', '2025-05-23 14:27:45.000000', NULL, NULL),
(40, 5, 'Haseeb Lace', '40', 1, 'no_avatar.png', '', NULL, 'Karachi', '0313-269483', '1st floor, Rufi mall, Mosamiyat.', '2025-05-23 14:44:49.000000', '2025-05-23 14:44:49.000000', NULL, NULL),
(41, 5, 'Ghulam Fareed', '41', 1, 'no_avatar.png', '', NULL, 'Karachi.', '0319-4877574', 'Harmain Market, Johar Mor.', '2025-05-23 14:55:01.000000', '2025-05-23 14:55:01.000000', NULL, NULL),
(42, 5, 'DILSHAD - ABBAS ZARI LACE', '42', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0300-4465144', 'RADO BAKERY, GULISTAN-E-JOHAR.', '2025-05-26 13:53:05.000000', '2025-05-26 13:53:05.000000', NULL, NULL),
(43, 5, 'RIZWAN', '43', 1, 'no_avatar.png', '', NULL, 'KARACHI', '03333374574', 'SALES MAN', '2025-05-26 17:32:25.000000', '2025-05-26 17:32:25.000000', NULL, NULL),
(44, 5, 'Mohsin - Vip Tailor', '44', 1, 'no_avatar.png', '', NULL, 'Karachi', '', 'Chota plaza, Al-asif, Sohrab Goth', '2025-05-27 08:58:03.000000', '2025-05-27 08:58:03.000000', NULL, NULL),
(45, 5, 'Saif - commission a/c', '45', 1, 'no_avatar.png', '', NULL, 'Karachi.', '03253660763', '', '2025-05-27 09:51:56.000000', '2025-05-27 09:51:56.000000', NULL, NULL),
(46, 5, 'Tariq Bhai - SAIF', '46', 1, 'no_avatar.png', '', NULL, 'Karachi', '0307-2802005', 'RB LACE CORNER, Shop # 4, NEAR EIDHI CENTRE, METHA DAR.', '2025-05-27 10:44:43.000000', '2025-05-27 15:26:21.000000', NULL, NULL),
(47, 5, 'ZEESHAN COSMETICS', '47', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0302-2227595', 'LASSI GOTH, HIGHWAY.', '2025-05-27 11:52:39.000000', '2025-05-27 11:52:39.000000', NULL, NULL),
(48, 5, 'PYARO - SHOP 1', '48', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0311-3266508', 'LASSI GOTH, HIGHWAY.', '2025-05-27 11:53:33.000000', '2025-05-27 11:53:33.000000', NULL, NULL),
(49, 5, 'PYARO - SHOP 2', '49', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0317-2050197', 'LASSI GOTH, HIGHWAY.', '2025-05-27 11:54:18.000000', '2025-05-27 11:54:18.000000', NULL, NULL),
(50, 5, 'SHAHID BHAI - VIP TAILOR', '50', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0306-2575612', 'LASSI GOTH, HIGHWAY', '2025-05-27 11:56:05.000000', '2025-05-27 11:56:05.000000', NULL, NULL),
(51, 5, 'SHAHZAD', '51', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0333-2543794', 'SALESMAN, ORANGI TOWN.', '2025-05-27 12:16:45.000000', '2025-05-27 12:16:45.000000', NULL, NULL),
(52, 5, 'SHAREEF', '52', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0320-3070672', 'M.S. COSMETICS, BHITAIABAD, GULISTAN-E-JOHAR.', '2025-05-27 14:52:56.000000', '2025-05-27 14:54:39.000000', NULL, NULL),
(53, 5, 'FAISAL ZARI', '53', 1, 'no_avatar.png', '', NULL, 'KARACHI.', '0348-2670926', 'NEAR MASJID-E-UMER,SAMNABAD, GULBERG.', '2025-05-27 14:56:09.000000', '2025-05-27 14:56:09.000000', NULL, NULL),
(54, 5, 'AHMER', '54', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0314-2330168', 'WARIS ZARI, SAMNABAD, GULBERG.', '2025-05-27 14:56:46.000000', '2025-05-27 14:56:46.000000', NULL, NULL),
(55, 5, 'HAQ NAWAZ', '55', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0300-2239065', 'HASSAN LADIES TAILOR, PARADISE BAKERY, ABUL AL HASAN ASPHANI ROAD.', '2025-05-27 16:05:48.000000', '2025-05-27 16:05:48.000000', NULL, NULL),
(56, 5, 'SHAHID', '56', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0308-2812072', 'SUPER HAMZA, PARADISE BAKERY, ABUL AL HASAN ASPHANI ROAD.', '2025-05-27 16:07:08.000000', '2025-05-27 16:07:08.000000', NULL, NULL),
(57, 1, 'Kashan', '57', 1, 'no_avatar.png', '', NULL, '', '', '', '2025-05-28 15:08:17.000000', '2025-05-28 15:08:17.000000', NULL, 5000.00),
(58, 1, 'dadw', '58', 1, 'no_avatar.png', '', NULL, '', '', '', '2025-05-28 15:40:32.000000', '2025-05-28 16:11:55.000000', '2025-05-28 16:11:55', 122222.00),
(59, 1, 'dqd', '59', 1, 'no_avatar.png', '', NULL, '', '', '', '2025-05-28 15:46:39.000000', '2025-05-28 16:11:51.000000', '2025-05-28 16:11:51', 150.00),
(60, 5, 'Imran 2.5no.', '60', 1, 'no_avatar.png', '', NULL, 'Karachi', '0316-2393933', 'Korangi 2.5 no. , scheme 33-e', '2025-05-29 11:50:44.000000', '2025-05-29 11:50:44.000000', NULL, 0.00),
(61, 5, 'DANISH - BIN ZAMEER', '61', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0310-2424864', 'P.E.C.H.S BLOCK - 2', '2025-05-29 12:45:12.000000', '2025-05-29 12:45:12.000000', NULL, 6000.00),
(62, 5, 'HASAN ALI - AL-GHANI COSMETICS', '62', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0310-3716376', 'GULSHAN-E-TOHEED, KHAIRABAD, ORANGI TOWN.', '2025-05-29 16:16:44.000000', '2025-05-29 16:16:44.000000', NULL, 0.00),
(63, 5, 'SIRAJUDDIN - GEO SANAE', '63', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0325-2125515', 'SAFORA.', '2025-05-29 16:24:11.000000', '2025-05-29 16:24:50.000000', NULL, 0.00),
(64, 5, 'AHSAN - BOMBAY TAILOR', '64', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0316-2523800', 'P.E.C.H.S BLOCK # 2, INFRONT OF NORANI KABAB HOUSE', '2025-05-29 16:30:40.000000', '2025-05-29 16:30:40.000000', NULL, 0.00),
(65, 5, 'MOHIUDDIN', '65', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0345-3016753', 'PEELA SCHOOL, NEW KARACHI.', '2025-05-29 17:29:03.000000', '2025-05-29 17:29:03.000000', NULL, 18720.00),
(66, 5, 'SAAD', '66', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0330-5491441', 'LYARI - 36.', '2025-05-29 17:30:27.000000', '2025-05-29 17:30:27.000000', NULL, 0.00),
(67, 5, 'MUFTI DARWESH', '67', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0303-2815803', 'LYARI - 36', '2025-05-29 17:31:18.000000', '2025-05-29 17:31:18.000000', NULL, 0.00),
(68, 5, 'MUKHTUYAR - ALNOOR TAILOR - SAIF', '68', 1, 'no_avatar.png', '', NULL, 'KARACHI', '03005146387', 'SADDI TOWN.', '2025-05-29 17:32:20.000000', '2025-05-29 17:32:40.000000', NULL, 0.00),
(69, 5, 'MASTER SAJJAD - SAIF', '69', 1, 'no_avatar.png', '', NULL, 'KARACHI', '', 'SADDI TOWN.', '2025-05-29 17:33:17.000000', '2025-05-29 17:33:17.000000', NULL, 0.00),
(70, 5, 'ADIL - ZARI MEHEL', '70', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0315-7023855', 'INFRONT  OF UBL BANK, AZIZ ABAD.', '2025-05-30 11:53:27.000000', '2025-05-30 11:53:27.000000', NULL, 0.00),
(71, 5, 'KASHIF BHAI - NIRMAL CLOTH HOUSE', '71', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0314-2983201', 'PRIME HEIGHTS, BACK OF AL-MUSTAFA HOSPITAL, GULSHAN', '2025-05-30 11:55:00.000000', '2025-05-30 11:55:00.000000', NULL, 47053.00),
(72, 5, 'Master sadiq - Tanzaib', '72', 1, 'no_avatar.png', '', NULL, 'Karachi', '0300-2427944', 'PARADISE BAKERY, ABUL AL HASAN ASPHANI ROAD.', '2025-05-31 12:37:57.000000', '2025-05-31 12:37:57.000000', NULL, 0.00),
(73, 5, 'SHARFUDDIN - MUZAMIL CLOTH HOUSE', '73', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0306-2234883', 'JOHAR COMPLEX, NEAR CHASE PLUS, MOSAMIYAT.', '2025-05-31 15:20:33.000000', '2025-05-31 15:20:33.000000', NULL, 0.00),
(74, 5, 'DANISH - ALMADINA', '74', 1, 'no_avatar.png', '', NULL, 'KARACHI', '0300-3052791', 'SHOP # Q6, CHOTA PLAZA, AL-ASIF SQUARE, SOHRAB GOTH.', '2025-05-31 15:39:16.000000', '2025-05-31 15:39:16.000000', NULL, 71400.00);

-- --------------------------------------------------------

--
-- Table structure for table `clients_ledgers`
--

CREATE TABLE `clients_ledgers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` int(11) NOT NULL,
  `type` varchar(191) NOT NULL,
  `reference` varchar(191) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `debit` decimal(15,2) NOT NULL DEFAULT 0.00,
  `credit` decimal(15,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients_ledgers`
--

INSERT INTO `clients_ledgers` (`id`, `client_id`, `type`, `reference`, `date`, `debit`, `credit`, `balance`, `created_at`, `updated_at`) VALUES
(1, 4, 'sale_payment', 'INV/SL-20250513-890943', '2025-05-13 12:34:36', 0.00, 2300.00, -2300.00, '2025-05-13 12:34:36', '2025-05-13 12:34:36'),
(2, 1, 'sale_return_payment', 'INV/RS-20250513-242632', '2025-05-13 12:35:12', 30.30, 0.00, 30.30, '2025-05-13 12:35:12', '2025-05-13 12:35:12'),
(3, 6, 'pos_sale', 'SO-20250513-063148', '2025-05-13 13:31:48', 22430.30, 0.00, 22430.30, '2025-05-13 13:31:48', '2025-05-13 13:31:48'),
(4, 6, 'pos_sale', 'SO-20250513-063220', '2025-05-13 13:32:20', 5000.00, 0.00, 27430.30, '2025-05-13 13:32:20', '2025-05-13 13:32:20'),
(5, 6, 'pos_sale', 'SO-20250513-063338', '2025-05-13 13:33:38', 121.20, 0.00, 27551.50, '2025-05-13 13:33:38', '2025-05-13 13:33:38'),
(6, 6, 'pos_sale', 'SO-20250518-102428', '2025-05-18 05:24:28', 151.50, 0.00, 27703.00, '2025-05-18 05:24:28', '2025-05-18 05:24:28'),
(7, 1, 'pos_sale', 'SO-20250518-104626', '2025-05-18 05:46:26', 12.00, 0.00, 42.30, '2025-05-18 05:46:26', '2025-05-18 05:46:26'),
(8, 1, 'pos_sale', 'SO-20250518-104845', '2025-05-18 05:48:45', 12.00, 0.00, 54.30, '2025-05-18 05:48:45', '2025-05-18 05:48:45'),
(9, 2, 'pos_sale', 'SO-20250518-014755', '2025-05-18 08:47:55', 144.00, 0.00, 144.00, '2025-05-18 08:47:55', '2025-05-18 08:47:55'),
(10, 2, 'pos_sale', 'SO-20250518-020302', '2025-05-18 09:03:02', 24.00, 0.00, 168.00, '2025-05-18 09:03:02', '2025-05-18 09:03:02'),
(11, 1, 'pos_sale', 'SO-20250518-023206', '2025-05-18 09:32:07', 44800.00, 0.00, 44854.30, '2025-05-18 09:32:07', '2025-05-18 09:32:07'),
(12, 3, 'pos_sale', 'SO-20250518-042921', '2025-05-18 11:29:21', 150.00, 0.00, 150.00, '2025-05-18 11:29:21', '2025-05-18 11:29:21'),
(13, 7, 'sale', 'SO-20250521-024519', '2025-05-21 14:45:19', 9246.00, 0.00, 9246.00, '2025-05-21 14:45:19', '2025-05-21 14:45:19'),
(14, 10, 'sale', 'SO-20250521-024732', '2025-05-21 14:47:32', 15047.00, 0.00, 15047.00, '2025-05-21 14:47:32', '2025-05-21 14:47:32'),
(15, 9, 'sale', 'SO-20250521-024913', '2025-05-21 14:49:13', 5881.00, 0.00, 5881.00, '2025-05-21 14:49:13', '2025-05-21 14:49:13'),
(16, 11, 'sale', 'SO-20250521-025126', '2025-05-21 14:51:26', 1200.00, 0.00, 1200.00, '2025-05-21 14:51:26', '2025-05-21 14:51:26'),
(17, 8, 'sale', 'SO-20250521-030501', '2025-05-21 15:05:01', 1380.00, 0.00, 1380.00, '2025-05-21 15:05:01', '2025-05-21 15:05:01'),
(18, 12, 'sale', 'SO-20250521-035912', '2025-05-21 15:59:12', 11121.00, 0.00, 11121.00, '2025-05-21 15:59:12', '2025-05-21 15:59:12'),
(19, 20, 'sale', 'SO-20250522-120145', '2025-05-22 12:01:45', 463.00, 0.00, 463.00, '2025-05-22 12:01:45', '2025-05-22 12:01:45'),
(20, 15, 'sale', 'SO-20250522-120513', '2025-05-22 12:05:13', 13608.96, 0.00, 13608.96, '2025-05-22 12:05:13', '2025-05-22 12:05:13'),
(21, 28, 'sale', 'SO-20250522-121040', '2025-05-22 12:10:40', 7884.00, 0.00, 7884.00, '2025-05-22 12:10:40', '2025-05-22 12:10:40'),
(22, 21, 'sale', 'SO-20250522-121346', '2025-05-22 12:13:46', 11208.00, 0.00, 11208.00, '2025-05-22 12:13:46', '2025-05-22 12:13:46'),
(23, 16, 'sale', 'SO-20250522-122633', '2025-05-22 12:26:33', 17305.00, 0.00, 17305.00, '2025-05-22 12:26:33', '2025-05-22 12:26:33'),
(24, 27, 'sale', 'SO-20250522-122817', '2025-05-22 12:28:17', 20705.00, 0.00, 20705.00, '2025-05-22 12:28:17', '2025-05-22 12:28:17'),
(25, 18, 'sale', 'SO-20250522-123509', '2025-05-22 12:35:09', 5346.00, 0.00, 5346.00, '2025-05-22 12:35:09', '2025-05-22 12:35:09'),
(26, 14, 'sale', 'SO-20250522-123822', '2025-05-22 12:38:22', 21544.00, 0.00, 21544.00, '2025-05-22 12:38:22', '2025-05-22 12:38:22'),
(27, 36, 'sale', 'SO-20250522-015937', '2025-05-22 13:59:37', 2750.00, 0.00, 2750.00, '2025-05-22 13:59:37', '2025-05-22 13:59:37'),
(28, 37, 'sale', 'SO-20250522-020231', '2025-05-22 14:02:31', 3710.00, 0.00, 3710.00, '2025-05-22 14:02:31', '2025-05-22 14:02:31'),
(29, 35, 'sale', 'SO-20250522-020401', '2025-05-22 14:04:01', 11855.00, 0.00, 11855.00, '2025-05-22 14:04:01', '2025-05-22 14:04:01'),
(30, 30, 'sale', 'SO-20250522-020441', '2025-05-22 14:04:41', 4967.00, 0.00, 4967.00, '2025-05-22 14:04:41', '2025-05-22 14:04:41'),
(31, 31, 'sale', 'SO-20250522-020612', '2025-05-22 14:06:12', 5992.00, 0.00, 5992.00, '2025-05-22 14:06:12', '2025-05-22 14:06:12'),
(32, 33, 'sale', 'SO-20250522-023319', '2025-05-22 14:33:19', 19434.00, 0.00, 19434.00, '2025-05-22 14:33:19', '2025-05-22 14:33:19'),
(33, 26, 'sale', 'SO-20250522-023506', '2025-05-22 14:35:06', 4126.00, 0.00, 4126.00, '2025-05-22 14:35:06', '2025-05-22 14:35:06'),
(34, 34, 'sale', 'SO-20250522-023747', '2025-05-22 14:37:47', 9303.00, 0.00, 9303.00, '2025-05-22 14:37:47', '2025-05-22 14:37:47'),
(35, 38, 'sale', 'SO-20250522-031937', '2025-05-22 15:19:37', 8000.00, 0.00, 8000.00, '2025-05-22 15:19:37', '2025-05-22 15:19:37'),
(36, 22, 'sale', 'SO-20250522-045743', '2025-05-22 16:57:43', 12086.00, 0.00, 12086.00, '2025-05-22 16:57:43', '2025-05-22 16:57:43'),
(37, 25, 'sale', 'SO-20250522-065859', '2025-05-22 18:58:59', 5342.00, 0.00, 5342.00, '2025-05-22 18:58:59', '2025-05-22 18:58:59'),
(38, 19, 'sale', 'SO-20250523-020310', '2025-05-23 14:03:10', 57620.00, 0.00, 57620.00, '2025-05-23 14:03:10', '2025-05-23 14:03:10'),
(39, 17, 'sale', 'SO-20250523-020628', '2025-05-23 14:06:28', 2088.00, 0.00, 2088.00, '2025-05-23 14:06:28', '2025-05-23 14:06:28'),
(40, 21, 'sale', 'SO-20250523-023634', '2025-05-23 14:36:34', 7800.00, 0.00, 19008.00, '2025-05-23 14:36:34', '2025-05-23 14:36:34'),
(41, 40, 'sale', 'SO-20250523-024642', '2025-05-23 14:46:42', 9900.00, 0.00, 9900.00, '2025-05-23 14:46:42', '2025-05-23 14:46:42'),
(42, 41, 'sale', 'SO-20250523-025710', '2025-05-23 14:57:10', 8562.00, 0.00, 8562.00, '2025-05-23 14:57:10', '2025-05-23 14:57:10'),
(43, 39, 'sale', 'SO-20250523-052254', '2025-05-23 17:22:54', 6160.00, 0.00, 6160.00, '2025-05-23 17:22:54', '2025-05-23 17:22:54'),
(44, 31, 'sale', 'SO-20250525-023203', '2025-05-25 14:32:03', 1050.00, 0.00, 7042.00, '2025-05-25 14:32:03', '2025-05-25 14:32:03'),
(45, 42, 'sale', 'SO-20250526-020714', '2025-05-26 14:07:14', 6500.00, 0.00, 6500.00, '2025-05-26 14:07:14', '2025-05-26 14:07:14'),
(46, 1, 'sale', 'SO-20250526-021837', '2025-05-26 14:18:37', 466.00, 0.00, 45320.30, '2025-05-26 14:18:37', '2025-05-26 14:18:37'),
(47, 1, 'sale', 'SO-20250526-030113', '2025-05-26 15:01:13', 95.00, 0.00, 45415.30, '2025-05-26 15:01:13', '2025-05-26 15:01:13'),
(48, 22, 'sale', 'SO-20250526-052532', '2025-05-26 17:25:32', 7764.00, 0.00, 19850.00, '2025-05-26 17:25:32', '2025-05-26 17:25:32'),
(49, 43, 'sale', 'SO-20250526-053544', '2025-05-26 17:35:44', 25314.72, 0.00, 25314.72, '2025-05-26 17:35:44', '2025-05-26 17:35:44'),
(50, 23, 'sale', 'SO-20250526-054209', '2025-05-26 17:42:09', 7656.00, 0.00, 7656.00, '2025-05-26 17:42:09', '2025-05-26 17:42:09'),
(51, 44, 'sale', 'SO-20250527-091307', '2025-05-27 09:13:07', 5400.00, 0.00, 5400.00, '2025-05-27 09:13:07', '2025-05-27 09:13:07'),
(52, 22, 'sale', 'SO-20250527-094735', '2025-05-27 09:47:35', 13842.00, 0.00, 33692.00, '2025-05-27 09:47:35', '2025-05-27 09:47:35'),
(53, 46, 'sale', 'SO-20250527-104917', '2025-05-27 10:49:17', 47250.00, 0.00, 47250.00, '2025-05-27 10:49:17', '2025-05-27 10:49:17'),
(54, 45, 'sale', 'SO-20250527-110140', '2025-05-27 11:01:40', 13100.00, 0.00, 13100.00, '2025-05-27 11:01:40', '2025-05-27 11:01:40'),
(55, 47, 'sale', 'SO-20250527-120056', '2025-05-27 12:00:56', 8215.00, 0.00, 8215.00, '2025-05-27 12:00:56', '2025-05-27 12:00:56'),
(56, 51, 'sale', 'SO-20250527-122319', '2025-05-27 12:23:19', 115564.16, 0.00, 115564.16, '2025-05-27 12:23:19', '2025-05-27 12:23:19'),
(57, 51, 'sale', 'SO-20250527-125358', '2025-05-27 12:53:58', 3650.00, 0.00, 119214.16, '2025-05-27 12:53:58', '2025-05-27 12:53:58'),
(58, 1, 'sale', 'SO-20250527-013027', '2025-05-27 13:30:27', 7830.00, 0.00, 53245.30, '2025-05-27 13:30:27', '2025-05-27 13:30:27'),
(59, 1, 'pos_sale', 'SO-20250527-015446', '2025-05-27 13:54:46', 120.00, 0.00, 53365.30, '2025-05-27 13:54:46', '2025-05-27 13:54:46'),
(60, 50, 'sale', 'SO-20250527-021941', '2025-05-27 14:19:41', 4526.00, 0.00, 4526.00, '2025-05-27 14:19:41', '2025-05-27 14:19:41'),
(61, 7, 'sale', 'SO-20250527-022332', '2025-05-27 14:23:32', 9738.00, 0.00, 18984.00, '2025-05-27 14:23:32', '2025-05-27 14:23:32'),
(62, 49, 'sale', 'SO-20250527-022454', '2025-05-27 14:24:54', 2415.00, 0.00, 2415.00, '2025-05-27 14:24:54', '2025-05-27 14:24:54'),
(63, 48, 'sale', 'SO-20250527-022615', '2025-05-27 14:26:15', 8743.00, 0.00, 8743.00, '2025-05-27 14:26:15', '2025-05-27 14:26:15'),
(64, 1, 'pos_sale', 'SO-20250527-023219', '2025-05-27 14:32:19', 240.00, 0.00, 53605.30, '2025-05-27 14:32:19', '2025-05-27 14:32:19'),
(65, 38, 'sale', 'SO-20250527-025751', '2025-05-27 14:57:51', 34192.00, 0.00, 42192.00, '2025-05-27 14:57:51', '2025-05-27 14:57:51'),
(66, 38, 'sale', 'SO-20250527-030201', '2025-05-27 15:02:01', 7550.00, 0.00, 49742.00, '2025-05-27 15:02:01', '2025-05-27 15:02:01'),
(67, 52, 'sale', 'SO-20250527-030549', '2025-05-27 15:05:49', 15508.00, 0.00, 15508.00, '2025-05-27 15:05:49', '2025-05-27 15:05:49'),
(68, 53, 'sale', 'SO-20250527-030626', '2025-05-27 15:06:26', 6440.00, 0.00, 6440.00, '2025-05-27 15:06:26', '2025-05-27 15:06:26'),
(69, 54, 'sale', 'SO-20250527-030722', '2025-05-27 15:07:22', 4691.00, 0.00, 4691.00, '2025-05-27 15:07:22', '2025-05-27 15:07:22'),
(70, 1, 'pos_sale', 'SO-20250527-033250', '2025-05-27 15:32:50', 900.00, 0.00, 54505.30, '2025-05-27 15:32:50', '2025-05-27 15:32:50'),
(71, 1, 'pos_sale', 'SO-20250527-034220', '2025-05-27 15:42:20', 180.00, 0.00, 54685.30, '2025-05-27 15:42:20', '2025-05-27 15:42:20'),
(72, 55, 'sale', 'SO-20250527-040839', '2025-05-27 16:08:39', 19533.00, 0.00, 19533.00, '2025-05-27 16:08:39', '2025-05-27 16:08:39'),
(73, 56, 'sale', 'SO-20250527-040946', '2025-05-27 16:09:46', 4915.00, 0.00, 4915.00, '2025-05-27 16:09:46', '2025-05-27 16:09:46'),
(74, 1, 'pos_sale', 'SO-20250527-042249', '2025-05-27 16:22:49', 100.00, 0.00, 54785.30, '2025-05-27 16:22:49', '2025-05-27 16:22:49'),
(75, 1, 'pos_sale', 'SO-20250527-044802', '2025-05-27 16:48:02', 480.00, 0.00, 55265.30, '2025-05-27 16:48:02', '2025-05-27 16:48:02'),
(76, 45, 'sale', 'SO-20250527-051128', '2025-05-27 17:11:28', 2000.00, 0.00, 15100.00, '2025-05-27 17:11:28', '2025-05-27 17:11:28'),
(77, 43, 'sale', 'SO-20250527-051616', '2025-05-27 17:16:16', 10350.00, 0.00, 35664.72, '2025-05-27 17:16:16', '2025-05-27 17:16:16'),
(78, 1, 'pos_sale', 'SO-20250527-052605', '2025-05-27 17:26:05', 1200.00, 0.00, 56465.30, '2025-05-27 17:26:05', '2025-05-27 17:26:05'),
(79, 1, 'pos_sale', 'SO-20250527-053343', '2025-05-27 17:33:43', 480.00, 0.00, 56945.30, '2025-05-27 17:33:43', '2025-05-27 17:33:43'),
(80, 1, 'pos_sale', 'SO-20250527-053621', '2025-05-27 17:36:21', 400.00, 0.00, 57345.30, '2025-05-27 17:36:21', '2025-05-27 17:36:21'),
(81, 59, 'opening_balance', 'Opening Balance', '2025-05-28 15:46:39', 1222.00, 0.00, 1222.00, '2025-05-28 15:46:39', '2025-05-28 15:46:39'),
(82, 59, 'opening_balance_update', 'Opening Balance Updated', '2025-05-28 16:10:13', 150.00, 0.00, 1372.00, '2025-05-28 16:10:13', '2025-05-28 16:10:13'),
(83, 43, 'sale', 'SO-20250528-045231', '2025-05-28 16:52:31', 10039.50, 0.00, 45704.22, '2025-05-28 16:52:31', '2025-05-28 16:52:31'),
(84, 1, 'sale', 'SO-20250528-100922', '2025-05-28 22:09:22', 360.00, 0.00, 57705.30, '2025-05-28 22:09:22', '2025-05-28 22:09:22'),
(85, 1, 'sale_return', 'RT_1122', '2025-05-28 22:10:24', 0.00, 360.00, 57345.30, '2025-05-28 22:10:24', '2025-05-28 22:10:24'),
(86, 15, 'sale', 'SO-20250529-085530', '2025-05-29 08:55:30', 4415.00, 0.00, 18023.96, '2025-05-29 08:55:30', '2025-05-29 08:55:30'),
(87, 27, 'sale', 'SO-20250529-085623', '2025-05-29 08:56:23', 6562.00, 0.00, 27267.00, '2025-05-29 08:56:23', '2025-05-29 08:56:23'),
(88, 14, 'sale', 'SO-20250529-085757', '2025-05-29 08:57:57', 6070.00, 0.00, 27614.00, '2025-05-29 08:57:57', '2025-05-29 08:57:57'),
(89, 13, 'sale', 'SO-20250529-090003', '2025-05-29 09:00:03', 7085.00, 0.00, 7085.00, '2025-05-29 09:00:03', '2025-05-29 09:00:03'),
(90, 20, 'sale', 'SO-20250529-090056', '2025-05-29 09:00:56', 6314.00, 0.00, 6777.00, '2025-05-29 09:00:56', '2025-05-29 09:00:56'),
(91, 28, 'sale', 'SO-20250529-090150', '2025-05-29 09:01:50', 10198.00, 0.00, 18082.00, '2025-05-29 09:01:50', '2025-05-29 09:01:50'),
(92, 16, 'sale', 'SO-20250529-120927', '2025-05-29 12:09:27', 132851.00, 0.00, 150156.00, '2025-05-29 12:09:27', '2025-05-29 12:09:27'),
(93, 21, 'sale', 'SO-20250529-121047', '2025-05-29 12:10:47', 1505.00, 0.00, 20513.00, '2025-05-29 12:10:47', '2025-05-29 12:10:47'),
(94, 60, 'sale', 'SO-20250529-123858', '2025-05-29 12:38:58', 11626.00, 0.00, 11626.00, '2025-05-29 12:38:58', '2025-05-29 12:38:58'),
(95, 61, 'opening_balance', 'Opening Balance', '2025-05-29 12:45:12', 6000.00, 0.00, 6000.00, '2025-05-29 12:45:12', '2025-05-29 12:45:12'),
(96, 61, 'sale', 'SO-20250529-124632', '2025-05-29 12:46:32', 14950.00, 0.00, 20950.00, '2025-05-29 12:46:32', '2025-05-29 12:46:32'),
(97, 37, 'sale', 'SO-20250529-031640', '2025-05-29 15:16:40', 6170.00, 0.00, 9880.00, '2025-05-29 15:16:40', '2025-05-29 15:16:40'),
(98, 56, 'sale', 'SO-20250529-031807', '2025-05-29 15:18:07', 29813.00, 0.00, 34728.00, '2025-05-29 15:18:07', '2025-05-29 15:18:07'),
(99, 55, 'sale', 'SO-20250529-032117', '2025-05-29 15:21:17', 3120.00, 0.00, 22653.00, '2025-05-29 15:21:17', '2025-05-29 15:21:17'),
(100, 30, 'sale', 'SO-20250529-034159', '2025-05-29 15:41:59', 9787.00, 0.00, 14754.00, '2025-05-29 15:41:59', '2025-05-29 15:41:59'),
(101, 40, 'sale', 'SO-20250529-034311', '2025-05-29 15:43:11', 13200.00, 0.00, 23100.00, '2025-05-29 15:43:11', '2025-05-29 15:43:11'),
(102, 25, 'sale', 'SO-20250529-035654', '2025-05-29 15:56:54', 3852.00, 0.00, 9194.00, '2025-05-29 15:56:54', '2025-05-29 15:56:54'),
(103, 62, 'sale', 'SO-20250529-041752', '2025-05-29 16:17:52', 7843.00, 0.00, 7843.00, '2025-05-29 16:17:52', '2025-05-29 16:17:52'),
(104, 26, 'sale', 'SO-20250529-042201', '2025-05-29 16:22:01', 4190.00, 0.00, 8316.00, '2025-05-29 16:22:01', '2025-05-29 16:22:01'),
(105, 63, 'sale', 'SO-20250529-042604', '2025-05-29 16:26:04', 4738.00, 0.00, 4738.00, '2025-05-29 16:26:04', '2025-05-29 16:26:04'),
(106, 29, 'sale', 'SO-20250529-043240', '2025-05-29 16:32:40', 3916.00, 0.00, 3916.00, '2025-05-29 16:32:40', '2025-05-29 16:32:40'),
(107, 64, 'sale', 'SO-20250529-043351', '2025-05-29 16:33:51', 6776.00, 0.00, 6776.00, '2025-05-29 16:33:51', '2025-05-29 16:33:51'),
(108, 23, 'sale', 'SO-20250529-051806', '2025-05-29 17:18:06', 4075.00, 0.00, 11731.00, '2025-05-29 17:18:06', '2025-05-29 17:18:06'),
(109, 65, 'opening_balance', 'Opening Balance', '2025-05-29 17:29:03', 18720.00, 0.00, 18720.00, '2025-05-29 17:29:03', '2025-05-29 17:29:03'),
(110, 1, 'sale', 'SO-20250529-073626', '2025-05-29 19:36:26', 360.00, 0.00, 57705.30, '2025-05-29 19:36:26', '2025-05-29 19:36:26'),
(111, 71, 'opening_balance', 'Opening Balance', '2025-05-30 11:55:00', 47053.00, 0.00, 47053.00, '2025-05-30 11:55:00', '2025-05-30 11:55:00'),
(112, 71, 'sale', 'SO-20250530-115618', '2025-05-30 11:56:18', 3150.00, 0.00, 50203.00, '2025-05-30 11:56:18', '2025-05-30 11:56:18'),
(113, 70, 'sale', 'SO-20250530-115909', '2025-05-30 11:59:09', 15724.36, 0.00, 15724.36, '2025-05-30 11:59:09', '2025-05-30 11:59:09'),
(114, 35, 'sale', 'SO-20250530-022316', '2025-05-30 14:23:16', 11408.00, 0.00, 23263.00, '2025-05-30 14:23:16', '2025-05-30 14:23:16'),
(115, 34, 'sale', 'SO-20250530-030033', '2025-05-30 15:00:33', 6871.00, 0.00, 16174.00, '2025-05-30 15:00:33', '2025-05-30 15:00:33'),
(116, 33, 'sale', 'SO-20250530-030717', '2025-05-30 15:07:17', 7413.00, 0.00, 26847.00, '2025-05-30 15:07:17', '2025-05-30 15:07:17'),
(117, 41, 'sale', 'SO-20250530-030929', '2025-05-30 15:09:29', 12198.00, 0.00, 20760.00, '2025-05-30 15:09:29', '2025-05-30 15:09:29'),
(118, 31, 'sale', 'SO-20250530-031153', '2025-05-30 15:11:53', 6401.00, 0.00, 13443.00, '2025-05-30 15:11:53', '2025-05-30 15:11:53'),
(119, 51, 'sale', 'SO-20250530-031843', '2025-05-30 15:18:43', 31991.50, 0.00, 151205.66, '2025-05-30 15:18:43', '2025-05-30 15:18:43'),
(120, 36, 'sale', 'SO-20250530-033116', '2025-05-30 15:31:16', 4033.00, 0.00, 6783.00, '2025-05-30 15:31:16', '2025-05-30 15:31:16'),
(121, 40, 'sale', 'SO-20250530-033505', '2025-05-30 15:35:05', 5350.00, 0.00, 28450.00, '2025-05-30 15:35:05', '2025-05-30 15:35:05'),
(122, 43, 'sale', 'SO-20250530-041728', '2025-05-30 16:17:28', 5692.50, 0.00, 51396.72, '2025-05-30 16:17:28', '2025-05-30 16:17:28'),
(123, 10, 'sale', 'SO-20250531-104946', '2025-05-31 10:49:46', 9371.00, 0.00, 24418.00, '2025-05-31 10:49:46', '2025-05-31 10:49:46'),
(124, 55, 'sale', 'SO-20250531-123413', '2025-05-31 12:34:13', 8580.00, 0.00, 31233.00, '2025-05-31 12:34:13', '2025-05-31 12:34:13'),
(125, 56, 'sale', 'SO-20250531-123457', '2025-05-31 12:34:57', 3120.00, 0.00, 37848.00, '2025-05-31 12:34:57', '2025-05-31 12:34:57'),
(126, 72, 'sale', 'SO-20250531-123840', '2025-05-31 12:38:40', 7800.00, 0.00, 7800.00, '2025-05-31 12:38:40', '2025-05-31 12:38:40'),
(127, 42, 'sale', 'SO-20250531-014559', '2025-05-31 13:45:59', 26609.00, 0.00, 33109.00, '2025-05-31 13:45:59', '2025-05-31 13:45:59'),
(128, 73, 'sale', 'SO-20250531-032157', '2025-05-31 15:21:57', 5797.00, 0.00, 5797.00, '2025-05-31 15:21:57', '2025-05-31 15:21:57'),
(129, 74, 'opening_balance', 'Opening Balance', '2025-05-31 15:39:16', 71400.00, 0.00, 71400.00, '2025-05-31 15:39:16', '2025-05-31 15:39:16'),
(130, 74, 'sale', 'SO-20250531-034131', '2025-05-31 15:41:31', 3690.00, 0.00, 75090.00, '2025-05-31 15:41:31', '2025-05-31 15:41:31'),
(131, 1, 'pos_sale', 'SO-20250612-044243', '2025-06-12 16:42:43', 220.00, 0.00, 57925.30, '2025-06-12 16:42:43', '2025-06-12 16:42:43'),
(132, 57, 'sale', 'SO-20250614-013145', '2025-06-14 13:31:45', 12200.00, 0.00, 12200.00, '2025-06-14 13:31:45', '2025-06-14 13:31:45'),
(133, 1, 'pos_sale', 'SO-20250615-123714', '2025-06-15 12:37:14', 115.00, 0.00, 58040.30, '2025-06-15 12:37:14', '2025-06-15 12:37:14'),
(134, 57, 'sale', 'SO-20250617-164', '2025-06-17 19:36:02', 6600.00, 0.00, 18800.00, '2025-06-17 19:36:02', '2025-06-17 19:36:02'),
(135, 1, 'pos_sale', 'SO-20250622-165', '2025-06-22 14:56:56', 115.00, 0.00, 58155.30, '2025-06-22 14:56:56', '2025-06-22 14:56:56');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` int(11) NOT NULL,
  `code` varchar(192) NOT NULL,
  `name` varchar(192) NOT NULL,
  `symbol` varchar(192) NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `code`, `name`, `symbol`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'USD', 'US Dollar', '$', NULL, NULL, NULL),
(2, 'PKR', 'Pakistani Rupee', 'PKR', '2025-04-26 06:36:52.000000', '2025-04-26 06:36:52.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `deposit_category_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `deposit_ref` varchar(192) NOT NULL,
  `description` text DEFAULT NULL,
  `attachment` varchar(192) DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deposits`
--

INSERT INTO `deposits` (`id`, `account_id`, `deposit_category_id`, `amount`, `payment_method_id`, `date`, `deposit_ref`, `description`, `attachment`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 6, 3, 400.00, 1, '2025-05-27 00:00:00', 'JAZZ CASH', 'MUJAHID CASH EXCHANGE FROM J.CASH', NULL, '2025-05-27 11:19:15.000000', '2025-05-27 11:19:15.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `deposit_categories`
--

CREATE TABLE `deposit_categories` (
  `id` int(11) NOT NULL,
  `title` varchar(192) NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deposit_categories`
--

INSERT INTO `deposit_categories` (`id`, `title`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Cash', '2025-04-26 06:42:41.000000', '2025-05-27 09:31:19.000000', NULL),
(2, 'Cheque', '2025-05-27 09:31:10.000000', '2025-05-27 09:31:10.000000', NULL),
(3, 'Online', '2025-05-27 09:31:27.000000', '2025-05-27 09:31:27.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `email_messages`
--

CREATE TABLE `email_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(192) DEFAULT NULL,
  `subject` varchar(192) DEFAULT NULL,
  `body` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `email_messages`
--

INSERT INTO `email_messages` (`id`, `name`, `subject`, `body`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'sale', 'Thank you for your purchase!', '<h1><span>Dear  {contact_name},</span></h1><p style=\"color:rgb(17,24,39);font-size:16px;\">Thank you for your purchase! Your invoice number is {invoice_number}.</p><p style=\"color:rgb(17,24,39);font-size:16px;\">If you have any questions or concerns, please don\'t hesitate to reach out to us. We are here to help!</p><p style=\"color:rgb(17,24,39);font-size:16px;\">Best regards,</p><p style=\"color:rgb(17,24,39);font-size:16px;\"><span>{business_name}</span></p>', NULL, NULL, NULL),
(2, 'quotation', 'Thank you for your interest in our products !', '<p style=\"color:rgb(17,24,39);font-size:16px;\"><span>Dear {contact_name},</span></p><p style=\"color:rgb(17,24,39);font-size:16px;\">Thank you for your interest in our products. Your quotation number is {quotation_number}.</p><p style=\"color:rgb(17,24,39);font-size:16px;\">Please let us know if you have any questions or concerns regarding your quotation. We are here to assist you.</p><p style=\"color:rgb(17,24,39);font-size:16px;\">Best regards,</p><p style=\"color:rgb(17,24,39);font-size:16px;\"><span>{business_name}</span></p>', NULL, NULL, NULL),
(3, 'payment_received', 'Payment Received - Thank You', '<p style=\"color:rgb(17,24,39);font-size:16px;\"><span>Dear {contact_name},</span></p><p style=\"color:rgb(17,24,39);font-size:16px;\">Thank you for making your payment. We have received it and it has been processed successfully.</p><p style=\"color:rgb(17,24,39);font-size:16px;\">If you have any further questions or concerns, please don\'t hesitate to reach out to us. We are always here to help.</p><p style=\"color:rgb(17,24,39);font-size:16px;\">Best regards,</p><p style=\"color:rgb(17,24,39);font-size:16px;\"><span>{business_name}</span></p>', NULL, NULL, NULL),
(4, 'purchase', 'Thank You for Your Cooperation and Service', '<p style=\"color:rgb(17,24,39);font-size:16px;\"><span>Dear {contact_name},</span></p><p style=\"color:rgb(17,24,39);font-size:16px;\">I recently made a purchase from your company and I wanted to thank you for your cooperation and service. My invoice number is {invoice_number} .</p><p style=\"color:rgb(17,24,39);font-size:16px;\">If you have any questions or concerns regarding my purchase, please don\'t hesitate to contact me. I am here to make sure I have a positive experience with your company.</p><p style=\"color:rgb(17,24,39);font-size:16px;\">Best regards,</p><p style=\"color:rgb(17,24,39);font-size:16px;\"><span>{business_name}</span></p>', NULL, NULL, NULL),
(5, 'payment_sent', 'Payment Sent - Thank You for Your Service', '<p style=\"color:rgb(17,24,39);font-size:16px;\"><span>Dear {contact_name},</span></p><p style=\"color:rgb(17,24,39);font-size:16px;\">We have just sent the payment . We appreciate your prompt attention to this matter and the high level of service you provide.</p><p style=\"color:rgb(17,24,39);font-size:16px;\">If you need any further information or clarification, please do not hesitate to reach out to us. We are here to help.</p><p style=\"color:rgb(17,24,39);font-size:16px;\">Best regards,</p><p style=\"color:rgb(17,24,39);font-size:16px;\"><span>{business_name}</span></p>', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `expense_category_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `expense_ref` varchar(192) NOT NULL,
  `description` text DEFAULT NULL,
  `attachment` varchar(192) DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `account_id`, `expense_category_id`, `amount`, `payment_method_id`, `date`, `expense_ref`, `description`, `attachment`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 4, 500.00, 6, '2025-04-25 00:00:00', 'n/a', '', NULL, '2025-04-26 14:11:07.000000', '2025-04-26 14:11:07.000000', NULL),
(2, 2, 2, 1000.00, 3, '2025-04-25 00:00:00', 'n/a', '', NULL, '2025-04-26 14:11:46.000000', '2025-04-26 14:11:46.000000', NULL),
(3, 5, 13, 403.00, 1, '2025-05-27 00:00:00', 'JAZZ CASH', 'MUJAHID CASH EXCHANGE', NULL, '2025-05-27 11:20:59.000000', '2025-05-27 11:20:59.000000', NULL),
(4, 6, 9, 250.00, 6, '2025-05-27 00:00:00', 'SAIF - BOLTON', '', NULL, '2025-05-27 15:03:50.000000', '2025-05-27 15:03:50.000000', NULL),
(5, 6, 9, 500.00, 6, '2025-05-25 00:00:00', '001', '', '1748633011.pdf', '2025-05-30 19:23:31.000000', '2025-05-30 19:23:31.000000', NULL),
(6, 6, 14, 111.00, 6, '2025-06-10 00:00:00', '', 'ffe', '1749909430.pdf', '2025-06-14 13:57:10.000000', '2025-06-14 13:57:59.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(11) NOT NULL,
  `title` varchar(192) NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `title`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Water & Tea', '2025-04-26 06:42:21.000000', '2025-05-26 21:11:37.000000', NULL),
(2, 'transportaion', '2025-04-26 14:09:31.000000', '2025-05-26 21:15:16.000000', '2025-05-26 21:15:16'),
(3, 'Staff entertainment.', '2025-04-26 14:09:45.000000', '2025-05-26 21:10:30.000000', NULL),
(4, 'Rent', '2025-04-26 14:09:55.000000', '2025-05-26 21:10:45.000000', NULL),
(5, 'Salaries', '2025-04-26 14:10:08.000000', '2025-05-26 21:11:51.000000', NULL),
(6, 'Commission.', '2025-05-26 21:12:08.000000', '2025-05-26 21:12:08.000000', NULL),
(7, 'Drawings', '2025-05-26 21:12:20.000000', '2025-05-26 21:12:20.000000', NULL),
(8, 'Parking.', '2025-05-26 21:12:38.000000', '2025-05-26 21:12:38.000000', NULL),
(9, 'Transportation', '2025-05-26 21:13:16.000000', '2025-05-26 21:13:16.000000', NULL),
(10, 'Mics.', '2025-05-26 21:13:52.000000', '2025-05-26 21:13:52.000000', NULL),
(11, 'Repair and maintainance.', '2025-05-26 21:14:29.000000', '2025-05-26 21:14:29.000000', NULL),
(12, 'Marketing', '2025-05-26 21:17:54.000000', '2025-05-26 21:17:54.000000', NULL),
(13, 'TRANSFER TO SHOP CASH', '2025-05-27 11:17:18.000000', '2025-05-27 11:17:18.000000', NULL),
(14, 'bad-debts', '2025-05-30 19:48:33.000000', '2025-05-30 19:48:33.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(2, '2023_06_15_231338_create_accounts_table', 1),
(3, '2023_06_15_231338_create_adjustment_details_table', 1),
(4, '2023_06_15_231338_create_adjustments_table', 1),
(5, '2023_06_15_231338_create_brands_table', 1),
(6, '2023_06_15_231338_create_categories_table', 1),
(7, '2023_06_15_231338_create_clients_table', 1),
(8, '2023_06_15_231338_create_currencies_table', 1),
(9, '2023_06_15_231338_create_deposit_categories_table', 1),
(10, '2023_06_15_231338_create_deposits_table', 1),
(11, '2023_06_15_231338_create_email_messages_table', 1),
(12, '2023_06_15_231338_create_expense_categories_table', 1),
(13, '2023_06_15_231338_create_expenses_table', 1),
(14, '2023_06_15_231338_create_model_has_permissions_table', 1),
(15, '2023_06_15_231338_create_model_has_roles_table', 1),
(16, '2023_06_15_231338_create_password_resets_table', 1),
(17, '2023_06_15_231338_create_payment_methods_table', 1),
(18, '2023_06_15_231338_create_payment_purchase_returns_table', 1),
(19, '2023_06_15_231338_create_payment_purchases_table', 1),
(20, '2023_06_15_231338_create_payment_sale_returns_table', 1),
(21, '2023_06_15_231338_create_payment_sales_table', 1),
(22, '2023_06_15_231338_create_permissions_table', 1),
(23, '2023_06_15_231338_create_pos_settings_table', 1),
(24, '2023_06_15_231338_create_product_variants_table', 1),
(25, '2023_06_15_231338_create_product_warehouse_table', 1),
(26, '2023_06_15_231338_create_products_table', 1),
(27, '2023_06_15_231338_create_providers_table', 1),
(28, '2023_06_15_231338_create_purchase_details_table', 1),
(29, '2023_06_15_231338_create_purchase_return_details_table', 1),
(30, '2023_06_15_231338_create_purchase_returns_table', 1),
(31, '2023_06_15_231338_create_purchases_table', 1),
(32, '2023_06_15_231338_create_quotation_details_table', 1),
(33, '2023_06_15_231338_create_quotations_table', 1),
(34, '2023_06_15_231338_create_role_has_permissions_table', 1),
(35, '2023_06_15_231338_create_roles_table', 1),
(36, '2023_06_15_231338_create_sale_details_table', 1),
(37, '2023_06_15_231338_create_sale_return_details_table', 1),
(38, '2023_06_15_231338_create_sale_returns_table', 1),
(39, '2023_06_15_231338_create_sales_table', 1),
(40, '2023_06_15_231338_create_settings_table', 1),
(41, '2023_06_15_231338_create_sms_messages_table', 1),
(42, '2023_06_15_231338_create_transfer_details_table', 1),
(43, '2023_06_15_231338_create_transfers_table', 1),
(44, '2023_06_15_231338_create_units_table', 1),
(45, '2023_06_15_231338_create_user_warehouse_table', 1),
(46, '2023_06_15_231338_create_users_table', 1),
(47, '2023_06_15_231338_create_warehouses_table', 1),
(48, '2023_06_15_231341_add_foreign_keys_to_adjustment_details_table', 1),
(49, '2023_06_15_231341_add_foreign_keys_to_adjustments_table', 1),
(50, '2023_06_15_231341_add_foreign_keys_to_clients_table', 1),
(51, '2023_06_15_231341_add_foreign_keys_to_deposits_table', 1),
(52, '2023_06_15_231341_add_foreign_keys_to_expenses_table', 1),
(53, '2023_06_15_231341_add_foreign_keys_to_model_has_permissions_table', 1),
(54, '2023_06_15_231341_add_foreign_keys_to_model_has_roles_table', 1),
(55, '2023_06_15_231341_add_foreign_keys_to_payment_purchase_returns_table', 1),
(56, '2023_06_15_231341_add_foreign_keys_to_payment_purchases_table', 1),
(57, '2023_06_15_231341_add_foreign_keys_to_payment_sale_returns_table', 1),
(58, '2023_06_15_231341_add_foreign_keys_to_payment_sales_table', 1),
(59, '2023_06_15_231341_add_foreign_keys_to_product_variants_table', 1),
(60, '2023_06_15_231341_add_foreign_keys_to_product_warehouse_table', 1),
(61, '2023_06_15_231341_add_foreign_keys_to_products_table', 1),
(62, '2023_06_15_231341_add_foreign_keys_to_providers_table', 1),
(63, '2023_06_15_231341_add_foreign_keys_to_purchase_details_table', 1),
(64, '2023_06_15_231341_add_foreign_keys_to_purchase_return_details_table', 1),
(65, '2023_06_15_231341_add_foreign_keys_to_purchase_returns_table', 1),
(66, '2023_06_15_231341_add_foreign_keys_to_purchases_table', 1),
(67, '2023_06_15_231341_add_foreign_keys_to_quotation_details_table', 1),
(68, '2023_06_15_231341_add_foreign_keys_to_quotations_table', 1),
(69, '2023_06_15_231341_add_foreign_keys_to_role_has_permissions_table', 1),
(70, '2023_06_15_231341_add_foreign_keys_to_sale_details_table', 1),
(71, '2023_06_15_231341_add_foreign_keys_to_sale_return_details_table', 1),
(72, '2023_06_15_231341_add_foreign_keys_to_sale_returns_table', 1),
(73, '2023_06_15_231341_add_foreign_keys_to_sales_table', 1),
(74, '2023_06_15_231341_add_foreign_keys_to_settings_table', 1),
(75, '2023_06_15_231341_add_foreign_keys_to_transfer_details_table', 1),
(76, '2023_06_15_231341_add_foreign_keys_to_transfers_table', 1),
(77, '2023_06_15_231341_add_foreign_keys_to_units_table', 1),
(78, '2023_06_15_231341_add_foreign_keys_to_user_warehouse_table', 1),
(79, '2023_06_15_231341_add_foreign_keys_to_users_table', 1),
(84, '2025_04_29_131519_make_shortname_nullable_in_units_table', 2),
(97, '2025_05_05_100346_create_product_ledgers_table', 3),
(98, '2025_05_05_115112_add_timestamp_to_product_ledgers_table', 3),
(100, '2025_05_07_105652_create_provider_ledgers_table', 4),
(101, '2025_05_13_092928_add_customer_name_and_product_code_to_product_ledgers_table', 5),
(102, '2025_05_13_164600_create_clients_ledgers_table', 6);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 5),
(1, 'App\\Models\\User', 10),
(1, 'App\\Models\\User', 11),
(2, 'App\\Models\\User', 2),
(3, 'App\\Models\\User', 3),
(5, 'App\\Models\\User', 4),
(5, 'App\\Models\\User', 6),
(5, 'App\\Models\\User', 7),
(5, 'App\\Models\\User', 8),
(6, 'App\\Models\\User', 12);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `id` int(11) NOT NULL,
  `title` varchar(192) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_methods`
--

INSERT INTO `payment_methods` (`id`, `title`, `is_default`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Other Payment Method', 0, NULL, NULL, NULL),
(2, 'Paypal', 1, NULL, NULL, NULL),
(3, 'Bank transfer', 0, NULL, NULL, NULL),
(4, 'Credit card', 1, NULL, NULL, NULL),
(5, 'Cheque', 0, NULL, '2025-05-26 21:00:39.000000', NULL),
(6, 'Cash', 0, NULL, NULL, NULL),
(7, 'gy', 0, '2025-05-30 19:58:56.000000', '2025-05-30 19:59:02.000000', '2025-05-30 19:59:02');

-- --------------------------------------------------------

--
-- Table structure for table `payment_purchases`
--

CREATE TABLE `payment_purchases` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `montant` double NOT NULL,
  `change` double NOT NULL DEFAULT 0,
  `payment_method_id` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_purchases`
--

INSERT INTO `payment_purchases` (`id`, `user_id`, `account_id`, `date`, `Ref`, `purchase_id`, `montant`, `change`, `payment_method_id`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, '2025-04-26 19:56:00', 'INV/PO-20250426-312721', 2, 227.25, 0, 6, '', '2025-04-26 09:56:16.000000', '2025-04-26 09:56:16.000000', NULL),
(2, 1, 1, '2025-04-26 20:58:00', 'INV/PO-20250426-331548', 3, 3000, 0, 5, '', '2025-04-26 10:58:40.000000', '2025-04-26 10:58:40.000000', NULL),
(3, 1, 2, '2025-04-26 22:32:00', 'INV/PO-20250426-333191', 4, 31650, 0, 6, '', '2025-04-26 12:33:15.000000', '2025-04-26 12:33:15.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_purchase_returns`
--

CREATE TABLE `payment_purchase_returns` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) NOT NULL,
  `purchase_return_id` int(11) NOT NULL,
  `montant` double NOT NULL,
  `change` double NOT NULL DEFAULT 0,
  `payment_method_id` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_purchase_returns`
--

INSERT INTO `payment_purchase_returns` (`id`, `user_id`, `account_id`, `date`, `Ref`, `purchase_return_id`, `montant`, `change`, `payment_method_id`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, '2025-04-26 21:08:00', 'INV/RP-20250426-295737', 1, 151.5, 0, 6, '', '2025-04-26 11:08:23.000000', '2025-04-26 11:08:23.000000', NULL),
(2, 1, 2, '2025-05-13 21:18:00', 'INV/RP-20250513-257368', 2, 250, 0, 6, '', '2025-05-13 11:19:02.000000', '2025-05-13 11:19:02.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_sales`
--

CREATE TABLE `payment_sales` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `Ref` varchar(192) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `montant` double NOT NULL,
  `change` double NOT NULL DEFAULT 0,
  `payment_method_id` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_sales`
--

INSERT INTO `payment_sales` (`id`, `user_id`, `account_id`, `date`, `Ref`, `sale_id`, `montant`, `change`, `payment_method_id`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, '2025-04-26 16:16:00', 'INV/SL-20250426-423002', 1, 30.3, 0, 6, '', '2025-04-26 06:16:33.000000', '2025-04-26 06:16:33.000000', NULL),
(2, 1, 1, '2025-04-26 16:38:00', 'INV/SL-20250426-147607', 2, 165.3, 0, 6, '', '2025-04-26 06:39:38.000000', '2025-04-26 06:39:38.000000', NULL),
(3, 1, 2, '2025-04-26 20:51:00', 'INV/SL-20250426-186439', 4, 604.5, 0, 6, '', '2025-04-26 10:52:17.000000', '2025-04-26 10:52:17.000000', NULL),
(4, 1, 2, '2025-04-26 20:59:00', 'INV/SL-20250426-907151', 5, 300, 0, 4, '', '2025-04-26 11:00:01.000000', '2025-04-26 11:00:01.000000', NULL),
(5, 1, 1, '2025-04-26 21:02:00', 'INV/SL-20250426-168426', 6, 350, 0, 6, '', '2025-04-26 11:02:20.000000', '2025-04-26 11:02:20.000000', NULL),
(6, 1, 2, '2025-04-26 21:02:00', 'INV/SL-20250426-135126', 3, 44890.9, 0, 6, '', '2025-04-26 11:03:03.000000', '2025-04-26 11:03:03.000000', NULL),
(7, 1, 2, '2025-04-26 22:43:00', 'INV/SL-20250426-192857', 8, 3575, 0, 6, '', '2025-04-26 12:43:51.000000', '2025-04-26 12:43:51.000000', NULL),
(8, 1, 1, '2025-03-29 00:19:00', 'INV/SL-20250426-231732', 12, 30.3, 0, 2, '', '2025-04-26 14:21:02.000000', '2025-04-26 14:21:02.000000', NULL),
(9, 1, 1, '2025-05-05 16:41:00', 'INV/SL-20250505-286011', 22, 5000, 0, 6, '10', '2025-05-05 06:41:50.000000', '2025-05-05 06:41:50.000000', NULL),
(10, 1, 2, '2025-05-05 16:41:00', 'INV/SL-20250505-267031', 23, 5000, 0, 5, '', '2025-05-05 06:42:38.000000', '2025-05-05 06:42:38.000000', NULL),
(11, 1, 2, '2025-05-05 16:42:00', 'INV/SL-20250505-267190', 24, 280.3, 0, 6, '', '2025-05-05 06:47:51.000000', '2025-05-05 06:47:51.000000', NULL),
(12, 1, 2, '2025-05-05 16:48:00', 'INV/SL-20250505-163184', 25, 22400, 0, 6, '', '2025-05-05 06:48:29.000000', '2025-05-05 06:48:29.000000', NULL),
(13, 1, 2, '2025-05-05 17:01:00', 'INV/SL-20250505-277367', 28, 22400, 0, 6, '', '2025-05-05 07:01:43.000000', '2025-05-05 07:01:43.000000', NULL),
(14, 1, 2, '2025-05-05 17:03:00', 'INV/SL-20250505-109532', 29, 22400, 0, 6, '', '2025-05-05 07:27:23.000000', '2025-05-05 07:27:23.000000', NULL),
(15, 1, 1, '2025-05-05 19:11:00', 'INV/SL-20250505-281434', 30, 5000, 0, 6, '', '2025-05-05 09:11:18.000000', '2025-05-05 09:11:18.000000', NULL),
(16, 1, 2, '2025-05-10 17:23:00', 'INV/SL-20250510-206489', 35, 27400, 0, 5, '', '2025-05-10 07:23:49.000000', '2025-05-10 07:23:49.000000', NULL),
(17, 1, 1, '2025-05-10 17:26:00', 'INV/SL-20250510-841059', 36, 303, 0, 6, '', '2025-05-10 07:26:50.000000', '2025-05-10 07:26:50.000000', NULL),
(18, 1, 1, '2025-05-10 18:32:00', 'INV/SL-20250510-669701', 31, 200, 0, 6, '', '2025-05-10 08:33:03.000000', '2025-05-10 08:33:03.000000', NULL),
(19, 1, 1, '2025-05-13 14:39:00', 'INV/SL-20250513-323461', 37, 52.3, 0, 5, '', '2025-05-13 04:39:31.000000', '2025-05-13 04:39:31.000000', NULL),
(20, 1, 1, '2025-05-13 14:43:00', 'INV/SL-20250513-300603', 38, 77.3, 0, 6, '', '2025-05-13 04:44:12.000000', '2025-05-13 04:44:12.000000', NULL),
(21, 1, 2, '2025-05-13 14:44:00', 'INV/SL-20250513-149648', 39, 30.3, 0, 6, '', '2025-05-13 05:09:05.000000', '2025-05-13 05:09:05.000000', NULL),
(22, 1, 2, '2025-05-13 22:34:00', 'INV/SL-20250513-890943', 9, 2300, 0, 5, '', '2025-05-13 12:34:36.000000', '2025-05-13 12:34:36.000000', NULL),
(23, 1, 2, '2025-05-13 23:16:00', 'INV/SL-20250513-322690', 34, 100, 0, 5, '', '2025-05-13 13:16:14.000000', '2025-05-13 13:16:14.000000', NULL),
(24, 1, 2, '2025-05-13 23:31:00', 'INV/SL-20250513-201675', 40, 22430.3, 0, 6, '', '2025-05-13 13:31:48.000000', '2025-05-13 13:31:48.000000', NULL),
(25, 1, 2, '2025-05-13 23:31:00', 'INV/SL-20250513-282774', 41, 5000, 0, 6, '', '2025-05-13 13:32:20.000000', '2025-05-13 13:32:20.000000', NULL),
(26, 1, 1, '2025-05-13 23:33:00', 'INV/SL-20250513-260800', 42, 50, 0, 5, '', '2025-05-13 13:33:39.000000', '2025-05-13 13:33:39.000000', NULL),
(27, 4, 2, '2025-05-18 15:18:00', 'INV/SL-20250518-900390', 42, 50, 0, 6, '', '2025-05-18 05:19:01.000000', '2025-05-18 05:19:01.000000', NULL),
(28, 1, 1, '2025-05-18 15:23:00', 'INV/SL-20250518-475638', 43, 20, 0, 6, '', '2025-05-18 05:24:28.000000', '2025-05-18 05:24:28.000000', NULL),
(29, 1, 2, '2025-05-18 15:45:00', 'INV/SL-20250518-188259', 44, 12, 0, 6, 'u', '2025-05-18 05:46:27.000000', '2025-05-20 15:03:19.000000', '2025-05-20 15:03:19'),
(30, 1, 2, '2025-05-18 15:48:00', 'INV/SL-20250518-159509', 45, 12, 0, 6, '', '2025-05-18 05:48:46.000000', '2025-05-20 15:03:15.000000', '2025-05-20 15:03:15'),
(31, 1, 2, '2025-05-18 18:47:00', 'INV/SL-20250518-568315', 46, 50, 0, 5, '', '2025-05-18 08:47:55.000000', '2025-05-20 15:03:11.000000', '2025-05-20 15:03:11'),
(32, 1, 2, '2025-05-18 18:48:00', 'INV/SL-20250518-829767', 47, 24, 0, 6, '', '2025-05-18 09:03:02.000000', '2025-05-20 15:03:22.000000', '2025-05-20 15:03:22'),
(33, 1, 2, '2025-05-18 19:31:00', 'INV/SL-20250518-109430', 48, 44800, 0, 6, '', '2025-05-18 09:32:07.000000', '2025-05-20 15:03:06.000000', '2025-05-20 15:03:06'),
(34, 1, 2, '2025-05-18 21:28:00', 'INV/SL-20250518-231656', 49, 150, 0, 6, '', '2025-05-18 11:29:21.000000', '2025-05-20 15:03:00.000000', '2025-05-20 15:03:00'),
(35, 6, NULL, '2025-05-21 15:50:00', 'INV/SL-20250522-522279', 53, 1200, 0, 6, 'Total 11,180. Current fully paid. Partial 9982 previous balance paid.', '2025-05-22 10:52:09.000000', '2025-05-22 10:52:09.000000', NULL),
(36, 6, NULL, '2025-05-22 15:52:00', 'INV/SL-20250522-248536', 50, 9246, 0, 6, 'Total rs. 10000 paid', '2025-05-22 10:53:20.000000', '2025-05-22 10:53:20.000000', NULL),
(37, 6, NULL, '2025-05-22 15:53:00', 'INV/SL-20250522-320588', 54, 1380, 0, 6, 'Rs. 9,000 paid.', '2025-05-22 10:53:57.000000', '2025-05-22 10:53:57.000000', NULL),
(38, 6, NULL, '2025-05-22 15:55:00', 'INV/SL-20250522-208406', 51, 15047, 0, 6, '1 part need to deliver. Rs. 18,000 paid', '2025-05-22 10:56:25.000000', '2025-05-22 10:56:25.000000', NULL),
(39, 6, NULL, '2025-05-21 15:57:00', 'INV/SL-20250522-373450', 52, 5881, 0, 6, 'Total 6600\nPervious 708\nCurrent 5881', '2025-05-22 10:58:22.000000', '2025-05-22 10:58:22.000000', NULL),
(40, 6, NULL, '2025-05-22 16:00:00', 'INV/SL-20250522-995863', 55, 11121, 0, 6, 'Total paid 11120', '2025-05-22 11:00:50.000000', '2025-05-22 11:00:50.000000', NULL),
(41, 5, NULL, '2025-05-22 23:55:00', 'INV/SL-20250523-287173', 74, 5342, 0, 6, '5350 receive', '2025-05-23 13:49:24.000000', '2025-05-23 13:49:24.000000', NULL),
(42, 5, NULL, '2025-05-23 18:49:00', 'INV/SL-20250523-748247', 73, 12086, 0, 6, 'Rs. 15,800 receive', '2025-05-23 13:50:49.000000', '2025-05-23 13:50:49.000000', NULL),
(43, 5, NULL, '2025-05-23 18:51:00', 'INV/SL-20250523-104831', 72, 8000, 0, 6, '', '2025-05-23 13:51:18.000000', '2025-05-23 13:51:18.000000', NULL),
(44, 5, NULL, '2025-05-23 18:51:00', 'INV/SL-20250523-107596', 70, 4126, 0, 6, 'Rs, 10,000 paid', '2025-05-23 13:51:56.000000', '2025-05-23 13:51:56.000000', NULL),
(45, 5, NULL, '2025-05-23 18:53:00', 'INV/SL-20250523-366620', 65, 3556, 0, 6, 'Rs. 3560 paid', '2025-05-23 13:54:02.000000', '2025-05-23 13:54:02.000000', NULL),
(46, 5, NULL, '2025-05-23 18:55:00', 'INV/SL-20250523-523684', 63, 14, 0, 6, '', '2025-05-23 13:55:31.000000', '2025-05-23 13:57:01.000000', NULL),
(47, 5, NULL, '2025-05-23 18:55:00', 'INV/SL-20250523-300160', 62, 3530, 0, 6, '', '2025-05-23 13:56:21.000000', '2025-05-23 13:56:21.000000', NULL),
(48, 5, NULL, '2025-05-23 18:57:00', 'INV/SL-20250523-259610', 56, 5000, 0, 6, '', '2025-05-23 13:57:55.000000', '2025-05-23 13:57:55.000000', NULL),
(49, 5, NULL, '2025-05-23 18:58:00', 'INV/SL-20250523-169978', 58, 7880, 0, 6, '', '2025-05-23 13:58:30.000000', '2025-05-23 13:58:30.000000', NULL),
(50, 5, NULL, '2025-05-23 18:58:00', 'INV/SL-20250523-316759', 57, 13608, 0, 6, 'Rs. 13,610 receive', '2025-05-23 13:59:20.000000', '2025-05-23 13:59:20.000000', NULL),
(51, 5, NULL, '2025-05-23 18:59:00', 'INV/SL-20250523-194520', 59, 10000, 0, 6, '', '2025-05-23 13:59:47.000000', '2025-05-23 13:59:47.000000', NULL),
(52, 5, NULL, '2025-05-23 19:00:00', 'INV/SL-20250523-218587', 60, 10000, 0, 6, '', '2025-05-23 14:00:22.000000', '2025-05-23 14:00:22.000000', NULL),
(53, 5, NULL, '2025-05-23 19:00:00', 'INV/SL-20250523-160902', 61, 10, 0, 6, '', '2025-05-23 14:00:48.000000', '2025-05-23 14:00:48.000000', NULL),
(54, 5, NULL, '2025-05-23 19:01:00', 'INV/SL-20250523-338864', 67, 4762, 0, 6, 'Rs. 4,970 receive', '2025-05-23 14:01:28.000000', '2025-05-23 14:01:28.000000', NULL),
(55, 5, NULL, '2025-05-25 20:34:00', 'INV/SL-20250525-364258', 80, 1, 0, 6, 'dummy payment.', '2025-05-25 15:34:34.000000', '2025-05-27 09:14:52.000000', '2025-05-27 09:14:52'),
(56, 5, NULL, '2025-05-26 22:42:00', 'INV/SL-20250526-677231', 87, 3896, 0, 6, '', '2025-05-26 17:43:27.000000', '2025-05-26 17:43:27.000000', NULL),
(57, 5, NULL, '2025-05-25 21:13:00', 'INV/SL-20250527-790201', 82, 6500, 0, 6, 'Collect by saqib', '2025-05-27 09:14:18.000000', '2025-05-27 09:14:18.000000', NULL),
(58, 5, NULL, '2025-05-27 14:15:00', 'INV/SL-20250527-354276', 78, 9900, 0, 6, 'Rs. 10,000 paid.', '2025-05-27 09:15:36.000000', '2025-05-27 09:15:36.000000', NULL),
(59, 5, 6, '2025-05-27 16:14:00', 'INV/SL-20250527-141807', 91, 13100, 0, 6, '', '2025-05-27 11:14:56.000000', '2025-05-27 11:14:56.000000', NULL),
(60, 5, 6, '2025-05-27 17:26:00', 'INV/SL-20250527-266620', 93, 50000, 0, 6, '', '2025-05-27 12:26:44.000000', '2025-05-27 12:26:44.000000', NULL),
(61, 5, 6, '2025-05-27 18:35:00', 'INV/SL-20250527-119187', 95, 7830, 0, 6, 'dedewdw', '2025-05-27 13:35:47.000000', '2025-05-27 13:35:47.000000', NULL),
(62, 5, 6, '2025-05-27 18:53:00', 'INV/SL-20250527-708417', 96, 120, 0, 6, '', '2025-05-27 13:54:46.000000', '2025-05-27 13:54:46.000000', NULL),
(63, 5, 6, '2025-05-27 18:54:00', 'INV/SL-20250527-175030', 101, 240, 0, 6, '', '2025-05-27 14:32:19.000000', '2025-05-27 14:32:19.000000', NULL),
(64, 5, 6, '2025-05-27 20:02:00', 'INV/SL-20250527-332716', 90, 47250, 0, 6, '', '2025-05-27 15:02:55.000000', '2025-05-27 15:02:55.000000', NULL),
(65, 5, 6, '2025-05-27 20:32:00', 'INV/SL-20250527-154419', 107, 900, 0, 6, '', '2025-05-27 15:32:50.000000', '2025-05-27 15:32:50.000000', NULL),
(66, 5, 6, '2025-05-27 20:32:00', 'INV/SL-20250527-177559', 108, 180, 0, 6, '', '2025-05-27 15:42:20.000000', '2025-05-27 15:42:20.000000', NULL),
(67, 5, 6, '2025-05-27 20:52:00', 'INV/SL-20250527-157939', 89, 10000, 0, 6, '', '2025-05-27 15:52:34.000000', '2025-05-27 15:52:34.000000', NULL),
(68, 5, 6, '2025-05-27 20:52:00', 'INV/SL-20250527-711410', 88, 5400, 0, 6, '', '2025-05-27 15:52:57.000000', '2025-05-27 15:52:57.000000', NULL),
(69, 5, 6, '2025-05-27 20:42:00', 'INV/SL-20250527-251675', 111, 100, 0, 6, '', '2025-05-27 16:22:49.000000', '2025-05-27 16:22:49.000000', NULL),
(70, 5, 5, '2025-05-27 21:46:00', 'INV/SL-20250527-215761', 112, 480, 0, 1, 'TID # 081687562366', '2025-05-27 16:48:02.000000', '2025-05-27 16:48:02.000000', NULL),
(71, 5, 6, '2025-05-27 22:00:00', 'INV/SL-20250527-361916', 100, 8470, 0, 6, '', '2025-05-27 17:01:02.000000', '2025-05-27 17:01:02.000000', NULL),
(72, 5, 6, '2025-05-27 22:01:00', 'INV/SL-20250527-331865', 99, 2410, 0, 6, '', '2025-05-27 17:01:37.000000', '2025-05-27 17:01:37.000000', NULL),
(73, 5, 6, '2025-05-27 22:02:00', 'INV/SL-20250527-273638', 110, 4915, 0, 6, 'RS.5,000 PAID', '2025-05-27 17:02:57.000000', '2025-05-27 17:09:06.000000', '2025-05-27 17:09:06'),
(74, 5, 6, '2025-05-27 22:03:00', 'INV/SL-20250527-179614', 92, 5000, 0, 6, '', '2025-05-27 17:03:35.000000', '2025-05-27 17:03:35.000000', NULL),
(75, 5, 6, '2025-05-27 22:07:00', 'INV/SL-20250527-135482', 97, 4526, 0, 6, 'RS. 5000 PAID', '2025-05-27 17:08:22.000000', '2025-05-27 17:08:22.000000', NULL),
(76, 5, 6, '2025-05-27 22:09:00', 'INV/SL-20250527-133504', 109, 10000, 0, 6, '', '2025-05-27 17:10:18.000000', '2025-05-27 17:10:48.000000', NULL),
(77, 5, 6, '2025-05-27 22:11:00', 'INV/SL-20250527-294717', 113, 2000, 0, 6, '', '2025-05-27 17:11:42.000000', '2025-05-27 17:11:42.000000', NULL),
(78, 5, 6, '2025-05-27 22:24:00', 'INV/SL-20250527-239136', 115, 1200, 0, 6, '', '2025-05-27 17:26:05.000000', '2025-05-27 17:26:05.000000', NULL),
(79, 5, 6, '2025-05-27 22:26:00', 'INV/SL-20250527-312403', 116, 480, 0, 6, '', '2025-05-27 17:33:43.000000', '2025-05-27 17:33:43.000000', NULL),
(80, 5, 6, '2025-05-27 22:35:00', 'INV/SL-20250527-242980', 117, 400, 0, 6, '', '2025-05-27 17:36:21.000000', '2025-05-27 17:36:21.000000', NULL),
(81, 1, 6, '2025-05-29 03:40:00', 'INV/SL-20250528-238216', 119, 361, 0, 6, '', '2025-05-28 22:41:15.000000', '2025-05-29 08:54:36.000000', '2025-05-29 08:54:36'),
(82, 5, 6, '2025-05-29 21:48:00', 'INV/SL-20250529-118060', 136, 7840, 0, 6, '', '2025-05-29 16:48:53.000000', '2025-05-29 16:48:53.000000', NULL),
(83, 5, 6, '2025-05-29 21:50:00', 'INV/SL-20250529-136804', 131, 20000, 0, 6, '', '2025-05-29 16:50:33.000000', '2025-05-29 16:50:33.000000', NULL),
(84, 5, 6, '2025-05-27 21:00:00', 'INV/SL-20250529-110782', 103, 6150, 0, 6, '', '2025-05-29 16:54:54.000000', '2025-05-29 16:54:54.000000', NULL),
(85, 1, 6, '2025-05-30 00:36:00', 'INV/SL-20250529-646565', 142, 120, 0, 6, 'rq3r', '2025-05-29 19:36:51.000000', '2025-05-29 19:40:58.000000', '2025-05-29 19:40:58'),
(86, 5, 6, '2025-05-31 00:51:00', 'INV/SL-20250530-309372', 153, 1, 0, 6, '', '2025-05-30 19:51:37.000000', '2025-05-30 19:51:37.000000', NULL),
(87, 5, 6, '2025-05-31 17:18:00', 'INV/SL-20250531-100308', 154, 9370, 0, 6, '', '2025-05-31 12:18:43.000000', '2025-05-31 12:18:43.000000', NULL),
(88, 5, 6, '2025-05-31 21:26:00', 'INV/SL-20250531-106187', 160, 3000, 0, 6, '', '2025-05-31 16:27:02.000000', '2025-05-31 16:27:02.000000', NULL),
(89, 12, 6, '2025-06-12 21:41:00', 'INV/SL-20250612-280798', 161, 200, 0, 6, '', '2025-06-12 16:42:43.000000', '2025-06-12 16:43:59.000000', '2025-06-12 16:43:59'),
(90, 1, 6, '2025-06-14 18:45:00', 'INV/SL-20250614-197581', 162, 1220000, 0, 6, 'dwd', '2025-06-14 13:45:33.000000', '2025-06-14 13:45:33.000000', NULL),
(91, 1, 6, '2025-06-15 17:36:00', 'INV/SL-20250615-110341', 163, 115, 0, 6, 'q3e', '2025-06-15 12:37:14.000000', '2025-06-15 12:37:14.000000', NULL),
(92, 1, 6, '2025-06-22 19:56:00', 'INV/SL-20250622-895379', 165, 115, 0, 6, '', '2025-06-22 14:56:56.000000', '2025-06-22 14:56:56.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_sale_returns`
--

CREATE TABLE `payment_sale_returns` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) NOT NULL,
  `sale_return_id` int(11) NOT NULL,
  `montant` double NOT NULL,
  `change` double NOT NULL DEFAULT 0,
  `payment_method_id` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_sale_returns`
--

INSERT INTO `payment_sale_returns` (`id`, `user_id`, `account_id`, `date`, `Ref`, `sale_return_id`, `montant`, `change`, `payment_method_id`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 2, '2025-04-26 21:09:00', 'INV/RS-20250426-209270', 2, 15, 0, 5, '', '2025-04-26 11:09:51.000000', '2025-04-26 11:09:51.000000', NULL),
(2, 1, 2, '2025-04-26 21:10:00', 'INV/RS-20250426-207443', 2, 185, 0, 5, '', '2025-04-26 11:10:45.000000', '2025-04-26 11:10:45.000000', NULL),
(3, 1, 2, '2025-04-26 22:42:00', 'INV/RS-20250426-300986', 3, 1287.5, 0, 6, '', '2025-04-26 12:43:00.000000', '2025-04-26 12:43:00.000000', NULL),
(4, 1, 2, '2025-05-13 22:35:00', 'INV/RS-20250513-242632', 4, 30.3, 0, 6, '', '2025-05-13 12:35:12.000000', '2025-05-13 12:35:12.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(192) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'user_view', 'web', NULL, NULL, NULL),
(2, 'user_add', 'web', NULL, NULL, NULL),
(3, 'user_edit', 'web', NULL, NULL, NULL),
(4, 'user_delete', 'web', NULL, NULL, NULL),
(5, 'account_view', 'web', NULL, NULL, NULL),
(6, 'account_add', 'web', NULL, NULL, NULL),
(7, 'account_edit', 'web', NULL, NULL, NULL),
(8, 'account_delete', 'web', NULL, NULL, NULL),
(9, 'deposit_view', 'web', NULL, NULL, NULL),
(10, 'deposit_add', 'web', NULL, NULL, NULL),
(11, 'deposit_edit', 'web', NULL, NULL, NULL),
(12, 'deposit_delete', 'web', NULL, NULL, NULL),
(13, 'expense_view', 'web', NULL, NULL, NULL),
(14, 'expense_add', 'web', NULL, NULL, NULL),
(15, 'expense_edit', 'web', NULL, NULL, NULL),
(16, 'expense_delete', 'web', NULL, NULL, NULL),
(17, 'client_view_all', 'web', NULL, NULL, NULL),
(18, 'client_add', 'web', NULL, NULL, NULL),
(19, 'client_edit', 'web', NULL, NULL, NULL),
(20, 'client_delete', 'web', NULL, NULL, NULL),
(21, 'deposit_category', 'web', NULL, NULL, NULL),
(22, 'payment_method', 'web', NULL, NULL, NULL),
(23, 'expense_category', 'web', NULL, NULL, NULL),
(24, 'settings', 'web', NULL, NULL, NULL),
(25, 'currency', 'web', NULL, NULL, NULL),
(26, 'backup', 'web', NULL, NULL, NULL),
(27, 'group_permission', 'web', NULL, NULL, NULL),
(28, 'products_view', 'web', NULL, NULL, NULL),
(29, 'products_add', 'web', NULL, NULL, NULL),
(30, 'products_edit', 'web', NULL, NULL, NULL),
(31, 'products_delete', 'web', NULL, NULL, NULL),
(32, 'barcode_view', 'web', NULL, NULL, NULL),
(33, 'category', 'web', NULL, NULL, NULL),
(34, 'brand', 'web', NULL, NULL, NULL),
(35, 'unit', 'web', NULL, NULL, NULL),
(36, 'warehouse', 'web', NULL, NULL, NULL),
(37, 'adjustment_view_all', 'web', NULL, NULL, NULL),
(38, 'adjustment_add', 'web', NULL, NULL, NULL),
(39, 'adjustment_edit', 'web', NULL, NULL, NULL),
(40, 'adjustment_delete', 'web', NULL, NULL, NULL),
(41, 'transfer_view_all', 'web', NULL, NULL, NULL),
(42, 'transfer_add', 'web', NULL, NULL, NULL),
(43, 'transfer_edit', 'web', NULL, NULL, NULL),
(44, 'transfer_delete', 'web', NULL, NULL, NULL),
(45, 'sales_view_all', 'web', NULL, NULL, NULL),
(46, 'sales_add', 'web', NULL, NULL, NULL),
(47, 'sales_edit', 'web', NULL, NULL, NULL),
(48, 'sales_delete', 'web', NULL, NULL, NULL),
(49, 'bon_livraison', 'web', NULL, NULL, NULL),
(50, 'purchases_view_all', 'web', NULL, NULL, NULL),
(51, 'purchases_add', 'web', NULL, NULL, NULL),
(52, 'purchases_edit', 'web', NULL, NULL, NULL),
(53, 'purchases_delete', 'web', NULL, NULL, NULL),
(54, 'quotations_view_all', 'web', NULL, NULL, NULL),
(55, 'quotations_add', 'web', NULL, NULL, NULL),
(56, 'quotations_edit', 'web', NULL, NULL, NULL),
(57, 'quotations_delete', 'web', NULL, NULL, NULL),
(58, 'sale_returns_view_all', 'web', NULL, NULL, NULL),
(59, 'sale_returns_add', 'web', NULL, NULL, NULL),
(60, 'sale_returns_edit', 'web', NULL, NULL, NULL),
(61, 'sale_returns_delete', 'web', NULL, NULL, NULL),
(62, 'purchase_returns_view_all', 'web', NULL, NULL, NULL),
(63, 'purchase_returns_add', 'web', NULL, NULL, NULL),
(64, 'purchase_returns_edit', 'web', NULL, NULL, NULL),
(65, 'purchase_returns_delete', 'web', NULL, NULL, NULL),
(66, 'payment_sales_view', 'web', NULL, NULL, NULL),
(67, 'payment_sales_add', 'web', NULL, NULL, NULL),
(68, 'payment_sales_edit', 'web', NULL, NULL, NULL),
(69, 'payment_sales_delete', 'web', NULL, NULL, NULL),
(70, 'payment_purchases_view', 'web', NULL, NULL, NULL),
(71, 'payment_purchases_add', 'web', NULL, NULL, NULL),
(72, 'payment_purchases_edit', 'web', NULL, NULL, NULL),
(73, 'payment_purchases_delete', 'web', NULL, NULL, NULL),
(74, 'payment_sell_returns_view', 'web', NULL, NULL, NULL),
(75, 'payment_sell_returns_add', 'web', NULL, NULL, NULL),
(76, 'payment_sell_returns_edit', 'web', NULL, NULL, NULL),
(77, 'payment_sell_returns_delete', 'web', NULL, NULL, NULL),
(78, 'suppliers_view_all', 'web', NULL, NULL, NULL),
(79, 'suppliers_add', 'web', NULL, NULL, NULL),
(80, 'suppliers_edit', 'web', NULL, NULL, NULL),
(81, 'suppliers_delete', 'web', NULL, NULL, NULL),
(82, 'sale_reports', 'web', NULL, NULL, NULL),
(83, 'purchase_reports', 'web', NULL, NULL, NULL),
(84, 'payment_sale_reports', 'web', NULL, NULL, NULL),
(85, 'payment_purchase_reports', 'web', NULL, NULL, NULL),
(86, 'payment_return_sale_reports', 'web', NULL, NULL, NULL),
(87, 'top_products_report', 'web', NULL, NULL, NULL),
(88, 'report_products', 'web', NULL, NULL, NULL),
(89, 'report_inventaire', 'web', NULL, NULL, NULL),
(90, 'report_clients', 'web', NULL, NULL, NULL),
(91, 'report_fournisseurs', 'web', NULL, NULL, NULL),
(92, 'reports_devis', 'web', NULL, NULL, NULL),
(93, 'reports_alert_qty', 'web', NULL, NULL, NULL),
(94, 'pos', 'web', NULL, NULL, NULL),
(95, 'report_profit', 'web', NULL, NULL, NULL),
(96, 'dashboard', 'web', NULL, NULL, NULL),
(97, 'print_labels', 'web', NULL, NULL, NULL),
(98, 'adjustment_details', 'web', NULL, NULL, NULL),
(99, 'pay_sale_due', 'web', NULL, NULL, NULL),
(100, 'pay_sale_return_due', 'web', NULL, NULL, NULL),
(101, 'client_details', 'web', NULL, NULL, NULL),
(102, 'supplier_details', 'web', NULL, NULL, NULL),
(103, 'pay_purchase_due', 'web', NULL, NULL, NULL),
(104, 'pay_purchase_return_due', 'web', NULL, NULL, NULL),
(105, 'purchases_details', 'web', NULL, NULL, NULL),
(106, 'sales_details', 'web', NULL, NULL, NULL),
(107, 'quotation_details', 'web', NULL, NULL, NULL),
(108, 'sms_settings', 'web', NULL, NULL, NULL),
(109, 'notification_template', 'web', NULL, NULL, NULL),
(110, 'payment_purchase_returns_view', 'web', NULL, NULL, NULL),
(111, 'payment_purchase_returns_add', 'web', NULL, NULL, NULL),
(112, 'payment_purchase_returns_edit', 'web', NULL, NULL, NULL),
(113, 'payment_purchase_returns_delete', 'web', NULL, NULL, NULL),
(114, 'payment_return_purchase_reports', 'web', NULL, NULL, NULL),
(115, 'pos_settings', 'web', NULL, NULL, NULL),
(200, 'adjustment_view_own', 'web', NULL, NULL, NULL),
(201, 'transfer_view_own', 'web', NULL, NULL, NULL),
(202, 'sales_view_own', 'web', NULL, NULL, NULL),
(203, 'purchases_view_own', 'web', NULL, NULL, NULL),
(204, 'quotations_view_own', 'web', NULL, NULL, NULL),
(205, 'sale_returns_view_own', 'web', NULL, NULL, NULL),
(206, 'purchase_returns_view_own', 'web', NULL, NULL, NULL),
(207, 'client_view_own', 'web', NULL, NULL, NULL),
(208, 'suppliers_view_own', 'web', NULL, NULL, NULL),
(209, 'attendance_view_own', 'web', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pos_settings`
--

CREATE TABLE `pos_settings` (
  `id` int(11) NOT NULL,
  `note_customer` varchar(192) NOT NULL DEFAULT 'Thank You For Shopping With Us . Please Come Again',
  `show_note` tinyint(1) NOT NULL DEFAULT 1,
  `show_barcode` tinyint(1) NOT NULL DEFAULT 1,
  `show_discount` tinyint(1) NOT NULL DEFAULT 1,
  `show_customer` tinyint(1) NOT NULL DEFAULT 1,
  `show_email` tinyint(1) NOT NULL DEFAULT 1,
  `show_phone` tinyint(1) NOT NULL DEFAULT 1,
  `show_address` tinyint(1) NOT NULL DEFAULT 1,
  `show_Warehouse` tinyint(1) NOT NULL DEFAULT 1,
  `is_printable` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pos_settings`
--

INSERT INTO `pos_settings` (`id`, `note_customer`, `show_note`, `show_barcode`, `show_discount`, `show_customer`, `show_email`, `show_phone`, `show_address`, `show_Warehouse`, `is_printable`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Thank You For Shopping With Us . Please Come Again', 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `type` varchar(192) NOT NULL,
  `code` varchar(192) NOT NULL,
  `Type_barcode` varchar(192) NOT NULL,
  `name` varchar(192) NOT NULL,
  `cost` double NOT NULL,
  `price` double NOT NULL,
  `category_id` int(11) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `unit_sale_id` int(11) DEFAULT NULL,
  `unit_purchase_id` int(11) DEFAULT NULL,
  `TaxNet` double DEFAULT 0,
  `tax_method` varchar(192) DEFAULT '1',
  `image` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `stock_alert` double DEFAULT 0,
  `qty_min` double DEFAULT 0,
  `is_promo` tinyint(1) NOT NULL DEFAULT 0,
  `promo_price` double NOT NULL DEFAULT 0,
  `promo_start_date` date DEFAULT NULL,
  `promo_end_date` date DEFAULT NULL,
  `is_variant` tinyint(1) NOT NULL DEFAULT 0,
  `is_imei` tinyint(1) NOT NULL DEFAULT 0,
  `not_selling` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `type`, `code`, `Type_barcode`, `name`, `cost`, `price`, `category_id`, `brand_id`, `unit_id`, `unit_sale_id`, `unit_purchase_id`, `TaxNet`, `tax_method`, `image`, `note`, `stock_alert`, `qty_min`, `is_promo`, `promo_price`, `promo_start_date`, `promo_end_date`, `is_variant`, `is_imei`, `not_selling`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'is_single', '62414852', 'CODE128', 'ThinkPad', 1500, 2000, 1, 3, 1, 1, 1, 150, '1', '1745612742.jpg', 'i5 gen 5 256gb ssd 8gb ram', 1500, 0, 0, 0, NULL, NULL, 0, 1, 0, 1, '2025-04-25 15:25:42.000000', '2025-05-18 10:13:23.000000', '2025-05-18 10:13:23'),
(2, 'is_service', '13293863', 'CODE128', 'Dhaga', 0, 20000, 1, 2, NULL, NULL, NULL, 12, '1', '1745664351.jpg', 'Dgaha Golden', 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-04-26 05:45:51.000000', '2025-05-18 10:13:17.000000', '2025-05-18 10:13:17'),
(3, 'is_single', '35030522', 'CODE128', 'Dark Brown Thread', 15, 30, 1, 2, 1, 1, 1, 1, '1', '1745679667.jpg', '', 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-04-26 05:54:23.000000', '2025-05-18 10:13:11.000000', '2025-05-18 10:13:11'),
(4, 'is_variant', '58700739', 'CODE128', 'Collar', 0, 0, 2, 1, 4, 4, 4, 0, '1', '1745682156.jpg', 'Supllier Izhar Mansoor', 150, 1, 0, 0, NULL, NULL, 1, 0, 0, 1, '2025-04-26 10:42:36.000000', '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(5, 'is_variant', '86313801', 'CODE128', 'SHERWANI', 0, 0, 3, 5, 5, 5, 5, 0, '1', '1745688350.jpg', '', 100, 0.12, 0, 0, NULL, NULL, 1, 0, 0, 1, '2025-04-26 12:25:50.000000', '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(6, 'is_single', '43260477', 'CODE128', 'helmet', 500, 550, 2, 3, 4, 4, 4, 0, '1', 'no_image.png', '', 10, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-04-26 13:01:02.000000', '2025-04-26 14:03:36.000000', '2025-04-26 14:03:36'),
(7, 'is_service', '94006406', 'CODE128', 'Dark Brown Thre1', 0, 12, 2, 2, NULL, NULL, NULL, 0, 'null', 'no_image.png', 'dwd', 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-04-29 08:47:40.000000', '2025-05-18 10:12:56.000000', '2025-05-18 10:12:56'),
(8, 'is_single', '58605902', 'CODE128', 'Dull Fiber', 350, 450, 2, 2, 4, 4, 4, 0, '1', '1746876165.png', '', 100, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-10 06:22:45.000000', '2025-05-18 10:12:51.000000', '2025-05-18 10:12:51'),
(9, 'is_variant', '22458658', 'CODE128', 'Collar-M', 0, 0, 2, 3, 5, 5, 5, 0, '1', 'no_image.png', '', 100, 1, 0, 0, NULL, NULL, 1, 0, 0, 1, '2025-05-10 06:25:03.000000', '2025-05-18 10:12:43.000000', '2025-05-18 10:12:43'),
(10, 'is_single', '13358592', 'CODE128', 'Fusing', 1500, 1800, 3, NULL, 4, 4, 4, 0, 'null', 'no_image.png', '', 1500, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-10 06:26:05.000000', '2025-05-18 10:12:38.000000', '2025-05-18 10:12:38'),
(11, 'is_single', '72918070', 'CODE128', 'Kashan Abbas', 15, 30, 1, 1, 1, 1, 1, 0, '1', 'no_image.png', '', 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-18 10:14:34.000000', '2025-05-20 15:02:29.000000', '2025-05-20 15:02:29'),
(12, 'is_single', '27922621', 'CODE128', '200M', 94, 120, 4, 6, 4, 4, 4, 0, '1', '1747836544.jpg', '', 2000, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-21 14:05:25.000000', '2025-06-20 22:21:23.000000', '2025-06-20 22:21:23'),
(13, 'is_single', '99601145', 'CODE128', '200G', 82, 115, 4, 7, 4, 4, 4, 0, '1', '1747836519.jpg', '', 3000, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-21 14:08:39.000000', '2025-05-21 14:08:39.000000', NULL),
(14, 'is_single', '72836795', 'CODE128', '200N', 92, 118, 4, 8, 4, 4, 4, 0, '1', '1747836602.jpg', '', 2000, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-21 14:10:02.000000', '2025-05-21 14:10:02.000000', NULL),
(15, 'is_single', '20148613', 'CODE128', '1\" - FINISH', 235, 300, 5, 9, 9, 9, 9, 0, '1', '1747837757.jpg', '', 50, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-21 14:29:17.000000', '2025-05-21 14:29:17.000000', NULL),
(16, 'is_single', '59476725', 'CODE128', '1.25\" - FINISH', 335, 400, 5, 9, 9, 9, 9, 0, '1', '1747837817.jpg', '', 50, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-21 14:30:17.000000', '2025-06-20 22:15:00.000000', '2025-06-20 22:15:00'),
(17, 'is_single', '84574413', 'CODE128', '1000P', 1500, 2200, 6, 10, 10, 10, 10, 0, '1', '1747838247.jpg', '', 100, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-21 14:37:27.000000', '2025-06-20 22:14:21.000000', '2025-06-20 22:14:21'),
(18, 'is_single', '49073241', 'CODE128', 'P1000', 1410, 2000, 6, 11, 10, 10, 10, 0, '1', '1747838321.jpg', '', 50, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-21 14:38:41.000000', '2025-05-21 14:38:41.000000', NULL),
(19, 'is_single', '17734593', 'CODE128', '200P', 60, 110, 4, 12, 4, 4, 4, 0, '1', 'no_image.png', '', 800, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-22 11:59:27.000000', '2025-05-22 11:59:27.000000', NULL),
(20, 'is_single', '74675288', 'CODE128', '1.25\" - UNFINISH - 30Y', 240, 320, 5, 13, 11, 11, 11, 0, '1', 'no_image.png', '', 10, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-22 14:09:45.000000', '2025-05-22 14:09:45.000000', NULL),
(21, 'is_single', '73136173', 'CODE128', '1.25\" - UNFINISH - 24Y', 190, 250, 5, 13, 11, 11, 11, 0, '1', 'no_image.png', '', 5, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-22 14:10:59.000000', '2025-05-22 14:10:59.000000', NULL),
(22, 'is_single', '27598140', 'CODE128', '1\" - UNFINISH - 25Y', 150, 200, 5, 13, 11, 11, 11, 0, '1', 'no_image.png', '', 30, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-22 14:12:04.000000', '2025-05-22 14:12:04.000000', NULL),
(23, 'is_single', '78690549', 'CODE128', 'Ladies - Matt', 150, 195, 7, 10, 12, 12, 12, 0, '1', 'no_image.png', '', 2, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-23 14:09:30.000000', '2025-05-23 14:09:30.000000', NULL),
(24, 'is_single', '37982477', 'CODE128', '4part - iz', 5.76, 7.5, 7, 10, 9, 9, 9, 0, '1', 'no_image.png', '', 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-23 14:26:46.000000', '2025-05-23 14:31:11.000000', NULL),
(25, 'is_single', '62976466', 'CODE128', '4part - Pkt', 4.6, 6.9, 7, 11, 9, 9, 9, 0, '1', 'no_image.png', '', 5000, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-23 14:30:35.000000', '2025-05-23 17:15:59.000000', NULL),
(26, 'is_single', '10152178', 'CODE128', 'Overlock', 590, 650, 4, 6, 1, 1, 1, 0, '1', 'no_image.png', '', 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-23 16:29:05.000000', '2025-05-23 16:29:05.000000', NULL),
(27, 'is_single', '24540226', 'CODE128', 'chamkili', 70, 90, 4, 14, 4, 4, 4, 0, '1', 'no_image.png', '', 700, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-26 17:20:21.000000', '2025-05-26 17:20:21.000000', NULL),
(28, 'is_single', '99591339', 'CODE128', '200A', 72, 110, 4, 15, 4, 4, 4, 0, '1', 'no_image.png', '', 100, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-27 09:00:53.000000', '2025-05-27 09:00:53.000000', NULL),
(29, 'is_single', '1', 'CODE128', 'COLLAR', 286, 360, 8, 6, 5, 5, 5, 0, '1', 'no_image.png', '', 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-27 13:15:34.000000', '2025-05-27 13:15:34.000000', NULL),
(30, 'is_single', '2', 'CODE128', '1.25\" D.D SHERWANI', 85, 125, 8, 6, 5, 5, 5, 0, '1', 'no_image.png', '', 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-27 13:16:58.000000', '2025-05-27 13:16:58.000000', NULL),
(31, 'is_single', '3', 'CODE128', '1\" D.D SHERWANI LARGE', 75, 100, 8, 6, 5, 5, 5, 0, '1', 'no_image.png', '', 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-27 13:17:55.000000', '2025-05-27 13:17:55.000000', NULL),
(32, 'is_single', '4', 'CODE128', '1\" D.D SHERWANI SMALL', 58, 90, 8, 6, 5, 5, 5, 0, '1', 'no_image.png', '', 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-27 13:19:17.000000', '2025-05-27 13:19:17.000000', NULL),
(33, 'is_single', '5', 'CODE128', 'PERFECT + COLLAR', 248, 300, 8, 16, 5, 5, 5, 0, '1', 'no_image.png', '', 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-27 13:23:50.000000', '2025-05-27 13:23:50.000000', NULL),
(34, 'is_single', '6', 'CODE128', 'CUFF 9.5*2.5', 400, 600, 8, 6, 10, 10, 10, 0, '1', 'no_image.png', '', 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-27 13:27:50.000000', '2025-05-27 13:27:50.000000', NULL),
(35, 'is_single', '7', 'CODE128', 'COLLAR - SI', 332, 450, 8, 17, 5, 5, 5, 0, '1', 'no_image.png', '', 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-27 15:29:35.000000', '2025-05-27 15:29:35.000000', NULL),
(36, 'is_single', '8', 'CODE128', '4PART - LOOSE', 9, 18, 7, 18, 9, 9, 9, 0, '1', 'no_image.png', '', 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-27 16:45:56.000000', '2025-05-27 16:45:56.000000', NULL),
(37, 'is_single', '9', 'CODE128', 'ZIP 9\" - BLACK', 480, 600, 9, 18, 10, 10, 10, 0, '1', 'no_image.png', '', 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-27 17:22:13.000000', '2025-05-27 17:23:38.000000', NULL),
(38, 'is_single', '10', 'CODE128', 'ZIP 9\" - WHITE', 430, 550, 9, 18, 10, 10, 10, 0, '1', 'no_image.png', '', 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-27 17:23:05.000000', '2025-05-27 17:23:05.000000', NULL),
(39, 'is_single', '11', 'CODE128', 'KAJ', 145, 200, 4, 18, 9, 9, 9, 0, '1', 'no_image.png', '', 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-27 17:35:03.000000', '2025-06-20 22:14:14.000000', '2025-06-20 22:14:14'),
(40, 'is_single', '91041091', 'CODE128', '1.25\" - P.Plus', 748, 900, 8, 16, 11, 11, 11, 0, '1', 'no_image.png', '', 20, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-29 10:04:03.000000', '2025-05-29 10:04:03.000000', NULL),
(41, 'is_single', '50233646', 'CODE128', '10:35 - FULL', 4150, 4600, 8, 20, 11, 11, 11, 0, '1', 'no_image.png', '', 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-29 15:37:21.000000', '2025-05-29 15:37:21.000000', NULL),
(42, 'is_variant', '56409744', 'CODE128', '901', 0, 0, 8, 21, 11, 11, 11, 0, '1', 'no_image.png', '', 25, 1, 0, 0, NULL, NULL, 1, 0, 0, 1, '2025-05-29 16:59:19.000000', '2025-06-20 22:14:09.000000', '2025-06-20 22:14:09'),
(43, 'is_single', '10420363', 'CODE128', 'ZIP 6.5\" - WHITE', 82, 360, 9, 18, 10, 10, 10, 0, '1', 'no_image.png', '', 10, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-29 17:02:12.000000', '2025-05-29 17:02:12.000000', NULL),
(44, 'is_single', '71793980', 'CODE128', '2.5\" - P.PLUS', 1563, 1850, 8, 16, 11, 11, 11, 0, '1', 'no_image.png', '', 10, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-29 17:11:54.000000', '2025-05-29 17:13:59.000000', NULL),
(45, 'is_single', '96986174', 'CODE128', '.75\" - P.PLUS', 469, 650, 8, 16, 11, 11, 11, 0, '1', 'no_image.png', '', 20, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-29 17:13:46.000000', '2025-05-29 17:13:46.000000', NULL),
(46, 'is_single', '25885872', 'CODE128', 'tesingt', 12, 22, 5, 6, 1, 1, 1, 0, '1', 'no_image.png', 'tesingt product', 0, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-29 19:09:20.000000', '2025-05-29 19:22:04.000000', '2025-05-29 19:22:04'),
(47, 'is_single', '58416738', 'CODE128', 'M.1000', 372, 550, 4, 6, 4, 4, 4, 0, '1', '1750602621.jpg', '', 3, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-05-30 15:20:13.000000', '2025-06-22 14:30:21.000000', NULL),
(48, 'is_single', '53373371', 'CODE128', 'Gucci Bag', 12, 15, 5, 7, 1, 1, 1, 0, '1', 'no_image.png', '3rGucci Bag', 122, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-06-15 12:39:17.000000', '2025-06-20 22:14:32.000000', '2025-06-20 22:14:32'),
(49, 'is_single', 'DC-1', 'CODE128', 'Dell Chromebook', 15000, 18000, 9, 7, 9, 9, 9, 0, '1', 'no_image.png', '', 5, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-06-20 06:34:15.000000', '2025-06-20 22:21:12.000000', '2025-06-20 22:21:12'),
(50, 'is_variant', 'HP-1', 'CODE128', 'HP Chromebook', 0, 0, 9, 7, 9, 9, 9, 0, '1', 'no_image.png', '', 1, 1, 0, 0, NULL, NULL, 1, 0, 0, 1, '2025-06-20 06:39:31.000000', '2025-06-20 22:14:44.000000', '2025-06-20 22:14:44'),
(51, 'is_single', 'Sp-1', 'CODE128', 'Speaker', 15000, 20000, 9, 7, 9, 9, 9, 0, '1', 'no_image.png', '', 1, 1, 0, 0, NULL, NULL, 0, 0, 0, 1, '2025-06-21 07:42:40.000000', '2025-06-21 07:42:48.000000', '2025-06-21 07:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `product_ledgers`
--

CREATE TABLE `product_ledgers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `date` date NOT NULL,
  `quantity_in` int(11) NOT NULL DEFAULT 0,
  `quantity_out` int(11) NOT NULL DEFAULT 0,
  `balance` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `customer_name` varchar(191) DEFAULT NULL,
  `product_code` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_ledgers`
--

INSERT INTO `product_ledgers` (`id`, `product_id`, `type`, `reference`, `date`, `quantity_in`, `quantity_out`, `balance`, `created_at`, `updated_at`, `customer_name`, `product_code`) VALUES
(1, 3, 'sale', 'SO-20250510-111852', '2025-05-10', 0, 100, -100, '2025-05-10 06:18:52', '2025-05-10 06:18:52', NULL, NULL),
(2, 3, 'sale_return', 'RT_1120', '2025-05-10', 15, 0, -85, '2025-05-10 06:19:13', '2025-05-10 06:19:13', NULL, NULL),
(3, 10, 'adjustment', 'AD_1115', '2025-05-10', 100, 0, 100, '2025-05-10 06:27:17', '2025-05-10 06:27:17', NULL, NULL),
(4, 9, 'adjustment', 'AD_1115', '2025-05-10', 15, 0, 15, '2025-05-10 06:27:17', '2025-05-10 06:27:17', NULL, NULL),
(5, 9, 'adjustment', 'AD_1115', '2025-05-10', 15, 0, 30, '2025-05-10 06:27:17', '2025-05-10 06:27:17', NULL, NULL),
(6, 10, 'sale', 'SO-20250510-113021', '2025-05-10', 0, 15, 85, '2025-05-10 06:30:21', '2025-05-10 06:30:21', NULL, NULL),
(7, 9, 'sale', 'SO-20250510-113021', '2025-05-10', 0, 10, 5, '2025-05-10 06:30:21', '2025-05-10 06:30:21', NULL, NULL),
(8, 9, 'sale', 'SO-20250510-113021', '2025-05-10', 0, 10, -5, '2025-05-10 06:30:21', '2025-05-10 06:30:21', NULL, NULL),
(9, 10, 'sale_return', 'RT_1121', '2025-05-10', 5, 0, 90, '2025-05-10 06:32:41', '2025-05-10 06:32:41', NULL, NULL),
(10, 9, 'sale_return', 'RT_1121', '2025-05-10', 5, 0, 10, '2025-05-10 06:32:41', '2025-05-10 06:32:41', NULL, NULL),
(11, 9, 'sale_return', 'RT_1121', '2025-05-10', 5, 0, 15, '2025-05-10 06:32:41', '2025-05-10 06:32:41', NULL, NULL),
(12, 10, 'purchase', 'PO-20250510-120135', '2025-05-10', 15, 0, 105, '2025-05-10 07:01:35', '2025-05-10 07:01:35', NULL, NULL),
(13, 10, 'sale', 'SO-20250510-120311', '2025-05-10', 0, 10, 95, '2025-05-10 07:03:11', '2025-05-10 07:03:11', NULL, NULL),
(14, 1, 'pos', 'SO-20250510-122349', '2025-05-10', 0, 1, -1, '2025-05-10 07:23:49', '2025-05-10 07:23:49', NULL, NULL),
(15, 2, 'pos', 'SO-20250510-122349', '2025-05-10', 0, 1, -1, '2025-05-10 07:23:49', '2025-05-10 07:23:49', NULL, NULL),
(16, 3, 'pos', 'SO-20250510-122650', '2025-05-10', 0, 10, -95, '2025-05-10 07:26:50', '2025-05-10 07:26:50', NULL, NULL),
(17, 3, 'pos', 'SO-20250513-093931', '2025-05-13', 0, 1, -96, '2025-05-13 04:39:31', '2025-05-13 04:39:31', 'POS Customer', '35030522'),
(18, 4, 'pos', 'SO-20250513-093931', '2025-05-13', 0, 1, -1, '2025-05-13 04:39:31', '2025-05-13 04:39:31', 'POS Customer', 'MD'),
(19, 3, 'pos', 'SO-20250513-094412', '2025-05-13', 0, 1, -97, '2025-05-13 04:44:12', '2025-05-13 04:44:12', 'Walkin Customer', '35030522'),
(20, 4, 'pos', 'SO-20250513-094412', '2025-05-13', 0, 1, -2, '2025-05-13 04:44:12', '2025-05-13 04:44:12', 'Walkin Customer', 'LG'),
(21, 4, 'pos', 'SO-20250513-094412', '2025-05-13', 0, 1, -3, '2025-05-13 04:44:12', '2025-05-13 04:44:12', 'Walkin Customer', 'MD'),
(22, 3, 'pos', 'SO-20250513-100905', '2025-05-13', 0, 1, -98, '2025-05-13 05:09:05', '2025-05-13 05:09:05', 'Syed Kashan Abbas Naqvi', '35030522'),
(23, 9, 'purchase', 'PO-20250513-034243', '2025-05-13', 50, 0, 60, '2025-05-13 10:42:43', '2025-05-13 10:42:43', NULL, NULL),
(24, 9, 'purchase', 'PO-20250513-042539', '2025-05-13', 200, 0, 260, '2025-05-13 11:25:39', '2025-05-13 11:25:39', NULL, NULL),
(25, 2, 'pos', 'SO-20250513-063148', '2025-05-13', 0, 1, -2, '2025-05-13 13:31:48', '2025-05-13 13:31:48', 'Anas', '13293863'),
(26, 3, 'pos', 'SO-20250513-063148', '2025-05-13', 0, 1, -99, '2025-05-13 13:31:48', '2025-05-13 13:31:48', 'Anas', '35030522'),
(27, 1, 'pos', 'SO-20250513-063220', '2025-05-13', 0, 1, -2, '2025-05-13 13:32:20', '2025-05-13 13:32:20', 'Anas', '62414852'),
(28, 3, 'pos', 'SO-20250513-063338', '2025-05-13', 0, 4, -103, '2025-05-13 13:33:39', '2025-05-13 13:33:39', 'Anas', '35030522'),
(29, 3, 'pos', 'SO-20250518-102428', '2025-05-18', 0, 5, -108, '2025-05-18 05:24:28', '2025-05-18 05:24:28', 'Anas', '35030522'),
(30, 7, 'pos', 'SO-20250518-104626', '2025-05-18', 0, 1, -1, '2025-05-18 05:46:27', '2025-05-18 05:46:27', 'Walkin Customer', '94006406'),
(31, 7, 'pos', 'SO-20250518-104845', '2025-05-18', 0, 1, -2, '2025-05-18 05:48:46', '2025-05-18 05:48:46', 'Walkin Customer', '94006406'),
(32, 7, 'pos', 'SO-20250518-014755', '2025-05-18', 0, 12, -14, '2025-05-18 08:47:55', '2025-05-18 08:47:55', 'Syed Kashan Abbas Naqvi', '94006406'),
(33, 7, 'pos', 'SO-20250518-020302', '2025-05-18', 0, 2, -16, '2025-05-18 09:03:02', '2025-05-18 09:03:02', 'Syed Kashan Abbas Naqvi', '94006406'),
(34, 2, 'pos', 'SO-20250518-023206', '2025-05-18', 0, 2, -4, '2025-05-18 09:32:07', '2025-05-18 09:32:07', 'Walkin Customer', '13293863'),
(35, 11, 'adjustment', 'AD_1116', '2025-05-18', 150, 0, 150, '2025-05-18 10:15:24', '2025-05-18 10:15:24', NULL, NULL),
(36, 11, 'adjustment', 'AD_1117', '2025-05-18', 0, 12, 138, '2025-05-18 11:00:39', '2025-05-18 11:00:39', NULL, NULL),
(37, 11, 'pos', 'SO-20250518-042921', '2025-05-18', 0, 5, 133, '2025-05-18 11:29:21', '2025-05-18 11:29:21', 'Usama Shaikh', '72918070'),
(38, 12, 'adjustment', 'AD_1118', '2025-05-21', 1500, 0, 1500, '2025-05-21 14:11:57', '2025-05-21 14:11:57', NULL, NULL),
(39, 13, 'adjustment', 'AD_1118', '2025-05-21', 3500, 0, 3500, '2025-05-21 14:11:57', '2025-05-21 14:11:57', NULL, NULL),
(40, 14, 'adjustment', 'AD_1118', '2025-05-21', 2000, 0, 2000, '2025-05-21 14:11:57', '2025-05-21 14:11:57', NULL, NULL),
(41, 15, 'adjustment', 'AD_1119', '2025-05-21', 41, 0, 41, '2025-05-21 14:32:09', '2025-05-21 14:32:09', NULL, NULL),
(42, 16, 'adjustment', 'AD_1119', '2025-05-21', 3, 0, 3, '2025-05-21 14:32:09', '2025-05-21 14:32:09', NULL, NULL),
(43, 18, 'adjustment', 'AD_1120', '2025-05-21', 7, 0, 7, '2025-05-21 14:42:00', '2025-05-21 14:42:00', NULL, NULL),
(44, 17, 'adjustment', 'AD_1120', '2025-05-21', 23, 0, 23, '2025-05-21 14:42:00', '2025-05-21 14:42:00', NULL, NULL),
(45, 12, 'sale', 'SO-20250521-024519', '2025-05-21', 0, 55, 1445, '2025-05-21 14:45:19', '2025-05-21 14:45:19', 'OWAIS', '27922621'),
(46, 13, 'sale', 'SO-20250521-024519', '2025-05-21', 0, 7, 3493, '2025-05-21 14:45:19', '2025-05-21 14:45:19', 'OWAIS', '99601145'),
(47, 14, 'sale', 'SO-20250521-024519', '2025-05-21', 0, 2, 1998, '2025-05-21 14:45:19', '2025-05-21 14:45:19', 'OWAIS', '72836795'),
(48, 15, 'sale', 'SO-20250521-024519', '2025-05-21', 0, 5, 36, '2025-05-21 14:45:19', '2025-05-21 14:45:19', 'OWAIS', '20148613'),
(49, 12, 'sale', 'SO-20250521-024732', '2025-05-21', 0, 74, 1371, '2025-05-21 14:47:32', '2025-05-21 14:47:32', 'BILAL', '27922621'),
(50, 13, 'sale', 'SO-20250521-024732', '2025-05-21', 0, 13, 3480, '2025-05-21 14:47:32', '2025-05-21 14:47:32', 'BILAL', '99601145'),
(51, 14, 'sale', 'SO-20250521-024732', '2025-05-21', 0, 8, 1990, '2025-05-21 14:47:32', '2025-05-21 14:47:32', 'BILAL', '72836795'),
(52, 17, 'sale', 'SO-20250521-024732', '2025-05-21', 0, 2, 21, '2025-05-21 14:47:32', '2025-05-21 14:47:32', 'BILAL', '84574413'),
(53, 13, 'sale', 'SO-20250521-024913', '2025-05-21', 0, 44, 3436, '2025-05-21 14:49:13', '2025-05-21 14:49:13', 'NEHA', '99601145'),
(54, 14, 'sale', 'SO-20250521-024913', '2025-05-21', 0, 3, 1987, '2025-05-21 14:49:13', '2025-05-21 14:49:13', 'NEHA', '72836795'),
(55, 12, 'sale', 'SO-20250521-024913', '2025-05-21', 0, 6, 1365, '2025-05-21 14:49:13', '2025-05-21 14:49:13', 'NEHA', '27922621'),
(56, 12, 'sale', 'SO-20250521-025126', '2025-05-21', 0, 10, 1355, '2025-05-21 14:51:26', '2025-05-21 14:51:26', 'DANISH', '27922621'),
(57, 13, 'sale', 'SO-20250521-030501', '2025-05-21', 0, 12, 3424, '2025-05-21 15:05:01', '2025-05-21 15:05:01', 'HASHIM ANSARI', '99601145'),
(58, 14, 'sale', 'SO-20250521-035912', '2025-05-21', 0, 102, 1885, '2025-05-21 15:59:12', '2025-05-21 15:59:12', 'MUJAHID', '72836795'),
(59, 19, 'adjustment', 'AD_1121', '2025-05-22', 1000, 0, 1000, '2025-05-22 12:00:52', '2025-05-22 12:00:52', NULL, NULL),
(60, 19, 'sale', 'SO-20250522-120145', '2025-05-22', 0, 1, 999, '2025-05-22 12:01:45', '2025-05-22 12:01:45', 'FARHAN', '17734593'),
(61, 14, 'sale', 'SO-20250522-120145', '2025-05-22', 0, 1, 1884, '2025-05-22 12:01:45', '2025-05-22 12:01:45', 'FARHAN', '72836795'),
(62, 13, 'sale', 'SO-20250522-120145', '2025-05-22', 0, 1, 3423, '2025-05-22 12:01:45', '2025-05-22 12:01:45', 'FARHAN', '99601145'),
(63, 12, 'sale', 'SO-20250522-120145', '2025-05-22', 0, 1, 1354, '2025-05-22 12:01:45', '2025-05-22 12:01:45', 'FARHAN', '27922621'),
(64, 19, 'sale', 'SO-20250522-120513', '2025-05-22', 0, 13, 986, '2025-05-22 12:05:13', '2025-05-22 12:05:13', 'Adnan bhai', '17734593'),
(65, 13, 'sale', 'SO-20250522-120513', '2025-05-22', 0, 86, 3337, '2025-05-22 12:05:13', '2025-05-22 12:05:13', 'Adnan bhai', '99601145'),
(66, 14, 'sale', 'SO-20250522-120513', '2025-05-22', 0, 12, 1872, '2025-05-22 12:05:13', '2025-05-22 12:05:13', 'Adnan bhai', '72836795'),
(67, 12, 'sale', 'SO-20250522-120513', '2025-05-22', 0, 12, 1342, '2025-05-22 12:05:13', '2025-05-22 12:05:13', 'Adnan bhai', '27922621'),
(68, 13, 'sale', 'SO-20250522-121040', '2025-05-22', 0, 60, 3277, '2025-05-22 12:10:40', '2025-05-22 12:10:40', 'KASHIF BHAI - HASSAN COSMETICS', '99601145'),
(69, 14, 'sale', 'SO-20250522-121040', '2025-05-22', 0, 3, 1869, '2025-05-22 12:10:40', '2025-05-22 12:10:40', 'KASHIF BHAI - HASSAN COSMETICS', '72836795'),
(70, 12, 'sale', 'SO-20250522-121040', '2025-05-22', 0, 7, 1335, '2025-05-22 12:10:40', '2025-05-22 12:10:40', 'KASHIF BHAI - HASSAN COSMETICS', '27922621'),
(71, 13, 'sale', 'SO-20250522-121346', '2025-05-22', 0, 84, 3193, '2025-05-22 12:13:46', '2025-05-22 12:13:46', 'IMDAD', '99601145'),
(72, 14, 'sale', 'SO-20250522-121346', '2025-05-22', 0, 6, 1863, '2025-05-22 12:13:46', '2025-05-22 12:13:46', 'IMDAD', '72836795'),
(73, 12, 'sale', 'SO-20250522-121346', '2025-05-22', 0, 7, 1328, '2025-05-22 12:13:46', '2025-05-22 12:13:46', 'IMDAD', '27922621'),
(74, 13, 'sale', 'SO-20250522-122633', '2025-05-22', 0, 123, 3070, '2025-05-22 12:26:33', '2025-05-22 12:26:33', 'Zafran - Shakir cosmetics', '99601145'),
(75, 19, 'sale', 'SO-20250522-122633', '2025-05-22', 0, 8, 978, '2025-05-22 12:26:33', '2025-05-22 12:26:33', 'Zafran - Shakir cosmetics', '17734593'),
(76, 12, 'sale', 'SO-20250522-122633', '2025-05-22', 0, 19, 1309, '2025-05-22 12:26:33', '2025-05-22 12:26:33', 'Zafran - Shakir cosmetics', '27922621'),
(77, 13, 'sale', 'SO-20250522-122817', '2025-05-22', 0, 149, 2921, '2025-05-22 12:28:17', '2025-05-22 12:28:17', 'SAIFI ULLAH.', '99601145'),
(78, 14, 'sale', 'SO-20250522-122817', '2025-05-22', 0, 15, 1848, '2025-05-22 12:28:17', '2025-05-22 12:28:17', 'SAIFI ULLAH.', '72836795'),
(79, 12, 'sale', 'SO-20250522-122817', '2025-05-22', 0, 15, 1294, '2025-05-22 12:28:17', '2025-05-22 12:28:17', 'SAIFI ULLAH.', '27922621'),
(80, 13, 'sale', 'SO-20250522-123509', '2025-05-22', 0, 34, 2887, '2025-05-22 12:35:09', '2025-05-22 12:35:09', 'Mati ullah.', '99601145'),
(81, 14, 'sale', 'SO-20250522-123509', '2025-05-22', 0, 2, 1846, '2025-05-22 12:35:09', '2025-05-22 12:35:09', 'Mati ullah.', '72836795'),
(82, 12, 'sale', 'SO-20250522-123509', '2025-05-22', 0, 10, 1284, '2025-05-22 12:35:09', '2025-05-22 12:35:09', 'Mati ullah.', '27922621'),
(83, 13, 'sale', 'SO-20250522-123822', '2025-05-22', 0, 161, 2726, '2025-05-22 12:38:22', '2025-05-22 12:38:22', 'Imran', '99601145'),
(84, 19, 'sale', 'SO-20250522-123822', '2025-05-22', 0, 4, 974, '2025-05-22 12:38:22', '2025-05-22 12:38:22', 'Imran', '17734593'),
(85, 14, 'sale', 'SO-20250522-123822', '2025-05-22', 0, 18, 1828, '2025-05-22 12:38:22', '2025-05-22 12:38:22', 'Imran', '72836795'),
(86, 12, 'sale', 'SO-20250522-123822', '2025-05-22', 0, 12, 1272, '2025-05-22 12:38:22', '2025-05-22 12:38:22', 'Imran', '27922621'),
(87, 13, 'sale', 'SO-20250522-015937', '2025-05-22', 0, 20, 2706, '2025-05-22 13:59:37', '2025-05-22 13:59:37', 'SHAHID', '99601145'),
(88, 19, 'sale', 'SO-20250522-015937', '2025-05-22', 0, 3, 971, '2025-05-22 13:59:37', '2025-05-22 13:59:37', 'SHAHID', '17734593'),
(89, 12, 'sale', 'SO-20250522-015937', '2025-05-22', 0, 1, 1271, '2025-05-22 13:59:37', '2025-05-22 13:59:37', 'SHAHID', '27922621'),
(90, 13, 'sale', 'SO-20250522-020231', '2025-05-22', 0, 26, 2680, '2025-05-22 14:02:31', '2025-05-22 14:02:31', 'ALI HASSAN - AYAT COSMETICS', '99601145'),
(91, 12, 'sale', 'SO-20250522-020231', '2025-05-22', 0, 6, 1265, '2025-05-22 14:02:31', '2025-05-22 14:02:31', 'ALI HASSAN - AYAT COSMETICS', '27922621'),
(92, 13, 'sale', 'SO-20250522-020401', '2025-05-22', 0, 75, 2605, '2025-05-22 14:04:01', '2025-05-22 14:04:01', 'M.NABI', '99601145'),
(93, 14, 'sale', 'SO-20250522-020401', '2025-05-22', 0, 10, 1818, '2025-05-22 14:04:01', '2025-05-22 14:04:01', 'M.NABI', '72836795'),
(94, 12, 'sale', 'SO-20250522-020401', '2025-05-22', 0, 5, 1260, '2025-05-22 14:04:01', '2025-05-22 14:04:01', 'M.NABI', '27922621'),
(95, 15, 'sale', 'SO-20250522-020401', '2025-05-22', 0, 5, 31, '2025-05-22 14:04:01', '2025-05-22 14:04:01', 'M.NABI', '20148613'),
(96, 13, 'sale', 'SO-20250522-020441', '2025-05-22', 0, 37, 2568, '2025-05-22 14:04:41', '2025-05-22 14:04:41', 'TAHA PEKO', '99601145'),
(97, 12, 'sale', 'SO-20250522-020441', '2025-05-22', 0, 2, 1258, '2025-05-22 14:04:41', '2025-05-22 14:04:41', 'TAHA PEKO', '27922621'),
(98, 14, 'sale', 'SO-20250522-020441', '2025-05-22', 0, 4, 1814, '2025-05-22 14:04:41', '2025-05-22 14:04:41', 'TAHA PEKO', '72836795'),
(99, 19, 'sale', 'SO-20250522-020612', '2025-05-22', 0, 2, 969, '2025-05-22 14:06:12', '2025-05-22 14:06:12', 'ABID', '17734593'),
(100, 13, 'sale', 'SO-20250522-020612', '2025-05-22', 0, 32, 2536, '2025-05-22 14:06:12', '2025-05-22 14:06:12', 'ABID', '99601145'),
(101, 14, 'sale', 'SO-20250522-020612', '2025-05-22', 0, 4, 1810, '2025-05-22 14:06:12', '2025-05-22 14:06:12', 'ABID', '72836795'),
(102, 12, 'sale', 'SO-20250522-020612', '2025-05-22', 0, 1, 1257, '2025-05-22 14:06:12', '2025-05-22 14:06:12', 'ABID', '27922621'),
(103, 15, 'sale', 'SO-20250522-020612', '2025-05-22', 0, 1, 30, '2025-05-22 14:06:12', '2025-05-22 14:06:12', 'ABID', '20148613'),
(104, 16, 'sale', 'SO-20250522-020612', '2025-05-22', 0, 3, 0, '2025-05-22 14:06:12', '2025-05-22 14:06:12', 'ABID', '59476725'),
(105, 20, 'adjustment', 'AD_1122', '2025-05-22', 46, 0, 46, '2025-05-22 14:15:12', '2025-05-22 14:15:12', NULL, NULL),
(106, 22, 'adjustment', 'AD_1122', '2025-05-22', 37, 0, 37, '2025-05-22 14:15:12', '2025-05-22 14:15:12', NULL, NULL),
(107, 13, 'sale', 'SO-20250522-023319', '2025-05-22', 0, 126, 2410, '2025-05-22 14:33:19', '2025-05-22 14:33:19', 'ISHTIAQUE', '99601145'),
(108, 12, 'sale', 'SO-20250522-023319', '2025-05-22', 0, 13, 1244, '2025-05-22 14:33:19', '2025-05-22 14:33:19', 'ISHTIAQUE', '27922621'),
(109, 14, 'sale', 'SO-20250522-023319', '2025-05-22', 0, 18, 1792, '2025-05-22 14:33:19', '2025-05-22 14:33:19', 'ISHTIAQUE', '72836795'),
(110, 19, 'sale', 'SO-20250522-023319', '2025-05-22', 0, 2, 967, '2025-05-22 14:33:19', '2025-05-22 14:33:19', 'ISHTIAQUE', '17734593'),
(111, 22, 'sale', 'SO-20250522-023319', '2025-05-22', 0, 2, 35, '2025-05-22 14:33:19', '2025-05-22 14:33:19', 'ISHTIAQUE', '27598140'),
(112, 20, 'sale', 'SO-20250522-023319', '2025-05-22', 0, 2, 44, '2025-05-22 14:33:19', '2025-05-22 14:33:19', 'ISHTIAQUE', '74675288'),
(113, 13, 'sale', 'SO-20250522-023506', '2025-05-22', 0, 27, 2383, '2025-05-22 14:35:06', '2025-05-22 14:35:06', 'SHAKEEL BHAI.', '99601145'),
(114, 12, 'sale', 'SO-20250522-023506', '2025-05-22', 0, 6, 1238, '2025-05-22 14:35:06', '2025-05-22 14:35:06', 'SHAKEEL BHAI.', '27922621'),
(115, 14, 'sale', 'SO-20250522-023506', '2025-05-22', 0, 4, 1788, '2025-05-22 14:35:06', '2025-05-22 14:35:06', 'SHAKEEL BHAI.', '72836795'),
(116, 12, 'sale', 'SO-20250522-023747', '2025-05-22', 0, 55, 1183, '2025-05-22 14:37:47', '2025-05-22 14:37:47', 'FAHAD', '27922621'),
(117, 14, 'sale', 'SO-20250522-023747', '2025-05-22', 0, 1, 1787, '2025-05-22 14:37:47', '2025-05-22 14:37:47', 'FAHAD', '72836795'),
(118, 13, 'sale', 'SO-20250522-023747', '2025-05-22', 0, 22, 2361, '2025-05-22 14:37:47', '2025-05-22 14:37:47', 'FAHAD', '99601145'),
(119, 18, 'sale', 'SO-20250522-031937', '2025-05-22', 0, 4, 3, '2025-05-22 15:19:37', '2025-05-22 15:19:37', 'SHAHBAZ - KAJ OVERLOCK', '49073241'),
(120, 13, 'sale', 'SO-20250522-045743', '2025-05-22', 0, 90, 2271, '2025-05-22 16:57:43', '2025-05-22 16:57:43', 'ABDUL RAZZAQ', '99601145'),
(121, 19, 'sale', 'SO-20250522-045743', '2025-05-22', 0, 1, 966, '2025-05-22 16:57:43', '2025-05-22 16:57:43', 'ABDUL RAZZAQ', '17734593'),
(122, 14, 'sale', 'SO-20250522-045743', '2025-05-22', 0, 12, 1775, '2025-05-22 16:57:43', '2025-05-22 16:57:43', 'ABDUL RAZZAQ', '72836795'),
(123, 12, 'sale', 'SO-20250522-045743', '2025-05-22', 0, 6, 1177, '2025-05-22 16:57:43', '2025-05-22 16:57:43', 'ABDUL RAZZAQ', '27922621'),
(124, 13, 'sale', 'SO-20250522-065859', '2025-05-22', 0, 37, 2234, '2025-05-22 18:58:59', '2025-05-22 18:58:59', 'WASEEM', '99601145'),
(125, 12, 'sale', 'SO-20250522-065859', '2025-05-22', 0, 7, 1170, '2025-05-22 18:58:59', '2025-05-22 18:58:59', 'WASEEM', '27922621'),
(126, 14, 'sale', 'SO-20250522-065859', '2025-05-22', 0, 4, 1771, '2025-05-22 18:58:59', '2025-05-22 18:58:59', 'WASEEM', '72836795'),
(127, 13, 'sale', 'SO-20250523-020310', '2025-05-23', 0, 460, 1774, '2025-05-23 14:03:10', '2025-05-23 14:03:10', 'Mati ullah - 3B cosmetics and gift center.', '99601145'),
(128, 14, 'sale', 'SO-20250523-020310', '2025-05-23', 0, 40, 1731, '2025-05-23 14:03:10', '2025-05-23 14:03:10', 'Mati ullah - 3B cosmetics and gift center.', '72836795'),
(129, 13, 'sale', 'SO-20250523-020628', '2025-05-23', 0, 14, 1760, '2025-05-23 14:06:28', '2025-05-23 14:06:28', 'Imran - Zain cosmetics.', '99601145'),
(130, 14, 'sale', 'SO-20250523-020628', '2025-05-23', 0, 1, 1730, '2025-05-23 14:06:28', '2025-05-23 14:06:28', 'Imran - Zain cosmetics.', '72836795'),
(131, 12, 'sale', 'SO-20250523-020628', '2025-05-23', 0, 3, 1167, '2025-05-23 14:06:28', '2025-05-23 14:06:28', 'Imran - Zain cosmetics.', '27922621'),
(132, 23, 'adjustment', 'AD_1123', '2025-05-23', 40, 0, 40, '2025-05-23 14:21:34', '2025-05-23 14:21:34', NULL, NULL),
(133, 24, 'adjustment', 'AD_1124', '2025-05-23', 21900, 0, 21900, '2025-05-23 14:29:12', '2025-05-23 14:29:12', NULL, NULL),
(134, 25, 'adjustment', 'AD_1125', '2025-05-23', 1000, 0, 1000, '2025-05-23 14:32:50', '2025-05-23 14:32:50', NULL, NULL),
(135, 23, 'sale', 'SO-20250523-023634', '2025-05-23', 0, 40, 0, '2025-05-23 14:36:34', '2025-05-23 14:36:34', 'IMDAD', '78690549'),
(136, 13, 'sale', 'SO-20250523-024642', '2025-05-23', 0, 74, 1686, '2025-05-23 14:46:42', '2025-05-23 14:46:42', 'Haseeb Lace', '99601145'),
(137, 14, 'sale', 'SO-20250523-024642', '2025-05-23', 0, 10, 1720, '2025-05-23 14:46:42', '2025-05-23 14:46:42', 'Haseeb Lace', '72836795'),
(138, 12, 'sale', 'SO-20250523-024642', '2025-05-23', 0, 6, 1161, '2025-05-23 14:46:42', '2025-05-23 14:46:42', 'Haseeb Lace', '27922621'),
(139, 13, 'sale', 'SO-20250523-025710', '2025-05-23', 0, 60, 1626, '2025-05-23 14:57:10', '2025-05-23 14:57:10', 'Ghulam Fareed', '99601145'),
(140, 12, 'sale', 'SO-20250523-025710', '2025-05-23', 0, 7, 1154, '2025-05-23 14:57:10', '2025-05-23 14:57:10', 'Ghulam Fareed', '27922621'),
(141, 14, 'sale', 'SO-20250523-025710', '2025-05-23', 0, 10, 1710, '2025-05-23 14:57:10', '2025-05-23 14:57:10', 'Ghulam Fareed', '72836795'),
(142, 26, 'adjustment', 'AD_1126', '2025-05-23', 18, 0, 18, '2025-05-23 16:32:46', '2025-05-23 16:32:46', NULL, NULL),
(143, 24, 'sale', 'SO-20250523-052254', '2025-05-23', 0, 200, 21700, '2025-05-23 17:22:54', '2025-05-23 17:22:54', 'Qamar - Top star', '37982477'),
(144, 25, 'sale', 'SO-20250523-052254', '2025-05-23', 0, 400, 600, '2025-05-23 17:22:54', '2025-05-23 17:22:54', 'Qamar - Top star', '62976466'),
(145, 18, 'sale', 'SO-20250523-052254', '2025-05-23', 0, 1, 2, '2025-05-23 17:22:54', '2025-05-23 17:22:54', 'Qamar - Top star', '49073241'),
(146, 13, 'sale', 'SO-20250525-023203', '2025-05-25', 0, 10, 1616, '2025-05-25 14:32:03', '2025-05-25 14:32:03', 'ABID', '99601145'),
(147, 13, 'adjustment', 'AD_1127', '2025-05-26', 1593, 0, 3209, '2025-05-26 12:40:25', '2025-05-26 12:40:25', NULL, NULL),
(148, 14, 'adjustment', 'AD_1128', '2025-05-26', 0, 34, 1676, '2025-05-26 12:56:45', '2025-05-26 12:56:45', NULL, NULL),
(149, 26, 'sale', 'SO-20250526-020714', '2025-05-26', 0, 10, 8, '2025-05-26 14:07:14', '2025-05-26 14:07:14', 'DILSHAD - ABBAS ZARI LACE', '10152178'),
(150, 13, 'sale', 'SO-20250526-021837', '2025-05-26', 0, 2, 3207, '2025-05-26 14:18:37', '2025-05-26 14:18:37', 'Walkin Customer', '99601145'),
(151, 14, 'sale', 'SO-20250526-021837', '2025-05-26', 0, 2, 1674, '2025-05-26 14:18:37', '2025-05-26 14:18:37', 'Walkin Customer', '72836795'),
(152, 13, 'sale', 'SO-20250526-030113', '2025-05-26', 0, 1, 3206, '2025-05-26 15:01:13', '2025-05-26 15:01:13', 'Walkin Customer', '99601145'),
(153, 12, 'adjustment', 'AD_1129', '2025-05-26', 1462, 0, 2616, '2025-05-26 15:26:24', '2025-05-26 15:26:24', NULL, NULL),
(154, 13, 'adjustment', 'AD_1130', '2025-05-26', 889, 0, 4095, '2025-05-26 15:27:54', '2025-05-26 15:27:54', NULL, NULL),
(155, 14, 'adjustment', 'AD_1130', '2025-05-26', 235, 0, 1909, '2025-05-26 15:27:54', '2025-05-26 15:27:54', NULL, NULL),
(156, 13, 'purchase', 'PO-20250526-033226', '2025-05-26', 6759, 0, 10854, '2025-05-26 15:32:26', '2025-05-26 15:32:26', NULL, NULL),
(157, 26, 'purchase', 'PO-20250526-033226', '2025-05-26', 14, 0, 22, '2025-05-26 15:32:26', '2025-05-26 15:32:26', NULL, NULL),
(158, 27, 'adjustment', 'AD_1131', '2025-05-26', 500, 0, 500, '2025-05-26 17:23:50', '2025-05-26 17:23:50', NULL, NULL),
(159, 27, 'sale', 'SO-20250526-052532', '2025-05-26', 0, 22, 478, '2025-05-26 17:25:32', '2025-05-26 17:25:32', 'ABDUL RAZZAQ', '24540226'),
(160, 13, 'sale', 'SO-20250526-052532', '2025-05-26', 0, 39, 10815, '2025-05-26 17:25:32', '2025-05-26 17:25:32', 'ABDUL RAZZAQ', '99601145'),
(161, 12, 'sale', 'SO-20250526-052532', '2025-05-26', 0, 4, 2612, '2025-05-26 17:25:32', '2025-05-26 17:25:32', 'ABDUL RAZZAQ', '27922621'),
(162, 14, 'sale', 'SO-20250526-052532', '2025-05-26', 0, 8, 1901, '2025-05-26 17:25:32', '2025-05-26 17:25:32', 'ABDUL RAZZAQ', '72836795'),
(163, 19, 'sale', 'SO-20250526-052532', '2025-05-26', 0, 1, 965, '2025-05-26 17:25:32', '2025-05-26 17:25:32', 'ABDUL RAZZAQ', '17734593'),
(164, 13, 'purchase', 'PO-20250526-053321', '2025-05-26', 100, 0, 10915, '2025-05-26 17:33:21', '2025-05-26 17:33:21', NULL, NULL),
(165, 13, 'sale', 'SO-20250526-053544', '2025-05-26', 0, 232, 10683, '2025-05-26 17:35:44', '2025-05-26 17:35:44', 'RIZWAN', '99601145'),
(166, 14, 'sale', 'SO-20250526-053544', '2025-05-26', 0, 12, 1889, '2025-05-26 17:35:44', '2025-05-26 17:35:44', 'RIZWAN', '72836795'),
(167, 12, 'purchase', 'PO-20250526-053836', '2025-05-26', 227, 0, 2839, '2025-05-26 17:38:36', '2025-05-26 17:38:36', NULL, NULL),
(168, 13, 'purchase', 'PO-20250526-053836', '2025-05-26', 17, 0, 10700, '2025-05-26 17:38:36', '2025-05-26 17:38:36', NULL, NULL),
(169, 13, 'purchase', 'PO-20250526-054045', '2025-05-26', 69, 0, 10769, '2025-05-26 17:40:45', '2025-05-26 17:40:45', NULL, NULL),
(170, 19, 'purchase', 'PO-20250526-054045', '2025-05-26', 4, 0, 969, '2025-05-26 17:40:45', '2025-05-26 17:40:45', NULL, NULL),
(171, 19, 'sale', 'SO-20250526-054209', '2025-05-26', 0, 4, 965, '2025-05-26 17:42:09', '2025-05-26 17:42:09', 'ABDUL LATIF', '17734593'),
(172, 13, 'sale', 'SO-20250526-054209', '2025-05-26', 0, 67, 10702, '2025-05-26 17:42:09', '2025-05-26 17:42:09', 'ABDUL LATIF', '99601145'),
(173, 12, 'purchase', 'PO-20250527-085548', '2025-05-27', 746, 0, 3585, '2025-05-27 08:55:48', '2025-05-27 08:55:48', NULL, NULL),
(174, 27, 'purchase', 'PO-20250527-085548', '2025-05-27', 13, 0, 491, '2025-05-27 08:55:48', '2025-05-27 08:55:48', NULL, NULL),
(175, 28, 'adjustment', 'AD_1132', '2025-05-27', 300, 0, 300, '2025-05-27 09:01:34', '2025-05-27 09:01:34', NULL, NULL),
(176, 28, 'sale', 'SO-20250527-091307', '2025-05-27', 0, 1, 299, '2025-05-27 09:13:07', '2025-05-27 09:13:07', 'Mohsin - Vip Tailor', '99591339'),
(177, 13, 'sale', 'SO-20250527-091307', '2025-05-27', 0, 50, 10652, '2025-05-27 09:13:07', '2025-05-27 09:13:07', 'Mohsin - Vip Tailor', '99601145'),
(178, 13, 'sale', 'SO-20250527-094735', '2025-05-27', 0, 113, 10539, '2025-05-27 09:47:35', '2025-05-27 09:47:35', 'ABDUL RAZZAQ', '99601145'),
(179, 14, 'sale', 'SO-20250527-094735', '2025-05-27', 0, 4, 1885, '2025-05-27 09:47:35', '2025-05-27 09:47:35', 'ABDUL RAZZAQ', '72836795'),
(180, 12, 'sale', 'SO-20250527-094735', '2025-05-27', 0, 2, 3583, '2025-05-27 09:47:35', '2025-05-27 09:47:35', 'ABDUL RAZZAQ', '27922621'),
(181, 27, 'sale', 'SO-20250527-094735', '2025-05-27', 0, 8, 483, '2025-05-27 09:47:35', '2025-05-27 09:47:35', 'ABDUL RAZZAQ', '24540226'),
(182, 16, 'purchase', 'PO-20250527-095913', '2025-05-27', 50, 0, 50, '2025-05-27 09:59:13', '2025-05-27 09:59:13', NULL, NULL),
(183, 16, 'purchase', 'PO-20250527-104730', '2025-05-27', 100, 0, 150, '2025-05-27 10:47:30', '2025-05-27 10:47:30', NULL, NULL),
(184, 15, 'purchase', 'PO-20250527-104730', '2025-05-27', 100, 0, 130, '2025-05-27 10:47:30', '2025-05-27 10:47:30', NULL, NULL),
(185, 21, 'purchase', 'PO-20250527-104730', '2025-05-27', 40, 0, 40, '2025-05-27 10:47:30', '2025-05-27 10:47:30', NULL, NULL),
(186, 22, 'purchase', 'PO-20250527-104730', '2025-05-27', 53, 0, 88, '2025-05-27 10:47:30', '2025-05-27 10:47:30', NULL, NULL),
(187, 16, 'sale', 'SO-20250527-104917', '2025-05-27', 0, 50, 100, '2025-05-27 10:49:17', '2025-05-27 10:49:17', 'Tariq Bhai', '59476725'),
(188, 15, 'sale', 'SO-20250527-104917', '2025-05-27', 0, 100, 30, '2025-05-27 10:49:17', '2025-05-27 10:49:17', 'Tariq Bhai', '20148613'),
(189, 16, 'sale', 'SO-20250527-110140', '2025-05-27', 0, 33, 67, '2025-05-27 11:01:40', '2025-05-27 11:01:40', 'Saif - commission a/c', '59476725'),
(190, 13, 'sale', 'SO-20250527-120056', '2025-05-27', 0, 45, 10494, '2025-05-27 12:00:56', '2025-05-27 12:00:56', 'ZEESHAN COSMETICS', '99601145'),
(191, 22, 'sale', 'SO-20250527-120056', '2025-05-27', 0, 15, 73, '2025-05-27 12:00:56', '2025-05-27 12:00:56', 'ZEESHAN COSMETICS', '27598140'),
(192, 21, 'sale', 'SO-20250527-120056', '2025-05-27', 0, 1, 39, '2025-05-27 12:00:56', '2025-05-27 12:00:56', 'ZEESHAN COSMETICS', '73136173'),
(193, 12, 'sale', 'SO-20250527-122319', '2025-05-27', 0, 775, 2808, '2025-05-27 12:23:19', '2025-05-27 12:23:19', 'SHAHZAD', '27922621'),
(194, 13, 'sale', 'SO-20250527-122319', '2025-05-27', 0, 257, 10237, '2025-05-27 12:23:19', '2025-05-27 12:23:19', 'SHAHZAD', '99601145'),
(195, 14, 'sale', 'SO-20250527-122319', '2025-05-27', 0, 11, 1874, '2025-05-27 12:23:19', '2025-05-27 12:23:19', 'SHAHZAD', '72836795'),
(196, 19, 'sale', 'SO-20250527-122319', '2025-05-27', 0, 7, 958, '2025-05-27 12:23:19', '2025-05-27 12:23:19', 'SHAHZAD', '17734593'),
(197, 24, 'sale', 'SO-20250527-122319', '2025-05-27', 0, 400, 21300, '2025-05-27 12:23:19', '2025-05-27 12:23:19', 'SHAHZAD', '37982477'),
(198, 16, 'sale', 'SO-20250527-125358', '2025-05-27', 0, 10, 57, '2025-05-27 12:53:58', '2025-05-27 12:53:58', 'SHAHZAD', '59476725'),
(199, 30, 'adjustment', 'AD_1133', '2025-05-27', 50, 0, 50, '2025-05-27 13:21:25', '2025-05-27 13:21:25', NULL, NULL),
(200, 31, 'adjustment', 'AD_1133', '2025-05-27', 300, 0, 300, '2025-05-27 13:21:25', '2025-05-27 13:21:25', NULL, NULL),
(201, 32, 'adjustment', 'AD_1133', '2025-05-27', 300, 0, 300, '2025-05-27 13:21:25', '2025-05-27 13:21:25', NULL, NULL),
(202, 29, 'adjustment', 'AD_1133', '2025-05-27', 100, 0, 100, '2025-05-27 13:21:25', '2025-05-27 13:21:25', NULL, NULL),
(203, 33, 'adjustment', 'AD_1134', '2025-05-27', 50, 0, 50, '2025-05-27 13:24:26', '2025-05-27 13:24:26', NULL, NULL),
(204, 34, 'adjustment', 'AD_1135', '2025-05-27', 40, 0, 40, '2025-05-27 13:28:13', '2025-05-27 13:28:13', NULL, NULL),
(205, 13, 'sale', 'SO-20250527-013027', '2025-05-27', 0, 28, 10209, '2025-05-27 13:30:27', '2025-05-27 13:30:27', 'Walkin Customer', '99601145'),
(206, 12, 'sale', 'SO-20250527-013027', '2025-05-27', 0, 6, 2802, '2025-05-27 13:30:27', '2025-05-27 13:30:27', 'Walkin Customer', '27922621'),
(207, 29, 'sale', 'SO-20250527-013027', '2025-05-27', 0, 6, 94, '2025-05-27 13:30:27', '2025-05-27 13:30:27', 'Walkin Customer', '1'),
(208, 33, 'sale', 'SO-20250527-013027', '2025-05-27', 0, 1, 49, '2025-05-27 13:30:27', '2025-05-27 13:30:27', 'Walkin Customer', '5'),
(209, 30, 'sale', 'SO-20250527-013027', '2025-05-27', 0, 1, 49, '2025-05-27 13:30:27', '2025-05-27 13:30:27', 'Walkin Customer', '2'),
(210, 31, 'sale', 'SO-20250527-013027', '2025-05-27', 0, 1, 299, '2025-05-27 13:30:27', '2025-05-27 13:30:27', 'Walkin Customer', '3'),
(211, 34, 'sale', 'SO-20250527-013027', '2025-05-27', 0, 1, 39, '2025-05-27 13:30:27', '2025-05-27 13:30:27', 'Walkin Customer', '6'),
(212, 20, 'sale', 'SO-20250527-013027', '2025-05-27', 0, 2, 42, '2025-05-27 13:30:27', '2025-05-27 13:30:27', 'Walkin Customer', '74675288'),
(213, 13, 'pos', 'SO-20250527-015446', '2025-05-27', 0, 1, 10208, '2025-05-27 13:54:46', '2025-05-27 13:54:46', 'Walkin Customer', '99601145'),
(214, 12, 'sale', 'SO-20250527-021941', '2025-05-27', 0, 16, 2786, '2025-05-27 14:19:41', '2025-05-27 14:19:41', 'SHAHID BHAI - VIP TAILOR', '27922621'),
(215, 13, 'sale', 'SO-20250527-021941', '2025-05-27', 0, 18, 10190, '2025-05-27 14:19:41', '2025-05-27 14:19:41', 'SHAHID BHAI - VIP TAILOR', '99601145'),
(216, 14, 'sale', 'SO-20250527-021941', '2025-05-27', 0, 3, 1871, '2025-05-27 14:19:41', '2025-05-27 14:19:41', 'SHAHID BHAI - VIP TAILOR', '72836795'),
(217, 12, 'sale', 'SO-20250527-022332', '2025-05-27', 0, 34, 2752, '2025-05-27 14:23:32', '2025-05-27 14:23:32', 'OWAIS', '27922621'),
(218, 13, 'sale', 'SO-20250527-022332', '2025-05-27', 0, 28, 10162, '2025-05-27 14:23:32', '2025-05-27 14:23:32', 'OWAIS', '99601145'),
(219, 14, 'sale', 'SO-20250527-022332', '2025-05-27', 0, 3, 1868, '2025-05-27 14:23:32', '2025-05-27 14:23:32', 'OWAIS', '72836795'),
(220, 16, 'sale', 'SO-20250527-022332', '2025-05-27', 0, 5, 52, '2025-05-27 14:23:32', '2025-05-27 14:23:32', 'OWAIS', '59476725'),
(221, 13, 'sale', 'SO-20250527-022454', '2025-05-27', 0, 21, 10141, '2025-05-27 14:24:54', '2025-05-27 14:24:54', 'PYARO - SHOP 2', '99601145'),
(222, 13, 'sale', 'SO-20250527-022615', '2025-05-27', 0, 75, 10066, '2025-05-27 14:26:15', '2025-05-27 14:26:15', 'PYARO - SHOP 1', '99601145'),
(223, 14, 'sale', 'SO-20250527-022615', '2025-05-27', 0, 1, 1867, '2025-05-27 14:26:15', '2025-05-27 14:26:15', 'PYARO - SHOP 1', '72836795'),
(224, 13, 'pos', 'SO-20250527-023219', '2025-05-27', 0, 2, 10064, '2025-05-27 14:32:19', '2025-05-27 14:32:19', 'Walkin Customer', '99601145'),
(225, 13, 'sale', 'SO-20250527-025751', '2025-05-27', 0, 290, 9774, '2025-05-27 14:57:51', '2025-05-27 14:57:51', 'SHAHBAZ - KAJ OVERLOCK', '99601145'),
(226, 12, 'sale', 'SO-20250527-025751', '2025-05-27', 0, 1, 2751, '2025-05-27 14:57:51', '2025-05-27 14:57:51', 'SHAHBAZ - KAJ OVERLOCK', '27922621'),
(227, 14, 'sale', 'SO-20250527-025751', '2025-05-27', 0, 4, 1863, '2025-05-27 14:57:51', '2025-05-27 14:57:51', 'SHAHBAZ - KAJ OVERLOCK', '72836795'),
(228, 26, 'sale', 'SO-20250527-030201', '2025-05-27', 0, 6, 16, '2025-05-27 15:02:01', '2025-05-27 15:02:01', 'SHAHBAZ - KAJ OVERLOCK', '10152178'),
(229, 24, 'sale', 'SO-20250527-030201', '2025-05-27', 0, 300, 21000, '2025-05-27 15:02:01', '2025-05-27 15:02:01', 'SHAHBAZ - KAJ OVERLOCK', '37982477'),
(230, 25, 'sale', 'SO-20250527-030201', '2025-05-27', 0, 200, 400, '2025-05-27 15:02:01', '2025-05-27 15:02:01', 'SHAHBAZ - KAJ OVERLOCK', '62976466'),
(231, 12, 'sale', 'SO-20250527-030549', '2025-05-27', 0, 122, 2629, '2025-05-27 15:05:49', '2025-05-27 15:05:49', 'SHAREEF', '27922621'),
(232, 13, 'sale', 'SO-20250527-030549', '2025-05-27', 0, 12, 9762, '2025-05-27 15:05:49', '2025-05-27 15:05:49', 'SHAREEF', '99601145'),
(233, 13, 'sale', 'SO-20250527-030626', '2025-05-27', 0, 56, 9706, '2025-05-27 15:06:26', '2025-05-27 15:06:26', 'FAISAL ZARI', '99601145'),
(234, 13, 'sale', 'SO-20250527-030722', '2025-05-27', 0, 33, 9673, '2025-05-27 15:07:22', '2025-05-27 15:07:22', 'AHMER', '99601145'),
(235, 14, 'sale', 'SO-20250527-030722', '2025-05-27', 0, 2, 1861, '2025-05-27 15:07:22', '2025-05-27 15:07:22', 'AHMER', '72836795'),
(236, 19, 'sale', 'SO-20250527-030722', '2025-05-27', 0, 6, 952, '2025-05-27 15:07:22', '2025-05-27 15:07:22', 'AHMER', '17734593'),
(237, 35, 'adjustment', 'AD_1136', '2025-05-27', 51, 0, 51, '2025-05-27 15:31:53', '2025-05-27 15:31:53', NULL, NULL),
(238, 35, 'pos', 'SO-20250527-033250', '2025-05-27', 0, 2, 49, '2025-05-27 15:32:50', '2025-05-27 15:32:50', 'Walkin Customer', '7'),
(239, 32, 'pos', 'SO-20250527-034220', '2025-05-27', 0, 2, 298, '2025-05-27 15:42:20', '2025-05-27 15:42:20', 'Walkin Customer', '4'),
(240, 13, 'sale', 'SO-20250527-040839', '2025-05-27', 0, 101, 9572, '2025-05-27 16:08:39', '2025-05-27 16:08:39', 'HAQ NAWAZ', '99601145'),
(241, 14, 'sale', 'SO-20250527-040839', '2025-05-27', 0, 1, 1860, '2025-05-27 16:08:39', '2025-05-27 16:08:39', 'HAQ NAWAZ', '72836795'),
(242, 16, 'sale', 'SO-20250527-040839', '2025-05-27', 0, 20, 32, '2025-05-27 16:08:39', '2025-05-27 16:08:39', 'HAQ NAWAZ', '59476725'),
(243, 13, 'sale', 'SO-20250527-040946', '2025-05-27', 0, 10, 9562, '2025-05-27 16:09:46', '2025-05-27 16:09:46', 'SHAHID', '99601145'),
(244, 12, 'sale', 'SO-20250527-040946', '2025-05-27', 0, 15, 2614, '2025-05-27 16:09:46', '2025-05-27 16:09:46', 'SHAHID', '27922621'),
(245, 16, 'sale', 'SO-20250527-040946', '2025-05-27', 0, 5, 27, '2025-05-27 16:09:46', '2025-05-27 16:09:46', 'SHAHID', '59476725'),
(246, 32, 'pos', 'SO-20250527-042249', '2025-05-27', 0, 1, 297, '2025-05-27 16:22:49', '2025-05-27 16:22:49', 'Walkin Customer', '4'),
(247, 36, 'adjustment', 'AD_1137', '2025-05-27', 500, 0, 500, '2025-05-27 16:46:38', '2025-05-27 16:46:38', NULL, NULL),
(248, 36, 'pos', 'SO-20250527-044802', '2025-05-27', 0, 24, 476, '2025-05-27 16:48:02', '2025-05-27 16:48:02', 'Walkin Customer', '8'),
(249, 16, 'sale', 'SO-20250527-051128', '2025-05-27', 0, 5, 22, '2025-05-27 17:11:28', '2025-05-27 17:11:28', 'Saif - commission a/c', '59476725'),
(250, 13, 'sale', 'SO-20250527-051616', '2025-05-27', 0, 100, 9462, '2025-05-27 17:16:16', '2025-05-27 17:16:16', 'RIZWAN', '99601145'),
(251, 37, 'adjustment', 'AD_1138', '2025-05-27', 13, 0, 13, '2025-05-27 17:24:43', '2025-05-27 17:24:43', NULL, NULL),
(252, 38, 'adjustment', 'AD_1138', '2025-05-27', 22, 0, 22, '2025-05-27 17:24:43', '2025-05-27 17:24:43', NULL, NULL),
(253, 38, 'pos', 'SO-20250527-052605', '2025-05-27', 0, 1, 21, '2025-05-27 17:26:05', '2025-05-27 17:26:05', 'Walkin Customer', '10'),
(254, 13, 'pos', 'SO-20250527-052605', '2025-05-27', 0, 1, 9461, '2025-05-27 17:26:05', '2025-05-27 17:26:05', 'Walkin Customer', '99601145'),
(255, 12, 'pos', 'SO-20250527-052605', '2025-05-27', 0, 2, 2612, '2025-05-27 17:26:05', '2025-05-27 17:26:05', 'Walkin Customer', '27922621'),
(256, 31, 'pos', 'SO-20250527-052605', '2025-05-27', 0, 3, 296, '2025-05-27 17:26:05', '2025-05-27 17:26:05', 'Walkin Customer', '3'),
(257, 36, 'pos', 'SO-20250527-053343', '2025-05-27', 0, 24, 452, '2025-05-27 17:33:43', '2025-05-27 17:33:43', 'Walkin Customer', '8'),
(258, 39, 'adjustment', 'AD_1139', '2025-05-27', 5, 0, 5, '2025-05-27 17:35:43', '2025-05-27 17:35:43', NULL, NULL),
(259, 39, 'pos', 'SO-20250527-053621', '2025-05-27', 0, 2, 3, '2025-05-27 17:36:21', '2025-05-27 17:36:21', 'Walkin Customer', '11'),
(260, 13, 'sale', 'SO-20250528-045231', '2025-05-28', 0, 97, 9364, '2025-05-28 16:52:31', '2025-05-28 16:52:31', 'RIZWAN', '99601145'),
(261, 29, 'sale', 'SO-20250528-100922', '2025-05-28', 0, 1, 93, '2025-05-28 22:09:22', '2025-05-28 22:09:22', 'Walkin Customer', '1'),
(262, 29, 'sale', 'RT_1122', '2025-05-28', 0, 1, 92, '2025-05-28 22:10:24', '2025-05-28 22:10:24', 'Walkin Customer', '1'),
(263, 13, 'sale', 'SO-20250529-085530', '2025-05-29', 0, 37, 9327, '2025-05-29 08:55:30', '2025-05-29 08:55:30', 'Adnan bhai', '99601145'),
(264, 14, 'sale', 'SO-20250529-085530', '2025-05-29', 0, 3, 1857, '2025-05-29 08:55:30', '2025-05-29 08:55:30', 'Adnan bhai', '72836795'),
(265, 13, 'sale', 'SO-20250529-085623', '2025-05-29', 0, 52, 9275, '2025-05-29 08:56:23', '2025-05-29 08:56:23', 'SAIFI ULLAH.', '99601145'),
(266, 14, 'sale', 'SO-20250529-085623', '2025-05-29', 0, 4, 1853, '2025-05-29 08:56:23', '2025-05-29 08:56:23', 'SAIFI ULLAH.', '72836795'),
(267, 19, 'sale', 'SO-20250529-085623', '2025-05-29', 0, 1, 951, '2025-05-29 08:56:23', '2025-05-29 08:56:23', 'SAIFI ULLAH.', '17734593'),
(268, 13, 'sale', 'SO-20250529-085757', '2025-05-29', 0, 49, 9226, '2025-05-29 08:57:57', '2025-05-29 08:57:57', 'Imran', '99601145'),
(269, 14, 'sale', 'SO-20250529-085757', '2025-05-29', 0, 2, 1851, '2025-05-29 08:57:57', '2025-05-29 08:57:57', 'Imran', '72836795'),
(270, 12, 'sale', 'SO-20250529-085757', '2025-05-29', 0, 3, 2609, '2025-05-29 08:57:57', '2025-05-29 08:57:57', 'Imran', '27922621'),
(271, 19, 'sale', 'SO-20250529-085757', '2025-05-29', 0, 1, 950, '2025-05-29 08:57:57', '2025-05-29 08:57:57', 'Imran', '17734593'),
(272, 13, 'sale', 'SO-20250529-090003', '2025-05-29', 0, 27, 9199, '2025-05-29 09:00:03', '2025-05-29 09:00:03', 'Raja bhai - Al-khair miyari', '99601145'),
(273, 14, 'sale', 'SO-20250529-090003', '2025-05-29', 0, 1, 1850, '2025-05-29 09:00:03', '2025-05-29 09:00:03', 'Raja bhai - Al-khair miyari', '72836795'),
(274, 17, 'sale', 'SO-20250529-090003', '2025-05-29', 0, 2, 19, '2025-05-29 09:00:03', '2025-05-29 09:00:03', 'Raja bhai - Al-khair miyari', '84574413'),
(275, 13, 'sale', 'SO-20250529-090056', '2025-05-29', 0, 44, 9155, '2025-05-29 09:00:56', '2025-05-29 09:00:56', 'FARHAN', '99601145'),
(276, 19, 'sale', 'SO-20250529-090056', '2025-05-29', 0, 6, 944, '2025-05-29 09:00:56', '2025-05-29 09:00:56', 'FARHAN', '17734593'),
(277, 14, 'sale', 'SO-20250529-090056', '2025-05-29', 0, 3, 1847, '2025-05-29 09:00:56', '2025-05-29 09:00:56', 'FARHAN', '72836795'),
(278, 12, 'sale', 'SO-20250529-090056', '2025-05-29', 0, 2, 2607, '2025-05-29 09:00:56', '2025-05-29 09:00:56', 'FARHAN', '27922621'),
(279, 13, 'sale', 'SO-20250529-090150', '2025-05-29', 0, 89, 9066, '2025-05-29 09:01:50', '2025-05-29 09:01:50', 'KASHIF BHAI - HASSAN COSMETICS', '99601145'),
(280, 14, 'sale', 'SO-20250529-090150', '2025-05-29', 0, 2, 1845, '2025-05-29 09:01:50', '2025-05-29 09:01:50', 'KASHIF BHAI - HASSAN COSMETICS', '72836795'),
(281, 13, 'sale', 'SO-20250529-120927', '2025-05-29', 0, 1147, 7919, '2025-05-29 12:09:27', '2025-05-29 12:09:27', 'Zafran - Shakir cosmetics', '99601145'),
(282, 14, 'sale', 'SO-20250529-120927', '2025-05-29', 0, 7, 1838, '2025-05-29 12:09:27', '2025-05-29 12:09:27', 'Zafran - Shakir cosmetics', '72836795'),
(283, 12, 'sale', 'SO-20250529-120927', '2025-05-29', 0, 1, 2606, '2025-05-29 12:09:27', '2025-05-29 12:09:27', 'Zafran - Shakir cosmetics', '27922621'),
(284, 13, 'sale', 'SO-20250529-121047', '2025-05-29', 0, 11, 7908, '2025-05-29 12:10:47', '2025-05-29 12:10:47', 'IMDAD', '99601145'),
(285, 12, 'sale', 'SO-20250529-121047', '2025-05-29', 0, 2, 2604, '2025-05-29 12:10:47', '2025-05-29 12:10:47', 'IMDAD', '27922621'),
(286, 13, 'sale', 'SO-20250529-123858', '2025-05-29', 0, 98, 7810, '2025-05-29 12:38:58', '2025-05-29 12:38:58', 'Imran 2.5no.', '99601145'),
(287, 14, 'sale', 'SO-20250529-123858', '2025-05-29', 0, 2, 1836, '2025-05-29 12:38:58', '2025-05-29 12:38:58', 'Imran 2.5no.', '72836795'),
(288, 12, 'sale', 'SO-20250529-123858', '2025-05-29', 0, 1, 2603, '2025-05-29 12:38:58', '2025-05-29 12:38:58', 'Imran 2.5no.', '27922621'),
(289, 13, 'sale', 'SO-20250529-124632', '2025-05-29', 0, 130, 7680, '2025-05-29 12:46:32', '2025-05-29 12:46:32', 'DANISH - BIN ZAMEER', '99601145'),
(290, 13, 'sale', 'SO-20250529-031640', '2025-05-29', 0, 54, 7626, '2025-05-29 15:16:40', '2025-05-29 15:16:40', 'ALI HASSAN - AYAT COSMETICS', '99601145'),
(291, 14, 'sale', 'SO-20250529-031640', '2025-05-29', 0, 1, 1835, '2025-05-29 15:16:40', '2025-05-29 15:16:40', 'ALI HASSAN - AYAT COSMETICS', '72836795'),
(292, 12, 'sale', 'SO-20250529-031640', '2025-05-29', 0, 1, 2602, '2025-05-29 15:16:40', '2025-05-29 15:16:40', 'ALI HASSAN - AYAT COSMETICS', '27922621'),
(293, 13, 'sale', 'SO-20250529-031807', '2025-05-29', 0, 97, 7529, '2025-05-29 15:18:07', '2025-05-29 15:18:07', 'SHAHID', '99601145'),
(294, 14, 'sale', 'SO-20250529-031807', '2025-05-29', 0, 16, 1819, '2025-05-29 15:18:07', '2025-05-29 15:18:07', 'SHAHID', '72836795'),
(295, 12, 'sale', 'SO-20250529-031807', '2025-05-29', 0, 111, 2491, '2025-05-29 15:18:07', '2025-05-29 15:18:07', 'SHAHID', '27922621'),
(296, 16, 'sale', 'SO-20250529-031807', '2025-05-29', 0, 5, 17, '2025-05-29 15:18:07', '2025-05-29 15:18:07', 'SHAHID', '59476725'),
(297, 15, 'sale', 'SO-20250529-031807', '2025-05-29', 0, 5, 25, '2025-05-29 15:18:07', '2025-05-29 15:18:07', 'SHAHID', '20148613'),
(298, 16, 'sale', 'SO-20250529-032117', '2025-05-29', 0, 8, 9, '2025-05-29 15:21:17', '2025-05-29 15:21:17', 'HAQ NAWAZ', '59476725'),
(299, 41, 'adjustment', 'AD_1140', '2025-05-29', 1, 0, 1, '2025-05-29 15:37:49', '2025-05-29 15:37:49', NULL, NULL),
(300, 13, 'sale', 'SO-20250529-034159', '2025-05-29', 0, 48, 7481, '2025-05-29 15:41:59', '2025-05-29 15:41:59', 'TAHA PEKO', '99601145'),
(301, 14, 'sale', 'SO-20250529-034159', '2025-05-29', 0, 1, 1818, '2025-05-29 15:41:59', '2025-05-29 15:41:59', 'TAHA PEKO', '72836795'),
(302, 41, 'sale', 'SO-20250529-034159', '2025-05-29', 0, 1, 0, '2025-05-29 15:41:59', '2025-05-29 15:41:59', 'TAHA PEKO', '50233646'),
(303, 13, 'sale', 'SO-20250529-034311', '2025-05-29', 0, 111, 7370, '2025-05-29 15:43:11', '2025-05-29 15:43:11', 'Haseeb Lace', '99601145'),
(304, 14, 'sale', 'SO-20250529-034311', '2025-05-29', 0, 9, 1809, '2025-05-29 15:43:11', '2025-05-29 15:43:11', 'Haseeb Lace', '72836795'),
(305, 19, 'sale', 'SO-20250529-035654', '2025-05-29', 0, 2, 942, '2025-05-29 15:56:54', '2025-05-29 15:56:54', 'WASEEM', '17734593'),
(306, 13, 'sale', 'SO-20250529-035654', '2025-05-29', 0, 32, 7338, '2025-05-29 15:56:54', '2025-05-29 15:56:54', 'WASEEM', '99601145'),
(307, 12, 'sale', 'SO-20250529-035654', '2025-05-29', 0, 1, 2490, '2025-05-29 15:56:54', '2025-05-29 15:56:54', 'WASEEM', '27922621'),
(308, 13, 'sale', 'SO-20250529-041752', '2025-05-29', 0, 47, 7291, '2025-05-29 16:17:52', '2025-05-29 16:17:52', 'HASAN ALI - AL-GHANI COSMETICS', '99601145'),
(309, 14, 'sale', 'SO-20250529-041752', '2025-05-29', 0, 1, 1808, '2025-05-29 16:17:52', '2025-05-29 16:17:52', 'HASAN ALI - AL-GHANI COSMETICS', '72836795'),
(310, 19, 'sale', 'SO-20250529-041752', '2025-05-29', 0, 2, 940, '2025-05-29 16:17:52', '2025-05-29 16:17:52', 'HASAN ALI - AL-GHANI COSMETICS', '17734593'),
(311, 16, 'sale', 'SO-20250529-041752', '2025-05-29', 0, 3, 6, '2025-05-29 16:17:52', '2025-05-29 16:17:52', 'HASAN ALI - AL-GHANI COSMETICS', '59476725'),
(312, 15, 'sale', 'SO-20250529-041752', '2025-05-29', 0, 3, 22, '2025-05-29 16:17:52', '2025-05-29 16:17:52', 'HASAN ALI - AL-GHANI COSMETICS', '20148613'),
(313, 13, 'sale', 'SO-20250529-042201', '2025-05-29', 0, 36, 7255, '2025-05-29 16:22:01', '2025-05-29 16:22:01', 'SHAKEEL BHAI.', '99601145'),
(314, 14, 'sale', 'SO-20250529-042201', '2025-05-29', 0, 2, 1806, '2025-05-29 16:22:01', '2025-05-29 16:22:01', 'SHAKEEL BHAI.', '72836795'),
(315, 13, 'sale', 'SO-20250529-042604', '2025-05-29', 0, 36, 7219, '2025-05-29 16:26:04', '2025-05-29 16:26:04', 'SIRAJUDDIN - GEO SANAE', '99601145'),
(316, 14, 'sale', 'SO-20250529-042604', '2025-05-29', 0, 1, 1805, '2025-05-29 16:26:05', '2025-05-29 16:26:05', 'SIRAJUDDIN - GEO SANAE', '72836795'),
(317, 12, 'sale', 'SO-20250529-042604', '2025-05-29', 0, 4, 2486, '2025-05-29 16:26:05', '2025-05-29 16:26:05', 'SIRAJUDDIN - GEO SANAE', '27922621'),
(318, 13, 'sale', 'SO-20250529-043240', '2025-05-29', 0, 32, 7187, '2025-05-29 16:32:40', '2025-05-29 16:32:40', 'MOIZ - ALI STORE.', '99601145'),
(319, 14, 'sale', 'SO-20250529-043240', '2025-05-29', 0, 2, 1803, '2025-05-29 16:32:40', '2025-05-29 16:32:40', 'MOIZ - ALI STORE.', '72836795'),
(320, 12, 'sale', 'SO-20250529-043351', '2025-05-29', 0, 31, 2455, '2025-05-29 16:33:51', '2025-05-29 16:33:51', 'AHSAN - BOMBAY TAILOR', '27922621'),
(321, 13, 'sale', 'SO-20250529-043351', '2025-05-29', 0, 15, 7172, '2025-05-29 16:33:51', '2025-05-29 16:33:51', 'AHSAN - BOMBAY TAILOR', '99601145'),
(322, 15, 'sale', 'SO-20250529-043351', '2025-05-29', 0, 5, 17, '2025-05-29 16:33:51', '2025-05-29 16:33:51', 'AHSAN - BOMBAY TAILOR', '20148613'),
(323, 16, 'purchase', 'PO-20250529-044651', '2025-05-29', 63, 0, 69, '2025-05-29 16:46:51', '2025-05-29 16:46:51', NULL, NULL),
(324, 15, 'purchase', 'PO-20250529-044651', '2025-05-29', 195, 0, 212, '2025-05-29 16:46:51', '2025-05-29 16:46:51', NULL, NULL),
(325, 40, 'adjustment', 'AD_1141', '2025-05-29', 40, 0, 40, '2025-05-29 16:51:35', '2025-05-29 16:51:35', NULL, NULL),
(326, 42, 'adjustment', 'AD_1142', '2025-05-29', 31, 0, 31, '2025-05-29 17:00:33', '2025-05-29 17:00:33', NULL, NULL),
(327, 42, 'adjustment', 'AD_1142', '2025-05-29', 22, 0, 53, '2025-05-29 17:00:33', '2025-05-29 17:00:33', NULL, NULL),
(328, 42, 'adjustment', 'AD_1142', '2025-05-29', 1, 0, 32, '2025-05-29 17:00:33', '2025-05-29 17:00:33', NULL, NULL),
(329, 42, 'adjustment', 'AD_1142', '2025-05-29', 17, 0, 48, '2025-05-29 17:00:33', '2025-05-29 17:00:33', NULL, NULL),
(330, 43, 'adjustment', 'AD_1143', '2025-05-29', 82, 0, 82, '2025-05-29 17:02:44', '2025-05-29 17:02:44', NULL, NULL),
(331, 45, 'adjustment', 'AD_1144', '2025-05-29', 134, 0, 134, '2025-05-29 17:14:46', '2025-05-29 17:14:46', NULL, NULL),
(332, 44, 'adjustment', 'AD_1144', '2025-05-29', 10, 0, 10, '2025-05-29 17:14:46', '2025-05-29 17:14:46', NULL, NULL),
(333, 13, 'sale', 'SO-20250529-051806', '2025-05-29', 0, 5, 7167, '2025-05-29 17:18:06', '2025-05-29 17:18:06', 'ABDUL LATIF', '99601145'),
(334, 16, 'sale', 'SO-20250529-051806', '2025-05-29', 0, 2, 67, '2025-05-29 17:18:06', '2025-05-29 17:18:06', 'ABDUL LATIF', '59476725'),
(335, 15, 'sale', 'SO-20250529-051806', '2025-05-29', 0, 5, 207, '2025-05-29 17:18:06', '2025-05-29 17:18:06', 'ABDUL LATIF', '20148613'),
(336, 22, 'sale', 'SO-20250529-051806', '2025-05-29', 0, 5, 68, '2025-05-29 17:18:06', '2025-05-29 17:18:06', 'ABDUL LATIF', '27598140'),
(337, 46, 'adjustment', 'AD_1145', '2025-05-29', 15, 0, 15, '2025-05-29 19:09:51', '2025-05-29 19:09:51', NULL, NULL),
(344, 46, 'adjustment_edit_revert', 'AD_1145', '2025-05-29', 0, 15, 0, '2025-05-29 19:14:23', '2025-05-29 19:14:23', NULL, NULL),
(345, 46, 'adjustment_edit', 'AD_1145', '2025-05-29', 14, 0, 14, '2025-05-29 19:14:23', '2025-05-29 19:14:23', NULL, NULL),
(346, 46, 'adjustment_edit_revert', 'AD_1145', '2025-05-29', 0, 14, -14, '2025-05-29 19:14:36', '2025-05-29 19:14:36', NULL, NULL),
(347, 46, 'adjustment_edit', 'AD_1145', '2025-05-29', 10, 0, -4, '2025-05-29 19:14:36', '2025-05-29 19:14:36', NULL, NULL),
(348, 46, 'adjustment_delete_revert', 'AD_1145', '2025-05-29', 0, 10, -24, '2025-05-29 19:19:54', '2025-05-29 19:19:54', NULL, NULL),
(349, 29, 'sale', 'SO-20250529-073626', '2025-05-29', 0, 1, 91, '2025-05-29 19:36:26', '2025-05-29 19:36:26', 'Walkin Customer', '1'),
(350, 13, 'sale', 'SO-20250530-115618', '2025-05-30', 0, 30, 7137, '2025-05-30 11:56:18', '2025-05-30 11:56:18', 'KASHIF BHAI - NIRMAL CLOTH HOUSE', '99601145'),
(351, 13, 'sale', 'SO-20250530-115909', '2025-05-30', 0, 139, 6998, '2025-05-30 11:59:09', '2025-05-30 11:59:09', 'ADIL - ZARI MEHEL', '99601145'),
(352, 14, 'sale', 'SO-20250530-115909', '2025-05-30', 0, 6, 1797, '2025-05-30 11:59:09', '2025-05-30 11:59:09', 'ADIL - ZARI MEHEL', '72836795'),
(353, 12, 'sale', 'SO-20250530-115909', '2025-05-30', 0, 1, 2454, '2025-05-30 11:59:09', '2025-05-30 11:59:09', 'ADIL - ZARI MEHEL', '27922621'),
(354, 13, 'sale', 'SO-20250530-022316', '2025-05-30', 0, 56, 6942, '2025-05-30 14:23:16', '2025-05-30 14:23:16', 'M.NABI', '99601145'),
(355, 14, 'sale', 'SO-20250530-022316', '2025-05-30', 0, 1, 1796, '2025-05-30 14:23:16', '2025-05-30 14:23:16', 'M.NABI', '72836795'),
(356, 16, 'sale', 'SO-20250530-022316', '2025-05-30', 0, 5, 62, '2025-05-30 14:23:16', '2025-05-30 14:23:16', 'M.NABI', '59476725'),
(357, 15, 'sale', 'SO-20250530-022316', '2025-05-30', 0, 10, 197, '2025-05-30 14:23:16', '2025-05-30 14:23:16', 'M.NABI', '20148613'),
(358, 13, 'sale', 'SO-20250530-030033', '2025-05-30', 0, 24, 6918, '2025-05-30 15:00:33', '2025-05-30 15:00:33', 'FAHAD', '99601145'),
(359, 12, 'sale', 'SO-20250530-030033', '2025-05-30', 0, 33, 2421, '2025-05-30 15:00:33', '2025-05-30 15:00:33', 'FAHAD', '27922621'),
(360, 14, 'sale', 'SO-20250530-030033', '2025-05-30', 0, 1, 1795, '2025-05-30 15:00:33', '2025-05-30 15:00:33', 'FAHAD', '72836795'),
(361, 13, 'sale', 'SO-20250530-030717', '2025-05-30', 0, 51, 6867, '2025-05-30 15:07:17', '2025-05-30 15:07:17', 'ISHTIAQUE', '99601145'),
(362, 19, 'sale', 'SO-20250530-030717', '2025-05-30', 0, 3, 937, '2025-05-30 15:07:17', '2025-05-30 15:07:17', 'ISHTIAQUE', '17734593'),
(363, 14, 'sale', 'SO-20250530-030717', '2025-05-30', 0, 1, 1794, '2025-05-30 15:07:17', '2025-05-30 15:07:17', 'ISHTIAQUE', '72836795'),
(364, 33, 'sale', 'SO-20250530-030717', '2025-05-30', 0, 3, 46, '2025-05-30 15:07:17', '2025-05-30 15:07:17', 'ISHTIAQUE', '5'),
(365, 22, 'sale', 'SO-20250530-030717', '2025-05-30', 0, 1, 67, '2025-05-30 15:07:17', '2025-05-30 15:07:17', 'ISHTIAQUE', '27598140'),
(366, 13, 'sale', 'SO-20250530-030929', '2025-05-30', 0, 104, 6763, '2025-05-30 15:09:29', '2025-05-30 15:09:29', 'Ghulam Fareed', '99601145'),
(367, 14, 'sale', 'SO-20250530-030929', '2025-05-30', 0, 1, 1793, '2025-05-30 15:09:29', '2025-05-30 15:09:29', 'Ghulam Fareed', '72836795'),
(368, 12, 'sale', 'SO-20250530-030929', '2025-05-30', 0, 1, 2420, '2025-05-30 15:09:29', '2025-05-30 15:09:29', 'Ghulam Fareed', '27922621'),
(369, 13, 'sale', 'SO-20250530-031153', '2025-05-30', 0, 37, 6726, '2025-05-30 15:11:53', '2025-05-30 15:11:53', 'ABID', '99601145'),
(370, 19, 'sale', 'SO-20250530-031153', '2025-05-30', 0, 1, 936, '2025-05-30 15:11:53', '2025-05-30 15:11:53', 'ABID', '17734593'),
(371, 14, 'sale', 'SO-20250530-031153', '2025-05-30', 0, 2, 1791, '2025-05-30 15:11:53', '2025-05-30 15:11:53', 'ABID', '72836795'),
(372, 15, 'sale', 'SO-20250530-031153', '2025-05-30', 0, 6, 191, '2025-05-30 15:11:53', '2025-05-30 15:11:53', 'ABID', '20148613'),
(373, 13, 'sale', 'SO-20250530-031843', '2025-05-30', 0, 155, 6571, '2025-05-30 15:18:43', '2025-05-30 15:18:43', 'SHAHZAD', '99601145'),
(374, 19, 'sale', 'SO-20250530-031843', '2025-05-30', 0, 2, 934, '2025-05-30 15:18:43', '2025-05-30 15:18:43', 'SHAHZAD', '17734593'),
(375, 14, 'sale', 'SO-20250530-031843', '2025-05-30', 0, 4, 1787, '2025-05-30 15:18:43', '2025-05-30 15:18:43', 'SHAHZAD', '72836795'),
(376, 12, 'sale', 'SO-20250530-031843', '2025-05-30', 0, 1, 2419, '2025-05-30 15:18:43', '2025-05-30 15:18:43', 'SHAHZAD', '27922621');
INSERT INTO `product_ledgers` (`id`, `product_id`, `type`, `reference`, `date`, `quantity_in`, `quantity_out`, `balance`, `created_at`, `updated_at`, `customer_name`, `product_code`) VALUES
(377, 24, 'sale', 'SO-20250530-031843', '2025-05-30', 0, 2000, 19000, '2025-05-30 15:18:43', '2025-05-30 15:18:43', 'SHAHZAD', '37982477'),
(378, 17, 'sale', 'SO-20250530-031843', '2025-05-30', 0, 1, 18, '2025-05-30 15:18:43', '2025-05-30 15:18:43', 'SHAHZAD', '84574413'),
(379, 47, 'adjustment', 'AD_1146', '2025-05-30', 10, 0, 10, '2025-05-30 15:20:38', '2025-05-30 15:20:38', NULL, NULL),
(380, 13, 'sale', 'SO-20250530-033116', '2025-05-30', 0, 33, 6538, '2025-05-30 15:31:16', '2025-05-30 15:31:16', 'SHAHID', '99601145'),
(381, 14, 'sale', 'SO-20250530-033116', '2025-05-30', 0, 1, 1786, '2025-05-30 15:31:16', '2025-05-30 15:31:16', 'SHAHID', '72836795'),
(382, 12, 'sale', 'SO-20250530-033116', '2025-05-30', 0, 1, 2418, '2025-05-30 15:31:16', '2025-05-30 15:31:16', 'SHAHID', '27922621'),
(383, 16, 'sale', 'SO-20250530-033505', '2025-05-30', 0, 10, 52, '2025-05-30 15:35:05', '2025-05-30 15:35:05', 'Haseeb Lace', '59476725'),
(384, 15, 'sale', 'SO-20250530-033505', '2025-05-30', 0, 5, 186, '2025-05-30 15:35:05', '2025-05-30 15:35:05', 'Haseeb Lace', '20148613'),
(385, 13, 'sale', 'SO-20250530-041728', '2025-05-30', 0, 55, 6483, '2025-05-30 16:17:28', '2025-05-30 16:17:28', 'RIZWAN', '99601145'),
(386, 12, 'sale', 'SO-20250531-104946', '2025-05-31', 0, 43, 2375, '2025-05-31 10:49:46', '2025-05-31 10:49:46', 'BILAL', '27922621'),
(387, 14, 'sale', 'SO-20250531-104946', '2025-05-31', 0, 3, 1783, '2025-05-31 10:49:46', '2025-05-31 10:49:46', 'BILAL', '72836795'),
(388, 13, 'sale', 'SO-20250531-104946', '2025-05-31', 0, 25, 6458, '2025-05-31 10:49:46', '2025-05-31 10:49:46', 'BILAL', '99601145'),
(389, 27, 'sale', 'SO-20250531-104946', '2025-05-31', 0, 13, 470, '2025-05-31 10:49:46', '2025-05-31 10:49:46', 'BILAL', '24540226'),
(390, 16, 'purchase', 'PO-20250531-122208', '2025-05-31', 100, 0, 152, '2025-05-31 12:22:08', '2025-05-31 12:22:08', NULL, NULL),
(391, 16, 'purchase', 'PO-20250531-122538', '2025-05-31', 99, 0, 251, '2025-05-31 12:25:39', '2025-05-31 12:25:39', NULL, NULL),
(392, 16, 'sale', 'SO-20250531-123413', '2025-05-31', 0, 22, 229, '2025-05-31 12:34:13', '2025-05-31 12:34:13', 'HAQ NAWAZ', '59476725'),
(393, 16, 'sale', 'SO-20250531-123457', '2025-05-31', 0, 8, 221, '2025-05-31 12:34:57', '2025-05-31 12:34:57', 'SHAHID', '59476725'),
(394, 16, 'sale', 'SO-20250531-123840', '2025-05-31', 0, 20, 201, '2025-05-31 12:38:40', '2025-05-31 12:38:40', 'Master sadiq - Tanzaib', '59476725'),
(395, 13, 'sale', 'SO-20250531-014559', '2025-05-31', 0, 217, 6241, '2025-05-31 13:45:59', '2025-05-31 13:45:59', 'DILSHAD - ABBAS ZARI LACE', '99601145'),
(396, 12, 'sale', 'SO-20250531-014559', '2025-05-31', 0, 1, 2374, '2025-05-31 13:45:59', '2025-05-31 13:45:59', 'DILSHAD - ABBAS ZARI LACE', '27922621'),
(397, 14, 'sale', 'SO-20250531-014559', '2025-05-31', 0, 13, 1770, '2025-05-31 13:45:59', '2025-05-31 13:45:59', 'DILSHAD - ABBAS ZARI LACE', '72836795'),
(398, 12, 'sale', 'SO-20250531-032157', '2025-05-31', 0, 47, 2327, '2025-05-31 15:21:57', '2025-05-31 15:21:57', 'SHARFUDDIN - MUZAMIL CLOTH HOUSE', '27922621'),
(399, 14, 'sale', 'SO-20250531-032157', '2025-05-31', 0, 3, 1767, '2025-05-31 15:21:57', '2025-05-31 15:21:57', 'SHARFUDDIN - MUZAMIL CLOTH HOUSE', '72836795'),
(400, 25, 'sale', 'SO-20250531-034131', '2025-05-31', 0, 100, 300, '2025-05-31 15:41:31', '2025-05-31 15:41:31', 'DANISH - ALMADINA', '62976466'),
(401, 24, 'sale', 'SO-20250531-034131', '2025-05-31', 0, 400, 18600, '2025-05-31 15:41:31', '2025-05-31 15:41:31', 'DANISH - ALMADINA', '37982477'),
(402, 13, 'pos', 'SO-20250612-044243', '2025-06-12', 0, 2, 6239, '2025-06-12 16:42:43', '2025-06-12 16:42:43', 'Walkin Customer', '99601145'),
(403, 47, 'sale', 'SO-20250614-013145', '2025-06-14', 0, 8, 2, '2025-06-14 13:31:45', '2025-06-14 13:31:45', 'Kashan', '58416738'),
(404, 45, 'sale', 'SO-20250614-013145', '2025-06-14', 0, 12, 122, '2025-06-14 13:31:45', '2025-06-14 13:31:45', 'Kashan', '96986174'),
(405, 29, 'purchase', 'PO-20250614-112323', '2025-06-14', 12, 0, 103, '2025-06-14 23:23:23', '2025-06-14 23:23:23', NULL, NULL),
(406, 13, 'pos', 'SO-20250615-123714', '2025-06-15', 0, 1, 6238, '2025-06-15 12:37:14', '2025-06-15 12:37:14', 'Walkin Customer', '99601145'),
(407, 48, 'purchase', 'PO-20250615-124014', '2025-06-15', 100, 0, 100, '2025-06-15 12:40:14', '2025-06-15 12:40:14', NULL, NULL),
(408, 48, 'adjustment', 'AD_1147', '2025-06-15', 100, 0, 200, '2025-06-15 12:40:42', '2025-06-15 12:40:42', NULL, NULL),
(409, 38, 'sale', 'SO-20250617-164', '2025-06-17', 0, 12, 9, '2025-06-17 19:36:02', '2025-06-17 19:36:02', 'Kashan', '10'),
(410, 49, 'adjustment', 'AD_1148', '2025-06-20', 50, 0, 50, '2025-06-20 06:37:57', '2025-06-20 06:37:57', NULL, NULL),
(411, 13, 'pos', 'SO-20250622-165', '2025-06-22', 0, 1, 6237, '2025-06-22 14:56:56', '2025-06-22 14:56:56', 'Walkin Customer', '99601145');

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `code` varchar(191) NOT NULL,
  `name` varchar(192) DEFAULT NULL,
  `cost` double DEFAULT 0,
  `price` double DEFAULT 0,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_variants`
--

INSERT INTO `product_variants` (`id`, `product_id`, `code`, `name`, `cost`, `price`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 4, 'SM', '10', 15, 20, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(2, 4, 'MD', '12', 18, 22, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(3, 4, 'LG', '14', 20, 25, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(4, 5, 'MS10', '10', 210, 250, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(5, 5, 'MS10.5', '10.5', 210, 250, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(6, 5, 'ML13', '13', 240, 280, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(7, 5, 'MXL18', '18', 260, 300, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(8, 9, '10', '10', 250, 280, NULL, '2025-05-18 10:12:43.000000', '2025-05-18 10:12:43'),
(9, 9, '12', '12', 250, 280, NULL, '2025-05-18 10:12:43.000000', '2025-05-18 10:12:43'),
(10, 42, '001', '.75\"', 1547, 1900, NULL, '2025-06-20 22:14:09.000000', '2025-06-20 22:14:09'),
(11, 42, '002', '1\"', 2062, 2490, NULL, '2025-06-20 22:14:09.000000', '2025-06-20 22:14:09'),
(12, 42, '003', '1.25\"', 2577, 3100, NULL, '2025-06-20 22:14:09.000000', '2025-06-20 22:14:09'),
(13, 42, '004', '2.5\"', 5155, 6200, NULL, '2025-06-20 22:14:09.000000', '2025-06-20 22:14:09'),
(14, 50, 'HP-1', 'HP Chromebook', 18000, 20000, NULL, '2025-06-20 22:14:44.000000', '2025-06-20 22:14:44');

-- --------------------------------------------------------

--
-- Table structure for table `product_warehouse`
--

CREATE TABLE `product_warehouse` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `product_variant_id` int(11) DEFAULT NULL,
  `qte` double NOT NULL DEFAULT 0,
  `manage_stock` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_warehouse`
--

INSERT INTO `product_warehouse` (`id`, `product_id`, `warehouse_id`, `product_variant_id`, `qte`, `manage_stock`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, NULL, 0, 1, NULL, '2025-05-18 10:13:23.000000', '2025-05-18 10:13:23'),
(2, 2, 1, NULL, 0, 0, NULL, '2025-05-18 10:13:17.000000', '2025-05-18 10:13:17'),
(3, 3, 1, NULL, 62, 1, NULL, '2025-05-18 10:13:11.000000', '2025-05-18 10:13:11'),
(4, 1, 2, NULL, 83, 1, NULL, '2025-05-18 10:13:23.000000', '2025-05-18 10:13:23'),
(5, 2, 2, NULL, 0, 0, NULL, '2025-05-18 10:13:17.000000', '2025-05-18 10:13:17'),
(6, 3, 2, NULL, 209, 1, NULL, '2025-05-18 10:13:11.000000', '2025-05-18 10:13:11'),
(7, 1, 3, NULL, 45, 1, NULL, '2025-05-18 10:13:23.000000', '2025-05-18 10:13:23'),
(8, 2, 3, NULL, 0, 0, NULL, '2025-05-18 10:13:17.000000', '2025-05-18 10:13:17'),
(9, 3, 3, NULL, 0, 1, NULL, '2025-05-18 10:13:11.000000', '2025-05-18 10:13:11'),
(10, 4, 1, 1, 10, 1, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(11, 4, 1, 2, 13, 1, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(12, 4, 1, 3, 4, 1, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(13, 4, 2, 1, 200, 1, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(14, 4, 2, 2, 0, 1, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(15, 4, 2, 3, 14, 1, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(16, 4, 3, 1, 140, 1, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(17, 4, 3, 2, 45, 1, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(18, 4, 3, 3, 1, 1, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(19, 5, 1, 4, 0, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(20, 5, 1, 5, 0, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(21, 5, 1, 6, 0, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(22, 5, 1, 7, 0, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(23, 5, 2, 4, 85, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(24, 5, 2, 5, 50, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(25, 5, 2, 6, 10, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(26, 5, 2, 7, 4, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(27, 5, 3, 4, 0, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(28, 5, 3, 5, 0, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(29, 5, 3, 6, 0, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(30, 5, 3, 7, 0, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(31, 6, 1, NULL, 0, 1, NULL, '2025-05-18 05:38:25.000000', '2025-05-18 05:38:25'),
(32, 6, 2, NULL, 1000, 1, NULL, '2025-05-18 05:38:23.000000', '2025-05-18 05:38:23'),
(33, 6, 3, NULL, 0, 1, NULL, '2025-05-18 05:38:21.000000', '2025-05-18 05:38:21'),
(34, 7, 1, NULL, 0, 0, NULL, '2025-05-18 10:12:57.000000', '2025-05-18 10:12:57'),
(35, 7, 2, NULL, 0, 0, NULL, '2025-05-18 10:12:57.000000', '2025-05-18 10:12:57'),
(36, 7, 3, NULL, 0, 0, NULL, '2025-05-18 10:12:57.000000', '2025-05-18 10:12:57'),
(37, 8, 1, NULL, 0, 1, NULL, '2025-05-18 10:12:51.000000', '2025-05-18 10:12:51'),
(38, 8, 2, NULL, 0, 1, NULL, '2025-05-18 10:12:51.000000', '2025-05-18 10:12:51'),
(39, 8, 3, NULL, 0, 1, NULL, '2025-05-18 10:12:51.000000', '2025-05-18 10:12:51'),
(40, 9, 1, 8, 10, 1, NULL, '2025-05-18 10:12:43.000000', '2025-05-18 10:12:43'),
(41, 9, 1, 9, 110, 1, NULL, '2025-05-18 10:12:43.000000', '2025-05-18 10:12:43'),
(42, 9, 2, 8, 0, 1, NULL, '2025-05-18 10:12:43.000000', '2025-05-18 10:12:43'),
(43, 9, 2, 9, 40, 1, NULL, '2025-05-18 10:12:43.000000', '2025-05-18 10:12:43'),
(44, 9, 3, 8, 0, 1, NULL, '2025-05-18 10:12:43.000000', '2025-05-18 10:12:43'),
(45, 9, 3, 9, 0, 1, NULL, '2025-05-18 10:12:43.000000', '2025-05-18 10:12:43'),
(46, 10, 1, NULL, 95, 1, NULL, '2025-05-18 10:12:38.000000', '2025-05-18 10:12:38'),
(47, 10, 2, NULL, 0, 1, NULL, '2025-05-18 10:12:38.000000', '2025-05-18 10:12:38'),
(48, 10, 3, NULL, 0, 1, NULL, '2025-05-18 10:12:38.000000', '2025-05-18 10:12:38'),
(49, 1, 4, NULL, 0, 1, NULL, '2025-05-18 10:13:23.000000', '2025-05-18 10:13:23'),
(50, 2, 4, NULL, 0, 0, NULL, '2025-05-18 10:13:17.000000', '2025-05-18 10:13:17'),
(51, 3, 4, NULL, 0, 1, NULL, '2025-05-18 10:13:11.000000', '2025-05-18 10:13:11'),
(52, 4, 4, 1, 0, 1, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(53, 4, 4, 2, 0, 1, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(54, 4, 4, 3, 0, 1, NULL, '2025-05-18 10:13:06.000000', '2025-05-18 10:13:06'),
(55, 5, 4, 4, 0, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(56, 5, 4, 5, 0, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(57, 5, 4, 6, 0, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(58, 5, 4, 7, 0, 1, NULL, '2025-05-18 10:13:01.000000', '2025-05-18 10:13:01'),
(59, 7, 4, NULL, 0, 0, NULL, '2025-05-18 10:12:57.000000', '2025-05-18 10:12:57'),
(60, 8, 4, NULL, 0, 1, NULL, '2025-05-18 10:12:51.000000', '2025-05-18 10:12:51'),
(61, 9, 4, 8, 0, 1, NULL, '2025-05-18 10:12:43.000000', '2025-05-18 10:12:43'),
(62, 9, 4, 9, 0, 1, NULL, '2025-05-18 10:12:43.000000', '2025-05-18 10:12:43'),
(63, 10, 4, NULL, 0, 1, NULL, '2025-05-18 10:12:38.000000', '2025-05-18 10:12:38'),
(64, 11, 4, NULL, -5, 1, NULL, '2025-05-20 15:02:29.000000', '2025-05-20 15:02:29'),
(65, 12, 4, NULL, 2364, 1, NULL, '2025-06-20 22:21:23.000000', '2025-06-20 22:21:23'),
(66, 13, 4, NULL, 7386, 1, NULL, '2025-06-22 14:56:56.000000', NULL),
(67, 14, 4, NULL, 1782, 1, NULL, '2025-06-03 04:13:50.000000', NULL),
(68, 15, 4, NULL, 184, 1, NULL, '2025-05-30 15:35:05.000000', NULL),
(69, 16, 4, NULL, 201, 1, NULL, '2025-06-20 22:15:00.000000', '2025-06-20 22:15:00'),
(70, 17, 4, NULL, 18, 1, NULL, '2025-06-20 22:14:21.000000', '2025-06-20 22:14:21'),
(71, 18, 4, NULL, 2, 1, NULL, '2025-05-23 17:22:54.000000', NULL),
(72, 19, 4, NULL, 923, 1, NULL, '2025-05-30 15:18:43.000000', NULL),
(73, 20, 4, NULL, 42, 1, NULL, '2025-05-27 13:30:27.000000', NULL),
(74, 21, 4, NULL, 30, 1, NULL, '2025-05-27 14:51:32.000000', NULL),
(75, 22, 4, NULL, 67, 1, NULL, '2025-05-30 15:07:17.000000', NULL),
(76, 23, 4, NULL, 0, 1, NULL, '2025-05-23 14:36:34.000000', NULL),
(77, 24, 4, NULL, 19000, 1, NULL, '2025-06-03 04:11:23.000000', NULL),
(78, 25, 4, NULL, 9472, 1, NULL, '2025-06-03 04:13:00.000000', NULL),
(79, 26, 4, NULL, 16, 1, NULL, '2025-05-29 16:54:00.000000', NULL),
(80, 27, 4, NULL, 470, 1, NULL, '2025-05-31 10:49:46.000000', NULL),
(81, 28, 4, NULL, 299, 1, NULL, '2025-05-27 09:13:07.000000', NULL),
(82, 29, 4, NULL, 3, 1, NULL, '2025-06-16 21:09:56.000000', NULL),
(83, 30, 4, NULL, 49, 1, NULL, '2025-05-27 13:30:27.000000', NULL),
(84, 31, 4, NULL, 296, 1, NULL, '2025-05-27 17:26:05.000000', NULL),
(85, 32, 4, NULL, 287, 1, NULL, '2025-05-27 16:22:49.000000', NULL),
(86, 33, 4, NULL, 46, 1, NULL, '2025-05-30 15:07:17.000000', NULL),
(87, 34, 4, NULL, 39, 1, NULL, '2025-05-27 13:30:27.000000', NULL),
(88, 35, 4, NULL, 49, 1, NULL, '2025-05-27 15:32:50.000000', NULL),
(89, 36, 4, NULL, 452, 1, NULL, '2025-05-27 17:33:43.000000', NULL),
(90, 37, 4, NULL, 13, 1, NULL, '2025-05-27 17:24:43.000000', NULL),
(91, 38, 4, NULL, 9, 1, NULL, '2025-06-17 19:36:02.000000', NULL),
(92, 39, 4, NULL, 3, 1, NULL, '2025-06-20 22:14:14.000000', '2025-06-20 22:14:14'),
(93, 40, 4, NULL, 39, 1, NULL, '2025-05-29 16:52:02.000000', NULL),
(94, 41, 4, NULL, 0, 1, NULL, '2025-05-29 15:41:59.000000', NULL),
(95, 42, 4, 10, 31, 1, NULL, '2025-06-20 22:14:09.000000', '2025-06-20 22:14:09'),
(96, 42, 4, 11, 22, 1, NULL, '2025-06-20 22:14:09.000000', '2025-06-20 22:14:09'),
(97, 42, 4, 12, 1, 1, NULL, '2025-06-20 22:14:09.000000', '2025-06-20 22:14:09'),
(98, 42, 4, 13, 17, 1, NULL, '2025-06-20 22:14:09.000000', '2025-06-20 22:14:09'),
(99, 43, 4, NULL, 82, 1, NULL, '2025-05-29 17:02:44.000000', NULL),
(100, 44, 4, NULL, 10, 1, NULL, '2025-05-29 17:14:46.000000', NULL),
(101, 45, 4, NULL, 122, 1, NULL, '2025-06-14 13:31:45.000000', NULL),
(102, 46, 4, NULL, 0, 1, NULL, '2025-05-29 19:22:04.000000', '2025-05-29 19:22:04'),
(103, 47, 4, NULL, 0, 1, NULL, '2025-06-14 13:31:45.000000', NULL),
(104, 48, 4, NULL, 200, 1, NULL, '2025-06-20 22:14:32.000000', '2025-06-20 22:14:32'),
(105, 49, 4, NULL, 50, 1, NULL, '2025-06-20 22:21:12.000000', '2025-06-20 22:21:12'),
(106, 50, 4, 14, 0, 1, NULL, '2025-06-20 22:14:44.000000', '2025-06-20 22:14:44'),
(107, 51, 4, NULL, 0, 1, NULL, '2025-06-21 07:42:48.000000', '2025-06-21 07:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `providers`
--

CREATE TABLE `providers` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(191) NOT NULL,
  `code` varchar(191) NOT NULL,
  `email` varchar(192) DEFAULT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `country` varchar(191) DEFAULT NULL,
  `city` varchar(191) DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `providers`
--

INSERT INTO `providers` (`id`, `user_id`, `name`, `code`, `email`, `phone`, `country`, `city`, `address`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Hassan', '1', '', '', '', '', '', '2025-04-26 05:37:25.000000', '2025-05-20 12:56:30.000000', '2025-05-20 12:56:30'),
(2, 1, 'ALi', '2', '', '', '', '', '', '2025-04-26 05:37:54.000000', '2025-05-20 12:56:27.000000', '2025-05-20 12:56:27'),
(3, 1, 'azhar', '3', '', '', '', '', '', '2025-04-26 10:28:31.000000', '2025-05-20 12:56:24.000000', '2025-05-20 12:56:24'),
(4, 1, 'Asghar', '4', 'asghar@gmail.com', '', '', '', '', '2025-05-13 11:24:23.000000', '2025-05-20 12:56:21.000000', '2025-05-20 12:56:21'),
(5, 1, 'Kashan', '5', 'abbaskashan234@gmail.com', '03140300572', 'Pakistan', 'KARACHI SOUTH', 'Kashane Zainab Plot no 255, Flat no 102 , Soldier bazaar no 1 ,Karachi ,Pakistan', '2025-05-22 15:12:09.000000', '2025-05-22 15:12:09.000000', NULL),
(6, 5, 'FACTORY', '6', '', '0321-2320002', 'PAKISTAN', 'KARACHI', 'PLOT # 247, BANGALI PARA, INFORNT OF KARACHI KANTA.', '2025-05-26 15:28:57.000000', '2025-05-26 15:28:57.000000', NULL),
(7, 5, 'Mujahid', '7', '', '0312 2981567', 'Pakistan', 'Karachi.', 'New Karachi, Industrial area.', '2025-05-27 09:53:06.000000', '2025-05-27 09:53:06.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `provider_ledgers`
--

CREATE TABLE `provider_ledgers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `provider_id` int(11) NOT NULL,
  `type` varchar(191) NOT NULL,
  `reference` varchar(191) DEFAULT NULL,
  `date` date NOT NULL,
  `debit` decimal(15,2) NOT NULL DEFAULT 0.00,
  `credit` decimal(15,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(15,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `provider_ledgers`
--

INSERT INTO `provider_ledgers` (`id`, `provider_id`, `type`, `reference`, `date`, `debit`, `credit`, `balance`, `created_at`, `updated_at`) VALUES
(1, 3, 'purchase', 'PO-20250510-120135', '2025-05-10', 22500.00, 0.00, 22500.00, '2025-05-10 07:01:35', '2025-05-10 07:01:35'),
(2, 3, 'purchase', 'PO-20250513-034243', '2025-05-13', 12500.00, 0.00, 35000.00, '2025-05-13 10:42:43', '2025-05-13 10:42:43'),
(3, 3, 'purchase_return', 'RT_1112', '2025-05-13', 0.00, 2500.00, 32500.00, '2025-05-13 10:49:57', '2025-05-13 10:49:57'),
(4, 3, 'purchase_return_payment', 'INV/RP-20250513-257368', '2025-05-13', 250.00, 0.00, 32750.00, '2025-05-13 11:19:02', '2025-05-13 11:19:02'),
(5, 4, 'purchase', 'PO-20250513-042539', '2025-05-13', 50000.00, 0.00, 50000.00, '2025-05-13 11:25:39', '2025-05-13 11:25:39'),
(6, 4, 'purchase_return', 'RT_1113', '2025-05-13', 0.00, 25000.00, 25000.00, '2025-05-13 11:26:31', '2025-05-13 11:26:31'),
(7, 6, 'purchase', 'PO-20250526-033226', '2025-05-26', 589534.00, 0.00, 589534.00, '2025-05-26 15:32:26', '2025-05-26 15:32:26'),
(8, 6, 'purchase', 'PO-20250526-053321', '2025-05-26', 8600.00, 0.00, 598134.00, '2025-05-26 17:33:21', '2025-05-26 17:33:21'),
(9, 6, 'purchase', 'PO-20250526-053836', '2025-05-26', 22732.00, 0.00, 620866.00, '2025-05-26 17:38:36', '2025-05-26 17:38:36'),
(10, 6, 'purchase', 'PO-20250526-054045', '2025-05-26', 6174.00, 0.00, 627040.00, '2025-05-26 17:40:45', '2025-05-26 17:40:45'),
(11, 6, 'purchase', 'PO-20250527-085548', '2025-05-27', 71034.00, 0.00, 698074.00, '2025-05-27 08:55:48', '2025-05-27 08:55:48'),
(12, 7, 'purchase', 'PO-20250527-095913', '2025-05-27', 16750.00, 0.00, 16750.00, '2025-05-27 09:59:13', '2025-05-27 09:59:13'),
(13, 7, 'purchase', 'PO-20250527-104730', '2025-05-27', 72550.00, 0.00, 89300.00, '2025-05-27 10:47:30', '2025-05-27 10:47:30'),
(14, 7, 'purchase', 'PO-20250529-044651', '2025-05-29', 66930.00, 0.00, 156230.00, '2025-05-29 16:46:51', '2025-05-29 16:46:51'),
(15, 7, 'purchase', 'PO-20250531-122208', '2025-05-31', 33500.00, 0.00, 189730.00, '2025-05-31 12:22:08', '2025-05-31 12:22:08'),
(16, 7, 'purchase', 'PO-20250531-122538', '2025-05-31', 33165.00, 0.00, 222895.00, '2025-05-31 12:25:38', '2025-05-31 12:25:38'),
(17, 5, 'purchase', 'PO-20250614-112323', '2025-06-14', 3432.00, 0.00, 3432.00, '2025-06-14 23:23:23', '2025-06-14 23:23:23'),
(18, 5, 'purchase', 'PO-20250615-124014', '2025-06-15', 1200.00, 0.00, 4632.00, '2025-06-15 12:40:14', '2025-06-15 12:40:14');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `Ref` varchar(192) NOT NULL,
  `date` datetime NOT NULL,
  `provider_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `tax_rate` double DEFAULT 0,
  `TaxNet` double DEFAULT 0,
  `discount` double DEFAULT 0,
  `discount_type` varchar(192) NOT NULL,
  `discount_percent_total` double DEFAULT 0,
  `shipping` double DEFAULT 0,
  `GrandTotal` double NOT NULL,
  `paid_amount` double NOT NULL DEFAULT 0,
  `statut` varchar(191) NOT NULL,
  `payment_statut` varchar(192) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `user_id`, `Ref`, `date`, `provider_id`, `warehouse_id`, `tax_rate`, `TaxNet`, `discount`, `discount_type`, `discount_percent_total`, `shipping`, `GrandTotal`, `paid_amount`, `statut`, `payment_statut`, `notes`, `created_at`, `updated_at`, `deleted_at`, `attachment`) VALUES
(1, 1, 'PO-20250426-113523', '2025-04-27 16:35:00', 1, 1, 0, 0, 0, 'fixed', 0, 0, 151.5, 0, 'received', 'unpaid', '', '2025-04-26 06:35:23.000000', '2025-04-26 06:35:23.000000', NULL, NULL),
(2, 1, 'PO-20250426-025542', '2025-04-26 19:55:00', 1, 2, 0, 0, 0, 'fixed', 0, 0, 227.25, 227.25, 'received', 'paid', '', '2025-04-26 09:55:42.000000', '2025-04-26 09:56:16.000000', NULL, NULL),
(3, 1, 'PO-20250426-035757', '2025-04-26 20:57:00', 1, 2, 0, 0, 0, 'fixed', 0, 0, 3000, 3000, 'received', 'paid', '', '2025-04-26 10:57:57.000000', '2025-04-26 10:58:40.000000', NULL, NULL),
(4, 1, 'PO-20250426-053236', '2025-04-26 22:28:00', 3, 2, 0, 0, 100, 'fixed', 0, 1000, 31650, 31650, 'received', 'paid', 'VIEW KARNA HAI MJHY', '2025-04-26 12:32:36.000000', '2025-04-26 12:33:15.000000', NULL, NULL),
(5, 1, 'PO-20250426-060256', '2025-04-26 23:02:00', 2, 2, 0, 0, 0, 'fixed', 0, 1000, 51000, 0, 'received', 'unpaid', '', '2025-04-26 13:02:56.000000', '2025-04-26 13:02:56.000000', NULL, NULL),
(6, 1, 'PO-20250426-060718', '2025-04-26 23:06:00', 2, 2, 0, 0, 0, 'fixed', 0, 0, 7800, 0, 'received', 'unpaid', '', '2025-04-26 13:07:18.000000', '2025-04-26 13:07:18.000000', NULL, NULL),
(7, 1, 'PO-20250505-125311', '2025-05-05 17:52:00', 2, 2, 0, 0, 0, 'fixed', 0, 0, 1666.5, 0, 'received', 'unpaid', '', '2025-05-05 07:53:11.000000', '2025-05-05 07:53:11.000000', NULL, NULL),
(8, 1, 'PO-20250505-125728', '2025-05-05 17:57:00', 3, 1, 0, 0, 0, 'fixed', 0, 0, 151.5, 0, 'received', 'unpaid', '', '2025-05-05 07:57:28.000000', '2025-05-05 07:57:28.000000', NULL, NULL),
(9, 1, 'PO-20250510-120135', '2025-05-10 17:01:00', 3, 1, 0, 0, 0, 'fixed', 0, 0, 22500, 0, 'received', 'unpaid', '', '2025-05-10 07:01:35.000000', '2025-05-10 07:01:35.000000', NULL, NULL),
(10, 1, 'PO-20250513-034243', '2025-05-13 20:41:00', 3, 2, 0, 0, 0, 'fixed', 0, 0, 12500, 0, 'received', 'unpaid', '', '2025-05-13 10:42:43.000000', '2025-05-13 10:42:43.000000', NULL, NULL),
(11, 1, 'PO-20250513-042539', '2025-05-13 21:25:00', 4, 1, 0, 0, 0, 'fixed', 0, 0, 50000, 0, 'received', 'unpaid', '', '2025-05-13 11:25:39.000000', '2025-05-13 11:25:39.000000', NULL, NULL),
(12, 5, 'PO-20250526-033226', '2025-05-26 20:29:00', 6, 4, 0, 0, 0, 'fixed', 0, 0, 589534, 0, 'received', 'unpaid', 'CHALLAN # 35 & 36', '2025-05-26 15:32:26.000000', '2025-05-26 15:32:26.000000', NULL, NULL),
(13, 5, 'PO-20250526-053321', '2025-05-25 22:32:00', 6, 4, 0, 0, 0, 'fixed', 0, 0, 8600, 0, 'received', 'unpaid', 'COLLECT BY RIZWAN', '2025-05-26 17:33:21.000000', '2025-05-26 17:33:21.000000', NULL, NULL),
(14, 5, 'PO-20250526-053836', '2025-05-26 22:37:00', 6, 4, 0, 0, 0, 'fixed', 0, 0, 22800, 0, '', 'unpaid', 'Challan # 37 - (further dori roll & order sheets also receive)', '2025-05-26 17:38:36.000000', '2025-05-26 17:38:57.000000', NULL, NULL),
(15, 5, 'PO-20250526-054045', '2025-05-26 22:39:00', 6, 4, 0, 0, 0, 'fixed', 0, 0, 6174, 0, 'received', 'unpaid', '', '2025-05-26 17:40:45.000000', '2025-05-26 17:40:45.000000', NULL, NULL),
(16, 5, 'PO-20250527-085548', '2025-05-27 13:54:00', 6, 4, 0, 0, 0, 'fixed', 0, 0, 71034, 0, 'received', 'unpaid', '', '2025-05-27 08:55:48.000000', '2025-05-27 08:55:48.000000', NULL, NULL),
(17, 5, 'PO-20250527-095913', '2025-05-27 14:54:00', 7, 4, 0, 0, 0, 'fixed', 0, 0, 16750, 0, 'received', 'unpaid', '', '2025-05-27 09:59:13.000000', '2025-05-27 09:59:13.000000', NULL, NULL),
(18, 5, 'PO-20250527-104730', '2025-05-27 15:41:00', 7, 4, 0, 0, 0, 'fixed', 0, 0, 72550, 0, 'received', 'unpaid', '', '2025-05-27 10:47:30.000000', '2025-05-27 10:47:30.000000', NULL, NULL),
(19, 5, 'PO-20250529-044651', '2025-05-28 20:44:00', 7, 4, 0, 0, 0, 'fixed', 0, 0, 66930, 0, 'received', 'unpaid', '', '2025-05-29 16:46:51.000000', '2025-05-29 16:46:51.000000', NULL, NULL),
(20, 5, 'PO-20250531-122208', '2025-05-31 17:21:00', 7, 4, 0, 0, 0, 'fixed', 0, 0, 33500, 0, 'received', 'unpaid', '', '2025-05-31 12:22:08.000000', '2025-05-31 12:22:08.000000', NULL, NULL),
(21, 5, 'PO-20250531-122538', '2025-05-31 17:25:00', 7, 4, 0, 0, 0, 'fixed', 0, 0, 33165, 0, 'received', 'unpaid', '', '2025-05-31 12:25:38.000000', '2025-05-31 12:25:38.000000', NULL, NULL),
(22, 1, 'PO-20250614-112323', '2025-06-15 04:22:00', 5, 4, 0, 0, 0, 'fixed', 0, 0, 3146, 0, 'received', 'unpaid', '', '2025-06-14 23:23:23.000000', '2025-06-14 23:45:20.000000', NULL, 'attachments/purchases/00dSinOjdTzFynA3kaX3KgfwcrW7cQian41mMA0l.pdf'),
(23, 1, 'PO-20250615-124014', '2025-06-15 17:39:00', 5, 4, 0, 0, 0, 'fixed', 0, 0, 1200, 0, 'received', 'unpaid', '', '2025-06-15 12:40:14.000000', '2025-06-15 12:40:14.000000', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_details`
--

CREATE TABLE `purchase_details` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `cost` double NOT NULL,
  `purchase_unit_id` int(11) DEFAULT NULL,
  `TaxNet` double DEFAULT 0,
  `tax_method` varchar(192) DEFAULT '1',
  `discount` double DEFAULT 0,
  `discount_method` varchar(192) DEFAULT '1',
  `purchase_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `total` double NOT NULL,
  `quantity` double NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_details`
--

INSERT INTO `purchase_details` (`id`, `date`, `cost`, `purchase_unit_id`, `TaxNet`, `tax_method`, `discount`, `discount_method`, `purchase_id`, `product_id`, `product_variant_id`, `imei_number`, `total`, `quantity`, `created_at`, `updated_at`) VALUES
(1, '2025-04-27 16:35:00', 15, 1, 1, '1', 0, '2', 1, 3, NULL, '', 151.5, 10, NULL, NULL),
(2, '2025-04-26 19:55:00', 15, 1, 1, '1', 0, '2', 2, 3, NULL, '', 227.25, 15, NULL, NULL),
(3, '2025-04-26 20:57:00', 15, 4, 0, '1', 0, '2', 3, 4, 1, '', 3000, 200, NULL, NULL),
(4, '2025-04-26 22:28:00', 205, 5, 0, '1', 0, '2', 4, 5, 4, '', 20500, 100, NULL, NULL),
(5, '2025-04-26 22:28:00', 205, 5, 0, '1', 0, '2', 4, 5, 5, '', 10250, 50, NULL, NULL),
(6, '2025-04-26 23:02:00', 50, 4, 0, '1', 0, '2', 5, 6, NULL, '', 50000, 1000, NULL, NULL),
(7, '2025-04-26 23:06:00', 300, 4, 0, '1', 0, '2', 6, 6, NULL, '', 7800, 26, NULL, NULL),
(8, '2025-05-05 17:52:00', 15, 1, 1, '1', 0, '2', 7, 3, NULL, '', 1666.5, 110, NULL, NULL),
(9, '2025-05-05 17:57:00', 15, 1, 1, '1', 0, '2', 8, 3, NULL, '', 151.5, 10, NULL, NULL),
(10, '2025-05-10 17:01:00', 1500, 4, 0, 'null', 0, '2', 9, 10, NULL, '', 22500, 15, NULL, NULL),
(11, '2025-05-13 20:41:00', 250, 5, 0, '1', 0, '2', 10, 9, 9, '', 12500, 50, NULL, NULL),
(12, '2025-05-13 21:25:00', 250, 5, 0, '1', 0, '2', 11, 9, 9, '', 50000, 200, NULL, NULL),
(13, '2025-05-26 20:29:00', 86, 4, 0, '1', 0, '2', 12, 13, NULL, '', 581274, 6759, NULL, NULL),
(14, '2025-05-26 20:29:00', 590, 1, 0, '1', 0, '2', 12, 26, NULL, '', 8260, 14, NULL, NULL),
(15, '2025-05-25 22:32:00', 86, 4, 0, '1', 0, '2', 13, 13, NULL, '', 8600, 100, NULL, NULL),
(16, '2025-05-26 22:37:00', 94, 4, 0, '1', 0, '2', 14, 12, NULL, '', 21338, 227, NULL, '2025-05-26 17:38:57.000000'),
(17, '2025-05-26 22:37:00', 86, 4, 0, '1', 0, '2', 14, 13, NULL, '', 1462, 17, NULL, '2025-05-26 17:38:57.000000'),
(18, '2025-05-26 22:39:00', 86, 4, 0, '1', 0, '2', 15, 13, NULL, '', 5934, 69, NULL, NULL),
(19, '2025-05-26 22:39:00', 60, 4, 0, '1', 0, '2', 15, 19, NULL, '', 240, 4, NULL, NULL),
(20, '2025-05-27 13:54:00', 94, 4, 0, '1', 0, '2', 16, 12, NULL, '', 70124, 746, NULL, NULL),
(21, '2025-05-27 13:54:00', 70, 4, 0, '1', 0, '2', 16, 27, NULL, '', 910, 13, NULL, NULL),
(22, '2025-05-27 14:54:00', 335, 9, 0, '1', 0, '2', 17, 16, NULL, '', 16750, 50, NULL, NULL),
(23, '2025-05-27 15:41:00', 335, 9, 0, '1', 0, '2', 18, 16, NULL, '', 33500, 100, NULL, NULL),
(24, '2025-05-27 15:41:00', 235, 9, 0, '1', 0, '2', 18, 15, NULL, '', 23500, 100, NULL, NULL),
(25, '2025-05-27 15:41:00', 190, 11, 0, '1', 0, '2', 18, 21, NULL, '', 7600, 40, NULL, NULL),
(26, '2025-05-27 15:41:00', 150, 11, 0, '1', 0, '2', 18, 22, NULL, '', 7950, 53, NULL, NULL),
(27, '2025-05-28 20:44:00', 335, 9, 0, '1', 0, '2', 19, 16, NULL, '', 21105, 63, NULL, NULL),
(28, '2025-05-28 20:44:00', 235, 9, 0, '1', 0, '2', 19, 15, NULL, '', 45825, 195, NULL, NULL),
(29, '2025-05-31 17:21:00', 335, 9, 0, '1', 0, '2', 20, 16, NULL, '', 33500, 100, NULL, NULL),
(30, '2025-05-31 17:25:00', 335, 9, 0, '1', 0, '2', 21, 16, NULL, '', 33165, 99, NULL, NULL),
(31, '2025-06-15 04:22:00', 286, 5, 0, '1', 0, '2', 22, 29, NULL, '', 3146, 11, NULL, '2025-06-14 23:45:20.000000'),
(32, '2025-06-15 17:39:00', 12, 1, 0, '1', 0, '2', 23, 48, NULL, '', 1200, 100, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_returns`
--

CREATE TABLE `purchase_returns` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `provider_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `tax_rate` double DEFAULT 0,
  `TaxNet` double DEFAULT 0,
  `discount` double DEFAULT 0,
  `discount_type` varchar(192) NOT NULL,
  `discount_percent_total` double DEFAULT 0,
  `shipping` double DEFAULT 0,
  `GrandTotal` double NOT NULL,
  `paid_amount` double NOT NULL DEFAULT 0,
  `payment_statut` varchar(192) NOT NULL,
  `statut` varchar(192) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_returns`
--

INSERT INTO `purchase_returns` (`id`, `user_id`, `date`, `Ref`, `purchase_id`, `provider_id`, `warehouse_id`, `tax_rate`, `TaxNet`, `discount`, `discount_type`, `discount_percent_total`, `shipping`, `GrandTotal`, `paid_amount`, `payment_statut`, `statut`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '2025-04-26 16:07:00', 'RT_1111', 1, 1, 1, 0, 0, 0, 'fixed', 0, 0, 151.5, 151.5, 'paid', 'completed', '', '2025-04-26 11:08:05.000000', '2025-04-26 11:08:23.000000', NULL),
(2, 1, '2025-05-13 15:49:00', 'RT_1112', 10, 3, 2, 0, 0, 0, 'fixed', 0, 0, 2500, 250, 'partial', 'completed', '', '2025-05-13 10:49:57.000000', '2025-05-13 11:19:02.000000', NULL),
(3, 1, '2025-05-13 16:26:00', 'RT_1113', 11, 4, 1, 0, 0, 0, 'fixed', 0, 0, 25000, 0, 'unpaid', 'completed', '', '2025-05-13 11:26:31.000000', '2025-05-13 11:26:31.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return_details`
--

CREATE TABLE `purchase_return_details` (
  `id` int(11) NOT NULL,
  `cost` decimal(16,3) NOT NULL,
  `purchase_unit_id` int(11) DEFAULT NULL,
  `TaxNet` double DEFAULT 0,
  `tax_method` varchar(192) DEFAULT '1',
  `discount` double DEFAULT 0,
  `discount_method` varchar(192) DEFAULT '1',
  `total` double NOT NULL,
  `quantity` double NOT NULL,
  `purchase_return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_return_details`
--

INSERT INTO `purchase_return_details` (`id`, `cost`, `purchase_unit_id`, `TaxNet`, `tax_method`, `discount`, `discount_method`, `total`, `quantity`, `purchase_return_id`, `product_id`, `product_variant_id`, `imei_number`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 15.000, 1, 1, '1', 0, '2', 151.5, 10, 1, 3, NULL, '', NULL, NULL, NULL),
(2, 250.000, 5, 0, '1', 0, '2', 2500, 10, 2, 9, 9, '', NULL, NULL, NULL),
(3, 250.000, 5, 0, '1', 0, '2', 25000, 100, 3, 9, 9, '', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

CREATE TABLE `quotations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) NOT NULL,
  `client_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `tax_rate` double DEFAULT 0,
  `TaxNet` double DEFAULT 0,
  `discount` double DEFAULT 0,
  `discount_type` varchar(192) NOT NULL,
  `discount_percent_total` double DEFAULT 0,
  `shipping` double DEFAULT 0,
  `GrandTotal` double NOT NULL,
  `statut` varchar(192) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotations`
--

INSERT INTO `quotations` (`id`, `user_id`, `date`, `Ref`, `client_id`, `warehouse_id`, `tax_rate`, `TaxNet`, `discount`, `discount_type`, `discount_percent_total`, `shipping`, `GrandTotal`, `statut`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '2025-04-26 16:34:00', 'QT_1111', 2, 1, 0, 0, 0, 'fixed', 0, 0, 303, 'pending', '', '2025-04-26 06:34:37.000000', '2025-04-26 06:34:37.000000', NULL),
(2, 1, '2025-04-26 20:56:00', 'QT_1112', 2, 1, 0, 0, 0, 'fixed', 0, 0, 300, 'pending', '', '2025-04-26 10:57:10.000000', '2025-04-26 10:57:10.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quotation_details`
--

CREATE TABLE `quotation_details` (
  `id` int(11) NOT NULL,
  `price` double NOT NULL,
  `sale_unit_id` int(11) DEFAULT NULL,
  `TaxNet` double DEFAULT 0,
  `tax_method` varchar(192) DEFAULT '1',
  `discount` double DEFAULT 0,
  `discount_method` varchar(192) DEFAULT '1',
  `total` double NOT NULL,
  `quantity` double NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `quotation_id` int(11) NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotation_details`
--

INSERT INTO `quotation_details` (`id`, `price`, `sale_unit_id`, `TaxNet`, `tax_method`, `discount`, `discount_method`, `total`, `quantity`, `product_id`, `product_variant_id`, `imei_number`, `quotation_id`, `created_at`, `updated_at`) VALUES
(1, 30, 1, 1, '1', 0, '2', 303, 10, 3, NULL, '', 1, NULL, NULL),
(2, 20, 4, 0, '1', 0, '2', 300, 15, 4, 1, '', 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `guard_name` varchar(191) NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `guard_name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Super Admin', 'Super Admin', 'web', NULL, NULL, NULL),
(5, 'Sales man', 'Generate Sales leads , Delivering goods and  collect payment.', 'web', '2025-05-18 05:13:57.000000', '2025-05-22 10:31:05.000000', NULL),
(6, 'Pos\'s operator', 'RECORD SALES', 'web', '2025-06-12 16:39:06.000000', '2025-06-12 16:39:06.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 3),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(17, 2),
(17, 3),
(17, 5),
(17, 6),
(18, 1),
(18, 3),
(18, 5),
(18, 6),
(19, 1),
(19, 6),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(24, 2),
(24, 3),
(25, 1),
(26, 1),
(26, 2),
(26, 3),
(27, 1),
(28, 1),
(28, 2),
(28, 3),
(28, 5),
(29, 1),
(29, 3),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(45, 3),
(45, 5),
(46, 1),
(46, 2),
(46, 3),
(46, 5),
(47, 1),
(47, 5),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(51, 3),
(52, 1),
(52, 3),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(58, 2),
(58, 3),
(58, 6),
(59, 1),
(59, 3),
(59, 5),
(59, 6),
(60, 1),
(60, 5),
(60, 6),
(61, 1),
(62, 1),
(62, 2),
(62, 3),
(63, 1),
(63, 3),
(64, 1),
(65, 1),
(66, 1),
(66, 2),
(66, 3),
(66, 5),
(66, 6),
(67, 1),
(67, 2),
(67, 3),
(67, 5),
(67, 6),
(68, 1),
(68, 3),
(69, 1),
(70, 1),
(70, 2),
(70, 3),
(71, 1),
(71, 2),
(71, 3),
(72, 1),
(72, 3),
(73, 1),
(74, 1),
(74, 2),
(74, 3),
(74, 6),
(75, 1),
(75, 2),
(75, 3),
(75, 6),
(76, 1),
(76, 3),
(76, 6),
(77, 1),
(78, 1),
(78, 2),
(79, 1),
(80, 1),
(81, 1),
(82, 1),
(83, 1),
(84, 1),
(85, 1),
(86, 1),
(87, 1),
(88, 1),
(89, 1),
(90, 1),
(90, 5),
(91, 1),
(92, 1),
(93, 1),
(94, 1),
(94, 2),
(94, 3),
(94, 5),
(94, 6),
(95, 1),
(96, 1),
(96, 2),
(97, 1),
(97, 2),
(97, 3),
(98, 1),
(99, 1),
(99, 2),
(99, 3),
(99, 6),
(100, 1),
(100, 2),
(100, 3),
(100, 6),
(101, 1),
(101, 6),
(102, 1),
(103, 1),
(104, 1),
(105, 1),
(105, 3),
(106, 1),
(106, 5),
(107, 1),
(108, 1),
(109, 1),
(110, 1),
(110, 2),
(110, 3),
(111, 1),
(111, 2),
(111, 3),
(112, 1),
(112, 3),
(113, 1),
(114, 1),
(115, 1),
(115, 2),
(115, 3),
(202, 2),
(202, 6),
(203, 3),
(208, 3);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) NOT NULL,
  `is_pos` tinyint(1) DEFAULT 0,
  `client_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `tax_rate` double DEFAULT 0,
  `TaxNet` double DEFAULT 0,
  `discount` double DEFAULT 0,
  `discount_type` varchar(192) NOT NULL,
  `discount_percent_total` double DEFAULT 0,
  `shipping` double DEFAULT 0,
  `GrandTotal` double NOT NULL DEFAULT 0,
  `paid_amount` double NOT NULL DEFAULT 0,
  `payment_statut` varchar(192) NOT NULL,
  `statut` varchar(191) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `assigned_driver` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `user_id`, `date`, `Ref`, `is_pos`, `client_id`, `warehouse_id`, `tax_rate`, `TaxNet`, `discount`, `discount_type`, `discount_percent_total`, `shipping`, `GrandTotal`, `paid_amount`, `payment_statut`, `statut`, `notes`, `created_at`, `updated_at`, `deleted_at`, `assigned_driver`) VALUES
(1, 1, '2025-04-26 16:16:00', 'SO-20250426-111633', 1, 1, 1, 0, 0, 0, 'fixed', 0, 0, 30.3, 30.3, 'paid', 'completed', '', '2025-04-26 06:16:33.000000', '2025-04-26 06:16:33.000000', NULL, NULL),
(2, 1, '2025-04-26 16:38:00', 'SO-20250426-113938', 1, 2, 1, 0, 0, 15, 'fixed', 0, 150, 165.3, 165.3, 'paid', 'completed', '', '2025-04-26 06:39:38.000000', '2025-04-26 06:39:38.000000', NULL, NULL),
(3, 1, '2025-04-26 16:39:00', 'SO-20250426-114031', 0, 2, 1, 0, 0, 0, 'fixed', 0, 0, 44890.9, 44890.9, 'paid', 'completed', '', '2025-04-26 06:40:31.000000', '2025-04-26 11:03:03.000000', NULL, NULL),
(4, 1, '2025-04-26 20:51:00', 'SO-20250426-035217', 1, 3, 1, 0, 0, 0, 'fixed', 0, 150, 604.5, 604.5, 'paid', 'completed', '', '2025-04-26 10:52:17.000000', '2025-04-26 10:52:17.000000', NULL, NULL),
(5, 1, '2025-04-26 20:59:00', 'SO-20250426-035927', 0, 2, 2, 0, 0, 0, 'fixed', 0, 0, 300, 300, 'paid', 'completed', '', '2025-04-26 10:59:27.000000', '2025-04-26 11:00:01.000000', NULL, NULL),
(6, 1, '2025-04-26 21:01:00', 'SO-20250426-040156', 0, 2, 1, 0, 0, 0, 'fixed', 0, 0, 350, 350, 'paid', 'completed', '', '2025-04-26 11:01:56.000000', '2025-04-26 11:02:21.000000', NULL, NULL),
(7, 1, '2025-04-26 21:08:00', 'SO-20250426-040854', 0, 2, 2, 0, 0, 0, 'fixed', 0, 0, 200, 0, 'unpaid', 'completed', '', '2025-04-26 11:08:54.000000', '2025-04-26 11:08:54.000000', NULL, NULL),
(8, 1, '2025-04-26 22:34:00', 'SO-20250426-053610', 0, 4, 2, 0, 0, 10, 'percent', 375, 200, 3575, 3575, 'paid', 'completed', '', '2025-04-26 12:36:10.000000', '2025-04-26 12:43:51.000000', NULL, NULL),
(9, 1, '2025-04-26 22:46:00', 'SO-20250426-054738', 0, 4, 2, 0, 0, 0, 'fixed', 0, 0, 2800, 2300, 'partial', 'completed', '', '2025-04-26 12:47:38.000000', '2025-05-13 12:34:36.000000', NULL, NULL),
(10, 1, '2025-04-26 22:47:00', 'SO-20250426-054905', 0, 3, 2, 0, 0, 0, 'fixed', 0, 0, 5550, 0, 'unpaid', 'completed', '', '2025-04-26 12:49:05.000000', '2025-04-26 12:49:05.000000', NULL, NULL),
(11, 1, '2025-04-26 23:04:00', 'SO-20250426-060524', 0, 2, 2, 0, 0, 0, 'fixed', 0, 500, 900, 0, 'unpaid', 'completed', '', '2025-04-26 13:05:24.000000', '2025-04-26 13:05:24.000000', NULL, NULL),
(12, 1, '2025-03-29 00:19:00', 'SO-20250426-072102', 1, 1, 1, 0, 0, 0, 'fixed', 0, 0, 30.3, 30.3, 'paid', 'completed', '', '2025-04-26 14:21:02.000000', '2025-04-26 14:21:02.000000', NULL, NULL),
(13, 1, '2025-04-28 23:58:00', 'SO-20250428-065909', 0, 2, 2, 0, 0, 0, 'fixed', 0, 0, 757.5, 0, 'unpaid', 'completed', '', '2025-04-28 13:59:09.000000', '2025-04-28 13:59:09.000000', NULL, NULL),
(14, 1, '2025-04-29 00:05:00', 'SO-20250428-070818', 0, 2, 1, 0, 0, 0, 'fixed', 0, 0, 454.5, 0, 'unpaid', 'completed', '', '2025-04-28 14:08:18.000000', '2025-04-28 14:08:18.000000', NULL, NULL),
(15, 1, '2025-04-29 00:15:00', 'SO-20250428-071544', 0, 2, 1, 0, 0, 0, 'fixed', 0, 0, 454.5, 0, 'unpaid', 'completed', '', '2025-04-28 14:15:44.000000', '2025-04-28 14:15:44.000000', NULL, NULL),
(16, 1, '2025-04-29 00:28:00', 'SO-20250428-072834', 0, 2, 1, 0, 0, 0, 'fixed', 0, 0, 151.5, 0, 'unpaid', 'completed', '', '2025-04-28 14:28:34.000000', '2025-04-28 14:43:51.000000', NULL, NULL),
(20, 1, '2025-05-05 16:33:00', 'SO-20250505-113329', 0, 2, 2, 0, 0, 0, 'fixed', 0, 0, 50000, 0, 'unpaid', 'completed', '', '2025-05-05 06:33:29.000000', '2025-05-05 06:33:29.000000', NULL, NULL),
(21, 1, '2025-05-05 16:40:00', 'SO-20250505-114112', 0, 2, 2, 0, 0, 0, 'fixed', 0, 0, 50000, 0, 'unpaid', 'completed', '', '2025-05-05 06:41:12.000000', '2025-05-05 06:41:12.000000', NULL, NULL),
(22, 1, '2025-05-05 16:41:00', 'SO-20250505-114150', 1, 2, 2, 0, 0, 0, 'fixed', 0, 0, 5000, 5000, 'paid', 'completed', '20', '2025-05-05 06:41:50.000000', '2025-05-05 06:41:50.000000', NULL, NULL),
(23, 1, '2025-05-05 16:41:00', 'SO-20250505-114238', 1, 2, 2, 0, 0, 0, 'fixed', 0, 0, 5000, 5000, 'paid', 'completed', '', '2025-05-05 06:42:38.000000', '2025-05-05 06:42:38.000000', NULL, NULL),
(24, 1, '2025-05-05 16:42:00', 'SO-20250505-114751', 1, 1, 2, 0, 0, 0, 'fixed', 0, 250, 280.3, 280.3, 'paid', 'completed', '', '2025-05-05 06:47:51.000000', '2025-05-05 06:47:51.000000', NULL, NULL),
(25, 1, '2025-05-05 16:48:00', 'SO-20250505-114829', 1, 2, 2, 0, 0, 0, 'fixed', 0, 0, 22400, 22400, 'paid', 'completed', '', '2025-05-05 06:48:29.000000', '2025-05-05 06:48:29.000000', NULL, NULL),
(28, 1, '2025-05-05 17:01:00', 'SO-20250505-120143', 1, 2, 2, 0, 0, 0, 'fixed', 0, 0, 22400, 22400, 'paid', 'completed', '', '2025-05-05 07:01:43.000000', '2025-05-05 07:01:43.000000', NULL, NULL),
(29, 1, '2025-05-05 17:03:00', 'SO-20250505-122723', 1, 2, 1, 0, 0, 0, 'fixed', 0, 0, 0, 22400, 'paid', 'completed', '', '2025-05-05 07:27:23.000000', '2025-05-05 08:36:20.000000', NULL, NULL),
(30, 1, '2025-05-05 19:11:00', 'SO-20250505-021118', 1, 2, 2, 0, 0, 0, 'fixed', 0, 0, 5000, 5000, 'paid', 'completed', '', '2025-05-05 09:11:18.000000', '2025-05-05 09:11:18.000000', NULL, NULL),
(31, 1, '2025-05-10 16:07:00', 'SO-20250510-110825', 0, 2, 1, 0, 0, 0, 'fixed', 0, 0, 303, 200, 'partial', 'completed', '', '2025-05-10 06:08:25.000000', '2025-05-10 08:33:03.000000', NULL, NULL),
(32, 1, '2025-05-10 16:18:00', 'SO-20250510-111852', 0, 2, 1, 0, 0, 0, 'fixed', 0, 0, 2575.5, 0, 'unpaid', 'completed', '', '2025-05-10 06:18:52.000000', '2025-05-10 06:19:13.000000', NULL, NULL),
(33, 1, '2025-05-10 16:29:00', 'SO-20250510-113021', 0, 2, 1, 0, 0, 0, 'fixed', 0, 0, 20800, 0, 'unpaid', 'completed', '', '2025-05-10 06:30:21.000000', '2025-05-10 06:32:41.000000', NULL, NULL),
(34, 1, '2025-05-10 17:02:00', 'SO-20250510-120311', 0, 2, 1, 0, 0, 0, 'fixed', 0, 0, 18000, 100, 'partial', 'completed', '', '2025-05-10 07:03:11.000000', '2025-05-13 13:16:14.000000', NULL, NULL),
(35, 1, '2025-05-10 17:23:00', 'SO-20250510-122349', 1, 2, 2, 0, 0, 0, 'fixed', 0, 0, 27400, 27400, 'paid', 'completed', '', '2025-05-10 07:23:49.000000', '2025-05-10 07:23:49.000000', NULL, NULL),
(36, 1, '2025-05-10 17:26:00', 'SO-20250510-122650', 1, 2, 1, 0, 0, 0, 'fixed', 0, 0, 303, 303, 'paid', 'completed', '', '2025-05-10 07:26:50.000000', '2025-05-10 07:26:50.000000', NULL, NULL),
(37, 1, '2025-05-13 14:39:00', 'SO-20250513-093931', 1, 2, 1, 0, 0, 0, 'fixed', 0, 0, 52.3, 52.3, 'paid', 'completed', '', '2025-05-13 04:39:31.000000', '2025-05-13 04:39:31.000000', NULL, NULL),
(38, 1, '2025-05-13 14:43:00', 'SO-20250513-094412', 1, 1, 1, 0, 0, 0, 'fixed', 0, 0, 77.3, 77.3, 'paid', 'completed', '', '2025-05-13 04:44:12.000000', '2025-05-13 04:44:12.000000', NULL, NULL),
(39, 1, '2025-05-13 14:44:00', 'SO-20250513-100905', 1, 2, 1, 0, 0, 0, 'fixed', 0, 0, 30.3, 30.3, 'paid', 'completed', '', '2025-05-13 05:09:05.000000', '2025-05-13 05:09:06.000000', NULL, NULL),
(40, 1, '2025-05-13 23:31:00', 'SO-20250513-063148', 1, 6, 1, 0, 0, 0, 'fixed', 0, 0, 22430.3, 22430.3, 'paid', 'completed', '', '2025-05-13 13:31:48.000000', '2025-05-13 13:31:48.000000', NULL, NULL),
(41, 1, '2025-05-13 23:31:00', 'SO-20250513-063220', 1, 6, 2, 0, 0, 0, 'fixed', 0, 0, 5000, 5000, 'paid', 'completed', '', '2025-05-13 13:32:20.000000', '2025-05-13 13:32:20.000000', NULL, NULL),
(42, 1, '2025-05-13 23:33:00', 'SO-20250513-063338', 1, 6, 1, 0, 0, 0, 'fixed', 0, 0, 121.2, 100, 'partial', 'completed', '', '2025-05-13 13:33:38.000000', '2025-05-18 05:19:01.000000', NULL, NULL),
(43, 1, '2025-05-18 15:23:00', 'SO-20250518-102428', 1, 6, 1, 0, 0, 0, 'fixed', 0, 0, 151.5, 20, 'partial', 'completed', '', '2025-05-18 05:24:28.000000', '2025-05-18 05:24:28.000000', NULL, NULL),
(44, 1, '2025-05-18 15:45:00', 'SO-20250518-104626', 1, 1, 4, 0, 0, 0, 'fixed', 0, 0, 12, 12, 'paid', 'completed', 'ghhv', '2025-05-18 05:46:26.000000', '2025-05-20 15:03:19.000000', '2025-05-20 15:03:19', NULL),
(45, 1, '2025-05-18 15:48:00', 'SO-20250518-104845', 1, 1, 4, 0, 0, 0, 'fixed', 0, 0, 12, 12, 'paid', 'completed', '', '2025-05-18 05:48:45.000000', '2025-05-20 15:03:15.000000', '2025-05-20 15:03:15', NULL),
(46, 1, '2025-05-18 18:47:00', 'SO-20250518-014755', 1, 2, 4, 0, 0, 0, 'fixed', 0, 0, 144, 50, 'partial', 'completed', '', '2025-05-18 08:47:55.000000', '2025-05-20 15:03:11.000000', '2025-05-20 15:03:11', NULL),
(47, 1, '2025-05-18 18:48:00', 'SO-20250518-020302', 1, 2, 4, 0, 0, 0, 'fixed', 0, 0, 24, 24, 'paid', 'completed', '', '2025-05-18 09:03:02.000000', '2025-05-20 15:03:22.000000', '2025-05-20 15:03:22', NULL),
(48, 1, '2025-05-18 19:31:00', 'SO-20250518-023206', 1, 1, 4, 0, 0, 0, 'fixed', 0, 0, 44800, 44800, 'paid', 'completed', '', '2025-05-18 09:32:06.000000', '2025-05-20 15:03:06.000000', '2025-05-20 15:03:06', NULL),
(49, 1, '2025-05-18 21:28:00', 'SO-20250518-042921', 1, 3, 4, 0, 0, 0, 'fixed', 0, 0, 150, 150, 'paid', 'completed', '', '2025-05-18 11:29:21.000000', '2025-05-20 15:03:00.000000', '2025-05-20 15:03:00', NULL),
(50, 5, '2025-05-21 19:42:00', 'SO-20250521-024519', 0, 7, 4, 0, 0, 0, 'fixed', 0, 50, 9246, 9246, 'paid', 'completed', 'OUT OF STOCK : 139,341,498,839', '2025-05-21 14:45:19.000000', '2025-05-22 10:53:20.000000', NULL, NULL),
(51, 5, '2025-05-21 19:45:00', 'SO-20250521-024732', 0, 10, 4, 0, 0, 0, 'fixed', 0, 0, 15047, 15047, 'paid', 'completed', 'OUT OF STOCK : 132,846.', '2025-05-21 14:47:32.000000', '2025-05-22 10:56:25.000000', NULL, NULL),
(52, 5, '2025-05-21 19:47:00', 'SO-20250521-024913', 0, 9, 4, 0, 0, 0, 'fixed', 0, 0, 5881, 5881, 'paid', 'completed', '', '2025-05-21 14:49:13.000000', '2025-05-22 10:58:22.000000', NULL, NULL),
(53, 5, '2025-05-21 19:50:00', 'SO-20250521-025126', 0, 11, 4, 0, 0, 0, 'fixed', 0, 0, 1200, 1200, 'paid', 'completed', '', '2025-05-21 14:51:26.000000', '2025-05-22 10:52:09.000000', NULL, NULL),
(54, 5, '2025-05-21 20:04:00', 'SO-20250521-030501', 0, 8, 4, 0, 0, 0, 'fixed', 0, 0, 1380, 1380, 'paid', 'completed', '', '2025-05-21 15:05:01.000000', '2025-05-22 10:53:57.000000', NULL, NULL),
(55, 5, '2025-05-21 20:57:00', 'SO-20250521-035912', 0, 12, 4, 0, 0, 966, 'fixed', 0, 0, 11121, 11121, 'paid', 'completed', '', '2025-05-21 15:59:12.000000', '2025-05-22 11:00:50.000000', NULL, NULL),
(56, 5, '2025-05-22 17:01:00', 'SO-20250522-120145', 0, 20, 4, 0, 0, 0, 'fixed', 0, 0, 10334, 5000, 'partial', '', '', '2025-05-22 12:01:45.000000', '2025-05-23 13:57:55.000000', NULL, NULL),
(57, 5, '2025-05-22 17:02:00', 'SO-20250522-120513', 0, 15, 4, 0, 0, 4, 'percent', 567.04, 0, 13608.96, 13608, 'partial', 'completed', '', '2025-05-22 12:05:13.000000', '2025-05-23 13:59:20.000000', NULL, NULL),
(58, 5, '2025-05-22 17:08:00', 'SO-20250522-121040', 0, 28, 4, 0, 0, 210, 'fixed', 0, 0, 7884, 7880, 'partial', 'completed', '', '2025-05-22 12:10:40.000000', '2025-05-23 13:58:30.000000', NULL, NULL),
(59, 5, '2025-05-22 17:12:00', 'SO-20250522-121346', 0, 21, 4, 0, 0, 0, 'fixed', 0, 0, 11208, 10000, 'partial', 'completed', '', '2025-05-22 12:13:46.000000', '2025-05-23 13:59:47.000000', NULL, NULL),
(60, 5, '2025-05-22 17:13:00', 'SO-20250522-122633', 0, 16, 4, 0, 0, 0, 'fixed', 0, 0, 17305, 10000, 'partial', 'completed', '', '2025-05-22 12:26:33.000000', '2025-05-23 14:00:22.000000', NULL, NULL),
(61, 5, '2025-05-22 17:27:00', 'SO-20250522-122817', 0, 27, 4, 0, 0, 0, 'fixed', 0, 0, 20705, 10, 'partial', 'completed', '', '2025-05-22 12:28:17.000000', '2025-05-23 14:00:48.000000', NULL, NULL),
(62, 5, '2025-05-22 17:34:00', 'SO-20250522-123509', 0, 18, 4, 0, 0, 0, 'fixed', 0, 0, 5346, 3530, 'partial', 'completed', '', '2025-05-22 12:35:09.000000', '2025-05-23 13:56:21.000000', NULL, NULL),
(63, 5, '2025-05-22 17:35:00', 'SO-20250522-123822', 0, 14, 4, 0, 0, 975, 'fixed', 0, 0, 21544, 14, 'partial', 'completed', '', '2025-05-22 12:38:22.000000', '2025-05-23 13:57:01.000000', NULL, NULL),
(64, 5, '2025-05-22 18:58:00', 'SO-20250522-015937', 0, 36, 4, 0, 0, 0, 'fixed', 0, 0, 2750, 0, 'unpaid', 'completed', '', '2025-05-22 13:59:37.000000', '2025-05-22 13:59:37.000000', NULL, NULL),
(65, 5, '2025-05-22 19:01:00', 'SO-20250522-020231', 0, 37, 4, 0, 0, 0, 'fixed', 0, 0, 3556, 3556, 'paid', '', '', '2025-05-22 14:02:31.000000', '2025-05-23 13:54:02.000000', NULL, NULL),
(66, 5, '2025-05-22 19:02:00', 'SO-20250522-020401', 0, 35, 4, 0, 0, 50, 'fixed', 0, 0, 11855, 0, 'unpaid', 'completed', '', '2025-05-22 14:04:01.000000', '2025-05-22 14:04:01.000000', NULL, NULL),
(67, 5, '2025-05-22 19:04:00', 'SO-20250522-020441', 0, 30, 4, 0, 0, 0, 'fixed', 0, 0, 4762, 4762, 'paid', '', '', '2025-05-22 14:04:41.000000', '2025-05-23 14:01:28.000000', NULL, NULL),
(68, 5, '2025-05-22 19:04:00', 'SO-20250522-020612', 0, 31, 4, 0, 0, 0, 'fixed', 0, 0, 6592, 0, 'unpaid', '', '', '2025-05-22 14:06:12.000000', '2025-05-22 14:59:09.000000', NULL, NULL),
(69, 5, '2025-05-22 19:30:00', 'SO-20250522-023319', 0, 33, 4, 0, 0, 0, 'fixed', 0, 0, 19434, 0, 'unpaid', 'completed', '', '2025-05-22 14:33:19.000000', '2025-05-22 14:33:19.000000', NULL, NULL),
(70, 5, '2025-05-22 19:33:00', 'SO-20250522-023506', 0, 26, 4, 0, 0, 0, 'fixed', 0, 0, 4126, 4126, 'paid', 'completed', '', '2025-05-22 14:35:06.000000', '2025-05-23 13:51:56.000000', NULL, NULL),
(71, 5, '2025-05-22 19:36:00', 'SO-20250522-023747', 0, 34, 4, 0, 0, 0, 'fixed', 0, 0, 9303, 0, 'unpaid', 'completed', '', '2025-05-22 14:37:47.000000', '2025-05-22 14:37:47.000000', NULL, NULL),
(72, 5, '2025-05-22 20:18:00', 'SO-20250522-031937', 0, 38, 4, 0, 0, 0, 'fixed', 0, 0, 8000, 8000, 'paid', 'completed', '', '2025-05-22 15:19:37.000000', '2025-05-23 13:51:18.000000', NULL, NULL),
(73, 5, '2025-05-22 21:54:00', 'SO-20250522-045743', 0, 22, 4, 0, 0, 0, 'fixed', 0, 0, 12086, 12086, 'paid', 'completed', '', '2025-05-22 16:57:43.000000', '2025-05-23 13:50:49.000000', NULL, NULL),
(74, 5, '2025-05-22 23:56:00', 'SO-20250522-065859', 0, 25, 4, 0, 0, 0, 'fixed', 0, 0, 5342, 5342, 'paid', 'completed', '', '2025-05-22 18:58:59.000000', '2025-05-23 13:49:24.000000', NULL, NULL),
(75, 5, '2025-05-23 19:02:00', 'SO-20250523-020310', 0, 19, 4, 0, 0, 0, 'fixed', 0, 0, 57620, 0, 'unpaid', 'completed', 'Rs. 25,000 pay karen gay delivery k waqt.', '2025-05-23 14:03:10.000000', '2025-05-23 14:03:10.000000', NULL, NULL),
(76, 5, '2025-05-23 19:05:00', 'SO-20250523-020628', 0, 17, 4, 0, 0, 0, 'fixed', 0, 0, 2088, 0, 'unpaid', 'completed', '', '2025-05-23 14:06:28.000000', '2025-05-23 14:06:28.000000', NULL, NULL),
(77, 5, '2025-05-23 19:35:00', 'SO-20250523-023634', 0, 21, 4, 0, 0, 0, 'fixed', 0, 0, 7800, 0, 'unpaid', 'completed', 'kindly cash this bill.', '2025-05-23 14:36:34.000000', '2025-05-23 14:36:34.000000', NULL, NULL),
(78, 5, '2025-05-23 19:45:00', 'SO-20250523-024642', 0, 40, 4, 0, 0, 0, 'fixed', 0, 0, 9900, 9900, 'paid', '', 'Out of Stock: 7,44,45,76,98,132,171,304,376,3405,419,458,498,486,666,750.', '2025-05-23 14:46:42.000000', '2025-05-27 09:15:36.000000', NULL, NULL),
(79, 5, '2025-05-23 19:55:00', 'SO-20250523-025710', 0, 41, 4, 0, 0, 0, 'fixed', 0, 0, 8562, 0, 'unpaid', 'completed', '', '2025-05-23 14:57:10.000000', '2025-05-23 14:57:10.000000', NULL, NULL),
(80, 5, '2025-05-23 22:21:00', 'SO-20250523-052254', 0, 39, 4, 0, 0, 0, 'fixed', 0, 0, 6160, 0, 'unpaid', 'completed', '', '2025-05-23 17:22:54.000000', '2025-05-27 09:14:52.000000', NULL, NULL),
(81, 5, '2025-05-25 19:31:00', 'SO-20250525-023203', 0, 31, 4, 0, 0, 50, 'fixed', 0, 0, 950, 0, 'unpaid', '', '', '2025-05-25 14:32:03.000000', '2025-05-25 15:24:40.000000', '2025-05-25 15:24:40', NULL),
(82, 5, '2025-05-26 18:53:00', 'SO-20250526-020714', 0, 42, 4, 0, 0, 0, 'fixed', 0, 0, 6500, 6500, 'paid', 'completed', '', '2025-05-26 14:07:14.000000', '2025-05-27 09:14:18.000000', NULL, NULL),
(83, 5, '2025-05-26 19:17:00', 'SO-20250526-021837', 0, 1, 4, 0, 0, 0, 'fixed', 0, 0, 466, 0, 'unpaid', 'completed', '', '2025-05-26 14:18:37.000000', '2025-05-26 14:48:13.000000', '2025-05-26 14:48:13', NULL),
(84, 1, '2025-05-26 19:59:00', 'SO-20250526-030113', 0, 1, 4, 0, 0, 0, 'fixed', 0, 0, 95, 0, 'unpaid', 'completed', '', '2025-05-26 15:01:13.000000', '2025-05-26 15:10:55.000000', '2025-05-26 15:10:55', NULL),
(85, 5, '2025-05-24 22:23:00', 'SO-20250526-052532', 0, 22, 4, 0, 0, 0, 'fixed', 0, 0, 7764, 0, 'unpaid', 'completed', '', '2025-05-26 17:25:32.000000', '2025-05-26 17:25:32.000000', NULL, NULL),
(86, 5, '2025-05-26 22:33:00', 'SO-20250526-053544', 0, 43, 4, 0, 0, 0, 'fixed', 0, 0, 25314.72, 0, 'unpaid', 'completed', 'Bill # 1669 and 1661', '2025-05-26 17:35:44.000000', '2025-05-26 17:35:44.000000', NULL, NULL),
(87, 5, '2025-05-24 22:40:00', 'SO-20250526-054209', 0, 23, 4, 0, 0, 0, 'fixed', 0, 0, 7656, 3896, 'partial', '', '', '2025-05-26 17:42:09.000000', '2025-05-26 17:43:27.000000', NULL, NULL),
(88, 5, '2025-05-27 14:12:00', 'SO-20250527-091307', 0, 44, 4, 0, 0, 0, 'fixed', 0, 0, 5400, 5400, 'paid', 'completed', '', '2025-05-27 09:13:07.000000', '2025-05-27 15:52:57.000000', NULL, NULL),
(89, 5, '2025-05-27 14:42:00', 'SO-20250527-094735', 0, 22, 4, 0, 0, 0, 'fixed', 0, 0, 13842, 10000, 'partial', 'completed', 'Out of stock: 134, 167, 327, 548, 685, 777', '2025-05-27 09:47:35.000000', '2025-05-27 15:52:34.000000', NULL, NULL),
(90, 5, '2025-05-27 15:47:00', 'SO-20250527-104917', 0, 46, 4, 0, 0, 0, 'fixed', 0, 250, 47250, 47250, 'paid', 'completed', '', '2025-05-27 10:49:17.000000', '2025-05-27 15:02:55.000000', NULL, NULL),
(91, 5, '2025-05-27 15:59:00', 'SO-20250527-110140', 0, 45, 4, 0, 0, 100, 'fixed', 0, 0, 13100, 13100, 'paid', 'completed', '', '2025-05-27 11:01:40.000000', '2025-05-27 11:14:56.000000', NULL, NULL),
(92, 5, '2025-05-27 16:57:00', 'SO-20250527-120056', 0, 47, 4, 0, 0, 0, 'fixed', 0, 0, 11125, 5000, 'partial', '', '', '2025-05-27 12:00:56.000000', '2025-05-27 17:03:35.000000', NULL, NULL),
(93, 5, '2025-05-27 17:16:00', 'SO-20250527-122319', 0, 51, 4, 0, 0, 0, 'fixed', 0, 0, 115564.16, 50000, 'partial', 'completed', '100 PCS F.S. IN 400 PCS - ARTICLE NOT OPEN IN SYSTEM', '2025-05-27 12:23:19.000000', '2025-05-27 12:26:44.000000', NULL, NULL),
(94, 5, '2025-05-27 17:53:00', 'SO-20250527-125358', 0, 51, 4, 0, 0, 0, 'fixed', 0, 0, 3650, 0, 'unpaid', 'completed', '', '2025-05-27 12:53:58.000000', '2025-05-27 12:53:58.000000', NULL, NULL),
(95, 5, '2025-05-27 18:28:00', 'SO-20250527-013027', 0, 1, 4, 0, 0, 30, 'fixed', 0, 0, 7830, 7830, 'paid', 'completed', '', '2025-05-27 13:30:27.000000', '2025-05-27 13:35:47.000000', NULL, NULL),
(96, 5, '2025-05-27 18:53:00', 'SO-20250527-015446', 1, 1, 4, 0, 0, 0, 'fixed', 0, 0, 120, 120, 'paid', 'completed', '', '2025-05-27 13:54:46.000000', '2025-05-27 13:54:46.000000', NULL, NULL),
(97, 5, '2025-05-27 19:14:00', 'SO-20250527-021941', 0, 50, 4, 0, 0, 0, 'fixed', 0, 0, 4526, 4526, 'paid', 'completed', 'OUT OF STOCK: 44,134,167.', '2025-05-27 14:19:41.000000', '2025-05-27 17:08:22.000000', NULL, NULL),
(98, 5, '2025-05-27 19:19:00', 'SO-20250527-022332', 0, 7, 4, 0, 0, 0, 'fixed', 0, 50, 9738, 0, 'unpaid', 'completed', 'OUT OF STOCK: 44,524,', '2025-05-27 14:23:32.000000', '2025-05-27 14:23:32.000000', NULL, NULL),
(99, 5, '2025-05-27 19:23:00', 'SO-20250527-022454', 0, 49, 4, 0, 0, 0, 'fixed', 0, 0, 2415, 2410, 'partial', 'completed', '', '2025-05-27 14:24:54.000000', '2025-05-27 17:01:37.000000', NULL, NULL),
(100, 5, '2025-05-27 19:25:00', 'SO-20250527-022615', 0, 48, 4, 0, 0, 0, 'fixed', 0, 0, 8743, 8470, 'partial', 'completed', 'OUT OF STOCK : 130,376.', '2025-05-27 14:26:15.000000', '2025-05-27 17:01:02.000000', NULL, NULL),
(101, 5, '2025-05-27 18:54:00', 'SO-20250527-023219', 1, 1, 4, 0, 0, 0, 'fixed', 0, 0, 240, 240, 'paid', 'completed', '', '2025-05-27 14:32:19.000000', '2025-05-27 14:32:19.000000', NULL, NULL),
(102, 5, '2025-05-27 19:56:00', 'SO-20250527-025751', 0, 38, 4, 0, 0, 0, 'fixed', 0, 250, 34192, 0, 'unpaid', 'completed', '', '2025-05-27 14:57:51.000000', '2025-05-27 14:57:51.000000', NULL, NULL),
(103, 5, '2025-05-27 19:58:00', 'SO-20250527-030201', 0, 38, 4, 0, 0, 0, 'fixed', 0, 0, 6150, 6150, 'paid', '', '', '2025-05-27 15:02:01.000000', '2025-05-29 16:54:54.000000', NULL, NULL),
(104, 5, '2025-05-27 20:04:00', 'SO-20250527-030549', 0, 52, 4, 0, 0, 0, 'fixed', 0, 0, 15508, 0, 'unpaid', 'completed', '', '2025-05-27 15:05:49.000000', '2025-05-27 15:05:49.000000', NULL, NULL),
(105, 5, '2025-05-27 20:06:00', 'SO-20250527-030626', 0, 53, 4, 0, 0, 0, 'fixed', 0, 0, 6440, 0, 'unpaid', 'completed', '', '2025-05-27 15:06:26.000000', '2025-05-27 15:06:26.000000', NULL, NULL),
(106, 5, '2025-05-27 20:06:00', 'SO-20250527-030722', 0, 54, 4, 0, 0, 0, 'fixed', 0, 0, 4691, 0, 'unpaid', 'completed', '', '2025-05-27 15:07:22.000000', '2025-05-27 15:07:22.000000', NULL, NULL),
(107, 5, '2025-05-27 20:32:00', 'SO-20250527-033250', 1, 1, 4, 0, 0, 0, 'fixed', 0, 0, 900, 900, 'paid', 'completed', '', '2025-05-27 15:32:50.000000', '2025-05-27 15:32:50.000000', NULL, NULL),
(108, 5, '2025-05-27 20:32:00', 'SO-20250527-034220', 1, 1, 4, 0, 0, 0, 'fixed', 0, 0, 180, 180, 'paid', 'completed', '', '2025-05-27 15:42:20.000000', '2025-05-27 15:42:20.000000', NULL, NULL),
(109, 5, '2025-05-27 21:07:00', 'SO-20250527-040839', 0, 55, 4, 0, 0, 0, 'fixed', 0, 0, 19533, 10000, 'partial', 'completed', '', '2025-05-27 16:08:39.000000', '2025-05-27 17:10:48.000000', NULL, NULL),
(110, 5, '2025-05-27 21:08:00', 'SO-20250527-040946', 0, 56, 4, 0, 0, 0, 'fixed', 0, 0, 4915, 0, 'unpaid', 'completed', '', '2025-05-27 16:09:46.000000', '2025-05-27 17:09:06.000000', NULL, NULL),
(111, 5, '2025-05-27 20:42:00', 'SO-20250527-042249', 1, 1, 4, 0, 0, 0, 'fixed', 0, 0, 100, 100, 'paid', 'completed', '', '2025-05-27 16:22:49.000000', '2025-05-27 16:22:49.000000', NULL, NULL),
(112, 5, '2025-05-27 21:46:00', 'SO-20250527-044802', 1, 1, 4, 0, 0, 0, 'fixed', 0, 0, 480, 480, 'paid', 'completed', '', '2025-05-27 16:48:02.000000', '2025-05-27 16:48:02.000000', NULL, NULL),
(113, 5, '2025-05-27 22:11:00', 'SO-20250527-051128', 0, 45, 4, 0, 0, 0, 'fixed', 0, 0, 2000, 2000, 'paid', 'completed', '', '2025-05-27 17:11:28.000000', '2025-05-27 17:11:42.000000', NULL, NULL),
(114, 5, '2025-05-27 22:15:00', 'SO-20250527-051616', 0, 43, 4, 0, 0, 0, 'fixed', 0, 0, 10350, 0, 'unpaid', 'completed', '', '2025-05-27 17:16:16.000000', '2025-05-27 17:16:16.000000', NULL, NULL),
(115, 5, '2025-05-27 22:24:00', 'SO-20250527-052605', 1, 1, 4, 0, 0, 5, 'fixed', 0, 0, 1200, 1200, 'paid', 'completed', '', '2025-05-27 17:26:05.000000', '2025-05-27 17:26:05.000000', NULL, NULL),
(116, 5, '2025-05-27 22:26:00', 'SO-20250527-053343', 1, 1, 4, 0, 0, 0, 'fixed', 0, 0, 480, 480, 'paid', 'completed', '', '2025-05-27 17:33:43.000000', '2025-05-27 17:33:43.000000', NULL, NULL),
(117, 5, '2025-05-27 22:35:00', 'SO-20250527-053621', 1, 1, 4, 0, 0, 0, 'fixed', 0, 0, 400, 400, 'paid', 'completed', '', '2025-05-27 17:36:21.000000', '2025-05-27 17:36:21.000000', NULL, NULL),
(118, 5, '2025-05-28 21:51:00', 'SO-20250528-045231', 0, 43, 4, 0, 0, 0, 'fixed', 0, 0, 10039.5, 0, 'unpaid', 'completed', '', '2025-05-28 16:52:31.000000', '2025-05-28 16:52:31.000000', NULL, NULL),
(119, 1, '2025-05-29 03:07:00', 'SO-20250528-100922', 0, 1, 4, 0, 0, 0, 'fixed', 0, 0, 360, 361, 'paid', '', '', '2025-05-28 22:09:22.000000', '2025-05-29 08:54:36.000000', '2025-05-29 08:54:36', 'saif'),
(120, 5, '2025-05-29 13:54:00', 'SO-20250529-085530', 0, 15, 4, 0, 0, 0, 'fixed', 0, 0, 4415, 0, 'unpaid', 'completed', '', '2025-05-29 08:55:30.000000', '2025-05-29 08:55:30.000000', NULL, 'saqib'),
(121, 5, '2025-05-29 13:55:00', 'SO-20250529-085623', 0, 27, 4, 0, 0, 0, 'fixed', 0, 0, 6562, 0, 'unpaid', 'completed', '', '2025-05-29 08:56:23.000000', '2025-05-29 08:56:23.000000', NULL, 'saqib'),
(122, 5, '2025-05-29 13:56:00', 'SO-20250529-085757', 0, 14, 4, 0, 0, 0, 'fixed', 0, 0, 6070, 0, 'unpaid', 'completed', '', '2025-05-29 08:57:57.000000', '2025-05-29 08:57:57.000000', NULL, ''),
(123, 5, '2025-05-29 13:58:00', 'SO-20250529-090003', 0, 13, 4, 0, 0, 0, 'fixed', 0, 0, 8980, 0, 'unpaid', '', '', '2025-05-29 09:00:03.000000', '2025-05-29 16:52:02.000000', NULL, NULL),
(124, 5, '2025-05-29 14:00:00', 'SO-20250529-090056', 0, 20, 4, 0, 0, 0, 'fixed', 0, 0, 6314, 0, 'unpaid', 'completed', '', '2025-05-29 09:00:56.000000', '2025-05-29 09:00:56.000000', NULL, 'saqib'),
(125, 5, '2025-05-29 14:01:00', 'SO-20250529-090150', 0, 28, 4, 0, 0, 0, 'fixed', 0, 0, 10198, 0, 'unpaid', 'completed', '', '2025-05-29 09:01:50.000000', '2025-05-29 09:01:50.000000', NULL, 'saqib'),
(126, 5, '2025-05-29 17:08:00', 'SO-20250529-120927', 0, 16, 4, 0, 0, 0, 'fixed', 0, 0, 18541, 0, 'unpaid', '', '', '2025-05-29 12:09:27.000000', '2025-05-29 12:36:56.000000', NULL, NULL),
(127, 5, '2025-05-29 17:10:00', 'SO-20250529-121047', 0, 21, 4, 0, 0, 0, 'fixed', 0, 0, 1505, 0, 'unpaid', 'completed', '', '2025-05-29 12:10:47.000000', '2025-05-29 12:10:47.000000', NULL, 'saqib'),
(128, 5, '2025-05-29 17:38:00', 'SO-20250529-123858', 0, 60, 4, 0, 0, 0, 'fixed', 0, 0, 11626, 0, 'unpaid', 'completed', '', '2025-05-29 12:38:58.000000', '2025-05-29 12:38:58.000000', NULL, 'saqib'),
(129, 5, '2025-05-29 17:45:00', 'SO-20250529-124632', 0, 61, 4, 0, 0, 0, 'fixed', 0, 0, 14950, 0, 'unpaid', 'completed', 'OUT OF STOCK : 79, 134, 174, 460', '2025-05-29 12:46:32.000000', '2025-05-29 12:46:32.000000', NULL, 'saif'),
(130, 5, '2025-05-29 20:14:00', 'SO-20250529-031640', 0, 37, 4, 0, 0, 0, 'fixed', 0, 0, 6170, 0, 'unpaid', 'completed', 'OUT OF STOCK: 174,210, 327', '2025-05-29 15:16:40.000000', '2025-05-29 15:16:40.000000', NULL, 'aqib'),
(131, 5, '2025-05-29 20:16:00', 'SO-20250529-031807', 0, 56, 4, 0, 0, 0, 'fixed', 0, 0, 29813, 20000, 'partial', 'completed', '', '2025-05-29 15:18:07.000000', '2025-05-29 16:50:33.000000', NULL, 'aqib'),
(132, 5, '2025-05-29 20:20:00', 'SO-20250529-032117', 0, 55, 4, 0, 0, 0, 'fixed', 0, 0, 3120, 0, 'unpaid', 'completed', '', '2025-05-29 15:21:17.000000', '2025-05-29 15:21:17.000000', NULL, 'aqib'),
(133, 5, '2025-05-29 20:38:00', 'SO-20250529-034159', 0, 30, 4, 0, 0, 208, 'fixed', 0, 0, 9787, 0, 'unpaid', 'completed', 'OUT OF STOCK: 305, 782, 800.', '2025-05-29 15:41:59.000000', '2025-05-29 15:41:59.000000', NULL, 'aqib'),
(134, 5, '2025-05-29 20:42:00', 'SO-20250529-034311', 0, 40, 4, 0, 0, 0, 'fixed', 0, 0, 13200, 0, 'unpaid', '', 'OUT OF STOCK: 44, 174, 305, 398, 413, 415, 419, 498, 777, 837, 872', '2025-05-29 15:43:11.000000', '2025-05-29 15:44:04.000000', NULL, NULL),
(135, 5, '2025-05-29 20:53:00', 'SO-20250529-035654', 0, 25, 4, 0, 0, 0, 'fixed', 0, 0, 3852, 0, 'unpaid', 'completed', 'OUT OF STOCK :306, 419, 498, 517, 548, 780', '2025-05-29 15:56:54.000000', '2025-05-29 15:56:54.000000', NULL, 'HASSAN'),
(136, 5, '2025-05-29 21:16:00', 'SO-20250529-041752', 0, 62, 4, 0, 0, 0, 'fixed', 0, 0, 7843, 7840, 'partial', 'completed', '', '2025-05-29 16:17:52.000000', '2025-05-29 16:48:54.000000', NULL, 'HASSAN'),
(137, 5, '2025-05-29 21:20:00', 'SO-20250529-042201', 0, 26, 4, 0, 0, 0, 'fixed', 0, 0, 4190, 0, 'unpaid', 'completed', 'OUT OF STOCK: 167, 248, 498', '2025-05-29 16:22:01.000000', '2025-05-29 16:22:01.000000', NULL, 'aqib'),
(138, 5, '2025-05-29 21:24:00', 'SO-20250529-042604', 0, 63, 4, 0, 0, 0, 'fixed', 0, 0, 4738, 0, 'unpaid', 'completed', 'OUT OF STOCK: 210, 305, 306, 392, 415, 445, 448, 780, 799, 839', '2025-05-29 16:26:04.000000', '2025-05-29 16:26:04.000000', NULL, 'aqib'),
(139, 5, '2025-05-29 21:31:00', 'SO-20250529-043240', 0, 29, 4, 0, 0, 0, 'fixed', 0, 0, 3916, 0, 'unpaid', 'completed', '', '2025-05-29 16:32:40.000000', '2025-05-29 16:32:40.000000', NULL, 'HASSAN'),
(140, 5, '2025-05-29 21:32:00', 'SO-20250529-043351', 0, 64, 4, 0, 0, 0, 'fixed', 0, 0, 6776, 0, 'unpaid', 'completed', '', '2025-05-29 16:33:51.000000', '2025-05-29 16:33:51.000000', NULL, 'HASSAN'),
(141, 5, '2025-05-29 22:16:00', 'SO-20250529-051806', 0, 23, 4, 0, 0, 0, 'fixed', 0, 0, 4040, 0, 'unpaid', '', '', '2025-05-29 17:18:06.000000', '2025-05-29 17:19:27.000000', NULL, NULL),
(142, 1, '2025-05-30 00:36:00', 'SO-20250529-073626', 0, 1, 4, 0, 0, 0, 'fixed', 0, 0, 360, 120, 'partial', 'completed', '', '2025-05-29 19:36:26.000000', '2025-05-29 19:40:58.000000', '2025-05-29 19:40:58', 'Usama Shaikh'),
(143, 5, '2025-05-30 16:55:00', 'SO-20250530-115618', 0, 71, 4, 0, 0, 0, 'fixed', 0, 0, 3150, 0, 'unpaid', 'completed', '', '2025-05-30 11:56:18.000000', '2025-05-30 11:56:18.000000', NULL, 'saif'),
(144, 5, '2025-05-30 16:56:00', 'SO-20250530-115909', 0, 70, 4, 0, 0, 6.5, 'percent', 1093.1375, 0, 15724.36, 0, 'unpaid', 'completed', '', '2025-05-30 11:59:09.000000', '2025-05-30 11:59:09.000000', NULL, 'saif'),
(145, 5, '2025-05-30 19:16:00', 'SO-20250530-022316', 0, 35, 4, 0, 0, 0, 'fixed', 0, 0, 11408, 0, 'unpaid', 'completed', 'OUT OF STOCK : 167, 375, 575, 588, 780, 799', '2025-05-30 14:23:16.000000', '2025-05-30 14:23:16.000000', NULL, 'aqib'),
(146, 5, '2025-05-30 19:57:00', 'SO-20250530-030033', 0, 34, 4, 0, 0, 0, 'fixed', 0, 0, 6871, 0, 'unpaid', 'completed', '', '2025-05-30 15:00:33.000000', '2025-05-30 15:00:33.000000', NULL, 'aqib'),
(147, 5, '2025-05-30 20:00:00', 'SO-20250530-030717', 0, 33, 4, 0, 0, 0, 'fixed', 0, 0, 7413, 0, 'unpaid', 'completed', '', '2025-05-30 15:07:17.000000', '2025-05-30 15:07:17.000000', NULL, 'aqib'),
(148, 5, '2025-05-30 20:07:00', 'SO-20250530-030929', 0, 41, 4, 0, 0, 0, 'fixed', 0, 0, 12771, 0, 'unpaid', '', 'OUT OF STOCK : 74, 167, 187, 205, 305, 398, 445, 502 , 505, 524, 800.', '2025-05-30 15:09:29.000000', '2025-05-30 17:52:37.000000', NULL, NULL),
(149, 5, '2025-05-30 20:09:00', 'SO-20250530-031153', 0, 31, 4, 0, 0, 0, 'fixed', 0, 0, 6401, 0, 'unpaid', 'completed', 'OUT OF STOCK: 205, 314,', '2025-05-30 15:11:53.000000', '2025-05-30 15:11:53.000000', NULL, 'aqib'),
(150, 5, '2025-05-30 20:13:00', 'SO-20250530-031843', 0, 51, 4, 0, 0, 0, 'fixed', 0, 0, 31991.5, 0, 'unpaid', 'completed', '', '2025-05-30 15:18:43.000000', '2025-05-30 15:18:43.000000', NULL, 'aqib'),
(151, 5, '2025-05-30 20:30:00', 'SO-20250530-033116', 0, 36, 4, 0, 0, 0, 'fixed', 0, 0, 4148, 0, 'unpaid', '', '', '2025-05-30 15:31:16.000000', '2025-05-30 15:32:34.000000', NULL, 'aqib'),
(152, 5, '2025-05-30 20:34:00', 'SO-20250530-033505', 0, 40, 4, 0, 0, 0, 'fixed', 0, 0, 5350, 0, 'unpaid', 'completed', '', '2025-05-30 15:35:05.000000', '2025-05-30 15:35:05.000000', NULL, 'aqib'),
(153, 5, '2025-05-30 21:16:00', 'SO-20250530-041728', 0, 43, 4, 0, 0, 0, 'fixed', 0, 0, 5692.5, 1, 'partial', 'completed', '', '2025-05-30 16:17:28.000000', '2025-05-30 19:51:37.000000', NULL, 'HASSAN'),
(154, 5, '2025-05-31 15:47:00', 'SO-20250531-104946', 0, 10, 4, 0, 0, 0, 'fixed', 0, 0, 9371, 9370, 'partial', 'completed', 'OUT OF STOCK : 314,683,685', '2025-05-31 10:49:46.000000', '2025-05-31 12:18:43.000000', NULL, 'HASSAN'),
(155, 5, '2025-05-31 17:25:00', 'SO-20250531-123413', 0, 55, 4, 0, 0, 0, 'fixed', 0, 0, 8580, 0, 'unpaid', 'completed', '', '2025-05-31 12:34:13.000000', '2025-05-31 12:34:13.000000', NULL, 'HASSAN'),
(156, 5, '2025-05-31 17:34:00', 'SO-20250531-123457', 0, 56, 4, 0, 0, 0, 'fixed', 0, 0, 3120, 0, 'unpaid', 'completed', '', '2025-05-31 12:34:57.000000', '2025-05-31 12:34:57.000000', NULL, 'HASSAN'),
(157, 5, '2025-05-31 17:38:00', 'SO-20250531-123840', 0, 72, 4, 0, 0, 0, 'fixed', 0, 0, 7800, 0, 'unpaid', 'completed', '', '2025-05-31 12:38:40.000000', '2025-05-31 12:38:40.000000', NULL, 'HASSAN'),
(158, 5, '2025-05-31 18:42:00', 'SO-20250531-014559', 0, 42, 4, 0, 0, 0, 'fixed', 0, 0, 235, 0, 'unpaid', '', 'OUT OF STOCK: 24, 44, 52, 84, 134, 167, 174, 205, 222, 223, 279, 305, 306, 307, 314, 327, 329, 376, 380, 390, 398, 405, 413, 415, 419, 427, 445, 458, 498, 500, 501, 505, 531, 548, 588, 782, 785, 786, 799, 800, 824, 834, 836, 839.', '2025-05-31 13:45:59.000000', '2025-06-03 04:13:50.000000', NULL, 'HASSAN'),
(159, 5, '2025-05-31 20:20:00', 'SO-20250531-032157', 0, 73, 4, 0, 0, 0, 'fixed', 0, 0, 464, 0, 'unpaid', '', '', '2025-05-31 15:21:57.000000', '2025-06-03 04:13:25.000000', NULL, 'HASSAN'),
(160, 5, '2025-05-31 20:39:00', 'SO-20250531-034131', 0, 74, 4, 0, 0, 0, 'fixed', 0, 0, 168, 3000, 'paid', '', '', '2025-05-31 15:41:31.000000', '2025-06-03 04:13:00.000000', NULL, NULL),
(161, 12, '2025-06-12 21:41:00', 'SO-20250612-044243', 1, 1, 4, 0, 0, 10, 'fixed', 0, 0, 220, 200, 'partial', 'completed', '', '2025-06-12 16:42:43.000000', '2025-06-12 16:43:59.000000', '2025-06-12 16:43:59', NULL),
(162, 1, '2025-06-14 18:30:00', 'SO-20250614-013145', 0, 57, 4, 0, 0, 0, 'fixed', 0, 0, 12200, 1220000, 'paid', 'completed', '', '2025-06-14 13:31:45.000000', '2025-06-14 13:45:33.000000', NULL, 'Usama Shaikh'),
(163, 1, '2025-06-15 17:36:00', 'SO-20250615-123714', 1, 1, 4, 0, 0, 0, 'fixed', 0, 0, 36463, 115, 'partial', '', '2e2', '2025-06-15 12:37:14.000000', '2025-06-16 21:09:56.000000', NULL, NULL),
(164, 1, '2025-06-18 00:35:00', 'SO-20250617-164', 0, 57, 4, 0, 0, 0, 'fixed', 0, 0, 6600, 0, 'unpaid', 'completed', '', '2025-06-17 19:36:02.000000', '2025-06-17 19:36:02.000000', NULL, 'Usama Shaikh'),
(165, 1, '2025-06-22 19:56:00', 'SO-20250622-165', 1, 1, 4, 0, 0, 0, 'fixed', 0, 0, 115, 115, 'paid', 'completed', '', '2025-06-22 14:56:56.000000', '2025-06-22 14:56:56.000000', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sale_details`
--

CREATE TABLE `sale_details` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `price` double NOT NULL,
  `sale_unit_id` int(11) DEFAULT NULL,
  `TaxNet` double DEFAULT NULL,
  `tax_method` varchar(192) DEFAULT '1',
  `discount` double DEFAULT NULL,
  `discount_method` varchar(192) DEFAULT '1',
  `total` double NOT NULL,
  `quantity` double NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_details`
--

INSERT INTO `sale_details` (`id`, `date`, `sale_id`, `product_id`, `product_variant_id`, `imei_number`, `price`, `sale_unit_id`, `TaxNet`, `tax_method`, `discount`, `discount_method`, `total`, `quantity`, `created_at`, `updated_at`) VALUES
(1, '2025-04-26 16:16:00', 1, 3, NULL, '', 30, 1, 1, '1', 0, '2', 30.3, 1, NULL, NULL),
(2, '2025-04-26 16:38:00', 2, 3, NULL, '', 30, 1, 1, '1', 0, '2', 30.3, 1, NULL, NULL),
(3, '2025-04-26 16:39:00', 3, 2, NULL, '', 20000, NULL, 12, '1', 0, '2', 44800, 2, NULL, NULL),
(4, '2025-04-26 16:39:00', 3, 3, NULL, '', 30, 1, 1, '1', 0, '2', 90.9, 3, NULL, NULL),
(5, '2025-04-26 20:51:00', 4, 3, NULL, '', 30, 1, 1, '1', 0, '2', 454.5, 15, NULL, NULL),
(6, '2025-04-26 20:59:00', 5, 4, 1, '', 20, 4, 0, '1', 0, '2', 300, 15, NULL, NULL),
(7, '2025-04-26 21:01:00', 6, 4, 1, '', 20, 4, 0, '1', 0, '2', 100, 5, NULL, NULL),
(8, '2025-04-26 21:01:00', 6, 4, 3, '', 25, 4, 0, '1', 0, '2', 250, 10, NULL, NULL),
(9, '2025-04-26 21:08:00', 7, 4, 1, '', 20, 4, 0, '1', 0, '2', 200, 10, NULL, NULL),
(10, '2025-04-26 22:34:00', 8, 5, 4, '', 250, 5, 0, '1', 0, '2', 3750, 15, NULL, NULL),
(11, '2025-04-26 22:46:00', 9, 5, 4, '', 280, 5, 0, '1', 0, '2', 2800, 10, NULL, NULL),
(12, '2025-04-26 22:47:00', 10, 5, 4, '', 250, 5, 0, '1', 0, '2', 1250, 5, NULL, NULL),
(13, '2025-04-26 22:47:00', 10, 5, 5, '', 250, 5, 0, '1', 0, '2', 2500, 10, NULL, NULL),
(14, '2025-04-26 22:47:00', 10, 5, 7, '', 300, 5, 0, '1', 0, '2', 1800, 6, NULL, NULL),
(15, '2025-04-26 23:04:00', 11, 6, NULL, '', 400, 4, 0, '1', 0, '2', 400, 1, NULL, NULL),
(16, '2025-03-29 00:19:00', 12, 3, NULL, '', 30, 1, 1, '1', 0, '2', 30.3, 1, NULL, NULL),
(17, '2025-04-28 23:58:00', 13, 3, NULL, '', 30, 1, 1, '1', 0, '2', 757.5, 10, NULL, '2025-04-28 13:59:29.000000'),
(18, '2025-04-29 00:05:00', 14, 3, NULL, '', 30, 1, 1, '1', 0, '2', 454.5, 15, NULL, NULL),
(19, '2025-04-29 00:15:00', 15, 3, NULL, '', 30, 1, 1, '1', 0, '2', 454.5, 5, NULL, '2025-04-28 14:21:36.000000'),
(20, '2025-04-29 00:28:00', 16, 3, NULL, '', 30, 1, 1, '1', 0, '2', 303, 5, NULL, '2025-04-28 14:43:51.000000'),
(24, '2025-05-05 16:33:00', 20, 1, NULL, '', 2000, 1, 150, '1', 0, '2', 50000, 10, NULL, NULL),
(25, '2025-05-05 16:40:00', 21, 1, NULL, '', 2000, 1, 150, '1', 0, '2', 50000, 10, NULL, NULL),
(26, '2025-05-05 16:41:00', 22, 1, NULL, '', 2000, 1, 150, '1', 0, '2', 5000, 1, NULL, NULL),
(27, '2025-05-05 16:41:00', 23, 1, NULL, '', 2000, 1, 150, '1', 0, '2', 5000, 1, NULL, NULL),
(28, '2025-05-05 16:42:00', 24, 3, NULL, '', 30, 1, 1, '1', 0, '2', 30.3, 1, NULL, NULL),
(29, '2025-05-05 16:48:00', 25, 2, NULL, '', 20000, NULL, 12, '1', 0, '2', 22400, 1, NULL, NULL),
(32, '2025-05-05 17:01:00', 28, 2, NULL, '', 20000, NULL, 12, '1', 0, '2', 22400, 1, NULL, NULL),
(33, '2025-05-05 17:03:00', 29, 2, NULL, '', 20000, NULL, 12, '1', 0, '2', 22400, 0, NULL, '2025-05-05 08:36:20.000000'),
(34, '2025-05-05 19:11:00', 30, 1, NULL, '', 2000, 1, 150, '1', 0, '2', 5000, 1, NULL, NULL),
(35, '2025-05-10 16:07:00', 31, 3, NULL, '', 30, 1, 1, '1', 0, '2', 606, 10, NULL, '2025-05-10 06:08:58.000000'),
(36, '2025-05-10 16:18:00', 32, 3, NULL, '', 30, 1, 1, '1', 0, '2', 3030, 85, NULL, '2025-05-10 06:19:13.000000'),
(37, '2025-05-10 16:29:00', 33, 10, NULL, '', 1800, 4, 0, 'null', 0, '2', 27000, 10, NULL, '2025-05-10 06:32:41.000000'),
(38, '2025-05-10 16:29:00', 33, 9, 9, '', 280, 5, 0, '1', 0, '2', 2800, 5, NULL, '2025-05-10 06:32:41.000000'),
(39, '2025-05-10 16:29:00', 33, 9, 8, '', 280, 5, 0, '1', 0, '2', 2800, 5, NULL, '2025-05-10 06:32:41.000000'),
(40, '2025-05-10 17:02:00', 34, 10, NULL, '', 1800, 4, 0, 'null', 0, '2', 18000, 10, NULL, NULL),
(41, '2025-05-10 17:23:00', 35, 1, NULL, '', 2000, 1, 150, '1', 0, '2', 5000, 1, NULL, NULL),
(42, '2025-05-10 17:23:00', 35, 2, NULL, '', 20000, NULL, 12, '1', 0, '2', 22400, 1, NULL, NULL),
(43, '2025-05-10 17:26:00', 36, 3, NULL, '', 30, 1, 1, '1', 0, '2', 303, 10, NULL, NULL),
(44, '2025-05-13 14:39:00', 37, 3, NULL, '', 30, 1, 1, '1', 0, '2', 30.3, 1, NULL, NULL),
(45, '2025-05-13 14:39:00', 37, 4, 2, '', 22, 4, 0, '1', 0, '2', 22, 1, NULL, NULL),
(46, '2025-05-13 14:43:00', 38, 3, NULL, '', 30, 1, 1, '1', 0, '2', 30.3, 1, NULL, NULL),
(47, '2025-05-13 14:43:00', 38, 4, 3, '', 25, 4, 0, '1', 0, '2', 25, 1, NULL, NULL),
(48, '2025-05-13 14:43:00', 38, 4, 2, '', 22, 4, 0, '1', 0, '2', 22, 1, NULL, NULL),
(49, '2025-05-13 14:44:00', 39, 3, NULL, '', 30, 1, 1, '1', 0, '2', 30.3, 1, NULL, NULL),
(50, '2025-05-13 23:31:00', 40, 2, NULL, '', 20000, NULL, 12, '1', 0, '2', 22400, 1, NULL, NULL),
(51, '2025-05-13 23:31:00', 40, 3, NULL, '', 30, 1, 1, '1', 0, '2', 30.3, 1, NULL, NULL),
(52, '2025-05-13 23:31:00', 41, 1, NULL, '', 2000, 1, 150, '1', 0, '2', 5000, 1, NULL, NULL),
(53, '2025-05-13 23:33:00', 42, 3, NULL, '', 30, 1, 1, '1', 0, '2', 121.2, 4, NULL, NULL),
(54, '2025-05-18 15:23:00', 43, 3, NULL, '', 30, 1, 1, '1', 0, '2', 151.5, 5, NULL, NULL),
(61, '2025-05-21 19:42:00', 50, 12, NULL, '', 121, 4, 0, '1', 0, '2', 6655, 55, NULL, NULL),
(62, '2025-05-21 19:42:00', 50, 13, NULL, '', 115, 4, 0, '1', 0, '2', 805, 7, NULL, NULL),
(63, '2025-05-21 19:42:00', 50, 14, NULL, '', 118, 4, 0, '1', 0, '2', 236, 2, NULL, NULL),
(64, '2025-05-21 19:42:00', 50, 15, NULL, '', 300, 9, 0, '1', 0, '2', 1500, 5, NULL, NULL),
(65, '2025-05-21 19:45:00', 51, 12, NULL, '', 117, 4, 0, '1', 0, '2', 8658, 74, NULL, NULL),
(66, '2025-05-21 19:45:00', 51, 13, NULL, '', 113, 4, 0, '1', 0, '2', 1469, 13, NULL, NULL),
(67, '2025-05-21 19:45:00', 51, 14, NULL, '', 115, 4, 0, '1', 0, '2', 920, 8, NULL, NULL),
(68, '2025-05-21 19:45:00', 51, 17, NULL, '', 2000, 10, 0, '1', 0, '2', 4000, 2, NULL, NULL),
(69, '2025-05-21 19:47:00', 52, 13, NULL, '', 110, 4, 0, '1', 0, '2', 4840, 44, NULL, NULL),
(70, '2025-05-21 19:47:00', 52, 14, NULL, '', 115, 4, 0, '1', 0, '2', 345, 3, NULL, NULL),
(71, '2025-05-21 19:47:00', 52, 12, NULL, '', 116, 4, 0, '1', 0, '2', 696, 6, NULL, NULL),
(72, '2025-05-21 19:50:00', 53, 12, NULL, '', 120, 4, 0, '1', 0, '2', 1200, 10, NULL, NULL),
(73, '2025-05-21 20:04:00', 54, 13, NULL, '', 115, 4, 0, '1', 0, '2', 1380, 12, NULL, NULL),
(74, '2025-05-21 20:57:00', 55, 14, NULL, '', 118.5, 4, 0, '1', 0, '2', 12087, 102, NULL, NULL),
(75, '2025-05-22 17:01:00', 56, 19, NULL, '', 110, 4, 0, '1', 0, '2', 1320, 12, NULL, '2025-05-22 12:02:41.000000'),
(76, '2025-05-22 17:01:00', 56, 14, NULL, '', 118, 4, 0, '1', 0, '2', 354, 3, NULL, '2025-05-22 12:02:41.000000'),
(77, '2025-05-22 17:01:00', 56, 13, NULL, '', 115, 4, 0, '1', 0, '2', 7820, 68, NULL, '2025-05-22 12:02:41.000000'),
(78, '2025-05-22 17:01:00', 56, 12, NULL, '', 120, 4, 0, '1', 0, '2', 840, 7, NULL, '2025-05-22 12:02:41.000000'),
(79, '2025-05-22 17:02:00', 57, 19, NULL, '', 110, 4, 0, '1', 0, '2', 1430, 13, NULL, NULL),
(80, '2025-05-22 17:02:00', 57, 13, NULL, '', 115, 4, 0, '1', 0, '2', 9890, 86, NULL, NULL),
(81, '2025-05-22 17:02:00', 57, 14, NULL, '', 118, 4, 0, '1', 0, '2', 1416, 12, NULL, NULL),
(82, '2025-05-22 17:02:00', 57, 12, NULL, '', 120, 4, 0, '1', 0, '2', 1440, 12, NULL, NULL),
(83, '2025-05-22 17:08:00', 58, 13, NULL, '', 115, 4, 0, '1', 0, '2', 6900, 60, NULL, NULL),
(84, '2025-05-22 17:08:00', 58, 14, NULL, '', 118, 4, 0, '1', 0, '2', 354, 3, NULL, NULL),
(85, '2025-05-22 17:08:00', 58, 12, NULL, '', 120, 4, 0, '1', 0, '2', 840, 7, NULL, NULL),
(86, '2025-05-22 17:12:00', 59, 13, NULL, '', 115, 4, 0, '1', 0, '2', 9660, 84, NULL, NULL),
(87, '2025-05-22 17:12:00', 59, 14, NULL, '', 118, 4, 0, '1', 0, '2', 708, 6, NULL, NULL),
(88, '2025-05-22 17:12:00', 59, 12, NULL, '', 120, 4, 0, '1', 0, '2', 840, 7, NULL, NULL),
(89, '2025-05-22 17:13:00', 60, 13, NULL, '', 115, 4, 0, '1', 0, '2', 14145, 123, NULL, NULL),
(90, '2025-05-22 17:13:00', 60, 19, NULL, '', 110, 4, 0, '1', 0, '2', 880, 8, NULL, NULL),
(91, '2025-05-22 17:13:00', 60, 12, NULL, '', 120, 4, 0, '1', 0, '2', 2280, 19, NULL, NULL),
(92, '2025-05-22 17:27:00', 61, 13, NULL, '', 115, 4, 0, '1', 0, '2', 17135, 149, NULL, NULL),
(93, '2025-05-22 17:27:00', 61, 14, NULL, '', 118, 4, 0, '1', 0, '2', 1770, 15, NULL, NULL),
(94, '2025-05-22 17:27:00', 61, 12, NULL, '', 120, 4, 0, '1', 0, '2', 1800, 15, NULL, NULL),
(95, '2025-05-22 17:34:00', 62, 13, NULL, '', 115, 4, 0, '1', 0, '2', 3910, 34, NULL, NULL),
(96, '2025-05-22 17:34:00', 62, 14, NULL, '', 118, 4, 0, '1', 0, '2', 236, 2, NULL, NULL),
(97, '2025-05-22 17:34:00', 62, 12, NULL, '', 120, 4, 0, '1', 0, '2', 1200, 10, NULL, NULL),
(98, '2025-05-22 17:35:00', 63, 13, NULL, '', 115, 4, 0, '1', 0, '2', 18515, 161, NULL, NULL),
(99, '2025-05-22 17:35:00', 63, 19, NULL, '', 110, 4, 0, '1', 0, '2', 440, 4, NULL, NULL),
(100, '2025-05-22 17:35:00', 63, 14, NULL, '', 118, 4, 0, '1', 0, '2', 2124, 18, NULL, NULL),
(101, '2025-05-22 17:35:00', 63, 12, NULL, '', 120, 4, 0, '1', 0, '2', 1440, 12, NULL, NULL),
(102, '2025-05-22 18:58:00', 64, 13, NULL, '', 115, 4, 0, '1', 0, '2', 2300, 20, NULL, NULL),
(103, '2025-05-22 18:58:00', 64, 19, NULL, '', 110, 4, 0, '1', 0, '2', 330, 3, NULL, NULL),
(104, '2025-05-22 18:58:00', 64, 12, NULL, '', 120, 4, 0, '1', 0, '2', 120, 1, NULL, NULL),
(105, '2025-05-22 19:01:00', 65, 13, NULL, '', 110, 4, 0, '1', 0, '2', 2860, 26, NULL, '2025-05-23 13:53:31.000000'),
(106, '2025-05-22 19:01:00', 65, 12, NULL, '', 116, 4, 0, '1', 0, '2', 696, 6, NULL, '2025-05-23 13:53:31.000000'),
(107, '2025-05-22 19:02:00', 66, 13, NULL, '', 115, 4, 0, '1', 0, '2', 8625, 75, NULL, NULL),
(108, '2025-05-22 19:02:00', 66, 14, NULL, '', 118, 4, 0, '1', 0, '2', 1180, 10, NULL, NULL),
(109, '2025-05-22 19:02:00', 66, 12, NULL, '', 120, 4, 0, '1', 0, '2', 600, 5, NULL, NULL),
(110, '2025-05-22 19:02:00', 66, 15, NULL, '', 300, 9, 0, '1', 0, '2', 1500, 5, NULL, NULL),
(111, '2025-05-22 19:04:00', 67, 13, NULL, '', 110, 4, 0, '1', 0, '2', 4070, 37, NULL, '2025-05-23 13:52:55.000000'),
(112, '2025-05-22 19:04:00', 67, 12, NULL, '', 116, 4, 0, '1', 0, '2', 232, 2, NULL, '2025-05-23 13:52:55.000000'),
(113, '2025-05-22 19:04:00', 67, 14, NULL, '', 115, 4, 0, '1', 0, '2', 460, 4, NULL, '2025-05-23 13:52:55.000000'),
(114, '2025-05-22 19:04:00', 68, 19, NULL, '', 110, 4, 0, '1', 0, '2', 220, 2, NULL, '2025-05-22 14:59:09.000000'),
(115, '2025-05-22 19:04:00', 68, 13, NULL, '', 115, 4, 0, '1', 0, '2', 3680, 32, NULL, '2025-05-22 14:59:09.000000'),
(116, '2025-05-22 19:04:00', 68, 14, NULL, '', 118, 4, 0, '1', 0, '2', 472, 4, NULL, '2025-05-22 14:59:09.000000'),
(117, '2025-05-22 19:04:00', 68, 12, NULL, '', 120, 4, 0, '1', 0, '2', 120, 1, NULL, '2025-05-22 14:59:09.000000'),
(118, '2025-05-22 19:04:00', 68, 15, NULL, '', 300, 9, 0, '1', 0, '2', 900, 3, NULL, '2025-05-22 14:59:09.000000'),
(119, '2025-05-22 19:04:00', 68, 16, NULL, '', 400, 9, 0, '1', 0, '2', 1200, 3, NULL, '2025-05-22 14:59:09.000000'),
(120, '2025-05-22 19:30:00', 69, 13, NULL, '', 115, 4, 0, '1', 0, '2', 14490, 126, NULL, NULL),
(121, '2025-05-22 19:30:00', 69, 12, NULL, '', 120, 4, 0, '1', 0, '2', 1560, 13, NULL, NULL),
(122, '2025-05-22 19:30:00', 69, 14, NULL, '', 118, 4, 0, '1', 0, '2', 2124, 18, NULL, NULL),
(123, '2025-05-22 19:30:00', 69, 19, NULL, '', 110, 4, 0, '1', 0, '2', 220, 2, NULL, NULL),
(124, '2025-05-22 19:30:00', 69, 22, NULL, '', 200, 11, 0, '1', 0, '2', 400, 2, NULL, NULL),
(125, '2025-05-22 19:30:00', 69, 20, NULL, '', 320, 11, 0, '1', 0, '2', 640, 2, NULL, NULL),
(126, '2025-05-22 19:33:00', 70, 13, NULL, '', 110, 4, 0, '1', 0, '2', 2970, 27, NULL, NULL),
(127, '2025-05-22 19:33:00', 70, 12, NULL, '', 116, 4, 0, '1', 0, '2', 696, 6, NULL, NULL),
(128, '2025-05-22 19:33:00', 70, 14, NULL, '', 115, 4, 0, '1', 0, '2', 460, 4, NULL, NULL),
(129, '2025-05-22 19:36:00', 71, 12, NULL, '', 121, 4, 0, '1', 0, '2', 6655, 55, NULL, NULL),
(130, '2025-05-22 19:36:00', 71, 14, NULL, '', 118, 4, 0, '1', 0, '2', 118, 1, NULL, NULL),
(131, '2025-05-22 19:36:00', 71, 13, NULL, '', 115, 4, 0, '1', 0, '2', 2530, 22, NULL, NULL),
(132, '2025-05-22 20:18:00', 72, 18, NULL, '', 2000, 10, 0, '1', 0, '2', 8000, 4, NULL, NULL),
(133, '2025-05-22 21:54:00', 73, 13, NULL, '', 110, 4, 0, '1', 0, '2', 9900, 90, NULL, NULL),
(134, '2025-05-22 21:54:00', 73, 19, NULL, '', 110, 4, 0, '1', 0, '2', 110, 1, NULL, NULL),
(135, '2025-05-22 21:54:00', 73, 14, NULL, '', 115, 4, 0, '1', 0, '2', 1380, 12, NULL, NULL),
(136, '2025-05-22 21:54:00', 73, 12, NULL, '', 116, 4, 0, '1', 0, '2', 696, 6, NULL, NULL),
(137, '2025-05-22 23:56:00', 74, 13, NULL, '', 110, 4, 0, '1', 0, '2', 4070, 37, NULL, NULL),
(138, '2025-05-22 23:56:00', 74, 12, NULL, '', 116, 4, 0, '1', 0, '2', 812, 7, NULL, NULL),
(139, '2025-05-22 23:56:00', 74, 14, NULL, '', 115, 4, 0, '1', 0, '2', 460, 4, NULL, NULL),
(140, '2025-05-23 19:02:00', 75, 13, NULL, '', 115, 4, 0, '1', 0, '2', 52900, 460, NULL, NULL),
(141, '2025-05-23 19:02:00', 75, 14, NULL, '', 118, 4, 0, '1', 0, '2', 4720, 40, NULL, NULL),
(142, '2025-05-23 19:05:00', 76, 13, NULL, '', 115, 4, 0, '1', 0, '2', 1610, 14, NULL, NULL),
(143, '2025-05-23 19:05:00', 76, 14, NULL, '', 118, 4, 0, '1', 0, '2', 118, 1, NULL, NULL),
(144, '2025-05-23 19:05:00', 76, 12, NULL, '', 120, 4, 0, '1', 0, '2', 360, 3, NULL, NULL),
(145, '2025-05-23 19:35:00', 77, 23, NULL, '', 195, 12, 0, '1', 0, '2', 7800, 40, NULL, NULL),
(146, '2025-05-23 19:45:00', 78, 13, NULL, '', 110, 4, 0, '1', 0, '2', 8140, 74, NULL, '2025-05-23 14:48:13.000000'),
(147, '2025-05-23 19:45:00', 78, 14, NULL, '', 110, 4, 0, '1', 0, '2', 1100, 10, NULL, '2025-05-23 14:48:13.000000'),
(148, '2025-05-23 19:45:00', 78, 12, NULL, '', 110, 4, 0, '1', 0, '2', 660, 6, NULL, '2025-05-23 14:48:13.000000'),
(149, '2025-05-23 19:55:00', 79, 13, NULL, '', 110, 4, 0, '1', 0, '2', 6600, 60, NULL, NULL),
(150, '2025-05-23 19:55:00', 79, 12, NULL, '', 116, 4, 0, '1', 0, '2', 812, 7, NULL, NULL),
(151, '2025-05-23 19:55:00', 79, 14, NULL, '', 115, 4, 0, '1', 0, '2', 1150, 10, NULL, NULL),
(152, '2025-05-23 22:21:00', 80, 24, NULL, '', 7, 9, 0, '1', 0, '2', 1400, 200, NULL, NULL),
(153, '2025-05-23 22:21:00', 80, 25, NULL, '', 6.9, 9, 0, '1', 0, '2', 2760, 400, NULL, NULL),
(154, '2025-05-23 22:21:00', 80, 18, NULL, '', 2000, 10, 0, '1', 0, '2', 2000, 1, NULL, NULL),
(156, '2025-05-26 18:53:00', 82, 26, NULL, '', 650, 1, 0, '1', 0, '2', 6500, 10, NULL, NULL),
(160, '2025-05-24 22:23:00', 85, 27, NULL, '', 90, 4, 0, '1', 0, '2', 1980, 22, NULL, NULL),
(161, '2025-05-24 22:23:00', 85, 13, NULL, '', 115, 4, 0, '1', 5, '2', 4290, 39, NULL, NULL),
(162, '2025-05-24 22:23:00', 85, 12, NULL, '', 120, 4, 0, '1', 4, '2', 464, 4, NULL, NULL),
(163, '2025-05-24 22:23:00', 85, 14, NULL, '', 118, 4, 0, '1', 3, '2', 920, 8, NULL, NULL),
(164, '2025-05-24 22:23:00', 85, 19, NULL, '', 110, 4, 0, '1', 0, '2', 110, 1, NULL, NULL),
(165, '2025-05-26 22:33:00', 86, 13, NULL, '', 115, 4, 0, '1', 10, '1', 24012, 232, NULL, NULL),
(166, '2025-05-26 22:33:00', 86, 14, NULL, '', 118, 4, 0, '1', 8, '1', 1302.72, 12, NULL, NULL),
(167, '2025-05-24 22:40:00', 87, 19, NULL, '', 110, 4, 0, '1', 5, '2', 420, 4, NULL, '2025-05-26 17:42:35.000000'),
(168, '2025-05-24 22:40:00', 87, 13, NULL, '', 115, 4, 0, '1', 7, '2', 7236, 67, NULL, '2025-05-26 17:42:35.000000'),
(169, '2025-05-27 14:12:00', 88, 28, NULL, '', 110, 4, 0, '1', 0, '2', 110, 1, NULL, NULL),
(170, '2025-05-27 14:12:00', 88, 13, NULL, '', 115, 4, 0, '1', 8, '1', 5290, 50, NULL, NULL),
(171, '2025-05-27 14:42:00', 89, 13, NULL, '', 115, 4, 0, '1', 5, '2', 12430, 113, NULL, NULL),
(172, '2025-05-27 14:42:00', 89, 14, NULL, '', 118, 4, 0, '1', 3, '2', 460, 4, NULL, NULL),
(173, '2025-05-27 14:42:00', 89, 12, NULL, '', 120, 4, 0, '1', 4, '2', 232, 2, NULL, NULL),
(174, '2025-05-27 14:42:00', 89, 27, NULL, '', 90, 4, 0, '1', 0, '2', 720, 8, NULL, NULL),
(175, '2025-05-27 15:47:00', 90, 16, NULL, '', 400, 9, 0, '1', 20, '2', 19000, 50, NULL, NULL),
(176, '2025-05-27 15:47:00', 90, 15, NULL, '', 300, 9, 0, '1', 20, '2', 28000, 100, NULL, NULL),
(177, '2025-05-27 15:59:00', 91, 16, NULL, '', 400, 9, 0, '1', 0, '2', 13200, 33, NULL, NULL),
(178, '2025-05-27 16:57:00', 92, 13, NULL, '', 115, 4, 0, '1', 3, '2', 5040, 45, NULL, '2025-05-27 14:51:32.000000'),
(179, '2025-05-27 16:57:00', 92, 22, NULL, '', 200, 11, 0, '1', 5, '2', 2925, 15, NULL, '2025-05-27 14:51:32.000000'),
(180, '2025-05-27 16:57:00', 92, 21, NULL, '', 250, 11, 0, '1', 0, '2', 2500, 10, NULL, '2025-05-27 14:51:32.000000'),
(181, '2025-05-27 17:16:00', 93, 12, NULL, '', 121, 4, 0, '1', 10, '1', 84397.5, 775, NULL, NULL),
(182, '2025-05-27 17:16:00', 93, 13, NULL, '', 115, 4, 0, '1', 10, '1', 26599.5, 257, NULL, NULL),
(183, '2025-05-27 17:16:00', 93, 14, NULL, '', 118, 4, 0, '1', 8, '1', 1194.16, 11, NULL, NULL),
(184, '2025-05-27 17:16:00', 93, 19, NULL, '', 110, 4, 0, '1', 10, '1', 693, 7, NULL, NULL),
(185, '2025-05-27 17:16:00', 93, 24, NULL, '', 7.5, 9, 0, '1', 0.8, '2', 2680, 400, NULL, NULL),
(186, '2025-05-27 17:53:00', 94, 16, NULL, '', 400, 9, 0, '1', 35, '2', 3650, 10, NULL, NULL),
(187, '2025-05-27 18:28:00', 95, 13, NULL, '', 115, 4, 0, '1', 0, '2', 3220, 28, NULL, NULL),
(188, '2025-05-27 18:28:00', 95, 12, NULL, '', 120, 4, 0, '1', 0, '2', 720, 6, NULL, NULL),
(189, '2025-05-27 18:28:00', 95, 29, NULL, '', 360, 5, 0, '1', 0, '2', 2160, 6, NULL, NULL),
(190, '2025-05-27 18:28:00', 95, 33, NULL, '', 300, 5, 0, '1', 0, '2', 300, 1, NULL, NULL),
(191, '2025-05-27 18:28:00', 95, 30, NULL, '', 125, 5, 0, '1', 5, '2', 120, 1, NULL, NULL),
(192, '2025-05-27 18:28:00', 95, 31, NULL, '', 100, 5, 0, '1', 0, '2', 100, 1, NULL, NULL),
(193, '2025-05-27 18:28:00', 95, 34, NULL, '', 600, 10, 0, '1', 0, '2', 600, 1, NULL, NULL),
(194, '2025-05-27 18:28:00', 95, 20, NULL, '', 320, 11, 0, '1', 0, '2', 640, 2, NULL, NULL),
(195, '2025-05-27 18:53:00', 96, 13, NULL, '', 120, 4, 0, '1', 0, '2', 120, 1, NULL, NULL),
(196, '2025-05-27 16:57:00', 92, 32, NULL, '', 90, 5, 0, '1', 24, '2', 660, 10, '2025-05-27 14:11:19.000000', '2025-05-27 14:51:32.000000'),
(197, '2025-05-27 19:14:00', 97, 12, NULL, '', 125, 4, 0, '1', 0, '2', 2000, 16, NULL, NULL),
(198, '2025-05-27 19:14:00', 97, 13, NULL, '', 120, 4, 0, '1', 0, '2', 2160, 18, NULL, NULL),
(199, '2025-05-27 19:14:00', 97, 14, NULL, '', 122, 4, 0, '1', 0, '2', 366, 3, NULL, NULL),
(200, '2025-05-27 19:19:00', 98, 12, NULL, '', 121, 4, 0, '1', 0, '2', 4114, 34, NULL, NULL),
(201, '2025-05-27 19:19:00', 98, 13, NULL, '', 115, 4, 0, '1', 0, '2', 3220, 28, NULL, NULL),
(202, '2025-05-27 19:19:00', 98, 14, NULL, '', 118, 4, 0, '1', 0, '2', 354, 3, NULL, NULL),
(203, '2025-05-27 19:19:00', 98, 16, NULL, '', 400, 9, 0, '1', 0, '2', 2000, 5, NULL, NULL),
(204, '2025-05-27 19:23:00', 99, 13, NULL, '', 115, 4, 0, '1', 0, '2', 2415, 21, NULL, NULL),
(205, '2025-05-27 19:25:00', 100, 13, NULL, '', 115, 4, 0, '1', 0, '2', 8625, 75, NULL, NULL),
(206, '2025-05-27 19:25:00', 100, 14, NULL, '', 118, 4, 0, '1', 0, '2', 118, 1, NULL, NULL),
(207, '2025-05-27 18:54:00', 101, 13, NULL, '', 120, 4, 0, '1', 0, '2', 240, 2, NULL, NULL),
(208, '2025-05-27 19:56:00', 102, 13, NULL, '', 115, 4, 0, '1', 0, '2', 33350, 290, NULL, NULL),
(209, '2025-05-27 19:56:00', 102, 12, NULL, '', 120, 4, 0, '1', 0, '2', 120, 1, NULL, NULL),
(210, '2025-05-27 19:56:00', 102, 14, NULL, '', 118, 4, 0, '1', 0, '2', 472, 4, NULL, NULL),
(211, '2025-05-27 19:58:00', 103, 26, NULL, '', 650, 1, 0, '1', 0, '2', 3900, 6, NULL, '2025-05-29 16:54:00.000000'),
(212, '2025-05-27 19:58:00', 103, 24, NULL, '', 7.5, 9, 0, '1', 0, '2', 2250, 300, NULL, '2025-05-29 16:54:00.000000'),
(214, '2025-05-27 20:04:00', 104, 12, NULL, '', 120, 4, 0, '1', 4, '2', 14152, 122, NULL, NULL),
(215, '2025-05-27 20:04:00', 104, 13, NULL, '', 115, 4, 0, '1', 2, '2', 1356, 12, NULL, NULL),
(216, '2025-05-27 20:06:00', 105, 13, NULL, '', 115, 4, 0, '1', 0, '2', 6440, 56, NULL, NULL),
(217, '2025-05-27 20:06:00', 106, 13, NULL, '', 115, 4, 0, '1', 0, '2', 3795, 33, NULL, NULL),
(218, '2025-05-27 20:06:00', 106, 14, NULL, '', 118, 4, 0, '1', 0, '2', 236, 2, NULL, NULL),
(219, '2025-05-27 20:06:00', 106, 19, NULL, '', 110, 4, 0, '1', 0, '2', 660, 6, NULL, NULL),
(220, '2025-05-27 20:32:00', 107, 35, NULL, '', 450, 5, 0, '1', 0, '2', 900, 2, NULL, NULL),
(221, '2025-05-27 20:32:00', 108, 32, NULL, '', 90, 5, 0, '1', 0, '2', 180, 2, NULL, NULL),
(222, '2025-05-27 21:07:00', 109, 13, NULL, '', 115, 4, 0, '1', 0, '2', 11615, 101, NULL, NULL),
(223, '2025-05-27 21:07:00', 109, 14, NULL, '', 118, 4, 0, '1', 0, '2', 118, 1, NULL, NULL),
(224, '2025-05-27 21:07:00', 109, 16, NULL, '', 400, 9, 0, '1', 10, '2', 7800, 20, NULL, NULL),
(225, '2025-05-27 21:08:00', 110, 13, NULL, '', 115, 4, 0, '1', 0, '2', 1150, 10, NULL, NULL),
(226, '2025-05-27 21:08:00', 110, 12, NULL, '', 121, 4, 0, '1', 0, '2', 1815, 15, NULL, NULL),
(227, '2025-05-27 21:08:00', 110, 16, NULL, '', 400, 9, 0, '1', 10, '2', 1950, 5, NULL, NULL),
(228, '2025-05-27 20:42:00', 111, 32, NULL, '', 100, 5, 0, '1', 0, '2', 100, 1, NULL, NULL),
(229, '2025-05-27 21:46:00', 112, 36, NULL, '', 20, 9, 0, '1', 0, '2', 480, 24, NULL, NULL),
(230, '2025-05-27 22:11:00', 113, 16, NULL, '', 400, 9, 0, '1', 0, '2', 2000, 5, NULL, NULL),
(231, '2025-05-27 22:15:00', 114, 13, NULL, '', 115, 4, 0, '1', 10, '1', 10350, 100, NULL, NULL),
(232, '2025-05-27 22:24:00', 115, 38, NULL, '', 550, 10, 0, '1', 0, '2', 550, 1, NULL, NULL),
(233, '2025-05-27 22:24:00', 115, 13, NULL, '', 115, 4, 0, '1', 0, '2', 115, 1, NULL, NULL),
(234, '2025-05-27 22:24:00', 115, 12, NULL, '', 120, 4, 0, '1', 0, '2', 240, 2, NULL, NULL),
(235, '2025-05-27 22:24:00', 115, 31, NULL, '', 100, 5, 0, '1', 0, '2', 300, 3, NULL, NULL),
(236, '2025-05-27 22:26:00', 116, 36, NULL, '', 20, 9, 0, '1', 0, '2', 480, 24, NULL, NULL),
(237, '2025-05-27 22:35:00', 117, 39, NULL, '', 200, 9, 0, '1', 0, '2', 400, 2, NULL, NULL),
(238, '2025-05-28 21:51:00', 118, 13, NULL, '', 115, 4, 0, '1', 10, '1', 10039.5, 97, NULL, NULL),
(240, '2025-05-29 13:54:00', 120, 13, NULL, '', 115, 4, 0, '1', 5, '2', 4070, 37, NULL, NULL),
(241, '2025-05-29 13:54:00', 120, 14, NULL, '', 118, 4, 0, '1', 3, '2', 345, 3, NULL, NULL),
(242, '2025-05-29 13:55:00', 121, 13, NULL, '', 115, 4, 0, '1', 0, '2', 5980, 52, NULL, NULL),
(243, '2025-05-29 13:55:00', 121, 14, NULL, '', 118, 4, 0, '1', 0, '2', 472, 4, NULL, NULL),
(244, '2025-05-29 13:55:00', 121, 19, NULL, '', 110, 4, 0, '1', 0, '2', 110, 1, NULL, NULL),
(245, '2025-05-29 13:56:00', 122, 13, NULL, '', 115, 4, 0, '1', 5, '2', 5390, 49, NULL, NULL),
(246, '2025-05-29 13:56:00', 122, 14, NULL, '', 118, 4, 0, '1', 3, '2', 230, 2, NULL, NULL),
(247, '2025-05-29 13:56:00', 122, 12, NULL, '', 120, 4, 0, '1', 5, '2', 345, 3, NULL, NULL),
(248, '2025-05-29 13:56:00', 122, 19, NULL, '', 110, 4, 0, '1', 5, '2', 105, 1, NULL, NULL),
(249, '2025-05-29 13:58:00', 123, 13, NULL, '', 115, 4, 0, '1', 5, '2', 3850, 35, NULL, '2025-05-29 16:52:02.000000'),
(250, '2025-05-29 13:58:00', 123, 14, NULL, '', 118, 4, 0, '1', 3, '2', 230, 2, NULL, '2025-05-29 16:52:02.000000'),
(251, '2025-05-29 13:58:00', 123, 17, NULL, '', 2200, 10, 0, '1', 200, '2', 4000, 2, NULL, '2025-05-29 16:52:02.000000'),
(252, '2025-05-29 14:00:00', 124, 13, NULL, '', 115, 4, 0, '1', 0, '2', 5060, 44, NULL, NULL),
(253, '2025-05-29 14:00:00', 124, 19, NULL, '', 110, 4, 0, '1', 0, '2', 660, 6, NULL, NULL),
(254, '2025-05-29 14:00:00', 124, 14, NULL, '', 118, 4, 0, '1', 0, '2', 354, 3, NULL, NULL),
(255, '2025-05-29 14:00:00', 124, 12, NULL, '', 120, 4, 0, '1', 0, '2', 240, 2, NULL, NULL),
(256, '2025-05-29 14:01:00', 125, 13, NULL, '', 115, 4, 0, '1', 3, '2', 9968, 89, NULL, NULL),
(257, '2025-05-29 14:01:00', 125, 14, NULL, '', 118, 4, 0, '1', 3, '2', 230, 2, NULL, NULL),
(258, '2025-05-29 17:08:00', 126, 13, NULL, '', 115, 4, 0, '1', 0, '2', 17595, 153, NULL, '2025-05-29 12:36:56.000000'),
(259, '2025-05-29 17:08:00', 126, 14, NULL, '', 118, 4, 0, '1', 0, '2', 826, 7, NULL, '2025-05-29 12:36:56.000000'),
(260, '2025-05-29 17:08:00', 126, 12, NULL, '', 120, 4, 0, '1', 0, '2', 120, 1, NULL, '2025-05-29 12:36:56.000000'),
(261, '2025-05-29 17:10:00', 127, 13, NULL, '', 115, 4, 0, '1', 0, '2', 1265, 11, NULL, NULL),
(262, '2025-05-29 17:10:00', 127, 12, NULL, '', 120, 4, 0, '1', 0, '2', 240, 2, NULL, NULL),
(263, '2025-05-29 17:38:00', 128, 13, NULL, '', 115, 4, 0, '1', 0, '2', 11270, 98, NULL, NULL),
(264, '2025-05-29 17:38:00', 128, 14, NULL, '', 118, 4, 0, '1', 0, '2', 236, 2, NULL, NULL),
(265, '2025-05-29 17:38:00', 128, 12, NULL, '', 120, 4, 0, '1', 0, '2', 120, 1, NULL, NULL),
(266, '2025-05-29 17:45:00', 129, 13, NULL, '', 115, 4, 0, '1', 0, '2', 14950, 130, NULL, NULL),
(267, '2025-05-29 20:14:00', 130, 13, NULL, '', 115, 4, 0, '1', 5, '2', 5940, 54, NULL, NULL),
(268, '2025-05-29 20:14:00', 130, 14, NULL, '', 118, 4, 0, '1', 3, '2', 115, 1, NULL, NULL),
(269, '2025-05-29 20:14:00', 130, 12, NULL, '', 120, 4, 0, '1', 5, '2', 115, 1, NULL, NULL),
(270, '2025-05-29 20:16:00', 131, 13, NULL, '', 115, 4, 0, '1', 0, '2', 11155, 97, NULL, NULL),
(271, '2025-05-29 20:16:00', 131, 14, NULL, '', 118, 4, 0, '1', 0, '2', 1888, 16, NULL, NULL),
(272, '2025-05-29 20:16:00', 131, 12, NULL, '', 120, 4, 0, '1', 0, '2', 13320, 111, NULL, NULL),
(273, '2025-05-29 20:16:00', 131, 16, NULL, '', 400, 9, 0, '1', 10, '2', 1950, 5, NULL, NULL),
(274, '2025-05-29 20:16:00', 131, 15, NULL, '', 300, 9, 0, '1', 0, '2', 1500, 5, NULL, NULL),
(275, '2025-05-29 20:20:00', 132, 16, NULL, '', 400, 9, 0, '1', 10, '2', 3120, 8, NULL, NULL),
(276, '2025-05-29 20:38:00', 133, 13, NULL, '', 115, 4, 0, '1', 5, '2', 5280, 48, NULL, NULL),
(277, '2025-05-29 20:38:00', 133, 14, NULL, '', 118, 4, 0, '1', 3, '2', 115, 1, NULL, NULL),
(278, '2025-05-29 20:38:00', 133, 41, NULL, '', 4600, 11, 0, '1', 0, '2', 4600, 1, NULL, NULL),
(279, '2025-05-29 20:42:00', 134, 13, NULL, '', 115, 4, 0, '1', 5, '2', 12210, 111, NULL, '2025-05-29 15:44:04.000000'),
(280, '2025-05-29 20:42:00', 134, 14, NULL, '', 118, 4, 0, '1', 8, '2', 990, 9, NULL, '2025-05-29 15:44:04.000000'),
(281, '2025-05-29 20:53:00', 135, 19, NULL, '', 110, 4, 0, '1', 2, '2', 216, 2, NULL, NULL),
(282, '2025-05-29 20:53:00', 135, 13, NULL, '', 115, 4, 0, '1', 5, '2', 3520, 32, NULL, NULL),
(283, '2025-05-29 20:53:00', 135, 12, NULL, '', 120, 4, 0, '1', 4, '2', 116, 1, NULL, NULL),
(284, '2025-05-29 21:16:00', 136, 13, NULL, '', 115, 4, 0, '1', 0, '2', 5405, 47, NULL, NULL),
(285, '2025-05-29 21:16:00', 136, 14, NULL, '', 118, 4, 0, '1', 0, '2', 118, 1, NULL, NULL),
(286, '2025-05-29 21:16:00', 136, 19, NULL, '', 110, 4, 0, '1', 0, '2', 220, 2, NULL, NULL),
(287, '2025-05-29 21:16:00', 136, 16, NULL, '', 400, 9, 0, '1', 0, '2', 1200, 3, NULL, NULL),
(288, '2025-05-29 21:16:00', 136, 15, NULL, '', 300, 9, 0, '1', 0, '2', 900, 3, NULL, NULL),
(289, '2025-05-29 21:20:00', 137, 13, NULL, '', 115, 4, 0, '1', 5, '2', 3960, 36, NULL, NULL),
(290, '2025-05-29 21:20:00', 137, 14, NULL, '', 118, 4, 0, '1', 3, '2', 230, 2, NULL, NULL),
(291, '2025-05-29 21:24:00', 138, 13, NULL, '', 115, 4, 0, '1', 0, '2', 4140, 36, NULL, NULL),
(292, '2025-05-29 21:24:00', 138, 14, NULL, '', 118, 4, 0, '1', 0, '2', 118, 1, NULL, NULL),
(293, '2025-05-29 21:24:00', 138, 12, NULL, '', 120, 4, 0, '1', 0, '2', 480, 4, NULL, NULL),
(294, '2025-05-29 21:31:00', 139, 13, NULL, '', 115, 4, 0, '1', 0, '2', 3680, 32, NULL, NULL),
(295, '2025-05-29 21:31:00', 139, 14, NULL, '', 118, 4, 0, '1', 0, '2', 236, 2, NULL, NULL),
(296, '2025-05-29 21:32:00', 140, 12, NULL, '', 120, 4, 0, '1', 4, '2', 3596, 31, NULL, NULL),
(297, '2025-05-29 21:32:00', 140, 13, NULL, '', 115, 4, 0, '1', 3, '2', 1680, 15, NULL, NULL),
(298, '2025-05-29 21:32:00', 140, 15, NULL, '', 300, 9, 0, '1', 0, '2', 1500, 5, NULL, NULL),
(299, '2025-05-29 13:58:00', 123, 40, NULL, NULL, 900, 11, 0, '1', 0, '2', 900, 1, '2025-05-29 16:52:02.000000', '2025-05-29 16:52:02.000000'),
(300, '2025-05-29 22:16:00', 141, 13, NULL, '', 115, 4, 0, '1', 7, '2', 540, 5, NULL, '2025-05-29 17:19:27.000000'),
(301, '2025-05-29 22:16:00', 141, 16, NULL, '', 400, 9, 0, '1', 0, '2', 800, 2, NULL, '2025-05-29 17:19:27.000000'),
(302, '2025-05-29 22:16:00', 141, 15, NULL, '', 310, 9, 0, '1', 0, '2', 1550, 5, NULL, '2025-05-29 17:19:27.000000'),
(303, '2025-05-29 22:16:00', 141, 22, NULL, '', 230, 11, 0, '1', 0, '2', 1150, 5, NULL, '2025-05-29 17:19:27.000000'),
(305, '2025-05-30 16:55:00', 143, 13, NULL, '', 115, 4, 0, '1', 10, '2', 3150, 30, NULL, NULL),
(306, '2025-05-30 16:56:00', 144, 13, NULL, '', 115, 4, 0, '1', 0, '2', 15985, 139, NULL, NULL),
(307, '2025-05-30 16:56:00', 144, 14, NULL, '', 118.5, 4, 0, '1', 0, '2', 711, 6, NULL, NULL),
(308, '2025-05-30 16:56:00', 144, 12, NULL, '', 121.5, 4, 0, '1', 0, '2', 121.5, 1, NULL, NULL),
(309, '2025-05-30 19:16:00', 145, 13, NULL, '', 115, 4, 0, '1', 0, '2', 6440, 56, NULL, NULL),
(310, '2025-05-30 19:16:00', 145, 14, NULL, '', 118, 4, 0, '1', 0, '2', 118, 1, NULL, NULL),
(311, '2025-05-30 19:16:00', 145, 16, NULL, '', 400, 9, 0, '1', 10, '2', 1950, 5, NULL, NULL),
(312, '2025-05-30 19:16:00', 145, 15, NULL, '', 300, 9, 0, '1', 10, '2', 2900, 10, NULL, NULL),
(313, '2025-05-30 19:57:00', 146, 13, NULL, '', 115, 4, 0, '1', 0, '2', 2760, 24, NULL, NULL),
(314, '2025-05-30 19:57:00', 146, 12, NULL, '', 121, 4, 0, '1', 0, '2', 3993, 33, NULL, NULL),
(315, '2025-05-30 19:57:00', 146, 14, NULL, '', 118, 4, 0, '1', 0, '2', 118, 1, NULL, NULL),
(316, '2025-05-30 20:00:00', 147, 13, NULL, '', 115, 4, 0, '1', 0, '2', 5865, 51, NULL, NULL),
(317, '2025-05-30 20:00:00', 147, 19, NULL, '', 110, 4, 0, '1', 0, '2', 330, 3, NULL, NULL),
(318, '2025-05-30 20:00:00', 147, 14, NULL, '', 118, 4, 0, '1', 0, '2', 118, 1, NULL, NULL),
(319, '2025-05-30 20:00:00', 147, 33, NULL, '', 300, 5, 0, '1', 0, '2', 900, 3, NULL, NULL),
(320, '2025-05-30 20:00:00', 147, 22, NULL, '', 200, 11, 0, '1', 0, '2', 200, 1, NULL, NULL),
(321, '2025-05-30 20:07:00', 148, 13, NULL, '', 115, 4, 0, '1', 5, '2', 11440, 104, NULL, '2025-05-30 17:52:37.000000'),
(322, '2025-05-30 20:07:00', 148, 14, NULL, '', 118, 4, 0, '1', 3, '2', 115, 1, NULL, '2025-05-30 17:52:37.000000'),
(323, '2025-05-30 20:07:00', 148, 12, NULL, '', 121, 4, 0, '1', 5, '2', 116, 1, NULL, '2025-05-30 17:52:37.000000'),
(324, '2025-05-30 20:09:00', 149, 13, NULL, '', 115, 4, 0, '1', 0, '2', 4255, 37, NULL, NULL),
(325, '2025-05-30 20:09:00', 149, 19, NULL, '', 110, 4, 0, '1', 0, '2', 110, 1, NULL, NULL),
(326, '2025-05-30 20:09:00', 149, 14, NULL, '', 118, 4, 0, '1', 0, '2', 236, 2, NULL, NULL),
(327, '2025-05-30 20:09:00', 149, 15, NULL, '', 300, 9, 0, '1', 0, '2', 1800, 6, NULL, NULL),
(328, '2025-05-30 20:13:00', 150, 13, NULL, '', 115, 4, 0, '1', 10, '1', 16042.5, 155, NULL, NULL),
(329, '2025-05-30 20:13:00', 150, 19, NULL, '', 110, 4, 0, '1', 10, '1', 198, 2, NULL, NULL),
(330, '2025-05-30 20:13:00', 150, 14, NULL, '', 118, 4, 0, '1', 8, '2', 440, 4, NULL, NULL),
(331, '2025-05-30 20:13:00', 150, 12, NULL, '', 121, 4, 0, '1', 10, '2', 111, 1, NULL, NULL),
(332, '2025-05-30 20:13:00', 150, 24, NULL, '', 6.7, 9, 0, '1', 0, '2', 13400, 2000, NULL, NULL),
(333, '2025-05-30 20:13:00', 150, 17, NULL, '', 1800, 10, 0, '1', 0, '2', 1800, 1, NULL, NULL),
(334, '2025-05-30 20:07:00', 148, 47, NULL, '', 550, 4, 0, '1', 0, '2', 1100, 2, '2025-05-30 15:21:51.000000', '2025-05-30 17:52:37.000000'),
(335, '2025-05-30 20:30:00', 151, 13, NULL, '', 115, 4, 0, '1', 0, '2', 3910, 34, NULL, '2025-05-30 15:32:34.000000'),
(336, '2025-05-30 20:30:00', 151, 14, NULL, '', 118, 4, 0, '1', 0, '2', 118, 1, NULL, '2025-05-30 15:32:34.000000'),
(337, '2025-05-30 20:30:00', 151, 12, NULL, '', 120, 4, 0, '1', 0, '2', 120, 1, NULL, '2025-05-30 15:32:34.000000'),
(338, '2025-05-30 20:34:00', 152, 16, NULL, '', 390, 9, 0, '1', 0, '2', 3900, 10, NULL, NULL),
(339, '2025-05-30 20:34:00', 152, 15, NULL, '', 290, 9, 0, '1', 0, '2', 1450, 5, NULL, NULL),
(340, '2025-05-30 21:16:00', 153, 13, NULL, '', 115, 4, 0, '1', 10, '1', 5692.5, 55, NULL, NULL),
(341, '2025-05-31 15:47:00', 154, 12, NULL, '', 120, 4, 0, '1', 3, '2', 5031, 43, NULL, NULL),
(342, '2025-05-31 15:47:00', 154, 14, NULL, '', 118, 4, 0, '1', 3, '2', 345, 3, NULL, NULL),
(343, '2025-05-31 15:47:00', 154, 13, NULL, '', 115, 4, 0, '1', 2, '2', 2825, 25, NULL, NULL),
(344, '2025-05-31 15:47:00', 154, 27, NULL, '', 90, 4, 0, '1', 0, '2', 1170, 13, NULL, NULL),
(345, '2025-05-31 17:25:00', 155, 16, NULL, '', 400, 9, 0, '1', 10, '2', 8580, 22, NULL, NULL),
(346, '2025-05-31 17:34:00', 156, 16, NULL, '', 400, 9, 0, '1', 10, '2', 3120, 8, NULL, NULL),
(347, '2025-05-31 17:38:00', 157, 16, NULL, '', 400, 9, 0, '1', 10, '2', 7800, 20, NULL, NULL),
(348, '2025-05-31 18:42:00', 158, 13, NULL, '', 115, 4, 0, '1', 0, '2', 115, 1, NULL, '2025-06-03 04:13:50.000000'),
(349, '2025-05-31 18:42:00', 158, 12, NULL, '', 120, 4, 0, '1', 0, '2', 120, 1, NULL, '2025-06-03 04:13:50.000000'),
(351, '2025-05-31 20:20:00', 159, 12, NULL, '', 120, 4, 0, '1', 4, '2', 464, 4, NULL, '2025-06-03 04:13:25.000000'),
(353, '2025-05-31 20:39:00', 160, 25, NULL, '', 6, 9, 0, '1', 0, '2', 168, 28, NULL, '2025-06-03 04:13:00.000000'),
(356, '2025-06-14 18:30:00', 162, 47, NULL, '', 550, 4, 0, '1', 0, '2', 4400, 8, NULL, NULL),
(357, '2025-06-14 18:30:00', 162, 45, NULL, '', 650, 11, 0, '1', 0, '2', 7800, 12, NULL, NULL),
(358, '2025-06-15 17:36:00', 163, 13, NULL, '', 115, 4, 0, '1', 12, '2', 103, 1, NULL, '2025-06-16 21:09:56.000000'),
(359, '2025-06-15 17:36:00', 163, 29, NULL, '', 360, 5, 0, '1', 0, '2', 36360, 101, '2025-06-16 21:01:39.000000', '2025-06-16 21:09:56.000000'),
(360, '2025-06-18 00:35:00', 164, 38, NULL, '', 550, 10, 0, '1', 0, '2', 6600, 12, NULL, NULL),
(361, '2025-06-22 19:56:00', 165, 13, NULL, '', 115, 4, 0, '1', 0, '2', 115, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sale_returns`
--

CREATE TABLE `sale_returns` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `tax_rate` double DEFAULT 0,
  `TaxNet` double DEFAULT 0,
  `discount` double DEFAULT 0,
  `discount_type` varchar(192) NOT NULL,
  `discount_percent_total` double DEFAULT 0,
  `shipping` double DEFAULT 0,
  `GrandTotal` double NOT NULL,
  `paid_amount` double NOT NULL DEFAULT 0,
  `payment_statut` varchar(192) NOT NULL,
  `statut` varchar(192) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_returns`
--

INSERT INTO `sale_returns` (`id`, `user_id`, `date`, `Ref`, `sale_id`, `client_id`, `warehouse_id`, `tax_rate`, `TaxNet`, `discount`, `discount_type`, `discount_percent_total`, `shipping`, `GrandTotal`, `paid_amount`, `payment_statut`, `statut`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '2025-04-26 11:41:00', 'RT_1111', 3, 2, 1, 0, 0, 0, 'fixed', 0, 0, 0, 0, 'unpaid', 'received', '', '2025-04-26 06:41:18.000000', '2025-04-26 06:41:18.000000', NULL),
(2, 1, '2025-04-26 16:09:00', 'RT_1112', 7, 2, 2, 0, 0, 0, 'fixed', 0, 0, 200, 200, 'paid', 'received', '', '2025-04-26 11:09:19.000000', '2025-04-26 11:10:45.000000', NULL),
(3, 1, '2025-04-26 17:36:00', 'RT_1113', 8, 4, 2, 0, 0, 5, 'percent', 62.5, 100, 1287.5, 1287.5, 'paid', 'received', '', '2025-04-26 12:37:17.000000', '2025-04-26 12:43:00.000000', NULL),
(4, 1, '2025-04-28 18:55:00', 'RT_1114', 12, 1, 1, 0, 0, 0, 'fixed', 0, 0, 30.3, 30.3, 'paid', 'received', '', '2025-04-28 13:55:59.000000', '2025-05-13 12:35:13.000000', NULL),
(5, 1, '2025-04-28 18:59:00', 'RT_1115', 13, 2, 2, 0, 0, 0, 'fixed', 0, 0, 454.5, 0, 'unpaid', 'received', '', '2025-04-28 13:59:29.000000', '2025-04-28 13:59:29.000000', NULL),
(8, 1, '2025-04-28 19:21:00', 'RT_1116', 15, 2, 1, 0, 0, 0, 'fixed', 0, 0, 303, 0, 'unpaid', 'received', '', '2025-04-28 14:21:36.000000', '2025-04-28 14:21:36.000000', NULL),
(14, 1, '2025-04-28 19:43:00', 'RT_1117', 16, 2, 1, 0, 0, 0, 'fixed', 0, 0, 151.5, 0, 'unpaid', 'received', '', '2025-04-28 14:43:51.000000', '2025-04-28 14:43:51.000000', NULL),
(17, 1, '2025-05-05 13:36:00', 'RT_1118', 29, 2, 1, 0, 0, 0, 'fixed', 0, 0, 22400, 0, 'unpaid', 'received', '', '2025-05-05 08:36:20.000000', '2025-05-05 08:36:20.000000', NULL),
(18, 1, '2025-05-10 11:08:00', 'RT_1119', 31, 2, 1, 0, 0, 0, 'fixed', 0, 0, 303, 0, 'unpaid', 'received', '', '2025-05-10 06:08:58.000000', '2025-05-10 06:08:58.000000', NULL),
(19, 1, '2025-05-10 11:19:00', 'RT_1120', 32, 2, 1, 0, 0, 0, 'fixed', 0, 0, 454.5, 0, 'unpaid', 'received', '', '2025-05-10 06:19:13.000000', '2025-05-10 06:19:13.000000', NULL),
(20, 1, '2025-05-10 11:30:00', 'RT_1121', 33, 2, 1, 0, 0, 0, 'fixed', 0, 0, 11800, 0, 'unpaid', 'received', '', '2025-05-10 06:32:41.000000', '2025-05-10 06:32:41.000000', NULL),
(21, 1, '2025-05-28 22:10:00', 'RT_1122', 119, 1, 4, 0, 0, 0, 'fixed', 0, 0, 360, 0, 'unpaid', 'received', '', '2025-05-28 22:10:24.000000', '2025-05-28 22:10:51.000000', '2025-05-28 22:10:51');

-- --------------------------------------------------------

--
-- Table structure for table `sale_return_details`
--

CREATE TABLE `sale_return_details` (
  `id` int(11) NOT NULL,
  `sale_return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` double NOT NULL,
  `sale_unit_id` int(11) DEFAULT NULL,
  `TaxNet` double DEFAULT 0,
  `tax_method` varchar(192) DEFAULT '1',
  `discount` double DEFAULT 0,
  `discount_method` varchar(192) DEFAULT '1',
  `product_variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_return_details`
--

INSERT INTO `sale_return_details` (`id`, `sale_return_id`, `product_id`, `price`, `sale_unit_id`, `TaxNet`, `tax_method`, `discount`, `discount_method`, `product_variant_id`, `imei_number`, `quantity`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 20000, NULL, 12, '1', 0, '2', NULL, '', 0, 0, NULL, NULL),
(2, 1, 3, 30, 1, 1, '1', 0, '2', NULL, '', 0, 0, NULL, NULL),
(3, 2, 4, 20, 4, 0, '1', 0, '2', 1, '', 10, 200, NULL, NULL),
(4, 3, 5, 250, 5, 0, '1', 0, '2', 4, '', 5, 1250, NULL, NULL),
(5, 4, 3, 30, 1, 1, '1', 0, '2', NULL, '', 1, 30.3, NULL, NULL),
(6, 5, 3, 30, 1, 1, '1', 0, '2', NULL, '', 15, 454.5, NULL, NULL),
(9, 8, 3, 30, 1, 1, '1', 0, '2', NULL, '', 10, 303, NULL, NULL),
(15, 14, 3, 30, 1, 1, '1', 0, '2', NULL, '', 5, 151.5, NULL, NULL),
(18, 17, 2, 20000, NULL, 12, '1', 0, '2', NULL, '', 1, 22400, NULL, NULL),
(19, 18, 3, 30, 1, 1, '1', 0, '2', NULL, '', 10, 303, NULL, NULL),
(20, 19, 3, 30, 1, 1, '1', 0, '2', NULL, '', 15, 454.5, NULL, NULL),
(21, 20, 10, 1800, 4, 0, 'null', 0, '2', NULL, '', 5, 9000, NULL, NULL),
(22, 20, 9, 280, 5, 0, '1', 0, '2', 9, '', 5, 1400, NULL, NULL),
(23, 20, 9, 280, 5, 0, '1', 0, '2', 8, '', 5, 1400, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `email` varchar(191) NOT NULL,
  `app_name` varchar(192) NOT NULL,
  `CompanyName` varchar(191) NOT NULL,
  `CompanyPhone` varchar(191) NOT NULL,
  `CompanyAdress` varchar(191) NOT NULL,
  `logo` varchar(191) DEFAULT NULL,
  `invoice_footer` varchar(192) DEFAULT NULL,
  `footer` varchar(192) NOT NULL,
  `developed_by` varchar(192) DEFAULT NULL,
  `default_language` varchar(192) NOT NULL DEFAULT 'en',
  `default_sms_gateway` varchar(192) DEFAULT NULL,
  `symbol_placement` varchar(192) NOT NULL DEFAULT 'before',
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `currency_id`, `client_id`, `warehouse_id`, `email`, `app_name`, `CompanyName`, `CompanyPhone`, `CompanyAdress`, `logo`, `invoice_footer`, `footer`, `developed_by`, `default_language`, `default_sms_gateway`, `symbol_placement`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 1, 4, 'admin@birdcoders.com', 'Master Material', 'Master Material', '+9203708655901', 'Karachi Pakistan', '1745664460.png', NULL, 'The Lakhas -  Inventory Management', 'Driestech', 'en', 'twilio', 'before', NULL, '2025-05-28 13:01:03.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sms_messages`
--

CREATE TABLE `sms_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(192) DEFAULT NULL,
  `text` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sms_messages`
--

INSERT INTO `sms_messages` (`id`, `name`, `text`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'sale', 'Dear {contact_name},\nThank you for your purchase! Your invoice number is {invoice_number}.\nIf you have any questions or concerns, please don\'t hesitate to reach out to us. We are here to help!\nBest regards,\n{business_name}', NULL, NULL, NULL),
(2, 'purchase', 'Dear {contact_name},\nI recently made a purchase from your company and I wanted to thank you for your cooperation and service. My invoice number is {invoice_number} .\nIf you have any questions or concerns regarding my purchase, please don\'t hesitate to contact me. I am here to make sure I have a positive experience with your company.\nBest regards,\n{business_name}', NULL, NULL, NULL),
(3, 'quotation', 'Dear {contact_name},\nThank you for your interest in our products. Your quotation number is {quotation_number}.\nPlease let us know if you have any questions or concerns regarding your quotation. We are here to assist you.\nBest regards,\n{business_name}', NULL, NULL, NULL),
(4, 'payment_received', 'Dear {contact_name},\nThank you for making your payment. We have received it and it has been processed successfully.\nIf you have any further questions or concerns, please don\'t hesitate to reach out to us. We are always here to help.\nBest regards,\n{business_name}', NULL, NULL, NULL),
(5, 'payment_sent', 'Dear {contact_name},\nWe have just sent the payment . We appreciate your prompt attention to this matter and the high level of service you provide.\nIf you need any further information or clarification, please do not hesitate to reach out to us. We are here to help.\nBest regards,\n{business_name}', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `Ref` varchar(192) NOT NULL,
  `date` datetime NOT NULL,
  `from_warehouse_id` int(11) NOT NULL,
  `to_warehouse_id` int(11) NOT NULL,
  `items` double NOT NULL,
  `tax_rate` double DEFAULT 0,
  `TaxNet` double DEFAULT 0,
  `discount` double DEFAULT 0,
  `discount_type` varchar(192) NOT NULL,
  `discount_percent_total` double DEFAULT 0,
  `shipping` double DEFAULT 0,
  `GrandTotal` double NOT NULL DEFAULT 0,
  `statut` varchar(192) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transfers`
--

INSERT INTO `transfers` (`id`, `user_id`, `Ref`, `date`, `from_warehouse_id`, `to_warehouse_id`, `items`, `tax_rate`, `TaxNet`, `discount`, `discount_type`, `discount_percent_total`, `shipping`, `GrandTotal`, `statut`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'TR_1111', '2025-04-26 16:33:00', 2, 1, 1, 0, 0, 0, 'fixed', 0, 0, 227.25, 'completed', '', '2025-04-26 06:33:47.000000', '2025-04-26 06:33:47.000000', NULL),
(2, 1, 'TR_1112', '2025-04-26 20:55:00', 3, 2, 2, 0, 0, 0, 'fixed', 0, 150, 655, 'completed', '', '2025-04-26 10:55:52.000000', '2025-04-26 10:55:52.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transfer_details`
--

CREATE TABLE `transfer_details` (
  `id` int(11) NOT NULL,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_variant_id` int(11) DEFAULT NULL,
  `cost` double NOT NULL,
  `purchase_unit_id` int(11) DEFAULT NULL,
  `TaxNet` double DEFAULT NULL,
  `tax_method` varchar(192) DEFAULT '1',
  `discount` double DEFAULT NULL,
  `discount_method` varchar(192) DEFAULT '1',
  `quantity` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transfer_details`
--

INSERT INTO `transfer_details` (`id`, `transfer_id`, `product_id`, `product_variant_id`, `cost`, `purchase_unit_id`, `TaxNet`, `tax_method`, `discount`, `discount_method`, `quantity`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 3, NULL, 15, 1, 1, '1', 0, '2', 15, 227.25, NULL, NULL),
(2, 2, 4, 1, 15, 4, 0, '1', 0, '2', 15, 225, NULL, NULL),
(3, 2, 4, 3, 20, 4, 0, '1', 0, '2', 14, 280, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(11) NOT NULL,
  `name` varchar(192) NOT NULL,
  `ShortName` varchar(191) DEFAULT NULL,
  `base_unit` int(11) DEFAULT NULL,
  `operator` char(192) DEFAULT '*',
  `operator_value` double DEFAULT 1,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `name`, `ShortName`, `base_unit`, `operator`, `operator_value`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Kilo Gram', 'kg', NULL, '*', 1, '2025-04-25 15:13:16.000000', '2025-04-25 15:13:16.000000', NULL),
(2, 'Kashan', 'kk', NULL, '*', 1, '2025-04-25 15:14:08.000000', '2025-04-26 06:29:09.000000', '2025-04-26 06:29:09'),
(3, 'Grams', 'gm', 1, '*', 1000, '2025-04-26 06:29:02.000000', '2025-04-26 06:29:02.000000', NULL),
(4, 'BOX', 'box', NULL, '*', 1, '2025-04-26 10:33:25.000000', '2025-04-26 10:33:25.000000', NULL),
(5, 'DOZEN', 'DZ', NULL, '*', 1, '2025-04-26 12:17:09.000000', '2025-04-26 12:17:09.000000', NULL),
(6, 'LOOSE', 'L', 5, '*', 12, '2025-04-26 12:19:06.000000', '2025-04-26 12:19:06.000000', NULL),
(7, 'feaf', '', NULL, '*', 1, '2025-04-29 08:19:45.000000', '2025-05-21 14:27:10.000000', '2025-05-21 14:27:10'),
(8, 'Kashan Abbas', '', NULL, '*', 1, '2025-05-10 06:06:01.000000', '2025-05-21 14:27:14.000000', '2025-05-21 14:27:14'),
(9, 'PIECE', 'PCS', NULL, '*', 1, '2025-05-21 14:28:07.000000', '2025-05-21 14:28:07.000000', NULL),
(10, 'PACKET', 'PKT', NULL, '*', 1, '2025-05-21 14:33:24.000000', '2025-05-21 14:33:24.000000', NULL),
(11, 'ROLL', '', NULL, '*', 1, '2025-05-22 14:08:56.000000', '2025-05-22 14:08:56.000000', NULL),
(12, 'Set', '', NULL, '*', 1, '2025-05-23 14:07:05.000000', '2025-05-23 14:07:05.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(192) NOT NULL,
  `email` varchar(192) NOT NULL,
  `email_verified_at` datetime DEFAULT NULL,
  `avatar` varchar(192) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `role_users_id` bigint(20) UNSIGNED NOT NULL,
  `is_all_warehouses` tinyint(1) NOT NULL DEFAULT 0,
  `password` varchar(192) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `email_verified_at`, `avatar`, `status`, `role_users_id`, `is_all_warehouses`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Usama Shaikh', 'admin@birdcoders.com', '2025-06-11 15:20:53', 'no_avatar.png', 1, 1, 1, '$2y$10$IFj6SwqC0Sxrsiv4YkCt.OJv1UV4mZrWuyLoRG7qt47mseP9mJ58u', NULL, '2025-05-31 13:41:50.000000', '2025-05-31 13:41:50.000000', NULL),
(4, 'Demo Driver', 'driver@gmail.com', '2025-06-11 15:21:05', 'no_avatar.png', 1, 5, 1, '$2y$10$Bp.wlndcyU5SU8ej0Zikz.w4QeDFenMEn27q7UV2Cn.FtsffMyPBu', NULL, '2025-05-18 05:14:47.000000', '2025-06-01 13:01:38.000000', NULL),
(5, 'HASSAN', 'hasan@db.com', '2025-06-11 15:21:09', 'no_avatar.png', 1, 1, 0, '$2y$10$EOZ9LVuz8/4EEPdtuw7cSOQKjb8lPHBMeCzvjXVjUeTlKehvhI4Dq', NULL, '2025-05-21 13:52:09.000000', '2025-06-12 16:30:57.000000', NULL),
(6, 'saqib', 'saqib@db.com', '2025-06-11 15:21:09', '1748264712.jpg', 0, 5, 1, '$2y$10$uNAz5l36jQ.tk70NHUuhAu1i8YNaLloG40QkyfDi2U3HWwBNHwX.y', NULL, '2025-05-22 10:35:29.000000', '2025-06-12 07:37:38.000000', '2025-06-12 07:37:38'),
(7, 'aqib', 'aqib@db.com', '2025-06-11 15:21:09', 'no_avatar.png', 0, 5, 0, '$2y$10$Fa6wZJr.oYNOSu4pOdV5sOMi1vLbORvZGDx6lfbBGqBBbzhe33AEK', NULL, '2025-05-22 10:38:29.000000', '2025-06-12 07:37:33.000000', '2025-06-12 07:37:33'),
(8, 'saif', 'saif@db.com', '2025-06-11 15:21:09', 'no_avatar.png', 0, 5, 0, '$2y$10$AC87B7jOpLOHnXYXsm8qfe7GDY1O8brp9uD.ADvm91iIb37aKveAq', NULL, '2025-05-22 11:22:02.000000', '2025-06-12 07:37:27.000000', '2025-06-12 07:37:27'),
(12, 'Point of sales', 'pos@db.com', NULL, 'no_avatar.png', 1, 6, 1, '$2y$10$tsWRzRv7yJqZBR3V8NrGA.5m37RUlppbh//nLP2P9b9qP5KL2jxHS', NULL, '2025-06-12 16:34:41.000000', '2025-06-12 16:39:26.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_warehouse`
--

CREATE TABLE `user_warehouse` (
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_warehouse`
--

INSERT INTO `user_warehouse` (`user_id`, `warehouse_id`) VALUES
(5, 4);

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` int(11) NOT NULL,
  `name` varchar(192) NOT NULL,
  `city` varchar(192) DEFAULT NULL,
  `mobile` varchar(192) DEFAULT NULL,
  `zip` varchar(192) DEFAULT NULL,
  `email` varchar(192) DEFAULT NULL,
  `country` varchar(192) DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `name`, `city`, `mobile`, `zip`, `email`, `country`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Sohrab Goth', 'Karachi', '', '', '', 'pakistan', '2025-04-26 05:34:59.000000', '2025-05-18 05:38:25.000000', '2025-05-18 05:38:25'),
(2, 'Defence', '', '', '', '', '', '2025-04-26 06:31:24.000000', '2025-05-18 05:38:23.000000', '2025-05-18 05:38:23'),
(3, 'garden', '', '', '', '', '', '2025-04-26 10:34:52.000000', '2025-05-18 05:38:20.000000', '2025-05-18 05:38:20'),
(4, 'Master Material', 'Karachi', '', '74000', '', 'Pakistan', '2025-05-18 05:38:16.000000', '2025-05-18 05:38:16.000000', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `account_ledgers`
--
ALTER TABLE `account_ledgers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `adjustments`
--
ALTER TABLE `adjustments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_adjustment` (`user_id`),
  ADD KEY `warehouse_id_adjustment` (`warehouse_id`);

--
-- Indexes for table `adjustment_details`
--
ALTER TABLE `adjustment_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adjust_product_id` (`product_id`),
  ADD KEY `adjust_adjustment_id` (`adjustment_id`),
  ADD KEY `adjust_product_variant` (`product_variant_id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clients_user_id` (`user_id`);

--
-- Indexes for table `clients_ledgers`
--
ALTER TABLE `clients_ledgers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `clients_ledgers_client_id_foreign` (`client_id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deposit_account_id` (`account_id`),
  ADD KEY `deposit_category_id` (`deposit_category_id`),
  ADD KEY `deposit_payment_method_id` (`payment_method_id`);

--
-- Indexes for table `deposit_categories`
--
ALTER TABLE `deposit_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_messages`
--
ALTER TABLE `email_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expenses_account_id` (`account_id`),
  ADD KEY `expenses_category_id` (`expense_category_id`),
  ADD KEY `expenses_payment_method_id` (`payment_method_id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`),
  ADD KEY `token` (`token`);

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_purchases`
--
ALTER TABLE `payment_purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_payment_purchases` (`user_id`),
  ADD KEY `payment_purchases_account_id` (`account_id`),
  ADD KEY `payments_purchase_id` (`purchase_id`),
  ADD KEY `payment_method_id_payment_purchases` (`payment_method_id`);

--
-- Indexes for table `payment_purchase_returns`
--
ALTER TABLE `payment_purchase_returns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_payment_return_purchase` (`user_id`),
  ADD KEY `payment_purchase_returns_account_id` (`account_id`),
  ADD KEY `supplier_id_payment_return_purchase` (`purchase_return_id`),
  ADD KEY `payment_method_id_payment_purchase_returns` (`payment_method_id`);

--
-- Indexes for table `payment_sales`
--
ALTER TABLE `payment_sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_payments_sale` (`user_id`),
  ADD KEY `account_id_payment_sales` (`account_id`),
  ADD KEY `payment_sale_id` (`sale_id`),
  ADD KEY `payment_method_id_payment_sales` (`payment_method_id`);

--
-- Indexes for table `payment_sale_returns`
--
ALTER TABLE `payment_sale_returns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `factures_sale_return_user_id` (`user_id`),
  ADD KEY `payment_sale_returns_account_id` (`account_id`),
  ADD KEY `factures_sale_return` (`sale_return_id`),
  ADD KEY `payment_method_id_payment_sale_returns` (`payment_method_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `pos_settings`
--
ALTER TABLE `pos_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `brand_id_products` (`brand_id`),
  ADD KEY `unit_id_products` (`unit_id`),
  ADD KEY `unit_id_sales` (`unit_sale_id`),
  ADD KEY `unit_purchase_products` (`unit_purchase_id`);

--
-- Indexes for table `product_ledgers`
--
ALTER TABLE `product_ledgers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_ledgers_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id_variant` (`product_id`);

--
-- Indexes for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_warehouse_id` (`product_id`),
  ADD KEY `warehouse_id` (`warehouse_id`),
  ADD KEY `product_variant_id` (`product_variant_id`);

--
-- Indexes for table `providers`
--
ALTER TABLE `providers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `providers_user_id` (`user_id`);

--
-- Indexes for table `provider_ledgers`
--
ALTER TABLE `provider_ledgers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `provider_ledgers_provider_id_index` (`provider_id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_purchases` (`user_id`),
  ADD KEY `provider_id` (`provider_id`),
  ADD KEY `warehouse_id_purchase` (`warehouse_id`);

--
-- Indexes for table `purchase_details`
--
ALTER TABLE `purchase_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_unit_id_purchase` (`purchase_unit_id`),
  ADD KEY `purchase_id` (`purchase_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `purchase_product_variant_id` (`product_variant_id`);

--
-- Indexes for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_returns` (`user_id`),
  ADD KEY `purchase_id_purchase_returns` (`purchase_id`),
  ADD KEY `provider_id_return` (`provider_id`),
  ADD KEY `purchase_return_warehouse_id` (`warehouse_id`);

--
-- Indexes for table `purchase_return_details`
--
ALTER TABLE `purchase_return_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unit_id_purchase_return_details` (`purchase_unit_id`),
  ADD KEY `purchase_return_id_return` (`purchase_return_id`),
  ADD KEY `product_id_details_purchase_return` (`product_id`),
  ADD KEY `purchase_return_product_variant_id` (`product_variant_id`);

--
-- Indexes for table `quotations`
--
ALTER TABLE `quotations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_quotation` (`user_id`),
  ADD KEY `client_id_quotation` (`client_id`),
  ADD KEY `warehouse_id_quotation` (`warehouse_id`);

--
-- Indexes for table `quotation_details`
--
ALTER TABLE `quotation_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_unit_id_quotation` (`sale_unit_id`),
  ADD KEY `product_id_quotation_details` (`product_id`),
  ADD KEY `quote_product_variant_id` (`product_variant_id`),
  ADD KEY `quotation_id` (`quotation_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_sales` (`user_id`),
  ADD KEY `sale_client_id` (`client_id`),
  ADD KEY `warehouse_id_sale` (`warehouse_id`);

--
-- Indexes for table `sale_details`
--
ALTER TABLE `sale_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Details_Sale_id` (`sale_id`),
  ADD KEY `sale_product_id` (`product_id`),
  ADD KEY `sale_product_variant_id` (`product_variant_id`),
  ADD KEY `sales_sale_unit_id` (`sale_unit_id`);

--
-- Indexes for table `sale_returns`
--
ALTER TABLE `sale_returns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_returns` (`user_id`),
  ADD KEY `sale_id_return_sales` (`sale_id`),
  ADD KEY `client_id_returns` (`client_id`),
  ADD KEY `warehouse_id_sale_return_id` (`warehouse_id`);

--
-- Indexes for table `sale_return_details`
--
ALTER TABLE `sale_return_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `return_id` (`sale_return_id`),
  ADD KEY `product_id_details_returns` (`product_id`),
  ADD KEY `sale_unit_id_return_details` (`sale_unit_id`),
  ADD KEY `sale_return_id_product_variant_id` (`product_variant_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `settings_currency_id` (`currency_id`),
  ADD KEY `settings_client_id` (`client_id`),
  ADD KEY `settings_warehouse_id` (`warehouse_id`);

--
-- Indexes for table `sms_messages`
--
ALTER TABLE `sms_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id_transfers` (`user_id`),
  ADD KEY `from_warehouse_id` (`from_warehouse_id`),
  ADD KEY `to_warehouse_id` (`to_warehouse_id`);

--
-- Indexes for table `transfer_details`
--
ALTER TABLE `transfer_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transfer_id` (`transfer_id`),
  ADD KEY `product_id_transfers` (`product_id`),
  ADD KEY `product_variant_id_transfer` (`product_variant_id`),
  ADD KEY `unit_sale_id_transfer` (`purchase_unit_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`),
  ADD KEY `base_unit` (`base_unit`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_role_users_id` (`role_users_id`);

--
-- Indexes for table `user_warehouse`
--
ALTER TABLE `user_warehouse`
  ADD KEY `user_warehouse_user_id` (`user_id`),
  ADD KEY `user_warehouse_warehouse_id` (`warehouse_id`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `account_ledgers`
--
ALTER TABLE `account_ledgers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `adjustments`
--
ALTER TABLE `adjustments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `adjustment_details`
--
ALTER TABLE `adjustment_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `clients_ledgers`
--
ALTER TABLE `clients_ledgers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `deposit_categories`
--
ALTER TABLE `deposit_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `email_messages`
--
ALTER TABLE `email_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `payment_purchases`
--
ALTER TABLE `payment_purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payment_purchase_returns`
--
ALTER TABLE `payment_purchase_returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payment_sales`
--
ALTER TABLE `payment_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `payment_sale_returns`
--
ALTER TABLE `payment_sale_returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=210;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pos_settings`
--
ALTER TABLE `pos_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `product_ledgers`
--
ALTER TABLE `product_ledgers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=412;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `providers`
--
ALTER TABLE `providers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `provider_ledgers`
--
ALTER TABLE `provider_ledgers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `purchase_details`
--
ALTER TABLE `purchase_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `purchase_return_details`
--
ALTER TABLE `purchase_return_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `quotations`
--
ALTER TABLE `quotations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `quotation_details`
--
ALTER TABLE `quotation_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=166;

--
-- AUTO_INCREMENT for table `sale_details`
--
ALTER TABLE `sale_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=362;

--
-- AUTO_INCREMENT for table `sale_returns`
--
ALTER TABLE `sale_returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `sale_return_details`
--
ALTER TABLE `sale_return_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sms_messages`
--
ALTER TABLE `sms_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transfer_details`
--
ALTER TABLE `transfer_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `adjustments`
--
ALTER TABLE `adjustments`
  ADD CONSTRAINT `user_id_adjustment` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `warehouse_id_adjustment` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `adjustment_details`
--
ALTER TABLE `adjustment_details`
  ADD CONSTRAINT `adjust_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `adjustments` (`id`),
  ADD CONSTRAINT `adjust_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `adjust_product_variant` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`);

--
-- Constraints for table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `clients_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `clients_ledgers`
--
ALTER TABLE `clients_ledgers`
  ADD CONSTRAINT `clients_ledgers_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `deposits`
--
ALTER TABLE `deposits`
  ADD CONSTRAINT `deposit_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `deposit_category_id` FOREIGN KEY (`deposit_category_id`) REFERENCES `deposit_categories` (`id`),
  ADD CONSTRAINT `deposit_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`);

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `expenses_category_id` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`),
  ADD CONSTRAINT `expenses_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`);

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payment_purchases`
--
ALTER TABLE `payment_purchases`
  ADD CONSTRAINT `payment_method_id_payment_purchases` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`),
  ADD CONSTRAINT `payment_purchases_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `payment_purchases_purchase_id` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`),
  ADD CONSTRAINT `payment_purchases_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `payment_purchase_returns`
--
ALTER TABLE `payment_purchase_returns`
  ADD CONSTRAINT `payment_method_id_payment_purchase_returns` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`),
  ADD CONSTRAINT `payment_purchase_returns_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `supplier_id_payment_return_purchase` FOREIGN KEY (`purchase_return_id`) REFERENCES `purchase_returns` (`id`),
  ADD CONSTRAINT `user_id_payment_return_purchase` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `payment_sales`
--
ALTER TABLE `payment_sales`
  ADD CONSTRAINT `account_id_payment_sales` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `payment_method_id_payment_sales` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`),
  ADD CONSTRAINT `payment_sales_sale_id` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`),
  ADD CONSTRAINT `user_id_payment_sales` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `payment_sale_returns`
--
ALTER TABLE `payment_sale_returns`
  ADD CONSTRAINT `payment_method_id_payment_sale_returns` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`),
  ADD CONSTRAINT `payment_sale_returns_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `payment_sale_returns_sale_return_id` FOREIGN KEY (`sale_return_id`) REFERENCES `sale_returns` (`id`),
  ADD CONSTRAINT `payment_sale_returns_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `brand_id_products` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`),
  ADD CONSTRAINT `category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `unit_id_products` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`),
  ADD CONSTRAINT `unit_id_sales` FOREIGN KEY (`unit_sale_id`) REFERENCES `units` (`id`),
  ADD CONSTRAINT `unit_purchase_products` FOREIGN KEY (`unit_purchase_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `product_ledgers`
--
ALTER TABLE `product_ledgers`
  ADD CONSTRAINT `product_ledgers_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD CONSTRAINT `product_id_variant` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  ADD CONSTRAINT `art_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `mag_id` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`),
  ADD CONSTRAINT `product_variant_id` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`);

--
-- Constraints for table `providers`
--
ALTER TABLE `providers`
  ADD CONSTRAINT `providers_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `provider_ledgers`
--
ALTER TABLE `provider_ledgers`
  ADD CONSTRAINT `provider_ledgers_provider_id_foreign` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `provider_id` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`),
  ADD CONSTRAINT `user_id_purchases` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `warehouse_id_purchase` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `purchase_details`
--
ALTER TABLE `purchase_details`
  ADD CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `purchase_id` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`),
  ADD CONSTRAINT `purchase_product_variant_id` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `purchase_unit_id_purchase` FOREIGN KEY (`purchase_unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  ADD CONSTRAINT `provider_id_return` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`),
  ADD CONSTRAINT `purchase_id_purchase_returns` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`),
  ADD CONSTRAINT `purchase_return_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `purchase_return_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `purchase_return_details`
--
ALTER TABLE `purchase_return_details`
  ADD CONSTRAINT `product_id_details_purchase_return` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `purchase_return_id_return` FOREIGN KEY (`purchase_return_id`) REFERENCES `purchase_returns` (`id`),
  ADD CONSTRAINT `purchase_return_product_variant_id` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`),
  ADD CONSTRAINT `unit_id_purchase_return_details` FOREIGN KEY (`purchase_unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `quotations`
--
ALTER TABLE `quotations`
  ADD CONSTRAINT `client_id _quotation` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `user_id_quotation` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `warehouse_id_quotation` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `quotation_details`
--
ALTER TABLE `quotation_details`
  ADD CONSTRAINT `product_id_quotation_details` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `quotation_id` FOREIGN KEY (`quotation_id`) REFERENCES `quotations` (`id`),
  ADD CONSTRAINT `quote_product_variant_id` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`),
  ADD CONSTRAINT `sale_unit_id_quotation` FOREIGN KEY (`sale_unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sale_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `user_id_sales` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `warehouse_id_sale` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `sale_details`
--
ALTER TABLE `sale_details`
  ADD CONSTRAINT `Details_Sale_id` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`),
  ADD CONSTRAINT `sale_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `sale_product_variant_id` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`),
  ADD CONSTRAINT `sales_sale_unit_id` FOREIGN KEY (`sale_unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `sale_returns`
--
ALTER TABLE `sale_returns`
  ADD CONSTRAINT `client_id_returns` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `sale_id_return_sales` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`),
  ADD CONSTRAINT `user_id_returns` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `warehouse_id_sale_return_id` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `sale_return_details`
--
ALTER TABLE `sale_return_details`
  ADD CONSTRAINT `product_id_details_returns` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `sale_return_id` FOREIGN KEY (`sale_return_id`) REFERENCES `sale_returns` (`id`),
  ADD CONSTRAINT `sale_return_id_product_variant_id` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`),
  ADD CONSTRAINT `sale_unit_id_return_details` FOREIGN KEY (`sale_unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `settings`
--
ALTER TABLE `settings`
  ADD CONSTRAINT `settings_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `settings_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  ADD CONSTRAINT `settings_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `transfers`
--
ALTER TABLE `transfers`
  ADD CONSTRAINT `from_warehouse_id` FOREIGN KEY (`from_warehouse_id`) REFERENCES `warehouses` (`id`),
  ADD CONSTRAINT `to_warehouse_id` FOREIGN KEY (`to_warehouse_id`) REFERENCES `warehouses` (`id`),
  ADD CONSTRAINT `user_id_transfers` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `transfer_details`
--
ALTER TABLE `transfer_details`
  ADD CONSTRAINT `product_id_transfers` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `product_variant_id_transfer` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`),
  ADD CONSTRAINT `transfer_id` FOREIGN KEY (`transfer_id`) REFERENCES `transfers` (`id`),
  ADD CONSTRAINT `unit_sale_id_transfer` FOREIGN KEY (`purchase_unit_id`) REFERENCES `units` (`id`);

--
-- Constraints for table `units`
--
ALTER TABLE `units`
  ADD CONSTRAINT `base_unit` FOREIGN KEY (`base_unit`) REFERENCES `units` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_users_id` FOREIGN KEY (`role_users_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `user_warehouse`
--
ALTER TABLE `user_warehouse`
  ADD CONSTRAINT `user_warehouse_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_warehouse_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
