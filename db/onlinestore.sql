-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2023 at 06:45 PM
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
(33, 11, '2023-06-01 16:37:47');

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

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`id`, `cart_id`, `product_id`, `quantity`, `user_id`) VALUES
(32, 33, 14, 3, 11);

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
(14, 'Essential Stretch Jeans', 'Show Less\nDesigned for all-day comfort and style, our essential stretch jeans have an authentic look and feel. The go-to wardrobe staple that never lets you down.\n\nMade from cotton-rich denim and woven with stretch for added comfort. Our variety of fits, colours and leg lengths ensures you can find the perfect match to suit your style.\n\nFeaturing traditional five-pocket styling, belt loops, rivets for extra durability, and plenty of pockets to hold your essentials. Forever Dark™ technology helps your jeans to maintain their colour and stay dark for a minimum of 20 washes.', 28, 0, 1017, '2023-05-25 13:26:00', '[{\"url\":\"https:\\/\\/img.shop.com\\/Image\\/250000\\/253200\\/253251\\/products\\/1938893011.jpg?plain&size=400x400\"}]'),
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
(31, 8, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjgiLCJ1c2VybmFtZSI6ImFzZGFhMjMiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODQ5MTkyNjksImV4cCI6MTY4NzUxMTI2OX0.WcYFRmT5QLiI7n7fGAXwJ8_N8In3yys76352QrkEodc', '2023-06-23 09:07:49', 0, '2023-05-24 09:07:49', '2023-05-24 09:07:49'),
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
(47, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODU0MzExNTcsImV4cCI6MTY4ODAyMzE1N30.bKlqkLekQuW9Ind9hhy15NUlCRGBM5nL42n0SJKk0ho', '2023-06-29 07:19:17', 0, '2023-05-30 07:19:17', '2023-05-30 07:19:17'),
(48, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODU0MzEyNTgsImV4cCI6MTY4ODAyMzI1OH0.59OAiNjr3wXN1y74den9CmeWq094vB0ddDTeZilxuo8', '2023-06-29 07:20:58', 0, '2023-05-30 07:20:58', '2023-05-30 07:20:58'),
(49, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTQzNDY4NSwiZXhwIjoxNjg4MDI2Njg1fQ.Tx0DmTa6yS4dMmpLeD8uvld5SPjhGRYq93NqjQSSJuY', '2023-06-29 08:18:05', 1, '2023-05-30 08:18:05', '2023-05-30 08:24:19'),
(50, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTQzNTI3MSwiZXhwIjoxNjg4MDI3MjcxfQ.WKvGvAnRJAOuTw-G99IWEF9X3EkdBeIGbHBYaO6jDZ4', '2023-06-29 08:27:51', 1, '2023-05-30 08:27:51', '2023-05-31 18:35:56'),
(51, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTU1ODMyNCwiZXhwIjoxNjg4MTUwMzI0fQ.lANFUFUkvKXSotRLceUggtomFdAOhQQVxAxOBkWKsHw', '2023-06-30 18:38:44', 1, '2023-05-31 18:38:44', '2023-05-31 19:12:06'),
(52, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTU2MDYxOCwiZXhwIjoxNjg4MTUyNjE4fQ.no3d25rta-1d_ZTsn5TnNdUH4zDD5HHHKb41WLJx-CA', '2023-06-30 19:16:58', 1, '2023-05-31 19:16:58', '2023-06-01 08:41:48'),
(53, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODU2MDg5MTgsImV4cCI6MTY4ODIwMDkxOH0.wuDZjb1tpty3jmkSKrkLU2QUI72wUE-LelFD7G_Qktw', '2023-07-01 08:41:58', 0, '2023-06-01 08:41:58', '2023-06-01 08:41:58'),
(54, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTYwODk0NiwiZXhwIjoxNjg4MjAwOTQ2fQ.xh-Qb8SIZ2CZXiiB7BSjt4RABmMKZbpZFdHmlV_eiCY', '2023-07-01 08:42:26', 1, '2023-06-01 08:42:26', '2023-06-01 12:26:20'),
(55, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODU2MDkwMTgsImV4cCI6MTY4ODIwMTAxOH0.LJO2pyI8d70AeiTSw3afUBRseMWwjn61RBValSDgPMQ', '2023-07-01 08:43:38', 0, '2023-06-01 08:43:38', '2023-06-01 08:43:38'),
(56, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTYwOTA0NCwiZXhwIjoxNjg4MjAxMDQ0fQ.4OBGj8P-db9rSwpVKjOvIxrtE7VlBtGdnJea3Tx_eRk', '2023-07-01 08:44:04', 1, '2023-06-01 08:44:04', '2023-06-01 12:26:20'),
(57, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTYyMjQ0NSwiZXhwIjoxNjg4MjE0NDQ1fQ.zSCxoSUaubw0GbgbAjj6YJdrtUjC_1DE0pfPTbsj0RA', '2023-07-01 12:27:25', 1, '2023-06-01 12:27:25', '2023-06-01 16:39:40'),
(58, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTYyNDQ0NiwiZXhwIjoxNjg4MjE2NDQ2fQ.bvUiVXrENa9oLMqiNEaAU7x9nkF9GXA6SIvHar5MC54', '2023-07-01 13:00:46', 1, '2023-06-01 13:00:46', '2023-06-01 16:39:40'),
(59, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTYzNjc1MywiZXhwIjoxNjg4MjI4NzUzfQ.dpJGyvXbcmYKSS2vKaURV4O8X4uNF_2KwoRTQe1ZbRM', '2023-07-01 16:25:53', 1, '2023-06-01 16:25:53', '2023-06-01 16:39:40'),
(60, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTYzNzI3NCwiZXhwIjoxNjg4MjI5Mjc0fQ.3GMWvs0pkFoiaM4gSNCEZJHQizhkQD8rhAAWSasj5hU', '2023-07-01 16:34:34', 1, '2023-06-01 16:34:34', '2023-06-01 16:39:40'),
(61, 15, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoiYXNlZWwiLCJyb2xlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODU2MzczNDQsImV4cCI6MTY4ODIyOTM0NH0.TevDwMLrVidc2IfSSkG0nRlYOQt-sYMlc8a7sKTICa0', '2023-07-01 16:35:44', 0, '2023-06-01 16:35:44', '2023-06-01 16:35:44'),
(62, 11, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoiYXNkYWEyMSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTY4NTYzNzM2MSwiZXhwIjoxNjg4MjI5MzYxfQ.hIX6dGASyGyV2az3lHMXU8_tXjRmdwutwgXX23wYYB4', '2023-07-01 16:36:01', 1, '2023-06-01 16:36:01', '2023-06-01 16:39:40');

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
(8, 'Amal', 'amal@gmail.com', '$2y$10$J6KLImZhtVnxBL/eq9IKaeY93zmZS3fqsqjAEAM894hUs5UrA9AXS', 'admin', 'active', '2023-05-23 17:36:05', 0),
(9, 'asdaa212', 'asds2@gmail.com', '$2y$10$ZIcax3S2gBMbLYDr959ovu3ZlczyQ7/4Vsjyjq.EcU1LOPvZ7pAXq', 'admin', 'active', '2023-05-23 18:19:29', 1),
(11, 'asdaa21', 'asds212@gmail.com', '$2y$10$A0qJpKJAh.zUlKGitU0u3uR8K6h6FlnX3n/Ex6CDWOATIswBgmqEq', 'admin', 'active', '2023-05-23 18:26:51', 0),
(12, 'Khaled', 'asds@gmail.com', '$2y$10$DdecP2bsFX6Njqp7PvP/oueG7R5pWo7S6Tmfuo7FDBlvSOe85eitW', 'customer', 'active', '2023-05-24 04:59:33', 1),
(13, 'asdasd3e23', 'asdasd3e23@gmail.com', '$2y$10$d7eUihdNQJFrK9OjowzJ5OfcW7Gaez6yt276h1fnvu4uaoKtYQLNK', 'customer', 'active', '2023-05-24 05:01:16', 1),
(14, 'e', 'khaled.abo.oriban@gmail.com', '$2y$10$4FidWWkJ1UmvEOtZaaOmo.TsUzwdZZGE8XkYJrhxAOOPxQEp57kAS', 'admin', 'active', '2023-05-26 08:33:40', 1),
(15, 'aseel', 'aseel@gmail.com', '$2y$10$i3gDEKsPnQmmAYKLnsLtsOgDo7iPpiy5YpRDaaVIYy/qPMtI0VlaS', 'customer', 'active', '2023-05-30 07:19:02', 0);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `sizes`
--
ALTER TABLE `sizes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
