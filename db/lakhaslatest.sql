-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 03, 2025 at 06:11 AM
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
(1, 1, '2025-07-03 05:45:00', 'AD_1111', 1, 1, 'vvgvgvgg', '2025-07-02 19:46:09.000000', '2025-07-02 19:46:09.000000', NULL);

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
(1, 'Fabrics', 'hjhhghhghghghghgh', '1751466382.png', '2025-07-02 09:26:22.000000', '2025-07-02 09:26:22.000000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_category_id` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `code`, `name`, `image`, `sub_category_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '6765778', 'Fabrics', '1751466329.png', 0, '2025-07-02 09:25:29.000000', '2025-07-02 09:25:29.000000', NULL);

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
(1, 1, 'sudais ahmed', '1', 1, '1751483569.png', 'sudais@example.com', NULL, 'Karachi', '03000002000', 'najdhfjkhkfj', '2025-07-02 14:12:49.000000', '2025-07-02 14:12:49.000000', NULL);

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
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients_ledgers`
--

INSERT INTO `clients_ledgers` (`id`, `client_id`, `type`, `reference`, `date`, `debit`, `credit`, `balance`, `created_at`, `updated_at`) VALUES
(1, 1, 'pos_sale', 'SO-20250703-1', '2025-07-02 20:30:31', '5645.00', '0.00', '5645.00', '2025-07-02 20:30:31', '2025-07-02 20:30:31'),
(2, 1, 'sale', 'SO-20250703-2', '2025-07-02 21:37:50', '11236.00', '0.00', '16881.00', '2025-07-02 21:37:50', '2025-07-02 21:37:50'),
(3, 1, 'sale', 'SO-20250703-3', '2025-07-02 22:12:13', '11056.00', '0.00', '27937.00', '2025-07-02 22:12:13', '2025-07-02 22:12:13'),
(4, 1, 'sale', 'SO-20250703-4', '2025-07-02 22:23:15', '11100.00', '0.00', '39037.00', '2025-07-02 22:23:15', '2025-07-02 22:23:15'),
(5, 1, 'sale', 'SO-20250703-5', '2025-07-02 23:21:18', '6339.00', '0.00', '45376.00', '2025-07-02 23:21:18', '2025-07-02 23:21:18'),
(6, 1, 'sale', 'SO-20250703-6', '2025-07-02 23:28:17', '6239.00', '0.00', '51615.00', '2025-07-02 23:28:17', '2025-07-02 23:28:17'),
(7, 1, 'sale', 'SO-20250703-7', '2025-07-02 23:49:59', '0.00', '0.00', '51615.00', '2025-07-02 23:49:59', '2025-07-02 23:49:59'),
(8, 1, 'sale', 'SO-20250703-8', '2025-07-02 23:49:59', '0.00', '0.00', '51615.00', '2025-07-02 23:49:59', '2025-07-02 23:49:59'),
(9, 1, 'sale', 'SO-20250703-9', '2025-07-03 00:20:08', '11189.00', '0.00', '62804.00', '2025-07-03 00:20:08', '2025-07-03 00:20:08'),
(10, 1, 'pos_sale', 'SO-20250703-10', '2025-07-03 00:47:47', '6049.00', '0.00', '68853.00', '2025-07-03 00:47:47', '2025-07-03 00:47:47'),
(11, 1, 'pos_sale', 'SO-20250703-11', '2025-07-03 00:50:22', '5500.00', '0.00', '74353.00', '2025-07-03 00:50:22', '2025-07-03 00:50:22');

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
) ENGINE=MyISAM AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(69, '2023_06_15_231341_add_foreign_keys_to_role_has_permissions_table', 1),
(68, '2023_06_15_231341_add_foreign_keys_to_quotations_table', 1),
(67, '2023_06_15_231341_add_foreign_keys_to_quotation_details_table', 1),
(66, '2023_06_15_231341_add_foreign_keys_to_purchases_table', 1),
(65, '2023_06_15_231341_add_foreign_keys_to_purchase_returns_table', 1),
(64, '2023_06_15_231341_add_foreign_keys_to_purchase_return_details_table', 1),
(63, '2023_06_15_231341_add_foreign_keys_to_purchase_details_table', 1),
(62, '2023_06_15_231341_add_foreign_keys_to_providers_table', 1),
(61, '2023_06_15_231341_add_foreign_keys_to_products_table', 1),
(60, '2023_06_15_231341_add_foreign_keys_to_product_warehouse_table', 1),
(59, '2023_06_15_231341_add_foreign_keys_to_product_variants_table', 1),
(58, '2023_06_15_231341_add_foreign_keys_to_payment_sales_table', 1),
(57, '2023_06_15_231341_add_foreign_keys_to_payment_sale_returns_table', 1),
(56, '2023_06_15_231341_add_foreign_keys_to_payment_purchases_table', 1),
(55, '2023_06_15_231341_add_foreign_keys_to_payment_purchase_returns_table', 1),
(54, '2023_06_15_231341_add_foreign_keys_to_model_has_roles_table', 1),
(53, '2023_06_15_231341_add_foreign_keys_to_model_has_permissions_table', 1),
(52, '2023_06_15_231341_add_foreign_keys_to_expenses_table', 1),
(51, '2023_06_15_231341_add_foreign_keys_to_deposits_table', 1),
(50, '2023_06_15_231341_add_foreign_keys_to_clients_table', 1),
(49, '2023_06_15_231341_add_foreign_keys_to_adjustments_table', 1),
(48, '2023_06_15_231341_add_foreign_keys_to_adjustment_details_table', 1),
(47, '2023_06_15_231338_create_warehouses_table', 1),
(46, '2023_06_15_231338_create_users_table', 1),
(45, '2023_06_15_231338_create_user_warehouse_table', 1),
(44, '2023_06_15_231338_create_units_table', 1),
(43, '2023_06_15_231338_create_transfers_table', 1),
(42, '2023_06_15_231338_create_transfer_details_table', 1),
(41, '2023_06_15_231338_create_sms_messages_table', 1),
(40, '2023_06_15_231338_create_settings_table', 1),
(39, '2023_06_15_231338_create_sales_table', 1),
(38, '2023_06_15_231338_create_sale_returns_table', 1),
(37, '2023_06_15_231338_create_sale_return_details_table', 1),
(36, '2023_06_15_231338_create_sale_details_table', 1),
(35, '2023_06_15_231338_create_roles_table', 1),
(34, '2023_06_15_231338_create_role_has_permissions_table', 1),
(33, '2023_06_15_231338_create_quotations_table', 1),
(32, '2023_06_15_231338_create_quotation_details_table', 1),
(31, '2023_06_15_231338_create_purchases_table', 1),
(30, '2023_06_15_231338_create_purchase_returns_table', 1),
(29, '2023_06_15_231338_create_purchase_return_details_table', 1),
(28, '2023_06_15_231338_create_purchase_details_table', 1),
(27, '2023_06_15_231338_create_providers_table', 1),
(26, '2023_06_15_231338_create_products_table', 1),
(25, '2023_06_15_231338_create_product_warehouse_table', 1),
(24, '2023_06_15_231338_create_product_variants_table', 1),
(23, '2023_06_15_231338_create_pos_settings_table', 1),
(22, '2023_06_15_231338_create_permissions_table', 1),
(21, '2023_06_15_231338_create_payment_sales_table', 1),
(20, '2023_06_15_231338_create_payment_sale_returns_table', 1),
(19, '2023_06_15_231338_create_payment_purchases_table', 1),
(18, '2023_06_15_231338_create_payment_purchase_returns_table', 1),
(17, '2023_06_15_231338_create_payment_methods_table', 1),
(16, '2023_06_15_231338_create_password_resets_table', 1),
(15, '2023_06_15_231338_create_model_has_roles_table', 1),
(14, '2023_06_15_231338_create_model_has_permissions_table', 1),
(13, '2023_06_15_231338_create_expenses_table', 1),
(12, '2023_06_15_231338_create_expense_categories_table', 1),
(11, '2023_06_15_231338_create_email_messages_table', 1),
(10, '2023_06_15_231338_create_deposits_table', 1),
(9, '2023_06_15_231338_create_deposit_categories_table', 1),
(8, '2023_06_15_231338_create_currencies_table', 1),
(7, '2023_06_15_231338_create_clients_table', 1),
(6, '2023_06_15_231338_create_categories_table', 1),
(5, '2023_06_15_231338_create_brands_table', 1),
(4, '2023_06_15_231338_create_adjustments_table', 1),
(3, '2023_06_15_231338_create_adjustment_details_table', 1),
(2, '2023_06_15_231338_create_accounts_table', 1),
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1),
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
(5, 'Cheque', 0, NULL, '2025-05-26 16:00:39.000000', NULL),
(6, 'Cash', 0, NULL, NULL, NULL),
(7, 'gy', 0, '2025-05-30 14:58:56.000000', '2025-05-30 14:59:02.000000', '2025-05-30 14:59:02');

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
(1, 1, 0, '2025-07-03 06:28:00', 'INV/SL-20250703-624787', 1, 5645, 0, 6, '', '2025-07-02 20:30:31.000000', '2025-07-02 20:30:31.000000', NULL),
(2, 1, 0, '2025-07-03 10:45:00', 'INV/SL-20250703-343109', 10, 6049, 0, 3, '', '2025-07-03 00:47:47.000000', '2025-07-03 00:47:47.000000', NULL),
(3, 1, 0, '2025-07-03 10:49:00', 'INV/SL-20250703-354508', 11, 5500, 0, 1, '', '2025-07-03 00:50:22.000000', '2025-07-03 00:50:22.000000', NULL);

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
  `type` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `garment_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'shirt_suit, pant_shalwar',
  `code` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Type_barcode` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(192) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cost` double NOT NULL,
  `price` double NOT NULL,
  `category_id` int NOT NULL,
  `brand_id` int DEFAULT NULL,
  `unit_id` int DEFAULT NULL,
  `unit_sale_id` int DEFAULT NULL,
  `unit_purchase_id` int DEFAULT NULL,
  `TaxNet` double DEFAULT '0',
  `tax_method` varchar(192) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `image` text COLLATE utf8mb4_unicode_ci,
  `note` text COLLATE utf8mb4_unicode_ci,
  `stock_alert` double DEFAULT '0',
  `qty_min` double DEFAULT '0',
  `is_promo` tinyint(1) NOT NULL DEFAULT '0',
  `promo_price` double NOT NULL DEFAULT '0',
  `promo_start_date` date DEFAULT NULL,
  `promo_end_date` date DEFAULT NULL,
  `is_variant` tinyint(1) NOT NULL DEFAULT '0',
  `is_imei` tinyint(1) NOT NULL DEFAULT '0',
  `not_selling` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `is_visible` tinyint(1) NOT NULL DEFAULT '1',
  `shirt_length` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_shoulder` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_sleeves` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_chest` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_upper_waist` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_lower_waist` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_hip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_neck` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_arms` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_cuff` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shirt_biceps` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pant_length` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pant_waist` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pant_hip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pant_thai` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pant_knee` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pant_bottom` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pant_fly` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collar_shirt` tinyint(1) NOT NULL DEFAULT '0',
  `collar_sherwani` tinyint(1) NOT NULL DEFAULT '0',
  `collar_damian` tinyint(1) NOT NULL DEFAULT '0',
  `collar_round` tinyint(1) NOT NULL DEFAULT '0',
  `collar_square` tinyint(1) NOT NULL DEFAULT '0',
  `thaan_length` decimal(10,2) DEFAULT '22.50',
  `suit_length` decimal(10,2) DEFAULT '4.50',
  `available_sizes` json DEFAULT NULL COMMENT 'Available sizes for unstitched garments',
  `created_at` timestamp(6) NULL DEFAULT NULL,
  `updated_at` timestamp(6) NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
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

INSERT INTO `products` (`id`, `type`, `garment_type`, `code`, `Type_barcode`, `name`, `cost`, `price`, `category_id`, `brand_id`, `unit_id`, `unit_sale_id`, `unit_purchase_id`, `TaxNet`, `tax_method`, `image`, `note`, `stock_alert`, `qty_min`, `is_promo`, `promo_price`, `promo_start_date`, `promo_end_date`, `is_variant`, `is_imei`, `not_selling`, `is_active`, `is_visible`, `shirt_length`, `shirt_shoulder`, `shirt_sleeves`, `shirt_chest`, `shirt_upper_waist`, `shirt_lower_waist`, `shirt_hip`, `shirt_neck`, `shirt_arms`, `shirt_cuff`, `shirt_biceps`, `pant_length`, `pant_waist`, `pant_hip`, `pant_thai`, `pant_knee`, `pant_bottom`, `pant_fly`, `collar_shirt`, `collar_sherwani`, `collar_damian`, `collar_round`, `collar_square`, `thaan_length`, `suit_length`, `available_sizes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'stitched_garment', 'shirt_suit', '50260853', 'CODE128', 'Fabrics', 2000, 2500, 1, 1, 1, 1, 1, 10, '1', '1751466541.png', 'njsvfvjfjhjfhvjv', 600, 2, 0, 0, NULL, NULL, 0, 1, 0, 1, 1, '22', '22', '22', '22', '22', '22', '22', '22', '22', '22', '22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 1, 0, '22.50', '4.50', NULL, '2025-07-02 09:29:01.000000', '2025-07-02 09:29:01.000000', NULL),
(2, 'unstitched_garment', NULL, '71634818', 'CODE128', 'Fabrics2', 2000, 2500, 1, 1, 1, 1, 1, 10, '2', '1751466640.png', '', 20, 4, 0, 0, NULL, NULL, 0, 1, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, '22.50', '4.50', '\"[\\\"S\\\",\\\"M\\\",\\\"L\\\",\\\"XL\\\"]\"', '2025-07-02 09:30:40.000000', '2025-07-02 09:30:40.000000', NULL),
(3, 'is_single', NULL, '73039371', 'CODE128', 'Fabrics3', 2000, 2500, 1, 1, 1, 1, 1, 10, '1', '1751466752.png', 'ndvjnfjnjf', 300, 3, 0, 0, NULL, NULL, 0, 1, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, '22.50', '4.50', NULL, '2025-07-02 09:32:33.000000', '2025-07-02 09:32:33.000000', NULL);

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
(1, 1, '1751466541_6865422d5c5fc.png', '2025-07-02 09:29:01', '2025-07-02 09:29:01'),
(2, 2, '1751466640_6865429028da8.png', '2025-07-02 09:30:40', '2025-07-02 09:30:40'),
(3, 3, '1751466753_68654301041ca.png', '2025-07-02 09:32:33', '2025-07-02 09:32:33');

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
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_ledgers`
--

INSERT INTO `product_ledgers` (`id`, `product_id`, `type`, `reference`, `date`, `quantity_in`, `quantity_out`, `balance`, `logged_at`, `created_at`, `updated_at`, `customer_name`, `product_code`) VALUES
(1, 2, 'adjustment', 'AD_1111', '2025-07-03', 4, 0, 4, '2025-07-03 00:46:09', '2025-07-02 19:46:09', '2025-07-02 19:46:09', NULL, NULL),
(2, 1, 'pos', 'SO-20250703-1', '2025-07-03', 0, 2, -2, '2025-07-03 01:30:31', '2025-07-02 20:30:31', '2025-07-02 20:30:31', 'sudais ahmed', '50260853'),
(3, 1, 'sale', 'SO-20250703-2', '2025-07-03', 0, 2, -4, '2025-07-03 02:37:50', '2025-07-02 21:37:50', '2025-07-02 21:37:50', 'sudais ahmed', '50260853'),
(4, 1, 'sale', 'SO-20250703-3', '2025-07-03', 0, 2, -6, '2025-07-03 03:12:13', '2025-07-02 22:12:13', '2025-07-02 22:12:13', 'sudais ahmed', '50260853'),
(5, 1, 'sale', 'SO-20250703-4', '2025-07-03', 0, 2, -8, '2025-07-03 03:23:15', '2025-07-02 22:23:15', '2025-07-02 22:23:15', 'sudais ahmed', '50260853'),
(6, 1, 'sale', 'SO-20250703-5', '2025-07-03', 0, 2, -10, '2025-07-03 04:21:18', '2025-07-02 23:21:18', '2025-07-02 23:21:18', 'sudais ahmed', '50260853'),
(7, 1, 'sale', 'SO-20250703-6', '2025-07-03', 0, 2, -12, '2025-07-03 04:28:17', '2025-07-02 23:28:17', '2025-07-02 23:28:17', 'sudais ahmed', '50260853'),
(8, 2, 'sale', 'SO-20250703-9', '2025-07-03', 0, 4, 0, '2025-07-03 05:20:08', '2025-07-03 00:20:08', '2025-07-03 00:20:08', 'sudais ahmed', '71634818'),
(9, 1, 'pos', 'SO-20250703-10', '2025-07-03', 0, 2, -14, '2025-07-03 05:47:47', '2025-07-03 00:47:47', '2025-07-03 00:47:47', 'sudais ahmed', '50260853'),
(10, 1, 'pos', 'SO-20250703-11', '2025-07-03', 0, 2, -16, '2025-07-03 05:50:22', '2025-07-03 00:50:22', '2025-07-03 00:50:22', 'sudais ahmed', '50260853');

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
(1, 1, 1, NULL, 1184, 1, '2025-07-02 09:29:01.000000', '2025-07-03 00:50:22.000000', NULL),
(2, 2, 1, NULL, 1, 1, '2025-07-02 09:30:40.000000', '2025-07-03 00:20:08.000000', NULL),
(3, 3, 1, NULL, 4, 1, '2025-07-02 09:32:33.000000', '2025-07-02 09:32:33.000000', NULL);

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
  `date` date NOT NULL DEFAULT '2025-07-02',
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
(1, 1, '2025-04-26 16:34:00', 'QT_1111', 2, 1, 0, 0, 0, 'fixed', 0, 0, 303, 'pending', '', '2025-04-26 01:34:37.000000', '2025-04-26 01:34:37.000000', NULL),
(2, 1, '2025-04-26 20:56:00', 'QT_1112', 2, 1, 0, 0, 0, 'fixed', 0, 0, 300, 'pending', '', '2025-04-26 05:57:10.000000', '2025-04-26 05:57:10.000000', NULL);

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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(5, 'Sales man', 'Generate Sales leads , Delivering goods and  collect payment.', 'web', '2025-05-18 00:13:57.000000', '2025-05-22 05:31:05.000000', NULL),
(6, 'Pos\'s operator', 'RECORD SALES', 'web', '2025-06-12 11:39:06.000000', '2025-06-12 11:39:06.000000', NULL);

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
  `assigned_driver` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_sales` (`user_id`),
  KEY `sale_client_id` (`client_id`),
  KEY `warehouse_id_sale` (`warehouse_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `user_id`, `date`, `Ref`, `is_pos`, `client_id`, `warehouse_id`, `tax_rate`, `TaxNet`, `discount`, `discount_type`, `discount_percent_total`, `shipping`, `GrandTotal`, `paid_amount`, `payment_statut`, `statut`, `notes`, `created_at`, `updated_at`, `deleted_at`, `shirt_length`, `shirt_shoulder`, `shirt_sleeves`, `shirt_chest`, `shirt_upper_waist`, `shirt_lower_waist`, `shirt_hip`, `shirt_neck`, `shirt_arms`, `shirt_cuff`, `shirt_biceps`, `shirt_collar_type`, `shirt_daman_type`, `pant_length`, `pant_waist`, `pant_hip`, `pant_thigh`, `pant_knee`, `pant_bottom`, `pant_fly`, `assigned_driver`) VALUES
(1, 1, '2025-07-03 06:28:00', 'SO-20250703-1', 1, 1, 1, 10, 495, 10, 'percent', 550, 200, 5645, 5645, 'paid', 'completed', '', '2025-07-02 20:30:31.000000', '2025-07-02 20:30:31.000000', NULL, '22', '22', '22', '22', '22', '22', '22', '22', '22', '22', '22', 'Shirt', 'Round', '22', '22', '22', '22', '22', '22', '22', NULL),
(2, 1, '2025-07-05 07:11:00', 'SO-20250703-2', 0, 1, 1, 100, 5468, 10, 'fixed', 0, 300, 11236, 0, 'unpaid', 'completed', 'nvjjdvjbvjvbbvb', '2025-07-02 21:37:50.000000', '2025-07-02 21:37:50.000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 1, '2025-07-04 08:09:00', 'SO-20250703-3', 0, 1, 1, 100, 5378, 100, 'fixed', 0, 300, 11056, 0, 'unpaid', 'completed', 'hjvhjhjhjvhjhvjvfhj', '2025-07-02 22:12:13.000000', '2025-07-02 22:12:13.000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, '2025-07-03 08:22:00', 'SO-20250703-4', 0, 1, 1, 100, 5400, 100, 'fixed', 0, 300, 11100, 0, 'unpaid', 'completed', 'nvjnfjnvfjf', '2025-07-02 22:23:15.000000', '2025-07-02 22:23:15.000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Demo Driver'),
(5, 1, '2025-07-03 09:17:00', 'SO-20250703-5', 0, 1, 1, 10, 549, 10, 'fixed', 0, 300, 6339, 0, 'unpaid', 'completed', 'hhhhh', '2025-07-02 23:21:18.000000', '2025-07-02 23:21:18.000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Demo Driver'),
(6, 1, '2025-07-03 09:24:00', 'SO-20250703-6', 0, 1, 1, 10, 549, 10, 'fixed', 0, 200, 6239, 0, 'unpaid', 'completed', 'jhjchjhdhhcjd', '2025-07-02 23:28:17.000000', '2025-07-02 23:28:17.000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(7, 1, '2025-07-03 09:49:00', 'SO-20250703-7', 0, 1, 1, 0, 0, 0, 'fixed', 0, 0, 0, 0, 'unpaid', 'completed', '', '2025-07-02 23:49:59.000000', '2025-07-02 23:49:59.000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(8, 1, '2025-07-03 09:49:00', 'SO-20250703-8', 0, 1, 1, 0, 0, 0, 'fixed', 0, 0, 0, 0, 'unpaid', 'completed', '', '2025-07-02 23:49:59.000000', '2025-07-02 23:49:59.000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, ''),
(9, 1, '2025-07-03 10:18:00', 'SO-20250703-9', 0, 1, 1, 10, 999, 10, 'fixed', 0, 200, 11189, 0, 'unpaid', 'completed', 'dnjhfhufh', '2025-07-03 00:20:08.000000', '2025-07-03 00:20:08.000000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Demo Driver'),
(10, 1, '2025-07-03 10:45:00', 'SO-20250703-10', 1, 1, 1, 10, 549, 10, 'fixed', 0, 10, 6049, 6049, 'paid', 'completed', '', '2025-07-03 00:47:47.000000', '2025-07-03 00:47:47.000000', NULL, '22', '22', '22', '22', '22', '22', '22', '22', '22', '22', '22', 'Shirt', 'Round', '', '', '', '', '', '', '', NULL),
(11, 1, '2025-07-03 10:49:00', 'SO-20250703-11', 1, 1, 1, 0, 0, 0, 'fixed', 0, 0, 5500, 5500, 'paid', 'completed', '', '2025-07-03 00:50:22.000000', '2025-07-03 00:50:22.000000', NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', NULL);

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
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_details`
--

INSERT INTO `sale_details` (`id`, `date`, `sale_id`, `product_id`, `product_variant_id`, `imei_number`, `price`, `sale_unit_id`, `TaxNet`, `tax_method`, `discount`, `discount_method`, `total`, `quantity`, `created_at`, `updated_at`) VALUES
(1, '2025-07-03 06:28:00', 1, 1, NULL, '', 2500, 1, 10, '1', 0, '2', 5500, 2, NULL, NULL),
(2, '2025-07-05 07:11:00', 2, 1, NULL, '099900000', 2500, 1, 10, '1', 10, '2', 5478, 2, NULL, NULL),
(3, '2025-07-04 08:09:00', 3, 1, NULL, '09999000', 2500, 1, 10, '1', 10, '2', 5478, 2, NULL, NULL),
(4, '2025-07-03 08:22:00', 4, 1, NULL, '', 2500, 1, 10, '1', 0, '2', 5500, 2, NULL, NULL),
(5, '2025-07-03 09:17:00', 5, 1, NULL, '', 2500, 1, 10, '1', 0, '2', 5500, 2, NULL, NULL),
(6, '2025-07-03 09:24:00', 6, 1, NULL, '50260853', 2500, 1, 10, '1', 0, '2', 5500, 2, NULL, NULL),
(7, '2025-07-03 10:18:00', 9, 2, NULL, '71634818', 2500, 1, 10, '2', 0, '2', 10000, 4, NULL, NULL),
(8, '2025-07-03 10:45:00', 10, 1, NULL, '', 2500, 1, 10, '1', 0, '2', 5500, 2, NULL, NULL),
(9, '2025-07-03 10:49:00', 11, 1, NULL, '', 2500, 1, 10, '1', 0, '2', 5500, 2, NULL, NULL);

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
(1, 2, 1, 4, 'admin@birdcoders.com', 'Master Material', 'Master Material', '+9203708655901', 'Karachi Pakistan', '1745664460.png', NULL, 'The Lakhas -  Inventory Management', 'Driestech', 'en', 'twilio', 'before', NULL, '2025-05-28 08:01:03.000000', NULL);

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
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_categories_slug_unique` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `name`, `ShortName`, `base_unit`, `operator`, `operator_value`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Fabrics', 'sudais', NULL, '*', 1, '2025-07-02 09:25:55.000000', '2025-07-02 09:25:55.000000', NULL);

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
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `email_verified_at`, `avatar`, `status`, `role_users_id`, `is_all_warehouses`, `password`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Usama Shaikh', 'admin@birdcoders.com', '2025-06-11 15:20:53', 'no_avatar.png', 1, 1, 1, '$2y$10$IFj6SwqC0Sxrsiv4YkCt.OJv1UV4mZrWuyLoRG7qt47mseP9mJ58u', NULL, '2025-05-31 08:41:50.000000', '2025-05-31 08:41:50.000000', NULL),
(4, 'Demo Driver', 'driver@gmail.com', '2025-06-11 15:21:05', 'no_avatar.png', 1, 5, 1, '$2y$10$Bp.wlndcyU5SU8ej0Zikz.w4QeDFenMEn27q7UV2Cn.FtsffMyPBu', NULL, '2025-05-18 00:14:47.000000', '2025-06-01 08:01:38.000000', NULL),
(5, 'HASSAN', 'hasan@db.com', '2025-06-11 15:21:09', 'no_avatar.png', 1, 1, 0, '$2y$10$EOZ9LVuz8/4EEPdtuw7cSOQKjb8lPHBMeCzvjXVjUeTlKehvhI4Dq', NULL, '2025-05-21 08:52:09.000000', '2025-06-12 11:30:57.000000', NULL),
(6, 'saqib', 'saqib@db.com', '2025-06-11 15:21:09', '1748264712.jpg', 0, 5, 1, '$2y$10$uNAz5l36jQ.tk70NHUuhAu1i8YNaLloG40QkyfDi2U3HWwBNHwX.y', NULL, '2025-05-22 05:35:29.000000', '2025-06-12 02:37:38.000000', '2025-06-12 02:37:38'),
(7, 'aqib', 'aqib@db.com', '2025-06-11 15:21:09', 'no_avatar.png', 0, 5, 0, '$2y$10$Fa6wZJr.oYNOSu4pOdV5sOMi1vLbORvZGDx6lfbBGqBBbzhe33AEK', NULL, '2025-05-22 05:38:29.000000', '2025-06-12 02:37:33.000000', '2025-06-12 02:37:33'),
(8, 'saif', 'saif@db.com', '2025-06-11 15:21:09', 'no_avatar.png', 0, 5, 0, '$2y$10$AC87B7jOpLOHnXYXsm8qfe7GDY1O8brp9uD.ADvm91iIb37aKveAq', NULL, '2025-05-22 06:22:02.000000', '2025-06-12 02:37:27.000000', '2025-06-12 02:37:27'),
(12, 'Point of sales', 'pos@db.com', NULL, 'no_avatar.png', 1, 6, 1, '$2y$10$tsWRzRv7yJqZBR3V8NrGA.5m37RUlppbh//nLP2P9b9qP5KL2jxHS', NULL, '2025-06-12 11:34:41.000000', '2025-06-12 11:39:26.000000', NULL);

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

--
-- Dumping data for table `user_warehouse`
--

INSERT INTO `user_warehouse` (`user_id`, `warehouse_id`) VALUES
(5, 4);

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
(1, 'Fabrics', 'Karachi', '0399999900090', '75660', 'admin@birdcoders.com', 'Pakistan', '2025-07-02 09:26:55.000000', '2025-07-02 09:26:55.000000', NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
