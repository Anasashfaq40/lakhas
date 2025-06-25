-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 23, 2025 at 11:26 PM
-- Server version: 10.4.27-MariaDB
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `account_ledgers`
--
ALTER TABLE `account_ledgers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `adjustments`
--
ALTER TABLE `adjustments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `adjustment_details`
--
ALTER TABLE `adjustment_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clients_ledgers`
--
ALTER TABLE `clients_ledgers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposit_categories`
--
ALTER TABLE `deposit_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_messages`
--
ALTER TABLE `email_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_purchase_returns`
--
ALTER TABLE `payment_purchase_returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_sales`
--
ALTER TABLE `payment_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_sale_returns`
--
ALTER TABLE `payment_sale_returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_ledgers`
--
ALTER TABLE `product_ledgers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `providers`
--
ALTER TABLE `providers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `provider_ledgers`
--
ALTER TABLE `provider_ledgers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_details`
--
ALTER TABLE `purchase_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_return_details`
--
ALTER TABLE `purchase_return_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sale_details`
--
ALTER TABLE `sale_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sale_returns`
--
ALTER TABLE `sale_returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sale_return_details`
--
ALTER TABLE `sale_return_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transfer_details`
--
ALTER TABLE `transfer_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
