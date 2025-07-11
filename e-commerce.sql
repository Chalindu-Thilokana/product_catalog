-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 11, 2025 at 05:56 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `e-commerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item_oders`
--

CREATE TABLE `item_oders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item_oders`
--

INSERT INTO `item_oders` (`id`, `order_id`, `product_id`, `quantity`, `price`, `created_at`, `updated_at`) VALUES
(13, 69, 4, 1, 150000.00, '2025-07-11 10:25:17', '2025-07-11 10:25:17');

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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2025_07_09_075525_create_sessions_table', 1),
(7, '2025_07_09_084753_create_products_table', 1),
(8, '2025_07_10_101852_create_orders_table', 2),
(9, '2025_07_11_100454_create_item_oders_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `total`, `created_at`, `updated_at`) VALUES
(69, 7, 150000.00, '2025-07-11 10:25:17', '2025-07-11 10:25:17');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `photo`, `created_at`, `updated_at`) VALUES
(3, 'iphone 6s', 'Apple iPhone 6s Price in Sri Lanka. Compare Best price', 25000.00, 44, 'products/MW3fn4Tt3YrQVBYbuaCsCcUNHylSQcXHjdhuxFr7.jpg', '2025-07-11 07:50:25', '2025-07-11 07:57:08'),
(4, 'samsung s25', 'samsung s25', 150000.00, 49, 'products/lx5Ro4PNvd2hBbuwAzm1iu4AahLEXtYHKitCieMl.jpg', '2025-07-11 09:21:40', '2025-07-11 10:25:17'),
(5, 'i phone xs', 'Super Retina OLED, HDR10, Dolby Vision, 625 nits (HBM)\r\nSize	5.8 inches, 84.4 cm2 (~82.9% screen-to-body ratio)\r\nResolution	1125 x 2436 pixels,', 800000.00, 60, 'products/qbHtO3jcONqSak3On70CwnB07pf3h2x9cD0aQ6WE.jpg', '2025-07-11 09:29:25', '2025-07-11 09:29:25'),
(6, 'i phone 14', 'i phone 14 brand new', 50000000.00, 56666, 'products/WAFtQyjISU6NqgftJpjFpy6CBT3TuojwM7no8SX3.jpg', '2025-07-11 09:30:00', '2025-07-11 09:30:00'),
(7, 'i phone xs max', 'new brand new i phone', 85000000.00, 56, 'products/whlWzk8e9Oux1tu64PNn14P1Ko1yxekLYYKf3WOl.jpg', '2025-07-11 09:30:41', '2025-07-11 09:30:41'),
(8, 'i phone 14', 'new phone', 150000.00, 52, 'products/RTnc7pf4kRpv0NmIb3uigN6FHl2DuExulkETMloa.jpg', '2025-07-11 09:31:08', '2025-07-11 09:31:08'),
(9, 'samsung galxy s2s', 'new brand new phoner get one get free', 750000.00, 20, 'products/tjaHBPf8ZyfRyy66GZNpiQfQhOQYF3brTycfFEFm.jpg', '2025-07-11 09:32:00', '2025-07-11 09:32:00'),
(10, 'samsung galxy', 'ew phoner get one get free', 65000.00, 20, 'products/bUXJmB3Jm7kXMlhZfgmqT09daD9FwCbLjkV6qPh8.jpg', '2025-07-11 09:32:26', '2025-07-11 09:32:26'),
(11, 'i phone se2', 'recondition i phone . not used sri lanka', 45000.00, 45, 'products/WO2URhwC8wIC06eHT3IEUQbq2mTLbvaiEz4LRFit.jpg', '2025-07-11 09:33:32', '2025-07-11 09:33:32'),
(12, 'i phone se 2020', 'recondition i phone . not used sri lanka', 25000.00, 45, 'products/Ikbu8TCnrf2ZwMQGSkynL3UflLgC1PggP0JuTyG6.jpg', '2025-07-11 09:33:58', '2025-07-11 09:33:58'),
(13, 'i phone 7', 'recondtion ueds in sri lanka', 20000.00, 12, 'products/e0laHk93Byu57VoJC4aJiv0I2eDlma1xOizyAtv8.jpg', '2025-07-11 09:34:59', '2025-07-11 09:34:59'),
(14, 'i phone xs', 'new phone', 590000.00, 15, 'products/PMuUStWmdwd7kcs019jbhiF2PwoAi7OQrIEDVYCn.jpg', '2025-07-11 09:41:04', '2025-07-11 09:41:04'),
(15, 'apple 8 plus', 'used in indea', 40000.00, 25, 'products/j79ujh6UKwvBPCmCMnBZKRMRHYfEdRMky4m9Vain.jpg', '2025-07-11 09:42:38', '2025-07-11 09:42:38'),
(16, 'aplle 6', 'new phone', 8500.00, 60, 'products/x0FLBv1UVqXMzpsMXfJkSATAlLw7ugugoIH5qaJs.jpg', '2025-07-11 09:45:16', '2025-07-11 09:45:16');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('1s5bRvH3xPaSE23livRpAeDJpoeVDVue3m9vu8X8', 7, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36 Edg/138.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZHNGQlRtUlRVZlZnUUpGajhVNVFQVFFQTUNiSDlaRWhJUjhiWGdoUSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6NztzOjIxOiJwYXNzd29yZF9oYXNoX3NhbmN0dW0iO3M6NjA6IiQyeSQxMCRxM2w4U0EvbXZncTdUcTRuVzIvOXUuTFNqempCOFM2TXpOMDZRWjJoLlRLc2dYakhCZC9oNiI7fQ==', 1752249320),
('9SnahvtYvT8uTOMmYOsquTnviL1PaCy5h8s0tUa5', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Avast/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYWhNcHF5Um40TFVZcHpweFpTczM0UTRSQksxMGU4OWN0Um0yanp5UyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1752247555),
('MLCRCYSKpTCkB3DNw568uurXnvpc03Nh532eVigG', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Avast/137.0.0.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiclBxZWd3aW5kNm9tdE1laWlVVnlsSXZOa2RHZ2ZQTGVlZ1Q1YWtZMyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1752247557),
('yeAkIACkIrJjjuxlF31PLvd6vOEceQSXrZ65TxvL', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Avast/137.0.0.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoidGpSb3hEWXBrMzh1WE5weWM5dGlLSkNtTXBVVUgyZVB6cGkxdm1iZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9DYXJ0X2luZGV4Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MztzOjIxOiJwYXNzd29yZF9oYXNoX3NhbmN0dW0iO3M6NjA6IiQyeSQxMCRlYmJqYUNUNENPV1J2Nms3MWlKQjQub1dVQWttcnlJYWd5QjRUMnYxYy4yVGlBSHRGOUJyZSI7fQ==', 1752248651);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) DEFAULT NULL,
  `usertype` varchar(255) NOT NULL DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `current_team_id`, `profile_photo_path`, `usertype`, `created_at`, `updated_at`) VALUES
(3, 'chalindu', 'testadmin@gmail.com', NULL, '$2y$10$ebbjaCT4COWRv6k71iJB4.oWUAkmryIagyB4T2v1c.2TiAHtF9Bre', NULL, NULL, NULL, 'Oy47LOq3zQ8Bwwd5bZAyJWzaKPmkkX3LhrvzqIUbYQAHTEEDuEB1PPq4iufg', NULL, NULL, 'admin', '2025-07-11 09:18:52', '2025-07-11 09:18:52'),
(4, 'test user', 'user@gmail.com', NULL, '$2y$10$VHYCPzBD6Fy8K1Ptw8XHbOcwNVyKL62OZhcta8B56n3/B6YTN5vLK', NULL, NULL, NULL, NULL, NULL, NULL, 'user', '2025-07-11 10:10:47', '2025-07-11 10:10:47'),
(5, 'testbot', 'test@gmail.com', NULL, '$2y$10$uyB/15T.hBjhEa1f/5wdI.6qH..JSczxqgzFTVNeDBObocERecH8y', NULL, NULL, NULL, 'JRGnzmv4dC3K41dJ5qDQqmkIIA9PkHbBN7qUyZEl2o5ofTLlfgnpb1UsX4RD', NULL, NULL, 'user', '2025-07-11 10:12:33', '2025-07-11 10:12:33'),
(6, 'test', 'tes@gmail.com', NULL, '$2y$10$nZPWTwEM8DoJUEHsBlArtOIeATT3dBRsPO5WynZZ0bYxXEB41Y/jW', NULL, NULL, NULL, NULL, NULL, NULL, 'user', '2025-07-11 10:20:45', '2025-07-11 10:20:45'),
(7, 'cahata', 'tset4@gmail.com', NULL, '$2y$10$q3l8SA/mvgq7Tq4nW2/9u.LSjzjB8S6MzN06QZ2h.TKsgXjHBd/h6', NULL, NULL, NULL, NULL, NULL, NULL, 'user', '2025-07-11 10:25:03', '2025-07-11 10:25:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `item_oders`
--
ALTER TABLE `item_oders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_oders_order_id_foreign` (`order_id`),
  ADD KEY `item_oders_product_id_foreign` (`product_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `item_oders`
--
ALTER TABLE `item_oders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `item_oders`
--
ALTER TABLE `item_oders`
  ADD CONSTRAINT `item_oders_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `item_oders_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
