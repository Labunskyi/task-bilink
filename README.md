# task-bilink
Задание. 
Имеется база данных MySql с тремя таблицами: payments - платежи через различные платежные системы; payment_systems - платёжные системы; payment_reports - отчеты по платежам. 

SQL для создания и наполнения таблиц:
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `payment_reports`;
CREATE TABLE `payment_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT ,
  `date` datetime NOT NULL COMMENT 'Дата отчета',
  `payment_system_id` smallint(6) NOT NULL COMMENT 'id платежной системы',
  `amount` float NOT NULL COMMENT 'Сумма платежей',
  `commission` float NOT NULL COMMENT 'Суммарная комиссия',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

DROP TABLE IF EXISTS `payment_systems`;
CREATE TABLE `payment_systems` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT 'id платежной системы',
  `name` varchar(255) NOT NULL COMMENT 'Название платежной системы.',
  `commission` int(11) NOT NULL DEFAULT '0' COMMENT 'Комиссия за платеж (проценты )',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

INSERT INTO `payment_systems` (`name`, `commission`) VALUES
('Payment_system_1', '0'),
('Payment_system_2', '3'),
('Payment_system_3', '5'),
('Payment_system_new', '2');

DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id платежа.',
  `amount` float NOT NULL COMMENT 'Сумма платежа.',
  `payment_system_id` tinyint(4) NOT NULL COMMENT 'id плетжной системы.',
  `payment_date` datetime NOT NULL COMMENT 'дата и время проведения платежа.',
  PRIMARY KEY (`id`),
  KEY `payment_system` (`payment_system_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

INSERT INTO `payments` (`amount`, `payment_system_id`, `payment_date`) VALUES
('20', '1', '2017-11-08 11:00:00'),
('133.22', '1', '2017-11-08 11:00:00'),
('58', '4', '2017-11-08 14:00:00'),
('96', '2', '2017-11-08 12:00:00'),
('12', '3', '2017-11-08 13:00:00'),
('269.26', '1', '2017-11-08 11:00:00'),
('69', '4', '2017-11-09 14:00:00'),
('66.66', '2', '2017-11-09 12:00:00'),
('100', '3', '2017-11-09 13:00:00'),
( '35', '3', '2017-11-09 13:00:00'),
( '920', '2', '2017-11-09 12:00:00'),
( '17.1', '4', '2017-11-09 14:00:00'),
( '89.99', '1', '2017-11-10 11:00:00'),
( '100', '2', '2017-11-10 12:00:00'),
( '100', '4', '2017-11-10 14:00:00'),
( '200', '1', '2017-11-10 11:00:00'),
( '201.55', '3', '2017-11-10 13:00:00'),
( '12', '2', '2017-11-10 12:00:00'),
( '105', '4', '2017-11-10 14:00:00'),
( '120', '2', '2017-11-10 12:00:00');

Необходимо написать php класс Payments для работы с данными таблицами  в котором будет  три публичных метода, не требующих его  реализации (класса)

1.Метод getPayments($payDate)  - возвращает массив  всех платежей на дату $payDate. Каждый элемент массива представляет собой ассоциативный массив с произвольными ключами и  содержит:  дату и время платежа , сумму платежа и (!)название платежной системы. Результат необходимо возвращать в json формате.

2.Метод createReport($reportDate) - создает записи в таблице payment_reports. Каждая запись содержит: дату по которой формируется отчет (дата задается параметром $reportDate)  , идентификатор платежной системы, сумму платежей от одной платежной системы в заданную дату, суммарную комиссию по платежам от одной платежной системы в заданную дату(величина комиссии  в процентах хранится в поле commission таблицы платежных систем). Если платежей по какой-то платежной системе в заданный день не было, создать пустые записи (сумма и комиссия  равны нулю). Также необходимо избежать дублирования записей - если при вызове метода есть записи на данную дату, их нужно переписать. Возвращает true в случае удачной записи/обновления или false в случае ошибки.

3.Метод createPayment($amount,$paymentSystemId) - создает запись в таблице payments с текущей датой и заданными в аргументах метода суммой и идентификатором платежной системы. Возвращает true в случае удачной записи и false в случае ошибки или отсутствия платежной системы. 
