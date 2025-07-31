-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 31, 2025 at 07:42 PM
-- Server version: 8.0.31
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lakhas`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_num` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_name` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `initial_balance` decimal(10,2) NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `account_ledgers`
--

DROP TABLE IF EXISTS `account_ledgers`;
CREATE TABLE IF NOT EXISTS `account_ledgers` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `account_id` bigint UNSIGNED NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date NOT NULL,
  `debit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `credit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `adjustments`
--

DROP TABLE IF EXISTS `adjustments`;
CREATE TABLE IF NOT EXISTS `adjustments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int NOT NULL,
  `items` double DEFAULT '0',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_adjustment` (`user_id`),
  KEY `warehouse_id_adjustment` (`warehouse_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `adjustments`
--

INSERT INTO `adjustments` (`id`, `user_id`, `date`, `Ref`, `warehouse_id`, `items`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '2025-07-03 05:45:00', 'AD_1111', 1, 1, 'vvgvgvgg', '2025-07-02 14:46:09.000000', '2025-07-02 14:46:09.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `adjustment_details`
--

DROP TABLE IF EXISTS `adjustment_details`;
CREATE TABLE IF NOT EXISTS `adjustment_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `adjustment_id` int NOT NULL,
  `product_variant_id` int DEFAULT NULL,
  `quantity` double NOT NULL,
  `type` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `adjust_product_id` (`product_id`),
  KEY `adjust_adjustment_id` (`adjustment_id`),
  KEY `adjust_product_variant` (`product_variant_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `adjustment_details`
--

INSERT INTO `adjustment_details` (`id`, `product_id`, `adjustment_id`, `product_variant_id`, `quantity`, `type`, `created_at`, `updated_at`) VALUES
(1, 2, 1, NULL, 4, 'add', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
CREATE TABLE IF NOT EXISTS `brands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `description`, `image`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Fabrics', 'hjhhghhghghghghgh', '1751466382.png', '2025-07-02 04:26:22.000000', '2025-07-02 04:26:22.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
CREATE TABLE IF NOT EXISTS `carts` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `size` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `carts_user_id_product_id_size_color_unique` (`user_id`,`product_id`,`size`,`color`),
  KEY `carts_product_id_foreign` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `product_id`, `quantity`, `size`, `color`, `price`, `created_at`, `updated_at`) VALUES
(12, 1, 3, 2, NULL, NULL, '2500.00', '2025-07-29 18:04:41', '2025-07-29 18:04:41'),
(13, 18, 1, 2, 'M', 'green', '1500.00', '2025-07-31 18:59:19', '2025-07-31 18:59:19');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `code`, `name`, `image`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '6765778', 'Fabrics', '1751879843.png', '2025-07-07 09:17:23.000000', '2025-07-07 09:17:23.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `photo` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clients_user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `user_id`, `username`, `code`, `status`, `photo`, `email`, `country`, `city`, `phone`, `address`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'sudais ahmed', '1', 1, '1751483569.png', 'sudais@example.com', NULL, 'Karachi', '03000002000', 'najdhfjkhkfj', '2025-07-02 09:12:49.000000', '2025-07-02 09:12:49.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `clients_ledgers`
--

DROP TABLE IF EXISTS `clients_ledgers`;
CREATE TABLE IF NOT EXISTS `clients_ledgers` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` int NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `debit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `credit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clients_ledgers_client_id_foreign` (`client_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients_ledgers`
--

INSERT INTO `clients_ledgers` (`id`, `client_id`, `type`, `reference`, `date`, `debit`, `credit`, `balance`, `created_at`, `updated_at`) VALUES
(1, 1, 'pos_sale', 'SO-20250703-1', '2025-07-02 15:30:31', '5645.00', '0.00', '5645.00', '2025-07-02 15:30:31', '2025-07-02 15:30:31'),
(2, 1, 'sale', 'SO-20250703-2', '2025-07-02 16:37:50', '11236.00', '0.00', '16881.00', '2025-07-02 16:37:50', '2025-07-02 16:37:50'),
(3, 1, 'sale', 'SO-20250703-3', '2025-07-02 17:12:13', '11056.00', '0.00', '27937.00', '2025-07-02 17:12:13', '2025-07-02 17:12:13'),
(4, 1, 'sale', 'SO-20250703-4', '2025-07-02 17:23:15', '11100.00', '0.00', '39037.00', '2025-07-02 17:23:15', '2025-07-02 17:23:15'),
(5, 1, 'sale', 'SO-20250703-5', '2025-07-02 18:21:18', '6339.00', '0.00', '45376.00', '2025-07-02 18:21:18', '2025-07-02 18:21:18'),
(6, 1, 'sale', 'SO-20250703-6', '2025-07-02 18:28:17', '6239.00', '0.00', '51615.00', '2025-07-02 18:28:17', '2025-07-02 18:28:17'),
(7, 1, 'sale', 'SO-20250703-7', '2025-07-02 18:49:59', '0.00', '0.00', '51615.00', '2025-07-02 18:49:59', '2025-07-02 18:49:59'),
(8, 1, 'sale', 'SO-20250703-8', '2025-07-02 18:49:59', '0.00', '0.00', '51615.00', '2025-07-02 18:49:59', '2025-07-02 18:49:59'),
(9, 1, 'sale', 'SO-20250703-9', '2025-07-02 19:20:08', '11189.00', '0.00', '62804.00', '2025-07-02 19:20:08', '2025-07-02 19:20:08'),
(10, 1, 'pos_sale', 'SO-20250703-10', '2025-07-02 19:47:47', '6049.00', '0.00', '68853.00', '2025-07-02 19:47:47', '2025-07-02 19:47:47'),
(11, 1, 'pos_sale', 'SO-20250703-11', '2025-07-02 19:50:22', '5500.00', '0.00', '74353.00', '2025-07-02 19:50:22', '2025-07-02 19:50:22'),
(12, 1, 'sale', 'SO-20250707-1', '2025-07-07 09:28:53', '6750.00', '0.00', '81103.00', '2025-07-07 09:28:53', '2025-07-07 09:28:53'),
(13, 1, 'sale', 'SO-20250707-2', '2025-07-07 09:33:55', '3000.00', '0.00', '84103.00', '2025-07-07 09:33:55', '2025-07-07 09:33:55');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
CREATE TABLE IF NOT EXISTS `currencies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

DROP TABLE IF EXISTS `deposits`;
CREATE TABLE IF NOT EXISTS `deposits` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `deposit_category_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method_id` int NOT NULL,
  `date` datetime NOT NULL,
  `deposit_ref` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `attachment` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deposit_account_id` (`account_id`),
  KEY `deposit_category_id` (`deposit_category_id`),
  KEY `deposit_payment_method_id` (`payment_method_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposit_categories`
--

DROP TABLE IF EXISTS `deposit_categories`;
CREATE TABLE IF NOT EXISTS `deposit_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_messages`
--

DROP TABLE IF EXISTS `email_messages`;
CREATE TABLE IF NOT EXISTS `email_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

DROP TABLE IF EXISTS `expenses`;
CREATE TABLE IF NOT EXISTS `expenses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `expense_category_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method_id` int NOT NULL,
  `date` datetime NOT NULL,
  `expense_ref` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `attachment` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_account_id` (`account_id`),
  KEY `expenses_category_id` (`expense_category_id`),
  KEY `expenses_payment_method_id` (`payment_method_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

DROP TABLE IF EXISTS `expense_categories`;
CREATE TABLE IF NOT EXISTS `expense_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=359 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(262, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(263, '2023_06_15_231338_create_accounts_table', 1),
(264, '2023_06_15_231338_create_adjustment_details_table', 1),
(265, '2023_06_15_231338_create_adjustments_table', 1),
(266, '2023_06_15_231338_create_brands_table', 1),
(267, '2023_06_15_231338_create_categories_table', 1),
(268, '2023_06_15_231338_create_clients_table', 1),
(269, '2023_06_15_231338_create_currencies_table', 1),
(270, '2023_06_15_231338_create_deposit_categories_table', 1),
(271, '2023_06_15_231338_create_deposits_table', 1),
(272, '2023_06_15_231338_create_email_messages_table', 1),
(273, '2023_06_15_231338_create_expense_categories_table', 1),
(274, '2023_06_15_231338_create_expenses_table', 1),
(275, '2023_06_15_231338_create_model_has_permissions_table', 1),
(276, '2023_06_15_231338_create_model_has_roles_table', 1),
(277, '2023_06_15_231338_create_password_resets_table', 1),
(278, '2023_06_15_231338_create_payment_methods_table', 1),
(279, '2023_06_15_231338_create_payment_purchase_returns_table', 1),
(280, '2023_06_15_231338_create_payment_purchases_table', 1),
(281, '2023_06_15_231338_create_payment_sale_returns_table', 1),
(282, '2023_06_15_231338_create_payment_sales_table', 1),
(283, '2023_06_15_231338_create_permissions_table', 1),
(284, '2023_06_15_231338_create_pos_settings_table', 1),
(285, '2023_06_15_231338_create_product_variants_table', 1),
(286, '2023_06_15_231338_create_product_warehouse_table', 1),
(287, '2023_06_15_231338_create_products_table', 1),
(288, '2023_06_15_231338_create_providers_table', 1),
(289, '2023_06_15_231338_create_purchase_details_table', 1),
(290, '2023_06_15_231338_create_purchase_return_details_table', 1),
(291, '2023_06_15_231338_create_purchase_returns_table', 1),
(292, '2023_06_15_231338_create_purchases_table', 1),
(293, '2023_06_15_231338_create_quotation_details_table', 1),
(294, '2023_06_15_231338_create_quotations_table', 1),
(295, '2023_06_15_231338_create_role_has_permissions_table', 1),
(296, '2023_06_15_231338_create_roles_table', 1),
(297, '2023_06_15_231338_create_sale_details_table', 1),
(298, '2023_06_15_231338_create_sale_return_details_table', 1),
(299, '2023_06_15_231338_create_sale_returns_table', 1),
(300, '2023_06_15_231338_create_sales_table', 1),
(301, '2023_06_15_231338_create_settings_table', 1),
(302, '2023_06_15_231338_create_sms_messages_table', 1),
(303, '2023_06_15_231338_create_transfer_details_table', 1),
(304, '2023_06_15_231338_create_transfers_table', 1),
(305, '2023_06_15_231338_create_units_table', 1),
(306, '2023_06_15_231338_create_user_warehouse_table', 1),
(307, '2023_06_15_231338_create_users_table', 1),
(308, '2023_06_15_231338_create_warehouses_table', 1),
(309, '2023_06_15_231341_add_foreign_keys_to_adjustment_details_table', 1),
(310, '2023_06_15_231341_add_foreign_keys_to_adjustments_table', 1),
(311, '2023_06_15_231341_add_foreign_keys_to_clients_table', 1),
(312, '2023_06_15_231341_add_foreign_keys_to_deposits_table', 1),
(313, '2023_06_15_231341_add_foreign_keys_to_expenses_table', 1),
(314, '2023_06_15_231341_add_foreign_keys_to_model_has_permissions_table', 1),
(315, '2023_06_15_231341_add_foreign_keys_to_model_has_roles_table', 1),
(316, '2023_06_15_231341_add_foreign_keys_to_payment_purchase_returns_table', 1),
(317, '2023_06_15_231341_add_foreign_keys_to_payment_purchases_table', 1),
(318, '2023_06_15_231341_add_foreign_keys_to_payment_sale_returns_table', 1),
(319, '2023_06_15_231341_add_foreign_keys_to_payment_sales_table', 1),
(320, '2023_06_15_231341_add_foreign_keys_to_product_variants_table', 1),
(321, '2023_06_15_231341_add_foreign_keys_to_product_warehouse_table', 1),
(322, '2023_06_15_231341_add_foreign_keys_to_products_table', 1),
(323, '2023_06_15_231341_add_foreign_keys_to_providers_table', 1),
(324, '2023_06_15_231341_add_foreign_keys_to_purchase_details_table', 1),
(325, '2023_06_15_231341_add_foreign_keys_to_purchase_return_details_table', 1),
(326, '2023_06_15_231341_add_foreign_keys_to_purchase_returns_table', 1),
(327, '2023_06_15_231341_add_foreign_keys_to_purchases_table', 1),
(328, '2023_06_15_231341_add_foreign_keys_to_quotation_details_table', 1),
(329, '2023_06_15_231341_add_foreign_keys_to_quotations_table', 1),
(330, '2023_06_15_231341_add_foreign_keys_to_role_has_permissions_table', 1),
(331, '2023_06_15_231341_add_foreign_keys_to_sale_details_table', 1),
(332, '2023_06_15_231341_add_foreign_keys_to_sale_return_details_table', 1),
(333, '2023_06_15_231341_add_foreign_keys_to_sale_returns_table', 1),
(334, '2023_06_15_231341_add_foreign_keys_to_sales_table', 1),
(335, '2023_06_15_231341_add_foreign_keys_to_settings_table', 1),
(336, '2023_06_15_231341_add_foreign_keys_to_transfer_details_table', 1),
(337, '2023_06_15_231341_add_foreign_keys_to_transfers_table', 1),
(338, '2023_06_15_231341_add_foreign_keys_to_units_table', 1),
(339, '2023_06_15_231341_add_foreign_keys_to_user_warehouse_table', 1),
(340, '2023_06_15_231341_add_foreign_keys_to_users_table', 1),
(341, '2025_04_29_131519_make_shortname_nullable_in_units_table', 1),
(342, '2025_05_05_100346_create_product_ledgers_table', 1),
(343, '2025_05_05_115112_add_timestamp_to_product_ledgers_table', 1),
(344, '2025_05_07_105652_create_provider_ledgers_table', 1),
(345, '2025_05_13_092928_add_customer_name_and_product_code_to_product_ledgers_table', 1),
(346, '2025_05_13_164600_create_clients_ledgers_table', 1),
(347, '2025_06_22_095633_create_account_ledgers_table', 1),
(348, '2025_06_24_184230_create_sub_categories_table', 1),
(349, '2025_06_24_201823_add_is_visible_to_products_table', 1),
(350, '2025_06_28_135246_add_shirt_and_pant_size_in_sales_table', 1),
(351, '2025_06_28_161745_create_product_images_table', 1),
(352, '2025_06_30_214621_add_product_type_to_products_table', 1),
(353, '2025_07_20_163006_create_wishlists_table', 2),
(354, '2025_07_20_163205_create_carts_table', 3),
(355, '2025_07_23_002720_create_orders_table', 4),
(356, '2025_07_23_002911_create_order_items_table', 4),
(357, '2025_07_29_225645_create_reviews_table', 5),
(358, '2025_07_30_194309_create_newsletters_table', 6);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 5),
(1, 'App\\Models\\User', 10),
(1, 'App\\Models\\User', 11),
(2, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 12),
(3, 'App\\Models\\User', 3),
(3, 'App\\Models\\User', 16),
(4, 'App\\Models\\User', 15),
(5, 'App\\Models\\User', 4),
(5, 'App\\Models\\User', 6),
(5, 'App\\Models\\User', 7),
(5, 'App\\Models\\User', 8),
(6, 'App\\Models\\User', 12),
(6, 'App\\Models\\User', 14),
(6, 'App\\Models\\User', 15);

-- --------------------------------------------------------

--
-- Table structure for table `newsletters`
--

DROP TABLE IF EXISTS `newsletters`;
CREATE TABLE IF NOT EXISTS `newsletters` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `newsletters_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `newsletters`
--

INSERT INTO `newsletters` (`id`, `email`, `created_at`, `updated_at`) VALUES
(1, 'admin@birdcoders.com', '2025-07-30 14:48:05', '2025-07-30 14:48:05');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `country` varchar(255) NOT NULL,
  `address1` varchar(255) NOT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zipcode` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `different_address` text,
  `payment_method` varchar(255) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `first_name`, `last_name`, `company_name`, `country`, `address1`, `address2`, `city`, `state`, `zipcode`, `phone`, `email`, `different_address`, `payment_method`, `total`, `status`, `created_at`, `updated_at`) VALUES
(4, 'Sudais', 'Ahmed', NULL, '2', 'mehrab khan essa khan road', NULL, 'Karachi', 'Sindh', '75660', '0302 6861279', 'admin@birdcoders.com', 'ehuhuw', 'on', '3000.00', 'Delivered', '2025-07-29 15:02:39', '2025-07-29 15:04:39'),
(2, 'Sudais', 'Ahmed', NULL, '2', 'mehrab khan essa khan road', NULL, 'Karachi', 'Garden', '75660', '0302 6861279', 'sudais2201a@aptechgdn.net', 'jgjghjgj', 'on', '5000.00', 'pending', '2025-07-28 14:57:22', '2025-07-28 14:57:22'),
(3, 'Sudais', 'Ahmed', NULL, '2', 'mehrab khan essa khan road', NULL, 'Karachi', 'Sindh', '75660', '0302 6861279', 'admin@birdcoders.com', 'kajkhfjhjkad', 'on', '12500.00', 'Shipped', '2025-07-29 14:36:28', '2025-07-29 14:58:55'),
(5, 'Sudais', 'Ahmed', NULL, '2', 'mehrab khan essa khan road', NULL, 'Karachi', 'Sindh', '75660', '0302 6861279', 'admin@birdcoders.com', 'jkdkjshkjhdjhsajk', 'on', '5000.00', 'Delivered', '2025-07-29 18:05:41', '2025-07-29 18:06:54'),
(6, 'Sudais', 'Ahmed', NULL, '2', 'mehrab khan essa khan road', NULL, 'Karachi', 'Sindh', '75660', '0302 6861279', 'sudais2201a@aptechgdn.net', 'shsghgs', 'on', '5000.00', 'Delivered', '2025-07-30 13:19:17', '2025-07-30 13:20:15'),
(7, 'Sudais', 'Ahmed', NULL, '2', 'mehrab khan essa khan road', NULL, 'Karachi', 'Sindh', '75660', '0302 6861279', 'sudais2201a@aptechgdn.net', 'jhjkhjhjkhk', 'on', '3000.00', 'pending', '2025-07-31 19:00:07', '2025-07-31 19:00:07');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE IF NOT EXISTS `order_items` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_product_id_foreign` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 2, '1500.00', '2025-07-23 11:31:22', '2025-07-23 11:31:22'),
(2, 1, 3, 2, '2500.00', '2025-07-23 11:31:22', '2025-07-23 11:31:22'),
(3, 2, 2, 2, '1500.00', '2025-07-23 11:48:11', '2025-07-23 11:48:11'),
(4, 3, 2, 2, '1500.00', '2025-07-23 19:17:50', '2025-07-23 19:17:50'),
(5, 1, 3, 2, '2500.00', '2025-07-28 13:27:27', '2025-07-28 13:27:27'),
(6, 2, 3, 2, '2500.00', '2025-07-28 14:57:22', '2025-07-28 14:57:22'),
(7, 3, 3, 5, '2500.00', '2025-07-29 14:36:28', '2025-07-29 14:36:28'),
(8, 4, 2, 2, '1500.00', '2025-07-29 15:02:39', '2025-07-29 15:02:39'),
(9, 5, 3, 2, '2500.00', '2025-07-29 18:05:41', '2025-07-29 18:05:41'),
(10, 6, 3, 2, '2500.00', '2025-07-30 13:19:17', '2025-07-30 13:19:17'),
(11, 7, 1, 2, '1500.00', '2025-07-31 19:00:07', '2025-07-31 19:00:07');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email` (`email`),
  KEY `token` (`token`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
CREATE TABLE IF NOT EXISTS `payment_methods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_methods`
--

INSERT INTO `payment_methods` (`id`, `title`, `is_default`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Other Payment Method', 0, NULL, NULL, NULL),
(2, 'Paypal', 1, NULL, NULL, NULL),
(3, 'Bank transfer', 0, NULL, NULL, NULL),
(4, 'Credit card', 1, NULL, NULL, NULL),
(5, 'Cheque', 0, NULL, '2025-05-26 11:00:39.000000', NULL),
(6, 'Cash', 0, NULL, NULL, NULL),
(7, 'gy', 0, '2025-05-30 09:58:56.000000', '2025-05-30 09:59:02.000000', '2025-05-30 09:59:02');

-- --------------------------------------------------------

--
-- Table structure for table `payment_purchases`
--

DROP TABLE IF EXISTS `payment_purchases`;
CREATE TABLE IF NOT EXISTS `payment_purchases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `account_id` int DEFAULT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchase_id` int NOT NULL,
  `montant` double NOT NULL,
  `change` double NOT NULL DEFAULT '0',
  `payment_method_id` int NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_payment_purchases` (`user_id`),
  KEY `payment_purchases_account_id` (`account_id`),
  KEY `payments_purchase_id` (`purchase_id`),
  KEY `payment_method_id_payment_purchases` (`payment_method_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_purchase_returns`
--

DROP TABLE IF EXISTS `payment_purchase_returns`;
CREATE TABLE IF NOT EXISTS `payment_purchase_returns` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `account_id` int DEFAULT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchase_return_id` int NOT NULL,
  `montant` double NOT NULL,
  `change` double NOT NULL DEFAULT '0',
  `payment_method_id` int NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_payment_return_purchase` (`user_id`),
  KEY `payment_purchase_returns_account_id` (`account_id`),
  KEY `supplier_id_payment_return_purchase` (`purchase_return_id`),
  KEY `payment_method_id_payment_purchase_returns` (`payment_method_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_sales`
--

DROP TABLE IF EXISTS `payment_sales`;
CREATE TABLE IF NOT EXISTS `payment_sales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `account_id` int DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `Ref` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sale_id` int NOT NULL,
  `montant` double NOT NULL,
  `change` double NOT NULL DEFAULT '0',
  `payment_method_id` int NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_payments_sale` (`user_id`),
  KEY `account_id_payment_sales` (`account_id`),
  KEY `payment_sale_id` (`sale_id`),
  KEY `payment_method_id_payment_sales` (`payment_method_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_sales`
--

INSERT INTO `payment_sales` (`id`, `user_id`, `account_id`, `date`, `Ref`, `sale_id`, `montant`, `change`, `payment_method_id`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 0, '2025-07-03 06:28:00', 'INV/SL-20250703-624787', 1, 5645, 0, 6, '', '2025-07-02 15:30:31.000000', '2025-07-02 15:30:31.000000', NULL),
(2, 1, 0, '2025-07-03 10:45:00', 'INV/SL-20250703-343109', 10, 6049, 0, 3, '', '2025-07-02 19:47:47.000000', '2025-07-02 19:47:47.000000', NULL),
(3, 1, 0, '2025-07-03 10:49:00', 'INV/SL-20250703-354508', 11, 5500, 0, 1, '', '2025-07-02 19:50:22.000000', '2025-07-02 19:50:22.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_sale_returns`
--

DROP TABLE IF EXISTS `payment_sale_returns`;
CREATE TABLE IF NOT EXISTS `payment_sale_returns` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `account_id` int DEFAULT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sale_return_id` int NOT NULL,
  `montant` double NOT NULL,
  `change` double NOT NULL DEFAULT '0',
  `payment_method_id` int NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `factures_sale_return_user_id` (`user_id`),
  KEY `payment_sale_returns_account_id` (`account_id`),
  KEY `factures_sale_return` (`sale_return_id`),
  KEY `payment_method_id_payment_sale_returns` (`payment_method_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=210 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pos_settings`
--

DROP TABLE IF EXISTS `pos_settings`;
CREATE TABLE IF NOT EXISTS `pos_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `note_customer` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Thank You For Shopping With Us . Please Come Again',
  `show_note` tinyint(1) NOT NULL DEFAULT '1',
  `show_barcode` tinyint(1) NOT NULL DEFAULT '1',
  `show_discount` tinyint(1) NOT NULL DEFAULT '1',
  `show_customer` tinyint(1) NOT NULL DEFAULT '1',
  `show_email` tinyint(1) NOT NULL DEFAULT '1',
  `show_phone` tinyint(1) NOT NULL DEFAULT '1',
  `show_address` tinyint(1) NOT NULL DEFAULT '1',
  `show_Warehouse` tinyint(1) NOT NULL DEFAULT '1',
  `is_printable` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pos_settings`
--

INSERT INTO `pos_settings` (`id`, `note_customer`, `show_note`, `show_barcode`, `show_discount`, `show_customer`, `show_email`, `show_phone`, `show_address`, `show_Warehouse`, `is_printable`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Thank You For Shopping With Us . Please Come Again', 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'is_single' COMMENT 'is_single, is_service, is_variant, stitched_garment, unstitched_garment',
  `garment_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'shalwar_suit, pant_shirt',
  `code` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Type_barcode` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `category_id` int NOT NULL,
  `sub_category_id` bigint UNSIGNED DEFAULT NULL,
  `brand_id` int DEFAULT NULL,
  `unit_id` int DEFAULT NULL,
  `unit_sale_id` int DEFAULT NULL,
  `unit_purchase_id` int DEFAULT NULL,
  `TaxNet` decimal(10,2) DEFAULT '0.00',
  `tax_method` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `image` text COLLATE utf8mb4_unicode_ci,
  `note` text COLLATE utf8mb4_unicode_ci,
  `stock_alert` decimal(10,2) DEFAULT '0.00',
  `qty_min` decimal(10,2) DEFAULT '0.00',
  `is_promo` tinyint(1) NOT NULL DEFAULT '0',
  `promo_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `promo_start_date` date DEFAULT NULL,
  `promo_end_date` date DEFAULT NULL,
  `is_variant` tinyint(1) NOT NULL DEFAULT '0',
  `is_imei` tinyint(1) NOT NULL DEFAULT '0',
  `not_selling` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_visible` tinyint(1) NOT NULL DEFAULT '1',
  `kameez_length` decimal(10,2) DEFAULT NULL,
  `kameez_shoulder` decimal(10,2) DEFAULT NULL,
  `kameez_sleeves` decimal(10,2) DEFAULT NULL,
  `kameez_chest` decimal(10,2) DEFAULT NULL,
  `kameez_upper_waist` decimal(10,2) DEFAULT NULL,
  `kameez_lower_waist` decimal(10,2) DEFAULT NULL,
  `kameez_hip` decimal(10,2) DEFAULT NULL,
  `kameez_neck` decimal(10,2) DEFAULT NULL,
  `kameez_arms` decimal(10,2) DEFAULT NULL,
  `kameez_cuff` decimal(10,2) DEFAULT NULL,
  `kameez_biceps` decimal(10,2) DEFAULT NULL,
  `shalwar_length` decimal(10,2) DEFAULT NULL,
  `shalwar_waist` decimal(10,2) DEFAULT NULL,
  `shalwar_bottom` decimal(10,2) DEFAULT NULL,
  `collar_shirt` tinyint(1) NOT NULL DEFAULT '0',
  `collar_sherwani` tinyint(1) NOT NULL DEFAULT '0',
  `collar_damian` tinyint(1) NOT NULL DEFAULT '0',
  `collar_round` tinyint(1) NOT NULL DEFAULT '0',
  `collar_square` tinyint(1) NOT NULL DEFAULT '0',
  `pshirt_length` decimal(10,2) DEFAULT NULL,
  `pshirt_shoulder` decimal(10,2) DEFAULT NULL,
  `pshirt_sleeves` decimal(10,2) DEFAULT NULL,
  `pshirt_chest` decimal(10,2) DEFAULT NULL,
  `pshirt_neck` decimal(10,2) DEFAULT NULL,
  `pshirt_collar_shirt` tinyint(1) NOT NULL DEFAULT '0',
  `pshirt_collar_round` tinyint(1) NOT NULL DEFAULT '0',
  `pshirt_collar_square` tinyint(1) NOT NULL DEFAULT '0',
  `pant_length` decimal(10,2) DEFAULT NULL,
  `pant_waist` decimal(10,2) DEFAULT NULL,
  `pant_hip` decimal(10,2) DEFAULT NULL,
  `pant_thai` decimal(10,2) DEFAULT NULL,
  `pant_knee` decimal(10,2) DEFAULT NULL,
  `pant_bottom` decimal(10,2) DEFAULT NULL,
  `pant_fly` decimal(10,2) DEFAULT NULL,
  `thaan_length` decimal(10,2) DEFAULT '22.50',
  `suit_length` decimal(10,2) DEFAULT '4.50',
  `available_sizes` json DEFAULT NULL COMMENT 'Available sizes (S, M, L, XL)',
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `product_type` enum('stitched','unstitched') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'stitched',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `brand_id_products` (`brand_id`),
  KEY `unit_id_products` (`unit_id`),
  KEY `unit_id_sales` (`unit_sale_id`),
  KEY `unit_purchase_products` (`unit_purchase_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `type`, `garment_type`, `code`, `Type_barcode`, `name`, `cost`, `price`, `category_id`, `sub_category_id`, `brand_id`, `unit_id`, `unit_sale_id`, `unit_purchase_id`, `TaxNet`, `tax_method`, `image`, `note`, `stock_alert`, `qty_min`, `is_promo`, `promo_price`, `promo_start_date`, `promo_end_date`, `is_variant`, `is_imei`, `not_selling`, `is_active`, `is_visible`, `kameez_length`, `kameez_shoulder`, `kameez_sleeves`, `kameez_chest`, `kameez_upper_waist`, `kameez_lower_waist`, `kameez_hip`, `kameez_neck`, `kameez_arms`, `kameez_cuff`, `kameez_biceps`, `shalwar_length`, `shalwar_waist`, `shalwar_bottom`, `collar_shirt`, `collar_sherwani`, `collar_damian`, `collar_round`, `collar_square`, `pshirt_length`, `pshirt_shoulder`, `pshirt_sleeves`, `pshirt_chest`, `pshirt_neck`, `pshirt_collar_shirt`, `pshirt_collar_round`, `pshirt_collar_square`, `pant_length`, `pant_waist`, `pant_hip`, `pant_thai`, `pant_knee`, `pant_bottom`, `pant_fly`, `thaan_length`, `suit_length`, `available_sizes`, `created_at`, `updated_at`, `deleted_at`, `product_type`) VALUES
(1, 'unstitched_garment', NULL, '62427561', '', 'Fabrics', '1000.00', '1500.00', 1, 1, 1, 1, 3, 2, '0.00', '1', '1751880452.png', '', '450.00', '1.00', 0, '0.00', NULL, NULL, 0, 1, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '22.50', '4.50', '\"[\\\"S\\\",\\\"M\\\",\\\"L\\\",\\\"XL\\\"]\"', '2025-07-07 09:27:32.000000', '2025-07-07 09:27:32.000000', NULL, 'stitched'),
(2, 'stitched_garment', 'shalwar_suit', '80585975', '', 'shalwar/kameez', '1000.00', '1500.00', 1, 2, 1, 1, 1, 2, '0.00', '1', '1751880788.png', 'dnjdsjksdkjbvks', '100.00', '1.00', 0, '0.00', NULL, NULL, 0, 1, 0, 1, 1, '22.00', '22.00', '22.00', '22.00', '22.00', '22.00', '22.00', '22.00', '22.00', '22.00', '22.00', '22.00', '22.00', '22.00', 0, 1, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '22.50', '4.50', NULL, '2025-07-07 09:33:08.000000', '2025-07-07 09:33:08.000000', NULL, 'stitched'),
(3, 'is_single', NULL, '24236515', '', 'Fabrics', '2000.00', '2500.00', 1, 2, 1, 1, 3, 1, '10.00', '1', '1753006869.png', 'kdjdsndsn', '100.00', '1.00', 0, '0.00', NULL, NULL, 0, 1, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '22.50', '4.50', NULL, '2025-07-20 10:21:09.000000', '2025-07-20 10:21:09.000000', NULL, 'stitched');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
CREATE TABLE IF NOT EXISTS `product_images` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` bigint UNSIGNED NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image`, `created_at`, `updated_at`) VALUES
(1, 1, '1751880452_686b9304ee058.png', '2025-07-07 09:27:32', '2025-07-07 09:27:32'),
(2, 2, '1751880788_686b94540b453.png', '2025-07-07 09:33:08', '2025-07-07 09:33:08'),
(3, 3, '1753006869_687cc31524437.png', '2025-07-20 10:21:09', '2025-07-20 10:21:09');

-- --------------------------------------------------------

--
-- Table structure for table `product_ledgers`
--

DROP TABLE IF EXISTS `product_ledgers`;
CREATE TABLE IF NOT EXISTS `product_ledgers` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date NOT NULL,
  `quantity_in` int NOT NULL DEFAULT '0',
  `quantity_out` int NOT NULL DEFAULT '0',
  `balance` int DEFAULT NULL,
  `logged_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `customer_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_ledgers_product_id_foreign` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_ledgers`
--

INSERT INTO `product_ledgers` (`id`, `product_id`, `type`, `reference`, `date`, `quantity_in`, `quantity_out`, `balance`, `logged_at`, `created_at`, `updated_at`, `customer_name`, `product_code`) VALUES
(1, 1, 'sale', 'SO-20250707-1', '2025-07-07', 0, 5, -5, '2025-07-07 09:28:53', '2025-07-07 09:28:53', '2025-07-07 09:28:53', 'sudais ahmed', '62427561'),
(2, 2, 'sale', 'SO-20250707-2', '2025-07-07', 0, 2, -2, '2025-07-07 09:33:55', '2025-07-07 09:33:55', '2025-07-07 09:33:55', 'sudais ahmed', '80585975');

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

DROP TABLE IF EXISTS `product_variants`;
CREATE TABLE IF NOT EXISTS `product_variants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost` double DEFAULT '0',
  `price` double DEFAULT '0',
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id_variant` (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_warehouse`
--

DROP TABLE IF EXISTS `product_warehouse`;
CREATE TABLE IF NOT EXISTS `product_warehouse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `product_variant_id` int DEFAULT NULL,
  `qte` double NOT NULL DEFAULT '0',
  `manage_stock` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_warehouse_id` (`product_id`),
  KEY `warehouse_id` (`warehouse_id`),
  KEY `product_variant_id` (`product_variant_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_warehouse`
--

INSERT INTO `product_warehouse` (`id`, `product_id`, `warehouse_id`, `product_variant_id`, `qte`, `manage_stock`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, NULL, 445.5, 1, '2025-07-07 09:27:32.000000', '2025-07-07 09:28:53.000000', NULL),
(2, 2, 1, NULL, 98, 1, '2025-07-07 09:33:08.000000', '2025-07-07 09:33:55.000000', NULL),
(3, 3, 1, NULL, 100, 1, '2025-07-20 10:21:09.000000', '2025-07-20 10:21:09.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `providers`
--

DROP TABLE IF EXISTS `providers`;
CREATE TABLE IF NOT EXISTS `providers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `providers_user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `provider_ledgers`
--

DROP TABLE IF EXISTS `provider_ledgers`;
CREATE TABLE IF NOT EXISTS `provider_ledgers` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `provider_id` int NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date NOT NULL DEFAULT '2025-07-07',
  `debit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `credit` decimal(15,2) NOT NULL DEFAULT '0.00',
  `balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `provider_ledgers_provider_id_index` (`provider_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
CREATE TABLE IF NOT EXISTS `purchases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `Ref` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `provider_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `tax_rate` double DEFAULT '0',
  `TaxNet` double DEFAULT '0',
  `discount` double DEFAULT '0',
  `discount_type` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_percent_total` double DEFAULT '0',
  `shipping` double DEFAULT '0',
  `GrandTotal` double NOT NULL,
  `paid_amount` double NOT NULL DEFAULT '0',
  `statut` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_statut` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_purchases` (`user_id`),
  KEY `provider_id` (`provider_id`),
  KEY `warehouse_id_purchase` (`warehouse_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_details`
--

DROP TABLE IF EXISTS `purchase_details`;
CREATE TABLE IF NOT EXISTS `purchase_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `cost` double NOT NULL,
  `purchase_unit_id` int DEFAULT NULL,
  `TaxNet` double DEFAULT '0',
  `tax_method` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `discount` double DEFAULT '0',
  `discount_method` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `purchase_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_variant_id` int DEFAULT NULL,
  `imei_number` text COLLATE utf8mb4_unicode_ci,
  `total` double NOT NULL,
  `quantity` double NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_unit_id_purchase` (`purchase_unit_id`),
  KEY `purchase_id` (`purchase_id`),
  KEY `product_id` (`product_id`),
  KEY `purchase_product_variant_id` (`product_variant_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_returns`
--

DROP TABLE IF EXISTS `purchase_returns`;
CREATE TABLE IF NOT EXISTS `purchase_returns` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchase_id` int DEFAULT NULL,
  `provider_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `tax_rate` double DEFAULT '0',
  `TaxNet` double DEFAULT '0',
  `discount` double DEFAULT '0',
  `discount_type` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_percent_total` double DEFAULT '0',
  `shipping` double DEFAULT '0',
  `GrandTotal` double NOT NULL,
  `paid_amount` double NOT NULL DEFAULT '0',
  `payment_statut` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `statut` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_returns` (`user_id`),
  KEY `purchase_id_purchase_returns` (`purchase_id`),
  KEY `provider_id_return` (`provider_id`),
  KEY `purchase_return_warehouse_id` (`warehouse_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return_details`
--

DROP TABLE IF EXISTS `purchase_return_details`;
CREATE TABLE IF NOT EXISTS `purchase_return_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cost` decimal(16,3) NOT NULL,
  `purchase_unit_id` int DEFAULT NULL,
  `TaxNet` double DEFAULT '0',
  `tax_method` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `discount` double DEFAULT '0',
  `discount_method` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `total` double NOT NULL,
  `quantity` double NOT NULL,
  `purchase_return_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_variant_id` int DEFAULT NULL,
  `imei_number` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `unit_id_purchase_return_details` (`purchase_unit_id`),
  KEY `purchase_return_id_return` (`purchase_return_id`),
  KEY `product_id_details_purchase_return` (`product_id`),
  KEY `purchase_return_product_variant_id` (`product_variant_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

DROP TABLE IF EXISTS `quotations`;
CREATE TABLE IF NOT EXISTS `quotations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `tax_rate` double DEFAULT '0',
  `TaxNet` double DEFAULT '0',
  `discount` double DEFAULT '0',
  `discount_type` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_percent_total` double DEFAULT '0',
  `shipping` double DEFAULT '0',
  `GrandTotal` double NOT NULL,
  `statut` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_quotation` (`user_id`),
  KEY `client_id_quotation` (`client_id`),
  KEY `warehouse_id_quotation` (`warehouse_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quotations`
--

INSERT INTO `quotations` (`id`, `user_id`, `date`, `Ref`, `client_id`, `warehouse_id`, `tax_rate`, `TaxNet`, `discount`, `discount_type`, `discount_percent_total`, `shipping`, `GrandTotal`, `statut`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '2025-04-26 16:34:00', 'QT_1111', 2, 1, 0, 0, 0, 'fixed', 0, 0, 303, 'pending', '', '2025-04-25 20:34:37.000000', '2025-04-25 20:34:37.000000', NULL),
(2, 1, '2025-04-26 20:56:00', 'QT_1112', 2, 1, 0, 0, 0, 'fixed', 0, 0, 300, 'pending', '', '2025-04-26 00:57:10.000000', '2025-04-26 00:57:10.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quotation_details`
--

DROP TABLE IF EXISTS `quotation_details`;
CREATE TABLE IF NOT EXISTS `quotation_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `price` double NOT NULL,
  `sale_unit_id` int DEFAULT NULL,
  `TaxNet` double DEFAULT '0',
  `tax_method` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `discount` double DEFAULT '0',
  `discount_method` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `total` double NOT NULL,
  `quantity` double NOT NULL,
  `product_id` int NOT NULL,
  `product_variant_id` int DEFAULT NULL,
  `imei_number` text COLLATE utf8mb4_unicode_ci,
  `quotation_id` int NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_unit_id_quotation` (`sale_unit_id`),
  KEY `product_id_quotation_details` (`product_id`),
  KEY `quote_product_variant_id` (`product_variant_id`),
  KEY `quotation_id` (`quotation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `rating` tinyint NOT NULL COMMENT '1 to 5',
  `comment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reviews_user_id_foreign` (`user_id`),
  KEY `reviews_product_id_foreign` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `product_id`, `rating`, `comment`, `created_at`, `updated_at`) VALUES
(2, 1, 3, 4, 'mdkfksdgjfjjsgsfhgjhsjgskjghjshgjkehuhjdhgjhkghdjghugehjhgdjkhuehguehuhguurghuhgur', '2025-07-30 13:20:50', '2025-07-30 13:20:50');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `guard_name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Super Admin', 'Super Admin', 'web', NULL, NULL, NULL),
(2, 'Sales man', 'Generate Sales leads , Delivering goods and  collect payment.', 'web', '2025-05-17 19:13:57.000000', '2025-05-22 00:31:05.000000', NULL),
(3, 'Pos\'s operator', 'RECORD SALES', 'web', '2025-06-12 06:39:06.000000', '2025-06-12 06:39:06.000000', NULL),
(4, 'Customer', 'Customer who purchases items', 'web', '2025-07-31 10:13:18.000000', '2025-07-31 10:13:18.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

DROP TABLE IF EXISTS `sales`;
CREATE TABLE IF NOT EXISTS `sales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_pos` tinyint(1) DEFAULT '0',
  `client_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `tax_rate` double DEFAULT '0',
  `TaxNet` double DEFAULT '0',
  `discount` double DEFAULT '0',
  `discount_type` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_percent_total` double DEFAULT '0',
  `shipping` double DEFAULT '0',
  `GrandTotal` double NOT NULL DEFAULT '0',
  `paid_amount` double NOT NULL DEFAULT '0',
  `payment_statut` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `statut` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `shirt_length` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_shoulder` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_sleeves` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_chest` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_upper_waist` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_lower_waist` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_hip` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_neck` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_arms` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_cuff` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_biceps` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_collar_type` enum('Shirt','Sherwani') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_daman_type` enum('Round','Square') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pant_length` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pant_waist` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pant_hip` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pant_thigh` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pant_knee` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pant_bottom` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pant_fly` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_sales` (`user_id`),
  KEY `sale_client_id` (`client_id`),
  KEY `warehouse_id_sale` (`warehouse_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `user_id`, `date`, `Ref`, `is_pos`, `client_id`, `warehouse_id`, `tax_rate`, `TaxNet`, `discount`, `discount_type`, `discount_percent_total`, `shipping`, `GrandTotal`, `paid_amount`, `payment_statut`, `statut`, `notes`, `created_at`, `updated_at`, `deleted_at`, `shirt_length`, `shirt_shoulder`, `shirt_sleeves`, `shirt_chest`, `shirt_upper_waist`, `shirt_lower_waist`, `shirt_hip`, `shirt_neck`, `shirt_arms`, `shirt_cuff`, `shirt_biceps`, `shirt_collar_type`, `shirt_daman_type`, `pant_length`, `pant_waist`, `pant_hip`, `pant_thigh`, `pant_knee`, `pant_bottom`, `pant_fly`) VALUES
(1, 1, '2025-07-07 14:28:00', 'SO-20250707-1', 0, 1, 1, 0, 0, 0, 'fixed', 0, 0, 6750, 0, 'unpaid', 'completed', 'jsihfh', '2025-07-07 09:28:53.000000', '2025-07-07 09:28:53.000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 1, '2025-07-07 14:33:00', 'SO-20250707-2', 0, 1, 1, 0, 0, 0, 'fixed', 0, 0, 3000, 0, 'unpaid', 'completed', 'njkbcjsdkbsdj', '2025-07-07 09:33:55.000000', '2025-07-07 09:33:55.000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sale_details`
--

DROP TABLE IF EXISTS `sale_details`;
CREATE TABLE IF NOT EXISTS `sale_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `sale_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_variant_id` int DEFAULT NULL,
  `imei_number` text COLLATE utf8mb4_unicode_ci,
  `price` double NOT NULL,
  `sale_unit_id` int DEFAULT NULL,
  `TaxNet` double DEFAULT NULL,
  `tax_method` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `discount` double DEFAULT NULL,
  `discount_method` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `total` double NOT NULL,
  `quantity` double NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Details_Sale_id` (`sale_id`),
  KEY `sale_product_id` (`product_id`),
  KEY `sale_product_variant_id` (`product_variant_id`),
  KEY `sales_sale_unit_id` (`sale_unit_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_details`
--

INSERT INTO `sale_details` (`id`, `date`, `sale_id`, `product_id`, `product_variant_id`, `imei_number`, `price`, `sale_unit_id`, `TaxNet`, `tax_method`, `discount`, `discount_method`, `total`, `quantity`, `created_at`, `updated_at`) VALUES
(1, '2025-07-07 14:28:00', 1, 1, 0, '2222', 6750, 3, 0, '1', 0, '2', 6750, 1, NULL, NULL),
(2, '2025-07-07 14:33:00', 2, 2, 0, '2222222222', 1500, 1, 0, '1', 0, '2', 3000, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sale_returns`
--

DROP TABLE IF EXISTS `sale_returns`;
CREATE TABLE IF NOT EXISTS `sale_returns` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `date` datetime NOT NULL,
  `Ref` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sale_id` int DEFAULT NULL,
  `client_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `tax_rate` double DEFAULT '0',
  `TaxNet` double DEFAULT '0',
  `discount` double DEFAULT '0',
  `discount_type` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_percent_total` double DEFAULT '0',
  `shipping` double DEFAULT '0',
  `GrandTotal` double NOT NULL,
  `paid_amount` double NOT NULL DEFAULT '0',
  `payment_statut` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `statut` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_returns` (`user_id`),
  KEY `sale_id_return_sales` (`sale_id`),
  KEY `client_id_returns` (`client_id`),
  KEY `warehouse_id_sale_return_id` (`warehouse_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sale_return_details`
--

DROP TABLE IF EXISTS `sale_return_details`;
CREATE TABLE IF NOT EXISTS `sale_return_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sale_return_id` int NOT NULL,
  `product_id` int NOT NULL,
  `price` double NOT NULL,
  `sale_unit_id` int DEFAULT NULL,
  `TaxNet` double DEFAULT '0',
  `tax_method` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `discount` double DEFAULT '0',
  `discount_method` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `product_variant_id` int DEFAULT NULL,
  `imei_number` text COLLATE utf8mb4_unicode_ci,
  `quantity` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `return_id` (`sale_return_id`),
  KEY `product_id_details_returns` (`product_id`),
  KEY `sale_unit_id_return_details` (`sale_unit_id`),
  KEY `sale_return_id_product_variant_id` (`product_variant_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `currency_id` int DEFAULT NULL,
  `client_id` int DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `app_name` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CompanyName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CompanyPhone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CompanyAdress` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_footer` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `developed_by` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_language` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `default_sms_gateway` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol_placement` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'before',
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `settings_currency_id` (`currency_id`),
  KEY `settings_client_id` (`client_id`),
  KEY `settings_warehouse_id` (`warehouse_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `currency_id`, `client_id`, `warehouse_id`, `email`, `app_name`, `CompanyName`, `CompanyPhone`, `CompanyAdress`, `logo`, `invoice_footer`, `footer`, `developed_by`, `default_language`, `default_sms_gateway`, `symbol_placement`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 1, 4, 'admin@birdcoders.com', 'Master Material', 'Master Material', '+9203708655901', 'Karachi Pakistan', '1745664460.png', NULL, 'The Lakhas -  Inventory Management', 'Driestech', 'en', 'twilio', 'before', NULL, '2025-05-28 03:01:03.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sms_messages`
--

DROP TABLE IF EXISTS `sms_messages`;
CREATE TABLE IF NOT EXISTS `sms_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `sub_categories`
--

DROP TABLE IF EXISTS `sub_categories`;
CREATE TABLE IF NOT EXISTS `sub_categories` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` int UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_categories_slug_unique` (`slug`),
  KEY `sub_categories_category_id_foreign` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`id`, `category_id`, `name`, `slug`, `image`, `created_at`, `updated_at`) VALUES
(1, 1, 'paint Shirt', 'paint-shirt', 'sub_categories/szCrEOPZqbCpSsPqmYkk5Ccw2cBfvjrh8tXls5Fs.png', '2025-07-07 09:17:52', '2025-07-07 09:17:52'),
(2, 1, 'shalwar/kameez', 'shalwarkameez', 'sub_categories/Tx4Cc193pvSKWXx4elBXPsrwuex0zCdaUs90mL0o.png', '2025-07-07 09:30:11', '2025-07-07 09:30:11');

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

DROP TABLE IF EXISTS `transfers`;
CREATE TABLE IF NOT EXISTS `transfers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `Ref` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `from_warehouse_id` int NOT NULL,
  `to_warehouse_id` int NOT NULL,
  `items` double NOT NULL,
  `tax_rate` double DEFAULT '0',
  `TaxNet` double DEFAULT '0',
  `discount` double DEFAULT '0',
  `discount_type` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_percent_total` double DEFAULT '0',
  `shipping` double DEFAULT '0',
  `GrandTotal` double NOT NULL DEFAULT '0',
  `statut` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_transfers` (`user_id`),
  KEY `from_warehouse_id` (`from_warehouse_id`),
  KEY `to_warehouse_id` (`to_warehouse_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transfer_details`
--

DROP TABLE IF EXISTS `transfer_details`;
CREATE TABLE IF NOT EXISTS `transfer_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transfer_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_variant_id` int DEFAULT NULL,
  `cost` double NOT NULL,
  `purchase_unit_id` int DEFAULT NULL,
  `TaxNet` double DEFAULT NULL,
  `tax_method` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `discount` double DEFAULT NULL,
  `discount_method` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `quantity` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transfer_id` (`transfer_id`),
  KEY `product_id_transfers` (`product_id`),
  KEY `product_variant_id_transfer` (`product_variant_id`),
  KEY `unit_sale_id_transfer` (`purchase_unit_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
CREATE TABLE IF NOT EXISTS `units` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ShortName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_unit` int DEFAULT NULL,
  `operator` char(192) COLLATE utf8mb4_unicode_ci DEFAULT '*',
  `operator_value` double DEFAULT '1',
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `base_unit` (`base_unit`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `name`, `ShortName`, `base_unit`, `operator`, `operator_value`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Meter', 'm', NULL, '*', 1, '2025-07-07 09:18:36.000000', '2025-07-07 09:18:36.000000', NULL),
(2, 'Than', 'than', 1, '*', 22.5, '2025-07-07 09:20:24.000000', '2025-07-07 09:20:24.000000', NULL),
(3, 'Suit', 'suit', 1, '*', 4.5, '2025-07-07 09:20:52.000000', '2025-07-07 09:20:52.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` datetime DEFAULT NULL,
  `avatar` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `role_users_id` bigint UNSIGNED NOT NULL,
  `is_all_warehouses` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_role_users_id` (`role_users_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `email_verified_at`, `avatar`, `status`, `role_users_id`, `is_all_warehouses`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Usama Shaikh', 'admin@birdcoders.com', '2025-06-11 15:20:53', 'no_avatar.png', 1, 1, 1, '$2y$10$IFj6SwqC0Sxrsiv4YkCt.OJv1UV4mZrWuyLoRG7qt47mseP9mJ58u', NULL, '2025-05-31 03:41:50.000000', '2025-05-31 03:41:50.000000', NULL),
(4, 'Demo Driver', 'driver@gmail.com', '2025-06-11 15:21:05', 'no_avatar.png', 1, 2, 1, '$2y$10$Bp.wlndcyU5SU8ej0Zikz.w4QeDFenMEn27q7UV2Cn.FtsffMyPBu', NULL, '2025-05-17 19:14:47.000000', '2025-07-14 18:25:59.000000', NULL),
(5, 'HASSAN', 'hasan@db.com', '2025-06-11 15:21:09', 'no_avatar.png', 0, 1, 0, '$2y$10$EOZ9LVuz8/4EEPdtuw7cSOQKjb8lPHBMeCzvjXVjUeTlKehvhI4Dq', NULL, '2025-05-21 03:52:09.000000', '2025-07-31 09:53:56.000000', '2025-07-31 09:53:56'),
(6, 'saqib', 'saqib@db.com', '2025-06-11 15:21:09', '1748264712.jpg', 0, 5, 1, '$2y$10$uNAz5l36jQ.tk70NHUuhAu1i8YNaLloG40QkyfDi2U3HWwBNHwX.y', NULL, '2025-05-22 00:35:29.000000', '2025-06-11 21:37:38.000000', '2025-06-11 21:37:38'),
(7, 'aqib', 'aqib@db.com', '2025-06-11 15:21:09', 'no_avatar.png', 0, 5, 0, '$2y$10$Fa6wZJr.oYNOSu4pOdV5sOMi1vLbORvZGDx6lfbBGqBBbzhe33AEK', NULL, '2025-05-22 00:38:29.000000', '2025-06-11 21:37:33.000000', '2025-06-11 21:37:33'),
(8, 'saif', 'saif@db.com', '2025-06-11 15:21:09', 'no_avatar.png', 0, 5, 0, '$2y$10$AC87B7jOpLOHnXYXsm8qfe7GDY1O8brp9uD.ADvm91iIb37aKveAq', NULL, '2025-05-22 01:22:02.000000', '2025-06-11 21:37:27.000000', '2025-06-11 21:37:27'),
(12, 'Point of sales', 'pos@db.com', NULL, 'no_avatar.png', 1, 2, 1, '$2y$10$tsWRzRv7yJqZBR3V8NrGA.5m37RUlppbh//nLP2P9b9qP5KL2jxHS', NULL, '2025-06-12 06:34:41.000000', '2025-07-31 10:09:06.000000', NULL),
(13, 'Sudais Ahmed', 'sudais@example.com', NULL, NULL, 1, 0, 0, '$2y$10$al.IMmKyqBz35tFQA6Vi9.XU5NycEEJimzNqHU3sHBQZSwlv7RDFG', NULL, '2025-07-30 19:08:27.000000', '2025-07-30 19:16:28.000000', NULL),
(16, 'Sudais Ahmed', 'sudaisahmad2514@gmail.com', '2025-07-01 15:23:59', NULL, 1, 4, 1, '$2y$10$/vvZsIyceERoQjefi1t85e7meJAtkYd9GpgfILHZuN7/umn2w1WJC', NULL, '2025-07-31 10:21:23.000000', '2025-07-31 10:57:40.000000', NULL),
(18, 'Sudais Ahmed', 'sudais2201a@aptechgdn.net', '2025-07-01 23:51:27', NULL, 1, 4, 0, '$2y$10$fyACNneHxemOREycerqFD.hQkDrQSIfMNX6Vt0ofypOu2nX6MZYje', 'GyyVUrleF7X0eQNNFJ7j6f2c01YhSyoiK9I6LMyamwpiBBbzr3vQosFkCsWn', '2025-07-31 18:45:36.000000', '2025-07-31 18:45:36.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_warehouse`
--

DROP TABLE IF EXISTS `user_warehouse`;
CREATE TABLE IF NOT EXISTS `user_warehouse` (
  `user_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  KEY `user_warehouse_user_id` (`user_id`),
  KEY `user_warehouse_warehouse_id` (`warehouse_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

DROP TABLE IF EXISTS `warehouses`;
CREATE TABLE IF NOT EXISTS `warehouses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `name`, `city`, `mobile`, `zip`, `email`, `country`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Fabrics', 'Karachi', '0399999900090', '75660', 'admin@birdcoders.com', 'Pakistan', '2025-07-02 04:26:55.000000', '2025-07-02 04:26:55.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

DROP TABLE IF EXISTS `wishlists`;
CREATE TABLE IF NOT EXISTS `wishlists` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wishlists_user_id_product_id_unique` (`user_id`,`product_id`),
  KEY `wishlists_product_id_foreign` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wishlists`
--

INSERT INTO `wishlists` (`id`, `user_id`, `product_id`, `created_at`, `updated_at`) VALUES
(9, 1, 3, '2025-07-29 14:31:30', '2025-07-29 14:31:30'),
(10, 1, 2, '2025-07-30 14:39:30', '2025-07-30 14:39:30');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
