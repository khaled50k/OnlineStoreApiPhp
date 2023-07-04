-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 08, 2023 at 07:23 PM
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
-- Database: `onlinestore`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `created_at`) VALUES
(38, 11, '2023-06-06 17:44:46');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `images` longtext CHARACTER SET utf8 COLLATE utf8_vietnamese_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `title`, `description`, `images`) VALUES
(7, 'Women\'s Clothing', 'Dress to impress with our collection of women\'s clothing, which combines timeless styles with modern elements and trendy designs. Sorting your weekday outfit dilemmas with sophisticated trousers and blouses, layered with jackets, to adding instant flair in your off-duty wardrobe with tops, jeans, sweatshirts and casual dresses, we have everything you need for a seasonal upgrade. Our stunning dresses are ideal for the party season; pair with tights and the perfect lingerie for an impeccable silhouette, and complete the look with our coats and accessories. Discover must-have jumpers in the cutest designs and layering options to keep you warm and snug all season long. With stripes, polka dots, solid hues, embellishments and warm textures, you\'re sure to love our classy collection.', '[{\"url\":\"https:\\/\\/tailwindui.com\\/img\\/ecommerce-images\\/home-page-04-collection-01.jpg\"}]'),
(8, 'Men\'s Clothing', 'At Next, we’re here to fill your wardrobe with the latest trends and styles. For your casual collection explore polos, T-shirts, and find your (perfect) fit with our extensive range of denim jeans. Whether your work is strictly formal or a little more laidback, we have sharp suits, tailored trousers, crisp shirts and waistcoats that can also double for your occasionwear. Find your feet with a pair of timeless Oxfords, Derby shoes or easy-going pumps, don’t forget to accessorise with the latest bags and watches. Take care of your night time routine with comfy pyjamas and cosy slippers.', '[{\"url\":\"https:\\/\\/tailwindui.com\\/img\\/ecommerce-images\\/home-page-04-collection-02.jpg\"}]'),
(10, 'Anniversary Gifts', 'Celebrate with anniversary gifts from our range. Make your day special with wedding anniversary gifts, whether it’s 25th, 50th or the first - there’s something beautiful for your better half. Unique gift ideas to wines and necklaces mark your day with gorgeous presents. Make anniversary gifts for him and her extra special with personalised gifting options.', '[{\"url\":\"https:\\/\\/xcdn.next.co.uk\\/Common\\/Items\\/Default\\/Default\\/ItemImages\\/Search\\/224x336\\/298543.jpg?im=Resize,width=450\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `colors`
--

CREATE TABLE `colors` (
  `id` int(11) NOT NULL,
  `color` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` int(11) NOT NULL,
  `discount` int(11) NOT NULL DEFAULT 0,
  `stock` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`images`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `description`, `price`, `discount`, `stock`, `created_at`, `images`) VALUES
(14, 'Essential Stretch Jeans', 'Show Less\nDesigned for all-day comfort and style, our essential stretch jeans have an authentic look and feel. The go-to wardrobe staple that never lets you down.\n\nMade from cotton-rich denim and woven with stretch for added comfort. Our variety of fits, colours and leg lengths ensures you can find the perfect match to suit your style.\n\nFeaturing traditional five-pocket styling, belt loops, rivets for extra durability, and plenty of pockets to hold your essentials. Forever Dark™ technology helps your jeans to maintain their colour and stay dark for a minimum of 20 washes.', 28, 0, 1020, '2023-05-25 13:26:00', '[{\"url\":\"https:\\/\\/img.shop.com\\/Image\\/250000\\/253200\\/253251\\/products\\/1938893011.jpg?plain&size=400x400\"}]'),
(16, 'L\'Homme  Eau De Toilette and  Hair and Body Wash Gift Set', 'Set contains 100ml EDT and 200ml Hair and Body wash. The scent: A rich and spicy blend of masculine woods, enticing oriental spices and handsome musks. Fragrance notes: Top- Ozonic, Mid- Lavender & Cardomom, Base- Sandalwood & Patchouli. For reasons of hygiene this product cannot be returned if unwrapped or unsealed, unless faulty. Discontinue use if irritation occurs.', 18, 0, 1040, '2023-05-26 05:40:37', '[{\"url\":\"http:\\/\\/localhost\\/e-commerce-php\\/app\\/upload\\/13735123c2b2fc07.webp\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`product_id`, `category_id`, `id`) VALUES
(14, 8, 61),
(16, 10, 66);

-- --------------------------------------------------------

--
-- Table structure for table `product_colors`
--

CREATE TABLE `product_colors` (
  `product_id` int(11) NOT NULL,
  `color_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_sizes`
--

CREATE TABLE `product_sizes` (
  `product_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sizes`
--

CREATE TABLE `sizes` (
  `id` int(11) NOT NULL,
  `size` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `revoked` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tokens`
--

INSERT INTO `tokens` (`id`, `user_id`, `token`, `expiration_date`, `revoked`, `created_at`, `updated_at`) VALUES
(16, 8, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6OCwidXNlcm5hbWUiOiJhc2RhYTIiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE2ODQ4NjUzMTUsImV4cCI6MTY4NzQ1NzMxNX0.aWHT3E2fo4jFWjy3xIFN0L0YplhBfyHpHxf_V__A6Xo', '2023-06-22 18:08:35', 1, '2023-05-23 18:08:35', '2023-05-24 04:24:48'),
(17, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NDg2NjU0NiwiZXhwIjoxNjg3NDU4NTQ2fQ.TmH-qOm0JwFSVLaP192q3bumVRTVTbw7eFtswvh2CBE', '2023-06-22 18:29:06', 1, '2023-05-23 18:29:06', '2023-05-23 18:35:32'),
(18, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NDg2NjU3NCwiZXhwIjoxNjg3NDU4NTc0fQ.PxECYaUdmE0TCrv2rsQgJfFbHinbcsLSgGNmwA6MWXA', '2023-06-22 18:29:34', 1, '2023-05-23 18:29:34', '2023-05-23 18:35:32'),
(19, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwidXNlcm5hbWUiOiJhc2RhYTIxIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg0ODY2OTMyLCJleHAiOjE2ODc0NTg5MzJ9.GssYL7Wx02Dk-q1SiKXoqlWCBUkNo-7mEzVXqwDFpCg', '2023-06-22 18:35:32', 1, '2023-05-23 18:35:32', '2023-05-23 18:35:45'),
(20, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NDg2NjkzNiwiZXhwIjoxNjg3NDU4OTM2fQ.wuVb4miosXQvjs1zXT65psGPVwuXwjvRJrgSU-Z3qZU', '2023-06-22 18:35:36', 1, '2023-05-23 18:35:36', '2023-05-23 18:35:45'),
(21, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwidXNlcm5hbWUiOiJhc2RhYTIxIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg0ODY2OTQ1LCJleHAiOjE2ODc0NTg5NDV9.hN4xH1Qayl23suBJPuFZjtc5YEsh_iwH686dkChmhOs', '2023-06-22 18:35:45', 1, '2023-05-23 18:35:45', '2023-05-23 18:35:56'),
(22, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwidXNlcm5hbWUiOiJhc2RhYTIxIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg0ODY2OTU2LCJleHAiOjE2ODc0NTg5NTZ9.l3dgTZyHhefHJJhBASpkagqyXGHnRq6Bv4j2FRxnxTs', '2023-06-22 18:35:56', 1, '2023-05-23 18:35:56', '2023-05-23 18:36:10'),
(23, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NDg2Njk2MSwiZXhwIjoxNjg3NDU4OTYxfQ.mYOYlrVVISTH3aSXzIlGy91FBRgdUZLAnY8F-XFKi7c', '2023-06-22 18:36:01', 1, '2023-05-23 18:36:01', '2023-05-23 18:36:10'),
(24, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwidXNlcm5hbWUiOiJhc2RhYTIxIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg0ODY2OTcwLCJleHAiOjE2ODc0NTg5NzB9.o64enGVQrL0XBm8NQWTLHXRRWp_zHDWcoXoeu4h5Euw', '2023-06-22 18:36:10', 1, '2023-05-23 18:36:10', '2023-05-23 18:38:39'),
(25, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJjdXN0b21lciIsImlhdCI6MTY4NDg2Njk3NSwiZXhwIjoxNjg3NDU4OTc1fQ.oiHFq8cu6ztxhARoug_qLO39IIGFLQ2b6Kz4FiZOtFA', '2023-06-22 18:36:15', 1, '2023-05-23 18:36:15', '2023-05-23 18:38:39'),
(26, 8, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJ1c2VybmFtZSI6ImFzZGFhMjMiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE2ODQ5MDIyODgsImV4cCI6MTY4NzQ5NDI4OH0.1EfxWL2r8NB2uweO8j-cYnMNfEuxW9qYdU2LM0hFIyc', '2023-06-23 04:24:48', 1, '2023-05-24 04:24:48', '2023-05-24 04:26:29'),
(27, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NDkwMjM1OSwiZXhwIjoxNjg3NDk0MzU5fQ.eYrvtBPTfXPNO22UH3aHK-BEdMJPvJ_XXuJHBGZVBqo', '2023-06-23 04:25:59', 1, '2023-05-24 04:25:59', '2023-05-24 04:42:22'),
(28, 8, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJ1c2VybmFtZSI6ImFzZGFhMjMiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE2ODQ5MDIzODksImV4cCI6MTY4NzQ5NDM4OX0.oHJKXgY8ZOKEnj5-bXP5EzbkNDGvMcGAvEXOBUWgIfA', '2023-06-23 04:26:29', 1, '2023-05-24 04:26:29', '2023-05-24 09:07:49'),
(29, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwidXNlcm5hbWUiOiJhc2RhYTIxMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NDkwMzM0MiwiZXhwIjoxNjg3NDk1MzQyfQ.IOwkvyD3ufNWuTIGtOnr2TSlKossCS1WDTEx59TvWsY', '2023-06-23 04:42:22', 1, '2023-05-24 04:42:22', '2023-05-29 09:44:24'),
(30, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NDkwMzQxMiwiZXhwIjoxNjg3NDk1NDEyfQ.5DgtqveDyE-qPHgcbp0IE0w16oD-BnXATo08C2NUkNY', '2023-06-23 04:43:32', 1, '2023-05-24 04:43:32', '2023-05-29 09:44:24'),
(31, 8, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJ1c2VybmFtZSI6ImFzZGFhMjMiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODQ5MTkyNjksImV4cCI6MTY4NzUxMTI2OX0.WcYFRmT5QLiI7n7fGAXwJ8_N8In3yys76352QrkEodc', '2023-06-23 09:07:49', 1, '2023-05-24 09:07:49', '2023-06-06 15:54:37'),
(32, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NDkxOTM2NywiZXhwIjoxNjg3NTExMzY3fQ.Pf70XhuWDZw8_LkodEaJPAKtvcaFSgYGihBWzvwge9o', '2023-06-23 09:09:27', 1, '2023-05-24 09:09:27', '2023-05-29 09:44:24'),
(33, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTIwOTQ4MSwiZXhwIjoxNjg3ODAxNDgxfQ.q-LQD_1KIDEq86lItDX3iYkN3CeE314FyrIcMTyU_DM', '2023-06-26 17:44:41', 1, '2023-05-27 17:44:41', '2023-05-29 09:44:24'),
(34, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTM1MzI2MiwiZXhwIjoxNjg3OTQ1MjYyfQ.6y0_5x4fCyDhvWYb3rP40uwoUTSBzFWKkylxsIqTuAU', '2023-06-28 09:41:02', 1, '2023-05-29 09:41:02', '2023-05-29 17:10:17'),
(35, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTM4MDc1MSwiZXhwIjoxNjg3OTcyNzUxfQ.RABYyn9bTJIa085mIIqWIEfSQ6eJETq9LeAK__XDm6Q', '2023-06-28 17:19:11', 1, '2023-05-29 17:19:11', '2023-05-29 17:19:33'),
(36, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTM4MDc1NiwiZXhwIjoxNjg3OTcyNzU2fQ.UcqtZKZG77SJxlzbDZv_IFrP887OIXNfh6VCekhifHM', '2023-06-28 17:19:16', 1, '2023-05-29 17:19:16', '2023-05-29 17:19:33'),
(37, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTM4MDc5NywiZXhwIjoxNjg3OTcyNzk3fQ.bRD5-Ax6_ElwGR6p9FH3q66Xh9NYwE3dxxOqxGrVIiw', '2023-06-28 17:19:57', 1, '2023-05-29 17:19:57', '2023-05-29 17:20:35'),
(38, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTM4MDg1NCwiZXhwIjoxNjg3OTcyODU0fQ.NmmmfwjzON5ffpYFuwraB6TEySR_cKT8BpC9j1RSAWQ', '2023-06-28 17:20:54', 1, '2023-05-29 17:20:54', '2023-05-29 17:20:57'),
(39, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTM4MDg1OSwiZXhwIjoxNjg3OTcyODU5fQ.oACdx7ZbOCIjLAZbCc55P38iWdDgHUjg2jYQx1jxhe8', '2023-06-28 17:20:59', 1, '2023-05-29 17:20:59', '2023-05-29 17:21:27'),
(40, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJjdXN0b21lciIsImlhdCI6MTY4NTM4MDkxMCwiZXhwIjoxNjg3OTcyOTEwfQ.dNsgP73pITF0FEEc1DZBEtwO9hW5nnG4P6tEpY9ayN8', '2023-06-28 17:21:50', 1, '2023-05-29 17:21:50', '2023-05-31 18:35:56'),
(41, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTM4MDk0OSwiZXhwIjoxNjg3OTcyOTQ5fQ.D9myXRI7W8bAtWpUcMhVBJssZp-l2BEst0eU2wDS-0U', '2023-06-28 17:22:29', 1, '2023-05-29 17:22:29', '2023-05-29 17:23:39'),
(42, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTM4MTAyMSwiZXhwIjoxNjg3OTczMDIxfQ.9fN795lrZVJ8oyeZsLKYFYfXkEyponc902aMtbwtbVU', '2023-06-28 17:23:41', 1, '2023-05-29 17:23:41', '2023-05-29 17:23:55'),
(43, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTM4MTA2NSwiZXhwIjoxNjg3OTczMDY1fQ.PAnQuM7twfS3U9F0QTqki5tgEOhSAYLKs-IMXdTMcWk', '2023-06-28 17:24:25', 1, '2023-05-29 17:24:25', '2023-05-29 17:24:40'),
(44, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTM4MzE2OCwiZXhwIjoxNjg3OTc1MTY4fQ.0RQAF3dAbUDnJoasdvEcuDQQYff8WghbCrRMf695SLg', '2023-06-28 17:59:28', 1, '2023-05-29 17:59:28', '2023-05-29 18:18:07'),
(45, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTM4MzQxNiwiZXhwIjoxNjg3OTc1NDE2fQ.GPOcmbEc_dFCCW1He3X9BNnoOOSg_NOvIpvTuS0Nsvk', '2023-06-28 18:03:36', 1, '2023-05-29 18:03:36', '2023-05-29 18:18:07'),
(46, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTQzMDcwOCwiZXhwIjoxNjg4MDIyNzA4fQ.z9kARXvpQWC7SLZw2HaIlG717MTwS1Wu_vyRPY-6sWs', '2023-06-29 07:11:48', 1, '2023-05-30 07:11:48', '2023-05-30 08:24:19'),
(47, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODU0MzExNTcsImV4cCI6MTY4ODAyMzE1N30.bKlqkLekQuW9Ind9hhy15NUlCRGBM5nL42n0SJKk0ho', '2023-06-29 07:19:17', 1, '2023-05-30 07:19:17', '2023-06-06 16:12:03'),
(48, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODU0MzEyNTgsImV4cCI6MTY4ODAyMzI1OH0.59OAiNjr3wXN1y74den9CmeWq094vB0ddDTeZilxuo8', '2023-06-29 07:20:58', 1, '2023-05-30 07:20:58', '2023-06-06 16:12:03'),
(49, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTQzNDY4NSwiZXhwIjoxNjg4MDI2Njg1fQ.Tx0DmTa6yS4dMmpLeD8uvld5SPjhGRYq93NqjQSSJuY', '2023-06-29 08:18:05', 1, '2023-05-30 08:18:05', '2023-05-30 08:24:19'),
(50, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTQzNTI3MSwiZXhwIjoxNjg4MDI3MjcxfQ.WKvGvAnRJAOuTw-G99IWEF9X3EkdBeIGbHBYaO6jDZ4', '2023-06-29 08:27:51', 1, '2023-05-30 08:27:51', '2023-05-31 18:35:56'),
(51, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTU1ODMyNCwiZXhwIjoxNjg4MTUwMzI0fQ.lANFUFUkvKXSotRLceUggtomFdAOhQQVxAxOBkWKsHw', '2023-06-30 18:38:44', 1, '2023-05-31 18:38:44', '2023-05-31 19:12:06'),
(52, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTU2MDYxOCwiZXhwIjoxNjg4MTUyNjE4fQ.no3d25rta-1d_ZTsn5TnNdUH4zDD5HHHKb41WLJx-CA', '2023-06-30 19:16:58', 1, '2023-05-31 19:16:58', '2023-06-01 08:41:48'),
(53, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODU2MDg5MTgsImV4cCI6MTY4ODIwMDkxOH0.wuDZjb1tpty3jmkSKrkLU2QUI72wUE-LelFD7G_Qktw', '2023-07-01 08:41:58', 1, '2023-06-01 08:41:58', '2023-06-06 16:12:03'),
(54, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTYwODk0NiwiZXhwIjoxNjg4MjAwOTQ2fQ.xh-Qb8SIZ2CZXiiB7BSjt4RABmMKZbpZFdHmlV_eiCY', '2023-07-01 08:42:26', 1, '2023-06-01 08:42:26', '2023-06-01 12:26:20'),
(55, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODU2MDkwMTgsImV4cCI6MTY4ODIwMTAxOH0.LJO2pyI8d70AeiTSw3afUBRseMWwjn61RBValSDgPMQ', '2023-07-01 08:43:38', 1, '2023-06-01 08:43:38', '2023-06-06 16:12:03'),
(56, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTYwOTA0NCwiZXhwIjoxNjg4MjAxMDQ0fQ.4OBGj8P-db9rSwpVKjOvIxrtE7VlBtGdnJea3Tx_eRk', '2023-07-01 08:44:04', 1, '2023-06-01 08:44:04', '2023-06-01 12:26:20'),
(57, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTYyMjQ0NSwiZXhwIjoxNjg4MjE0NDQ1fQ.zSCxoSUaubw0GbgbAjj6YJdrtUjC_1DE0pfPTbsj0RA', '2023-07-01 12:27:25', 1, '2023-06-01 12:27:25', '2023-06-01 16:39:40'),
(58, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTYyNDQ0NiwiZXhwIjoxNjg4MjE2NDQ2fQ.bvUiVXrENa9oLMqiNEaAU7x9nkF9GXA6SIvHar5MC54', '2023-07-01 13:00:46', 1, '2023-06-01 13:00:46', '2023-06-01 16:39:40'),
(59, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTYzNjc1MywiZXhwIjoxNjg4MjI4NzUzfQ.dpJGyvXbcmYKSS2vKaURV4O8X4uNF_2KwoRTQe1ZbRM', '2023-07-01 16:25:53', 1, '2023-06-01 16:25:53', '2023-06-01 16:39:40'),
(60, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTYzNzI3NCwiZXhwIjoxNjg4MjI5Mjc0fQ.3GMWvs0pkFoiaM4gSNCEZJHQizhkQD8rhAAWSasj5hU', '2023-07-01 16:34:34', 1, '2023-06-01 16:34:34', '2023-06-01 16:39:40'),
(61, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODU2MzczNDQsImV4cCI6MTY4ODIyOTM0NH0.TevDwMLrVidc2IfSSkG0nRlYOQt-sYMlc8a7sKTICa0', '2023-07-01 16:35:44', 1, '2023-06-01 16:35:44', '2023-06-06 16:12:03'),
(62, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTYzNzM2MSwiZXhwIjoxNjg4MjI5MzYxfQ.hIX6dGASyGyV2az3lHMXU8_tXjRmdwutwgXX23wYYB4', '2023-07-01 16:36:01', 1, '2023-06-01 16:36:01', '2023-06-01 16:39:40'),
(63, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTcwNDM5MiwiZXhwIjoxNjg4Mjk2MzkyfQ.3nuTKs36wv8Sat_ccalVQJYe93h18F36m6Y-B7u6qtM', '2023-07-02 11:13:12', 1, '2023-06-02 11:13:12', '2023-06-02 11:14:41'),
(64, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTcwNDUzOSwiZXhwIjoxNjg4Mjk2NTM5fQ.FLnQaSvmDhImi0k5PE2mnWmynfQ2-AABLMEHdTPOMQs', '2023-07-02 11:15:39', 1, '2023-06-02 11:15:39', '2023-06-02 11:15:43'),
(65, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTcwNDY2MywiZXhwIjoxNjg4Mjk2NjYzfQ.aX2ap3W6kDJbX2cYxsPLKFkD2xPAHw1CsWZYfvmga94', '2023-07-02 11:17:43', 1, '2023-06-02 11:17:43', '2023-06-02 11:17:47'),
(66, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTcwNDg0OSwiZXhwIjoxNjg4Mjk2ODQ5fQ.AGsyNA4xmcG8gA0Lr0m4Ik_NoHk6QyHthZR_VF9STZM', '2023-07-02 11:20:49', 1, '2023-06-02 11:20:49', '2023-06-02 12:36:53'),
(67, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTcwNDkwMCwiZXhwIjoxNjg4Mjk2OTAwfQ.A36oeSzChZwYp-SS_GK3bWilGgEO2M3ukBt7iybFDJA', '2023-07-02 11:21:40', 1, '2023-06-02 11:21:40', '2023-06-02 12:36:53'),
(68, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTcwNDk0MywiZXhwIjoxNjg4Mjk2OTQzfQ.0Lh_5UEnC3zWC7Mb2618e7O2V8qqn38tcAoDDyTJK8c', '2023-07-02 11:22:23', 1, '2023-06-02 11:22:23', '2023-06-02 12:36:53'),
(69, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTcwNDk2NCwiZXhwIjoxNjg4Mjk2OTY0fQ.cS4QRNOgOkDboW24vyUsW8fq6YEmzMGOaV6vo_7uXEM', '2023-07-02 11:22:44', 1, '2023-06-02 11:22:44', '2023-06-02 12:36:53'),
(70, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTcwNjEzNiwiZXhwIjoxNjg4Mjk4MTM2fQ.lC0c0a9S8xO9Dt-kszjRnEGq4iSqm62fcZWz60X8qo4', '2023-07-02 11:42:16', 1, '2023-06-02 11:42:16', '2023-06-02 12:36:53'),
(71, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA3NzM0LCJleHAiOjE2ODgyOTk3MzR9.SjLYUPHaEcW0aPmHau1WBIGMhP2iPbPCLzHJ92p63kE', '2023-07-02 12:08:54', 1, '2023-06-02 12:08:54', '2023-06-02 12:36:53'),
(72, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA3NzYzLCJleHAiOjE2ODgyOTk3NjN9.4M-bwq0FgRmiUF1gb1F0GJOw6_gLHmEb6F0x8Kp5sbo', '2023-07-02 12:09:23', 1, '2023-06-02 12:09:23', '2023-06-02 12:36:53'),
(73, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA3ODE5LCJleHAiOjE2ODgyOTk4MTl9.jvQ1Nq8rRG8sLncAlD-q3HqPrzCgn_1ZSeDmrCLaPIo', '2023-07-02 12:10:19', 1, '2023-06-02 12:10:19', '2023-06-02 12:36:53'),
(74, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA5MDE1LCJleHAiOjE2ODgzMDEwMTV9.vNOSRQ4_KV7xaYnJ1vRUwly8Gvdg2u8sB48KwToHLqc', '2023-07-02 12:30:15', 1, '2023-06-02 12:30:15', '2023-06-02 12:36:53'),
(75, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA5NDE4LCJleHAiOjE2ODgzMDE0MTh9.384frAybEBHuRpKodDrmEy4L4GETSpsIqGWJKCMzF6g', '2023-07-02 12:36:58', 1, '2023-06-02 12:36:58', '2023-06-02 12:40:07'),
(76, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA5NDI1LCJleHAiOjE2ODgzMDE0MjV9.Qd57elR_ksfAArEiJ4cUmPcfDJMBdLti35qAxphBMWw', '2023-07-02 12:37:05', 1, '2023-06-02 12:37:05', '2023-06-02 12:40:07'),
(77, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA5NDMxLCJleHAiOjE2ODgzMDE0MzF9.fvb_P0il7fLWDNXA5EFuTRktwjFVY53fh5CEDovo-5U', '2023-07-02 12:37:11', 1, '2023-06-02 12:37:11', '2023-06-02 12:40:07'),
(78, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA5NDUxLCJleHAiOjE2ODgzMDE0NTF9.TZPe2gv1EijMG0B0lpqVDeHOkblmxNqL91jDLe_N-W0', '2023-07-02 12:37:31', 1, '2023-06-02 12:37:31', '2023-06-02 12:40:07'),
(79, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA5NDkwLCJleHAiOjE2ODgzMDE0OTB9.tr7ecNZLi5hSnGFoIzqTPPY4RkDwfyvqGh99CxQsPZw', '2023-07-02 12:38:10', 1, '2023-06-02 12:38:10', '2023-06-02 12:40:07'),
(80, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA5NTA3LCJleHAiOjE2ODgzMDE1MDd9.ixfDNJRSynpk884zDjoZ_S68PbhCXaHkk5wm0K6OUyA', '2023-07-02 12:38:27', 1, '2023-06-02 12:38:27', '2023-06-02 12:40:07'),
(81, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA5NTE2LCJleHAiOjE2ODgzMDE1MTZ9.5XHIElyiFvLUmrYTBQ0b_BcOp1SemfZYlf83yC8_h54', '2023-07-02 12:38:36', 1, '2023-06-02 12:38:36', '2023-06-02 12:40:07'),
(82, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA5NjExLCJleHAiOjE2ODgzMDE2MTF9._l9StM3poRpKQd49B2xzO6tDnS0UMtRs0H32G7leSHs', '2023-07-02 12:40:11', 1, '2023-06-02 12:40:11', '2023-06-02 13:19:55'),
(83, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA5NjE1LCJleHAiOjE2ODgzMDE2MTV9.7SJpHlxeBSarNqtMFB9guwqKtUZLJUwpxmMCyrQzmW8', '2023-07-02 12:40:15', 1, '2023-06-02 12:40:15', '2023-06-02 13:19:55'),
(84, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA5NjQzLCJleHAiOjE2ODgzMDE2NDN9.n1vv9PUEvNt7-V9pY8TGlpSAlFb8NvCABXMP2xXLm58', '2023-07-02 12:40:43', 1, '2023-06-02 12:40:43', '2023-06-02 13:19:55'),
(85, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzA5NjcxLCJleHAiOjE2ODgzMDE2NzF9.RGSIVIw4ZiDs3ylHpCJrpyNPqPeLKw8IRAvmtAUwCIU', '2023-07-02 12:41:11', 1, '2023-06-02 12:41:11', '2023-06-02 13:19:55'),
(86, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzEyMDUxLCJleHAiOjE2ODgzMDQwNTF9.zjIBTYCXULu9tHN3vUT2m5TTE9DcHYlyMgJcGyGpy48', '2023-07-02 13:20:51', 1, '2023-06-02 13:20:51', '2023-06-02 13:22:17'),
(87, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzEyMTAzLCJleHAiOjE2ODgzMDQxMDN9.k7xhXWk7aduNI5PqnKx_M-DVbkElTxennUjQTQDGrQA', '2023-07-02 13:21:43', 1, '2023-06-02 13:21:43', '2023-06-02 13:22:17'),
(88, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzEyMTQwLCJleHAiOjE2ODgzMDQxNDB9.MYILzSEVhUrVX66vYdZXSFgf-e04_Im-8-_YcAVlCVI', '2023-07-02 13:22:20', 1, '2023-06-02 13:22:20', '2023-06-02 13:22:46'),
(89, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzEyMTQyLCJleHAiOjE2ODgzMDQxNDJ9.so7EcNkGrZhtEYkRP0y5XWPcWQHH7osEdIoaQLfi9vk', '2023-07-02 13:22:22', 1, '2023-06-02 13:22:22', '2023-06-02 13:22:46'),
(90, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzEyMTY4LCJleHAiOjE2ODgzMDQxNjh9.33RwlvIZ-QO4QXfk_ZRYZ3d9BCFBKELN_jXIAEswsGg', '2023-07-02 13:22:48', 1, '2023-06-02 13:22:48', '2023-06-02 13:23:01'),
(91, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzEyMTg3LCJleHAiOjE2ODgzMDQxODd9.wmcKyvKnoz6tee_0g7Fxw8tcD4jFzwOIc6XWiZfhxek', '2023-07-02 13:23:07', 1, '2023-06-02 13:23:07', '2023-06-02 13:24:06'),
(92, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzEyMjUzLCJleHAiOjE2ODgzMDQyNTN9.4CE7zQE-7fbKFFGpA51v-hz1CZVf8eYpCN5TaQ_1CCw', '2023-07-02 13:24:13', 1, '2023-06-02 13:24:13', '2023-06-02 13:24:28'),
(93, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzEyMzQ5LCJleHAiOjE2ODgzMDQzNDl9.mPcqqdE85jvgrJgfljHvGtrWIzZIfuXDh1SEQdGwyDI', '2023-07-02 13:25:49', 1, '2023-06-02 13:25:49', '2023-06-02 13:30:16'),
(94, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzEyNjQyLCJleHAiOjE2ODgzMDQ2NDJ9.MRC-OXTvCGyD-h2WzosKUg78r4AWOgWK9NmsRgy8QmM', '2023-07-02 13:30:42', 1, '2023-06-02 13:30:42', '2023-06-02 14:21:01'),
(95, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg1NzEyODk4LCJleHAiOjE2ODgzMDQ4OTh9.nDpbJkF8yFnm5I55fUodsyHN-sdMFc9St3Mp217ZYNU', '2023-07-02 13:34:58', 1, '2023-06-02 13:34:58', '2023-06-02 14:21:01'),
(96, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg1NzE1NjcwLCJleHAiOjE2ODgzMDc2NzB9.xotnu3-WP4mj78Iip8-zQ6qle_pjsbaHWjNYohB0yBY', '2023-07-02 14:21:10', 1, '2023-06-02 14:21:10', '2023-06-03 08:23:38'),
(97, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg1NzE1NjczLCJleHAiOjE2ODgzMDc2NzN9.wMULhc8RtAV2cQyh5Y4GBOq99XiTL2rECJ-NQkbJWEk', '2023-07-02 14:21:13', 1, '2023-06-02 14:21:13', '2023-06-03 08:23:38'),
(98, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg1NzcxODI4LCJleHAiOjE2ODgzNjM4Mjh9.aMsMX7KqBmv_D80ZukhLfxixL629UjqE1bU3nnJrsWo', '2023-07-03 05:57:08', 1, '2023-06-03 05:57:08', '2023-06-03 08:23:38'),
(99, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg1NzcxODQxLCJleHAiOjE2ODgzNjM4NDF9.4OiAyqM49H70EhdijsQfZlizSfT-lhlZhnLUUP5bG4k', '2023-07-03 05:57:21', 1, '2023-06-03 05:57:21', '2023-06-03 08:23:38'),
(100, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzcxODU3LCJleHAiOjE2ODgzNjM4NTd9.eZGRDJuNTiTgROaZhMRue8t5XdWdQ0IBSAETvJclEQo', '2023-07-03 05:57:37', 1, '2023-06-03 05:57:37', '2023-06-03 08:23:38'),
(101, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwNjMwLCJleHAiOjE2ODgzNzI2MzB9.J6yP8goPGS0mLPdV4zfmkiOgPQGLkCirYANjyU7ec18', '2023-07-03 08:23:50', 1, '2023-06-03 08:23:50', '2023-06-03 08:23:59'),
(102, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwNjM0LCJleHAiOjE2ODgzNzI2MzR9.k-wIb68QL6RYnYoQwZMb5__KuanuY5X2MxXJtxvt-kY', '2023-07-03 08:23:54', 1, '2023-06-03 08:23:54', '2023-06-03 08:23:59'),
(103, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwNjQ3LCJleHAiOjE2ODgzNzI2NDd9.x6F5DA-D3d-En5VizQk-hfU33eqMkFHxJL_NJjnrw0Y', '2023-07-03 08:24:07', 1, '2023-06-03 08:24:07', '2023-06-03 08:25:18'),
(104, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwNzIxLCJleHAiOjE2ODgzNzI3MjF9.tkbmCIGi61dLhcPnx6E5WhKfy_vOm6CY6cxpqw87JyE', '2023-07-03 08:25:21', 1, '2023-06-03 08:25:21', '2023-06-03 08:26:05'),
(105, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwNzUwLCJleHAiOjE2ODgzNzI3NTB9.BaEBQyON6Yqx8iWgn6_L9maU5Njh-2RpZr7qhz7uy8g', '2023-07-03 08:25:50', 1, '2023-06-03 08:25:50', '2023-06-03 08:26:05'),
(106, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwNzUzLCJleHAiOjE2ODgzNzI3NTN9.P5Fd02_EUwv1cuA1jK5V_rhB1IKel-c5IbAJMMVGA_8', '2023-07-03 08:25:53', 1, '2023-06-03 08:25:53', '2023-06-03 08:26:05'),
(107, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwNzYwLCJleHAiOjE2ODgzNzI3NjB9.GlLS-C2JovEf8h6NgpYYw2GCFvVItyX0ocOhb0d2vyA', '2023-07-03 08:26:00', 1, '2023-06-03 08:26:00', '2023-06-03 08:26:05'),
(108, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwNzY3LCJleHAiOjE2ODgzNzI3Njd9.r4rpPZLQC8RVAv-On_d34Zh9UURdAIZuczpUERI-Q4I', '2023-07-03 08:26:07', 1, '2023-06-03 08:26:07', '2023-06-03 08:26:28'),
(109, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwNzg0LCJleHAiOjE2ODgzNzI3ODR9.yGgZI60auq4c3esRoUQdoJ3rQiOqRnfAzvZUDclPwYs', '2023-07-03 08:26:24', 1, '2023-06-03 08:26:24', '2023-06-03 08:26:28'),
(110, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwNzkzLCJleHAiOjE2ODgzNzI3OTN9.ucrh_uUqysXOAVVAdRsT50n2-ZKv5OQzz0kcXLDrHg4', '2023-07-03 08:26:33', 1, '2023-06-03 08:26:33', '2023-06-03 08:26:48'),
(111, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwNzk0LCJleHAiOjE2ODgzNzI3OTR9.zUA_mhDmPx2YP4Wrjuq_gB8kVQHoIPIA1MrOTSGGnbQ', '2023-07-03 08:26:34', 1, '2023-06-03 08:26:34', '2023-06-03 08:26:48'),
(112, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwODEwLCJleHAiOjE2ODgzNzI4MTB9.89KLG2ZJWQPOT6PuHYvBkCMXRyP3kJokaw6lVehHJs0', '2023-07-03 08:26:50', 1, '2023-06-03 08:26:50', '2023-06-03 08:27:11'),
(113, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwODEyLCJleHAiOjE2ODgzNzI4MTJ9.NHdseRhUM7nlTmQoMYFY03t6WFzhHHnXNuzT9gX6spo', '2023-07-03 08:26:52', 1, '2023-06-03 08:26:52', '2023-06-03 08:27:11'),
(114, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwODM0LCJleHAiOjE2ODgzNzI4MzR9.sm0E6dQnwdcKyCbafy8QmW253eTaJCPMXbR9YjyrkAo', '2023-07-03 08:27:14', 1, '2023-06-03 08:27:14', '2023-06-03 08:27:25'),
(115, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwODQyLCJleHAiOjE2ODgzNzI4NDJ9.CEllei7mMdp8wxEU2Vz-DYMnDyAS-HSNAZbKc3fFEPQ', '2023-07-03 08:27:22', 1, '2023-06-03 08:27:22', '2023-06-03 08:27:25'),
(116, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwODQ4LCJleHAiOjE2ODgzNzI4NDh9.ftQMOL3K_GLHkug0p_MTLbQs9Re6NmYaxAIjcXbzi_Y', '2023-07-03 08:27:28', 1, '2023-06-03 08:27:28', '2023-06-03 08:28:05'),
(117, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwOTA5LCJleHAiOjE2ODgzNzI5MDl9.GTIqxPFchUw67C-ck1wzAqTL7_Hp-yAg-q-zBzHG2PM', '2023-07-03 08:28:29', 1, '2023-06-03 08:28:29', '2023-06-03 08:29:14'),
(118, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgwOTc4LCJleHAiOjE2ODgzNzI5Nzh9.3WlAbsXbRTkWzgFQ7t9QdebyLEIy0im_rHyC1ecPBvw', '2023-07-03 08:29:38', 1, '2023-06-03 08:29:38', '2023-06-03 08:30:00'),
(119, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxMDA1LCJleHAiOjE2ODgzNzMwMDV9.PhKG0vGzVCwl6hIaPF4StYhvE-lmeXNIRHQmR6jhllc', '2023-07-03 08:30:05', 1, '2023-06-03 08:30:05', '2023-06-03 08:31:33'),
(120, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxMDExLCJleHAiOjE2ODgzNzMwMTF9.A5H0-4XENyoMsMC10m4HMB8ZDqjXG5CC6lLaL07VLI4', '2023-07-03 08:30:11', 1, '2023-06-03 08:30:11', '2023-06-03 08:31:33'),
(121, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxMDEyLCJleHAiOjE2ODgzNzMwMTJ9.fD6TOUpwCUVR-B1vhWdadLW9zJM-5mhOB9eOVEFQHH0', '2023-07-03 08:30:12', 1, '2023-06-03 08:30:12', '2023-06-03 08:31:33'),
(122, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxMDIwLCJleHAiOjE2ODgzNzMwMjB9.7IWxKk5tKt7bYRUlil_ykQ72SN2h2FnNSQKKVN5Dl9M', '2023-07-03 08:30:20', 1, '2023-06-03 08:30:20', '2023-06-03 08:31:33'),
(123, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxMDk2LCJleHAiOjE2ODgzNzMwOTZ9.cJDkU2EW3p9D6okzqs6KLkpMfnhAgzIwVVfik6GQEH0', '2023-07-03 08:31:36', 1, '2023-06-03 08:31:36', '2023-06-03 08:32:34'),
(124, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxMTU4LCJleHAiOjE2ODgzNzMxNTh9.Qs9E3VPGQ7wSYE6RMz7N-Jj1NVK-8Kj2qcMf6ue9X_I', '2023-07-03 08:32:38', 1, '2023-06-03 08:32:38', '2023-06-03 08:33:18'),
(125, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxMjAwLCJleHAiOjE2ODgzNzMyMDB9.rI16VIvJSSQgpWMeCXFxJfuuXm_J-FOmllnpJ9hMMf4', '2023-07-03 08:33:20', 1, '2023-06-03 08:33:20', '2023-06-03 08:33:41'),
(126, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxMjI1LCJleHAiOjE2ODgzNzMyMjV9.a6e833OuiW7nLML8tabiix1qxN2u5P5Nvbsc6cyc4-c', '2023-07-03 08:33:45', 1, '2023-06-03 08:33:45', '2023-06-03 08:34:06'),
(127, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxMjQ5LCJleHAiOjE2ODgzNzMyNDl9.MZdLcayYb9r01o9JAudh6LiVsra-ao2N_U7I5Jm4Ttg', '2023-07-03 08:34:09', 1, '2023-06-03 08:34:09', '2023-06-03 08:34:19'),
(128, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxMjYyLCJleHAiOjE2ODgzNzMyNjJ9.ak-2PmArjaipM6Eg5czE61TsHWdbi5gVTE6Y_LouXxw', '2023-07-03 08:34:22', 1, '2023-06-03 08:34:22', '2023-06-03 08:34:34'),
(129, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxMjc3LCJleHAiOjE2ODgzNzMyNzd9.AtgZch3kLVi6H-1yOhV6tb8I4fyxORny9Ispa-ymckM', '2023-07-03 08:34:37', 1, '2023-06-03 08:34:37', '2023-06-03 08:35:09'),
(130, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxMjk2LCJleHAiOjE2ODgzNzMyOTZ9.qeYAHBq73dWSt1CQQcRK-XJf83GH3X5PJaEY1Pq7Yrw', '2023-07-03 08:34:56', 1, '2023-06-03 08:34:56', '2023-06-03 08:35:09'),
(131, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxMzE0LCJleHAiOjE2ODgzNzMzMTR9.Ji3iuNzULgz9nRM5DBM5CEkqbQCrIRR_5DKeMtXy6sY', '2023-07-03 08:35:14', 1, '2023-06-03 08:35:14', '2023-06-03 08:36:23'),
(132, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxMzg1LCJleHAiOjE2ODgzNzMzODV9.5ZSWNfYKXHKqkhc3Izrh5NfEMdzK9fUWeuWtQonVVbk', '2023-07-03 08:36:25', 1, '2023-06-03 08:36:25', '2023-06-03 08:37:16'),
(133, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxNDM5LCJleHAiOjE2ODgzNzM0Mzl9.SazP-EdnGGCOgMfibwkSLIjZTZaWPu7qtQlyE-kBn2k', '2023-07-03 08:37:19', 1, '2023-06-03 08:37:19', '2023-06-03 08:37:35'),
(134, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxNDU3LCJleHAiOjE2ODgzNzM0NTd9.0WiqeD-AosIdKNIfla4cHdveindwHAJVuD-vNvBjLC4', '2023-07-03 08:37:37', 1, '2023-06-03 08:37:37', '2023-06-03 08:38:42'),
(135, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxNTAzLCJleHAiOjE2ODgzNzM1MDN9.ddVXhjVc0Wrs7cGYlTUVaggibm3vF18BlKn_5ENEmYA', '2023-07-03 08:38:23', 1, '2023-06-03 08:38:23', '2023-06-03 08:38:42'),
(136, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxNTI0LCJleHAiOjE2ODgzNzM1MjR9.fFwquU717uV-qioY7y3FmsmYxRq3gmWUdPdgRNwqbdI', '2023-07-03 08:38:44', 1, '2023-06-03 08:38:44', '2023-06-03 08:39:08'),
(137, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxNTUzLCJleHAiOjE2ODgzNzM1NTN9.6ZYW_u6aSEgNly_ICRrxl6-lmTJku5bsV-XX6QHFOmQ', '2023-07-03 08:39:13', 1, '2023-06-03 08:39:13', '2023-06-03 08:39:29'),
(138, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxNTcyLCJleHAiOjE2ODgzNzM1NzJ9.AA-ETlK89eIV9d6TJa80plXziYk__dUw6xQtEUxU7D8', '2023-07-03 08:39:32', 1, '2023-06-03 08:39:32', '2023-06-03 08:40:30'),
(139, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxNjMyLCJleHAiOjE2ODgzNzM2MzJ9.n0fYVb_y1pe_DNX07pt1uI3NRo6CD5cjveIUml6-kIA', '2023-07-03 08:40:32', 1, '2023-06-03 08:40:32', '2023-06-03 08:40:48'),
(140, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxNjUwLCJleHAiOjE2ODgzNzM2NTB9.vwvxNlbj7UuGkjQm9_Rn0WTqcXHNqLc1fFROqn_UhxM', '2023-07-03 08:40:50', 1, '2023-06-03 08:40:50', '2023-06-03 08:41:13'),
(141, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxNjc1LCJleHAiOjE2ODgzNzM2NzV9.j9zX2HK0deMgWihyzNgZojgep4vY4SHulfwjRXx6iBw', '2023-07-03 08:41:15', 1, '2023-06-03 08:41:15', '2023-06-03 08:41:30'),
(142, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgxNjkyLCJleHAiOjE2ODgzNzM2OTJ9.8YT81FEKS4ceI649E5HTC2eVR3FVddriVup0WRWyKe0', '2023-07-03 08:41:32', 1, '2023-06-03 08:41:32', '2023-06-03 08:57:05'),
(143, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgyMzg0LCJleHAiOjE2ODgzNzQzODR9.QCdYI-FGc6UbYdJaQMQi34CclnOjNpkVu3CJg1VzkJ0', '2023-07-03 08:53:04', 1, '2023-06-03 08:53:04', '2023-06-03 08:57:05'),
(144, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1NzgyNjMxLCJleHAiOjE2ODgzNzQ2MzF9._WS-fpPVvCs90goQKhlczoQIY2V5w9KBhWLX4qp5Dzo', '2023-07-03 08:57:11', 1, '2023-06-03 08:57:11', '2023-06-03 09:21:38'),
(145, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1Nzg0MDUyLCJleHAiOjE2ODgzNzYwNTJ9.ZccTT7g3R4oyaLWdpvM4jAOul5O_OylC5h-Z6zukNuY', '2023-07-03 09:20:52', 1, '2023-06-03 09:20:52', '2023-06-03 09:21:38'),
(146, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg1Nzg0MTAyLCJleHAiOjE2ODgzNzYxMDJ9.DY8IQvWHdqtc54f1l9iKIbG3y_uMI2lFLywQPdnp4mg', '2023-07-03 09:21:42', 1, '2023-06-03 09:21:42', '2023-06-03 09:47:57'),
(147, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg1Nzg0MzA3LCJleHAiOjE2ODgzNzYzMDd9.XUuGXsjvyJnuswXsJWUdAqtVGldHiBY39RB8bypDb0s', '2023-07-03 09:25:07', 1, '2023-06-03 09:25:07', '2023-06-03 09:47:57'),
(148, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg1Nzg0NDc3LCJleHAiOjE2ODgzNzY0Nzd9.fLdrj_rWe-ISFXMDWe714dZX-cceqyUCgmSDTxjOsFQ', '2023-07-03 09:27:57', 1, '2023-06-03 09:27:57', '2023-06-03 09:47:57'),
(149, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg1Nzg1NjcwLCJleHAiOjE2ODgzNzc2NzB9.imFTjalvhyzipXH6cD1mRnWK9tQU7oeFTqAhqhhLNuo', '2023-07-03 09:47:50', 1, '2023-06-03 09:47:50', '2023-06-03 09:47:57'),
(150, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1Nzg1NjgwLCJleHAiOjE2ODgzNzc2ODB9.pa69adlgUKMjYu2ZjdzEWi98MnlUW0tXX12qoLmjMYU', '2023-07-03 09:48:00', 1, '2023-06-03 09:48:00', '2023-06-03 09:58:39'),
(151, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1Nzg2NjgwLCJleHAiOjE2ODgzNzg2ODB9.EuZmV6lCVbwsUDmuahGVgycWDd1w_kGhL-7qOgyBKMw', '2023-07-03 10:04:40', 1, '2023-06-03 10:04:40', '2023-06-03 10:05:23'),
(152, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1Nzg4NzMzLCJleHAiOjE2ODgzODA3MzN9.Hfc_w8NbbfS7Y97bLRYnHWtYj92nY1lD_jAdo6YpCpw', '2023-07-03 10:38:53', 1, '2023-06-03 10:38:53', '2023-06-03 10:39:03'),
(153, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1Nzg4ODQ4LCJleHAiOjE2ODgzODA4NDh9.7NvB37833dLagTzeNBYbQy1ceyRaK0G9pdt6LFn5ZqM', '2023-07-03 10:40:48', 1, '2023-06-03 10:40:48', '2023-06-03 10:45:35'),
(154, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1Nzg5NTc5LCJleHAiOjE2ODgzODE1Nzl9.QHNJtOscD72FVHllTgNpx9Hjp_kg7t2TdN1n4jEMdUE', '2023-07-03 10:52:59', 1, '2023-06-03 10:52:59', '2023-06-03 10:54:41'),
(155, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg1Nzg5NTg3LCJleHAiOjE2ODgzODE1ODd9.EqBpMq7xips_7IWpsyfTV8bv69hSCTSu6LK0NeSI9S4', '2023-07-03 10:53:07', 1, '2023-06-03 10:53:07', '2023-06-03 10:54:41'),
(156, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1Nzg5NjYwLCJleHAiOjE2ODgzODE2NjB9.IE7Iwz1MC4ZnmsaCkkvh67L-CQGErG8corQeOBKfHVs', '2023-07-03 10:54:20', 1, '2023-06-03 10:54:20', '2023-06-03 10:54:41'),
(157, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1Nzg5NzA0LCJleHAiOjE2ODgzODE3MDR9.Zy0EKMLDuO6iirFzam-aQ4kyoEYJkAAzqXpS8OFmFX4', '2023-07-03 10:55:04', 1, '2023-06-03 10:55:04', '2023-06-03 12:27:14'),
(158, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1Nzg5Nzk1LCJleHAiOjE2ODgzODE3OTV9.4YI1nbko9VLsrfgX5yH0q8Zf4LHrZDr_Og-X5RyfwJE', '2023-07-03 10:56:35', 1, '2023-06-03 10:56:35', '2023-06-03 12:27:14'),
(159, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1Nzk1MjQxLCJleHAiOjE2ODgzODcyNDF9.z-2qTQ_1z2Je1PXRHTQoiWMAstRrz_mAScLriDkEmW8', '2023-07-03 12:27:21', 1, '2023-06-03 12:27:21', '2023-06-03 19:07:23'),
(160, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1ODE5MTM0LCJleHAiOjE2ODg0MTExMzR9.MdTaguQFKb0FKQYyooDS67M0DtpHDQQrY-dsQMQAVVo', '2023-07-03 19:05:34', 1, '2023-06-03 19:05:34', '2023-06-03 19:07:23'),
(161, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg1ODE5MjUzLCJleHAiOjE2ODg0MTEyNTN9.UNSWSQiP2_8TPXPs339mDkUuEHV8zvT95qgR36EiiIw', '2023-07-03 19:07:33', 1, '2023-06-03 19:07:33', '2023-06-05 07:27:41'),
(162, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg1ODE5Mjg2LCJleHAiOjE2ODg0MTEyODZ9.SnLu2ceEexp6DGYHivImKJmat1Sq5EBqKdVH45VwQqA', '2023-07-03 19:08:06', 1, '2023-06-03 19:08:06', '2023-06-05 07:27:41'),
(163, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg1ODE5NjQ2LCJleHAiOjE2ODg0MTE2NDZ9.8bkShCl9aOlUHHwJjPCJIFOGiRYxg5yAoZU8j9muusk', '2023-07-03 19:14:06', 1, '2023-06-03 19:14:06', '2023-06-05 07:27:41'),
(164, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjg1OTUwMDQ3LCJleHAiOjE2ODg1NDIwNDd9.ach2BuxbG57-nfwiOt5AcwnH5d5nRnLfESNUKC9WThA', '2023-07-05 07:27:27', 1, '2023-06-05 07:27:27', '2023-06-05 07:27:41'),
(165, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1OTUwMDcxLCJleHAiOjE2ODg1NDIwNzF9.WtG_wbNn_BwuCWTVOGljW0z7pfOBVw6dZpY7Xj2lkZs', '2023-07-05 07:27:51', 1, '2023-06-05 07:27:51', '2023-06-06 15:26:27'),
(166, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1OTUwMTQwLCJleHAiOjE2ODg1NDIxNDB9.ngKp2gWT4FqBBtQOVndiDxqGbYbOHdGb64WFgUWdgTc', '2023-07-05 07:29:00', 1, '2023-06-05 07:29:00', '2023-06-06 15:26:27'),
(167, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYXNkYXNkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg1OTUwODE0LCJleHAiOjE2ODg1NDI4MTR9.TX-kcZX_nmgcGPP5JeX26ng5ML1FY3Lv7uMm3BZE8AM', '2023-07-05 07:40:14', 1, '2023-06-05 07:40:14', '2023-06-06 15:26:27'),
(168, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MDY1NDQ4LCJleHAiOjE2ODg2NTc0NDh9.TM0JyG-rjvPrcVFcK3T5wxNaK4Gwuu9k3QaBMFcWw04', '2023-07-06 15:30:48', 1, '2023-06-06 15:30:48', '2023-06-06 15:42:04'),
(169, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MDY1NDY2LCJleHAiOjE2ODg2NTc0NjZ9.v__1lNv55yJwz982gArIJ5kHT6PuMMxfiy3bJpmcgBk', '2023-07-06 15:31:06', 1, '2023-06-06 15:31:06', '2023-06-06 15:42:04'),
(170, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwidXNlcm5hbWUiOiJraGFsZWRXYWxlYWQiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE2ODYwNjYxMjQsImV4cCI6MTY4ODY1ODEyNH0.Aigpk2MDTeWKVqW9BCR1SDP8MDI4tZOtExTn39kS4Gk', '2023-07-06 15:42:04', 1, '2023-06-06 15:42:04', '2023-06-06 15:52:27'),
(171, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwidXNlcm5hbWUiOiJraGFsZWRXYWxlYWQiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE2ODYwNjY3NDcsImV4cCI6MTY4ODY1ODc0N30.bwV_LuiD3qXrZcLKcFPUnebOoTn2XX1JBiul9o47BO0', '2023-07-06 15:52:27', 1, '2023-06-06 15:52:27', '2023-06-06 15:59:16'),
(172, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNjcyMjgsImV4cCI6MTY4ODY1OTIyOH0.MpfuWx4QXi4eGvNM_uOZQMoyunyqgOtKCJj1tWI8F94', '2023-07-06 16:00:28', 1, '2023-06-06 16:00:28', '2023-06-06 16:12:03'),
(173, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MDY3MjU3LCJleHAiOjE2ODg2NTkyNTd9.tcdtOdrqx5JjHNYXgnTDVH8WRbQbEBr1KFKKPBgDYxA', '2023-07-06 16:00:57', 1, '2023-06-06 16:00:57', '2023-06-06 16:11:53'),
(174, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNjc5MTgsImV4cCI6MTY4ODY1OTkxOH0.4VeNgjtiYUffsxk2DkdBRNyuCp9rrxyPsyYjbuSHE4M', '2023-07-06 16:11:58', 1, '2023-06-06 16:11:58', '2023-06-06 16:12:03'),
(175, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MDY3OTMxLCJleHAiOjE2ODg2NTk5MzF9.eI3HAC1tb-iQ8PkzrqayUZzO1484mz8d9ddknxVIUps', '2023-07-06 16:12:11', 1, '2023-06-06 16:12:11', '2023-06-06 16:12:21'),
(176, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNjc5NDksImV4cCI6MTY4ODY1OTk0OX0.geWQZcZyLM0SgUTWL4MAZomUH9Mr0pY-k7Mfey3SV7Q', '2023-07-06 16:12:29', 1, '2023-06-06 16:12:29', '2023-06-06 18:01:19'),
(177, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNjg2MjgsImV4cCI6MTY4ODY2MDYyOH0.fwi1J8_O1iN6NIOgoF6t9jpA57VUrat-pn1_CJdExu4', '2023-07-06 16:23:48', 1, '2023-06-06 16:23:48', '2023-06-06 18:01:19'),
(178, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MDY5MDM2LCJleHAiOjE2ODg2NjEwMzZ9.lbFHT_yTGpujsw-EGHJ1eiFi_Ox05E4iJC48zkE6XbA', '2023-07-06 16:30:36', 1, '2023-06-06 16:30:36', '2023-06-06 17:56:28'),
(179, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNzQzMDYsImV4cCI6MTY4ODY2NjMwNn0.-FVPwH1JeuTyYuy-W5NUxA190_UvhuGnybDlqxL0z9Q', '2023-07-06 17:58:26', 1, '2023-06-06 17:58:26', '2023-06-06 18:01:19'),
(180, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNzQzMTYsImV4cCI6MTY4ODY2NjMxNn0.A8TN_0u5M_rhjMped5_sErFz36Z_zv1B4MfXHo9K8g4', '2023-07-06 17:58:36', 1, '2023-06-06 17:58:36', '2023-06-06 18:01:19'),
(181, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNzQ0MDYsImV4cCI6MTY4ODY2NjQwNn0.YwekIDkocgWPIVyRT-_ksPSaSUmhH7yEBTgLI-sud-M', '2023-07-06 18:00:06', 1, '2023-06-06 18:00:06', '2023-06-06 18:01:19'),
(182, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNzQ0MjIsImV4cCI6MTY4ODY2NjQyMn0.qPeWYT9uCH6N1YMZJW8EdSonN_sEkwDZwx_xjptY3Ks', '2023-07-06 18:00:22', 1, '2023-06-06 18:00:22', '2023-06-06 18:01:19'),
(183, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNzQ0MjcsImV4cCI6MTY4ODY2NjQyN30.KeiUow7wXnqGS4aq_f0wIzVvbvFRdUVj5XOybAEBKTI', '2023-07-06 18:00:27', 1, '2023-06-06 18:00:27', '2023-06-06 18:01:19'),
(184, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNzQ0MjgsImV4cCI6MTY4ODY2NjQyOH0.z8bqvffxIvFzU8Ie2qpwlIxImYoJ0qFHjDFbVXUlWSU', '2023-07-06 18:00:28', 1, '2023-06-06 18:00:28', '2023-06-06 18:01:19'),
(185, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNzQ0MzQsImV4cCI6MTY4ODY2NjQzNH0.8F9l1zo1E37J6fqskgC2qDJp8GfMozqQ9FEOy2Ml6pw', '2023-07-06 18:00:34', 1, '2023-06-06 18:00:34', '2023-06-06 18:01:19'),
(186, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNzQ0MzQsImV4cCI6MTY4ODY2NjQzNH0.8F9l1zo1E37J6fqskgC2qDJp8GfMozqQ9FEOy2Ml6pw', '2023-07-06 18:00:34', 1, '2023-06-06 18:00:34', '2023-06-06 18:01:19'),
(187, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNzQ0MzUsImV4cCI6MTY4ODY2NjQzNX0.WXHgYvCiPa0Rm1hKoYFiuVtFFM3z093NMCDCloS-ORM', '2023-07-06 18:00:35', 1, '2023-06-06 18:00:35', '2023-06-06 18:01:19'),
(188, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNzQ0MzUsImV4cCI6MTY4ODY2NjQzNX0.WXHgYvCiPa0Rm1hKoYFiuVtFFM3z093NMCDCloS-ORM', '2023-07-06 18:00:35', 1, '2023-06-06 18:00:35', '2023-06-06 18:01:19'),
(189, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNzQ0MzUsImV4cCI6MTY4ODY2NjQzNX0.WXHgYvCiPa0Rm1hKoYFiuVtFFM3z093NMCDCloS-ORM', '2023-07-06 18:00:35', 1, '2023-06-06 18:00:35', '2023-06-06 18:01:19'),
(190, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYwNzQ0MzYsImV4cCI6MTY4ODY2NjQzNn0.jycf1M1qg4OAOlxx4wptPDRpxVNbSJ1Os3t_jKyGJrY', '2023-07-06 18:00:36', 1, '2023-06-06 18:00:36', '2023-06-06 18:01:19'),
(191, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MDc0NDg5LCJleHAiOjE2ODg2NjY0ODl9.ylc-YFUvIiKuw62skIhDEypgzuAMAujRU8Ktnb67dZs', '2023-07-06 18:01:29', 1, '2023-06-06 18:01:29', '2023-06-06 18:06:13'),
(192, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MDc0NDk0LCJleHAiOjE2ODg2NjY0OTR9.3HvfU0NvjgtGCk-XcyxDRRk1lEBZTCXUix9oGBIqCYE', '2023-07-06 18:01:34', 1, '2023-06-06 18:01:34', '2023-06-06 18:06:13'),
(193, 16, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTYsInVzZXJuYW1lIjoiYWhtZWQiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE2ODYwNzQ3OTcsImV4cCI6MTY4ODY2Njc5N30.7HrNRcyzlzcxWb4yTQPZR-QYOzXQyWJ-0WR1bTvU-GU', '2023-07-06 18:06:37', 1, '2023-06-06 18:06:37', '2023-06-07 05:14:42'),
(194, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYxMTQ4OTQsImV4cCI6MTY4ODcwNjg5NH0.jKfcIri7J736xS0QBVlhi1tz62EZ5oTR7RGEMF4cFC4', '2023-07-07 05:14:54', 1, '2023-06-07 05:14:54', '2023-06-07 05:17:19'),
(195, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYxMTQ5NDEsImV4cCI6MTY4ODcwNjk0MX0.XAMBX8L-pfS3o_ybozI8pEWIUqMJdi7U4rAf9FRS2FI', '2023-07-07 05:15:41', 1, '2023-06-07 05:15:41', '2023-06-07 05:17:19'),
(196, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYxMTUwMTcsImV4cCI6MTY4ODcwNzAxN30.CoEAgzlqdxbPklXsZ63bRfWtNObflUUafj0yl6zRWsY', '2023-07-07 05:16:57', 1, '2023-06-07 05:16:57', '2023-06-07 05:17:19'),
(197, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYxMTUwNDMsImV4cCI6MTY4ODcwNzA0M30.dvsMqwRypz5I8-xlZCso_VS0pf2fJbe6L8Zy_zRqTdw', '2023-07-07 05:17:23', 1, '2023-06-07 05:17:23', '2023-06-07 05:17:34');
INSERT INTO `tokens` (`id`, `user_id`, `token`, `expiration_date`, `revoked`, `created_at`, `updated_at`) VALUES
(198, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MTE1MDU4LCJleHAiOjE2ODg3MDcwNTh9.F0b-IELxPy7nCqI_sDdDy9iz4VPLQ_BMEE-7LosvyuY', '2023-07-07 05:17:38', 1, '2023-06-07 05:17:38', '2023-06-07 05:18:06'),
(199, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MTI0ODE0LCJleHAiOjE2ODg3MTY4MTR9.SXiQFJOY6MMXkKHAN8MMW8rOXQMU5CjzblHzxWVtTIk', '2023-07-07 08:00:14', 1, '2023-06-07 08:00:14', '2023-06-08 05:42:29'),
(200, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MTI0ODE4LCJleHAiOjE2ODg3MTY4MTh9.680kjT-0lo6adRTQTnLoejCh4Nfp7ZXE7s6sr-WM1fY', '2023-07-07 08:00:18', 1, '2023-06-07 08:00:18', '2023-06-08 05:42:29'),
(201, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MTI0ODE5LCJleHAiOjE2ODg3MTY4MTl9.rOSWTNqYpcHktFVXFGUniaM_2QNl9JRYYT4D9aqz1pI', '2023-07-07 08:00:19', 1, '2023-06-07 08:00:19', '2023-06-08 05:42:29'),
(202, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MTI0ODIwLCJleHAiOjE2ODg3MTY4MjB9.T87VUsRZVD1APYTjpvAj4IV-WoQtLuRj6QbrSlB4dKo', '2023-07-07 08:00:20', 1, '2023-06-07 08:00:20', '2023-06-08 05:42:29'),
(203, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MTI0ODM2LCJleHAiOjE2ODg3MTY4MzZ9.DvRFMj2EZNqxFrwU8MCQE_VKsgdY742cXC9kWFGMIS4', '2023-07-07 08:00:36', 1, '2023-06-07 08:00:36', '2023-06-08 05:42:29'),
(204, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjAyOTU1LCJleHAiOjE2ODg3OTQ5NTV9.Ku8DtMzldCuRaZQ8No2x4uYtzRZBwHV3sco24Rp5xUA', '2023-07-08 05:42:35', 1, '2023-06-08 05:42:35', '2023-06-08 06:05:12'),
(205, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjAyOTk5LCJleHAiOjE2ODg3OTQ5OTl9.YgBGpZgDv3j_fD6AG_9QHaDDn2RIIcnU1-0GoZvv7UI', '2023-07-08 05:43:19', 1, '2023-06-08 05:43:19', '2023-06-08 06:05:12'),
(206, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjAzMDQwLCJleHAiOjE2ODg3OTUwNDB9.zdys1__VBIX9t1hahVmqaOJecqMW3VAq1cxyg0UTnKk', '2023-07-08 05:44:00', 1, '2023-06-08 05:44:00', '2023-06-08 06:05:12'),
(207, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjAzMDQ0LCJleHAiOjE2ODg3OTUwNDR9.iuUaldKozD1LlUAtlYTIGoWbPa5V7bp3yx75u9QyPR4', '2023-07-08 05:44:04', 1, '2023-06-08 05:44:04', '2023-06-08 06:05:12'),
(208, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjAzMDU4LCJleHAiOjE2ODg3OTUwNTh9.wfHSBfjsPrmNr9o8AeWCgoa-7eDSlgj2nHaZFlVds-I', '2023-07-08 05:44:18', 1, '2023-06-08 05:44:18', '2023-06-08 06:05:12'),
(209, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjAzMTMxLCJleHAiOjE2ODg3OTUxMzF9._T0LAIQEJLyCr_ijDte1wJ8j2zLBQe4g268Ld93_hSg', '2023-07-08 05:45:31', 1, '2023-06-08 05:45:31', '2023-06-08 06:05:12'),
(210, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjAzMTQyLCJleHAiOjE2ODg3OTUxNDJ9.np7jcjFEXlVLhWcg5q-g22wsdxWsFRdA73w0YbCbOSU', '2023-07-08 05:45:42', 1, '2023-06-08 05:45:42', '2023-06-08 06:05:12'),
(211, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjAzMTU4LCJleHAiOjE2ODg3OTUxNTh9.Kh3I3rsTpTQObwr3ymnIm7lR0IN8gYb36rXWeQtm68c', '2023-07-08 05:45:58', 1, '2023-06-08 05:45:58', '2023-06-08 06:05:12'),
(212, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjAzMjAyLCJleHAiOjE2ODg3OTUyMDJ9.VpTrf2b478XeFNKxwczNRnem4DekPPcPeI9vvjfrItc', '2023-07-08 05:46:42', 1, '2023-06-08 05:46:42', '2023-06-08 06:05:12'),
(213, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjAzMzEzLCJleHAiOjE2ODg3OTUzMTN9.cKu6qLMZT9nONjOiwDRYvfEGtoB9E1Iyd0xie5XGQGs', '2023-07-08 05:48:33', 1, '2023-06-08 05:48:33', '2023-06-08 06:05:12'),
(214, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjAzMzYyLCJleHAiOjE2ODg3OTUzNjJ9.nxiGIjjoAZfIxBmjAnA7PqQW2Vx2RqK8pl3z-Uyu8Gk', '2023-07-08 05:49:22', 1, '2023-06-08 05:49:22', '2023-06-08 06:05:12'),
(215, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjAzMzY5LCJleHAiOjE2ODg3OTUzNjl9.zkg7V0CxTJJg1yJBw9WhMhRl2XWB464AremiTeMiIaI', '2023-07-08 05:49:29', 1, '2023-06-08 05:49:29', '2023-06-08 06:05:12'),
(216, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjAzMzkwLCJleHAiOjE2ODg3OTUzOTB9.V0h1Usg4QrRL_GfN5wbs1skdQ3tjLYW0L3OuMZ5sP6M', '2023-07-08 05:49:50', 1, '2023-06-08 05:49:50', '2023-06-08 06:05:12'),
(217, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjAzNTQwLCJleHAiOjE2ODg3OTU1NDB9.fauNDJSrvbNtv-pWtItCWK2gbRC1T1jllXKwr5fuk4k', '2023-07-08 05:52:20', 1, '2023-06-08 05:52:20', '2023-06-08 06:05:12'),
(218, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjA0MjQ4LCJleHAiOjE2ODg3OTYyNDh9.2tUIN15OBvauJYrmdyzY7Egn7L2pX0Sci_zS4YtbLSc', '2023-07-08 06:04:08', 1, '2023-06-08 06:04:08', '2023-06-08 06:05:12'),
(219, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjA0MjgxLCJleHAiOjE2ODg3OTYyODF9.pxNdvGLeW-EK15eyfY8YKh9qAzFqhOfcA58Qpuoajuc', '2023-07-08 06:04:41', 1, '2023-06-08 06:04:41', '2023-06-08 06:05:12'),
(220, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjA0MzA1LCJleHAiOjE2ODg3OTYzMDV9.Qi7a1W8_8vnnwfEX6Xp58lghC1WpNapOHf_UP1slSek', '2023-07-08 06:05:05', 1, '2023-06-08 06:05:05', '2023-06-08 06:05:12'),
(221, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYyMDQzMjAsImV4cCI6MTY4ODc5NjMyMH0.bM8SOwqABtEl1cMyVgrZm493uWxjYpq2pf4faUm6Vp4', '2023-07-08 06:05:20', 1, '2023-06-08 06:05:20', '2023-06-08 06:05:47'),
(222, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYyMDQzMzAsImV4cCI6MTY4ODc5NjMzMH0.N0XG0OjA43ARMJPs5Xxou9bVA4VQNaz5JyRT1n1RPcU', '2023-07-08 06:05:30', 1, '2023-06-08 06:05:30', '2023-06-08 06:05:47'),
(223, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYyMDQzNTEsImV4cCI6MTY4ODc5NjM1MX0.7VOjBoGc4qTggHzpAPVGQr7J3pmq18wcbdYy4it5gIQ', '2023-07-08 06:05:51', 1, '2023-06-08 06:05:51', '2023-06-08 06:11:56'),
(224, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYyMDQ3MTksImV4cCI6MTY4ODc5NjcxOX0.8ug0GXGAVIjLVnrkzu50La0uuWx_HYneqP2l7XpFF_Q', '2023-07-08 06:11:59', 1, '2023-06-08 06:11:59', '2023-06-08 06:12:04'),
(225, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoia2hhbGVkV2FsZWFkIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjg2MjA0NzI5LCJleHAiOjE2ODg3OTY3Mjl9.wgaNDhxx8M3QF1UPWq2QkV_uygg4mmgXTKJK9tdKcHQ', '2023-07-08 06:12:09', 1, '2023-06-08 06:12:09', '2023-06-08 06:36:24'),
(226, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjExIiwidXNlcm5hbWUiOiJraGFsZWRXYWxlYWQiLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE2ODYyMDYxODQsImV4cCI6MTY4ODc5ODE4NH0.X1wNLnkWJlddI4OuEek3BOy9ncARIDK-yY9kEQoERtE', '2023-07-08 06:36:24', 1, '2023-06-08 06:36:24', '2023-06-08 06:36:41'),
(227, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODYyMDYyMTcsImV4cCI6MTY4ODc5ODIxN30.Bpyaca9YR7loOohD5W2-lYjm5mz91L-oumfBZXn9I5Q', '2023-07-08 06:36:57', 1, '2023-06-08 06:36:57', '2023-06-08 06:50:57');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','customer') NOT NULL DEFAULT 'customer',
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `status`, `created_at`, `deleted`) VALUES
(7, 'asdaa1', 'asds1@gmail.com', '$2y$10$H5oo8TWPFYlw/rwGTrJ.bustOociM9yKuPdRt3EWNyjhaTujlE3TW', 'admin', 'active', '2023-05-23 17:13:19', 1),
(8, 'Amal', 'amal@gmail.com', '$2y$10$.lniW.9XK5QXYGbzcjsM7.drR878amrFP32Jqx1gh.p9wV7VlTsMC', 'customer', 'active', '2023-05-23 17:36:05', 0),
(9, 'asdaa212', 'asds2@gmail.com', '$2y$10$ZIcax3S2gBMbLYDr959ovu3ZlczyQ7/4Vsjyjq.EcU1LOPvZ7pAXq', 'admin', 'active', '2023-05-23 18:19:29', 1),
(11, 'khaledWalead', 'asds212@gmail.com', '$2y$10$kC3HPgxQHKaf7iPh5mPzq.Z68eBi.yulLm2tTbNfwe3soc/qWpure', 'admin', 'active', '2023-05-23 18:26:51', 0),
(12, 'Khaled', 'asds@gmail.com', '$2y$10$DdecP2bsFX6Njqp7PvP/oueG7R5pWo7S6Tmfuo7FDBlvSOe85eitW', 'customer', 'active', '2023-05-24 04:59:33', 1),
(13, 'asdasd3e23', 'asdasd3e23@gmail.com', '$2y$10$d7eUihdNQJFrK9OjowzJ5OfcW7Gaez6yt276h1fnvu4uaoKtYQLNK', 'customer', 'active', '2023-05-24 05:01:16', 1),
(14, 'e', 'khaled.abo.oriban@gmail.com', '$2y$10$4FidWWkJ1UmvEOtZaaOmo.TsUzwdZZGE8XkYJrhxAOOPxQEp57kAS', 'admin', 'active', '2023-05-26 08:33:40', 1),
(15, 'aseel', 'aseel@gmail.com', '$2y$10$i3gDEKsPnQmmAYKLnsLtsOgDo7iPpiy5YpRDaaVIYy/qPMtI0VlaS', 'customer', 'active', '2023-05-30 07:19:02', 0),
(16, 'ahmed', 'ahmed@app.com', '$2y$10$ZPnEaQd96aomRzHV.DL6H.uWR2EN21pmoQOTirjMzfRGOGXhMf8gC', 'admin', 'active', '2023-06-06 18:06:02', 0),
(17, 'alph', 'asds212as@gmail.com', '$2y$10$XdYz.bZFqOdgAgYg0ZGXUOnIE6mE2Pps1bztL2X.yJ/xhj3ejTSGW', 'customer', 'active', '2023-06-07 05:39:27', 1),
(18, 'alphA', 'khaled@khaled.khaled', '$2y$10$9nyLOfSYqraJVakuPUIfwOFwEcq0OFsP.fGFdCtN/knMa66biJotK', 'customer', 'active', '2023-06-07 05:40:54', 1),
(19, 'asdwq', 'qweqwe@gmail.com', '$2y$10$dyXvV/xtGnjTXWaVkVSuweOSUP/coUB4QbMKp7/V8L6V0JVlxRJj6', 'admin', 'active', '2023-06-08 06:24:54', 1),
(20, 'asdasdasd', 'asds2asdasd12@gmail.com', '$2y$10$IRuluF3jhcvkFQaGZbiY8.iviC4BlyrfydQ7OS5eapujVo07zZjI.', 'customer', 'active', '2023-06-08 06:35:00', 1),
(21, 'AlphaV', 'alpha@gmail.com', '$2y$10$vwF0A3J9jxEE.WTCrx.DI.Yq.y5TtrOYUqvZ.ccdYuasBOT9gNp5O', 'admin', 'active', '2023-06-08 06:36:03', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `cart_items_ibfk_1` (`cart_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `colors`
--
ALTER TABLE `colors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_colors`
--
ALTER TABLE `product_colors`
  ADD KEY `product_id` (`product_id`),
  ADD KEY `color_id` (`color_id`);

--
-- Indexes for table `product_sizes`
--
ALTER TABLE `product_sizes`
  ADD KEY `product_id` (`product_id`),
  ADD KEY `size_id` (`size_id`);

--
-- Indexes for table `sizes`
--
ALTER TABLE `sizes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `colors`
--
ALTER TABLE `colors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `sizes`
--
ALTER TABLE `sizes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=228;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`),
  ADD CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `cart_items_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `product_categories_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `product_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `product_colors`
--
ALTER TABLE `product_colors`
  ADD CONSTRAINT `product_colors_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `product_colors_ibfk_2` FOREIGN KEY (`color_id`) REFERENCES `colors` (`id`);

--
-- Constraints for table `product_sizes`
--
ALTER TABLE `product_sizes`
  ADD CONSTRAINT `product_sizes_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `product_sizes_ibfk_2` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`);

--
-- Constraints for table `tokens`
--
ALTER TABLE `tokens`
  ADD CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
