-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Окт 01 2019 г., 00:26
-- Версия сервера: 5.7.25
-- Версия PHP: 7.1.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `bilink`
--

-- --------------------------------------------------------

--
-- Структура таблицы `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL COMMENT 'id платежа.',
  `amount` float NOT NULL COMMENT 'Сумма платежа.',
  `payment_system_id` tinyint(4) NOT NULL COMMENT 'id плетжной системы.',
  `payment_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'дата и время проведения платежа.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `payments`
--

INSERT INTO `payments` (`id`, `amount`, `payment_system_id`, `payment_date`) VALUES
(253, 20, 1, '2017-11-08 11:00:00'),
(254, 133.22, 1, '2017-11-08 11:00:00'),
(255, 58, 4, '2017-11-08 14:00:00'),
(256, 96, 2, '2017-11-08 12:00:00'),
(257, 12, 3, '2017-11-08 13:00:00'),
(258, 269.26, 1, '2017-11-08 11:00:00'),
(259, 69, 4, '2017-11-09 14:00:00'),
(260, 66.66, 2, '2017-11-09 12:00:00'),
(261, 100, 3, '2017-11-09 13:00:00'),
(262, 35, 3, '2017-11-09 13:00:00'),
(263, 920, 2, '2017-11-09 12:00:00'),
(264, 17.1, 4, '2017-11-09 14:00:00'),
(265, 89.99, 1, '2017-11-10 11:00:00'),
(266, 100, 2, '2017-11-10 12:00:00'),
(267, 100, 4, '2017-11-10 14:00:00'),
(268, 200, 1, '2017-11-10 11:00:00'),
(269, 201.55, 3, '2017-11-10 13:00:00'),
(270, 12, 2, '2017-11-10 12:00:00'),
(271, 105, 4, '2017-11-10 14:00:00'),
(272, 120, 2, '2017-11-10 12:00:00');

-- --------------------------------------------------------

--
-- Структура таблицы `payment_reports`
--

CREATE TABLE `payment_reports` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL COMMENT 'Дата отчета',
  `payment_system_id` smallint(6) DEFAULT NULL COMMENT 'id платежной системы',
  `amount` float NOT NULL COMMENT 'Сумма платежей',
  `commission` float NOT NULL COMMENT 'Суммарная комиссия'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Структура таблицы `payment_systems`
--

CREATE TABLE `payment_systems` (
  `id` tinyint(4) NOT NULL COMMENT 'id платежной системы',
  `name` varchar(255) NOT NULL COMMENT 'Название платежной системы.',
  `commission` int(11) NOT NULL DEFAULT '0' COMMENT 'Комиссия за платеж (проценты )'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `payment_systems`
--

INSERT INTO `payment_systems` (`id`, `name`, `commission`) VALUES
(1, 'Payment_system_1', 0),
(2, 'Payment_system_2', 3),
(3, 'Payment_system_3', 5),
(4, 'Payment_system_new', 2);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_system` (`payment_system_id`);

--
-- Индексы таблицы `payment_reports`
--
ALTER TABLE `payment_reports`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `date` (`date`,`payment_system_id`);

--
-- Индексы таблицы `payment_systems`
--
ALTER TABLE `payment_systems`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id платежа.', AUTO_INCREMENT=322;

--
-- AUTO_INCREMENT для таблицы `payment_reports`
--
ALTER TABLE `payment_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=319;

--
-- AUTO_INCREMENT для таблицы `payment_systems`
--
ALTER TABLE `payment_systems`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'id платежной системы', AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
