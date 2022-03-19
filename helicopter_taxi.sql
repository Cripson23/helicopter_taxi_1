-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Ноя 29 2021 г., 11:46
-- Версия сервера: 10.4.21-MariaDB
-- Версия PHP: 8.0.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `helicopter_taxi`
--

-- --------------------------------------------------------

--
-- Структура таблицы `branch`
--

CREATE TABLE `branch` (
  `branch_code` int(11) NOT NULL,
  `branch_name` varchar(25) DEFAULT NULL,
  `full_name_director` varchar(75) DEFAULT NULL,
  `branch_address` varchar(60) DEFAULT NULL,
  `branch_phone` varchar(12) DEFAULT NULL,
  `company_code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `branch`
--

INSERT INTO `branch` (`branch_code`, `branch_name`, `full_name_director`, `branch_address`, `branch_phone`, `company_code`) VALUES
(1, 'Московский', 'Гараев Иван Фёдорович', 'г. Москва, ул. Переселенская, д. 37, этаж 21', '+78003333502', 1),
(36, 'Екатеринбургский', 'Иванов Дмитрий Анатольевич', 'г. Екатеринбург, ул. Николая Островского, д. 28, этаж 2', '+78005555666', 1),
(37, 'Петербургский', 'Казаков Сергей Петрович', 'г. Санкт-Петербург, ул. Ленина, д. 13, этаж 5', '+78003333777', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `company`
--

CREATE TABLE `company` (
  `company_code` int(11) NOT NULL,
  `company_name` varchar(25) DEFAULT NULL,
  `full_name_director` varchar(75) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `phone_number` varchar(12) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `company`
--

INSERT INTO `company` (`company_code`, `company_name`, `full_name_director`, `address`, `phone_number`, `email`) VALUES
(1, 'Такси вертолет', 'Петрищев Александр Владимирович', 'г. Москва, Пресненская набережная, д. 12, этаж 37', '+78003333502', 'info@taxiheli.ru');

-- --------------------------------------------------------

--
-- Структура таблицы `fuel_provider`
--

CREATE TABLE `fuel_provider` (
  `provider_code` int(11) NOT NULL,
  `provider_name` varchar(50) DEFAULT NULL,
  `provider_address` varchar(70) DEFAULT NULL,
  `provider_phone` varchar(25) DEFAULT NULL,
  `full_name_director` varchar(50) DEFAULT NULL,
  `branch_code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `fuel_provider`
--

INSERT INTO `fuel_provider` (`provider_code`, `provider_name`, `provider_address`, `provider_phone`, `full_name_director`, `branch_code`) VALUES
(1, 'ИП Иванов', 'ул. Касперская 32', '+79501247891', 'Михайлова Ирина Олеговна', 1),
(2, 'ООО \"Триада\"', 'ул. Нижегородская 52', '+79224562178', 'Колесников Михаил Арапович', 1),
(3, 'ИП Сергеев', 'ул. Деревянная 124', '+79351689721', 'Богданов Николай Петрович', 1),
(4, 'ОАО \"Энергетик\"', 'проспект Декабристов 22', '+79125679856', 'Лебедева Наталья Сергеевна', 1),
(5, 'ЗАО \"ТопЛиво\"', 'ул. Энергетиков 55', '+79231233223', 'Миллер Георгий Газизович', 1),
(6, 'ИП Ковальчук Н. И.', 'г. Пермь, ул. Пушкина, 28', '+79123151820', 'Ковальчук Николай Иванович', 1),
(7, 'ИП Ковалёв А. Ю.', 'г. Пермь, ул. Куйбышева 92', '+79282283288', 'Ковалёв Антон Юрьевич', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `fuel_purchase`
--

CREATE TABLE `fuel_purchase` (
  `purchase_code` int(11) NOT NULL,
  `provider_code` int(11) DEFAULT NULL,
  `purchase_volume` int(11) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_price` double DEFAULT NULL,
  `branch_code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `fuel_purchase`
--

INSERT INTO `fuel_purchase` (`purchase_code`, `provider_code`, `purchase_volume`, `purchase_date`, `purchase_price`, `branch_code`) VALUES
(2, 1, 123, '2021-09-30', 333, 36),
(3, 2, 150, '2021-02-09', 200, 37),
(4, 3, 120, '2021-08-06', 150, 36),
(5, 3, 128, '2021-04-07', 234, 37),
(6, 5, 80, '2021-03-04', 220, 1),
(7, 2, 110, '2021-09-09', 500, 37),
(27, 1, 100, '2021-10-07', 50, 1),
(49, 4, 123, '2021-12-02', 123, 1),
(50, 2, 444, '2021-11-23', 444, 36);

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `Код заказа` int(11) NOT NULL,
  `Код диспетчера` int(11) DEFAULT NULL,
  `Код пилота` int(11) DEFAULT NULL,
  `Код клиента` int(11) DEFAULT NULL,
  `Код вертолета` int(11) DEFAULT NULL,
  `Адрес заказа` varchar(50) DEFAULT NULL,
  `Адрес доставки` varchar(50) DEFAULT NULL,
  `Дата выполнения заказа` datetime DEFAULT NULL,
  `Дата поступления заказа` datetime DEFAULT NULL,
  `Время аренды` int(11) DEFAULT NULL,
  `Способ оплаты` varchar(255) DEFAULT NULL,
  `Код филиала` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`Код заказа`, `Код диспетчера`, `Код пилота`, `Код клиента`, `Код вертолета`, `Адрес заказа`, `Адрес доставки`, `Дата выполнения заказа`, `Дата поступления заказа`, `Время аренды`, `Способ оплаты`, `Код филиала`) VALUES
(1, 2, 10, 5, 10, 'Аэродромная ул., 18', 'Сосинская ул., 20', '2019-04-24 00:00:00', '2019-12-21 00:00:00', 5, 'Наличные', 1),
(3, 3, 6, 6, 14, '1-я Текстильщиков ул., 11', 'ул. Вифанская, 27-25\r\nСергиев Посад\r\nМосковская об', '2019-11-09 00:00:00', '2018-11-09 00:00:00', 10, 'Безналичный расчет', 1),
(4, 1, 12, 1, 2, 'Варшавское ш., 59', 'Румянцево, Московская обл.\r\nМосковская обл.\r\nМоско', '2019-06-13 00:00:00', '2018-06-10 00:00:00', 3, 'Безналичный расчет', 1),
(5, 2, 11, 2, 5, 'Земледельческий пер., 18', 'Жуковский, Московская обл.', '2019-04-27 00:00:00', '2018-04-26 00:00:00', 2, 'Наличные', 1),
(7, 1, 5, 5, 8, 'Сивцев Вражек переулок, 35', 'Декабристов ул., 26', '2019-07-09 00:00:00', '2018-07-09 00:00:00', 5, 'Безналичный расчет', 1),
(8, 2, 6, 6, 10, 'Кастанаевская ул., 48', 'Щёлково, Московская обл.', '2019-12-31 00:00:00', '2017-12-30 00:00:00', 10, 'Безналичный расчет', 1),
(10, 2, 10, 1, 2, '3-й Останкинский пер.', 'Домодедово, Московская обл.', '2018-12-29 00:00:00', '2018-12-29 00:00:00', 6, NULL, 1),
(18, 4, 9, 6, 9, 'ул. Пушкина, 12', 'ул. Ленина, 38', '2019-04-12 00:00:00', '2019-04-11 00:00:00', 7, 'Наличные', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `менеджер`
--

CREATE TABLE `менеджер` (
  `Код сотрудника` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `менеджер`
--

INSERT INTO `менеджер` (`Код сотрудника`) VALUES
(8);

-- --------------------------------------------------------

--
-- Структура таблицы `модель вертолета`
--

CREATE TABLE `модель вертолета` (
  `Код модели` int(11) NOT NULL,
  `Наименование модели` varchar(25) DEFAULT NULL,
  `Вместимость` int(11) DEFAULT NULL,
  `Скорость` int(11) DEFAULT NULL,
  `Дальность` int(11) DEFAULT NULL,
  `Стоимость одного часа аренды` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `модель вертолета`
--

INSERT INTO `модель вертолета` (`Код модели`, `Наименование модели`, `Вместимость`, `Скорость`, `Дальность`, `Стоимость одного часа аренды`) VALUES
(1, 'Eurocopter AS350', 5, 287, 500, 15000),
(2, 'Eurocopter EC130', 6, 235, 1200, 20000),
(3, 'Bell 429', 5, 278, 700, 12000),
(4, 'Bell 407', 6, 256, 600, 13000),
(5, 'Eurocopter EC135', 6, 260, 1000, 15000),
(6, 'Agusta AW119', 6, 270, 1200, 17000),
(7, 'AgustaWestland AW109 Gran', 7, 270, 1500, 22000),
(8, 'AgustaWestland AW139', 8, 310, 1000, 25000),
(9, 'Robinson R44', 3, 210, 500, 10000),
(10, 'КА-32', 13, 260, 1200, 25000),
(11, 'Ми-8', 28, 250, 2000, 30000),
(12, 'Ми-9', 12, 281, 2000, 25000);

-- --------------------------------------------------------

--
-- Структура таблицы `диспетчер`
--

CREATE TABLE `диспетчер` (
  `Код сотрудника` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `диспетчер`
--

INSERT INTO `диспетчер` (`Код сотрудника`) VALUES
(1),
(2),
(3),
(4);

-- --------------------------------------------------------

--
-- Структура таблицы `клиент`
--

CREATE TABLE `клиент` (
  `Код клиента` int(11) NOT NULL,
  `Имя` varchar(25) DEFAULT NULL,
  `Отчество` varchar(25) DEFAULT NULL,
  `Номер телефона` varchar(12) DEFAULT NULL,
  `Электронная почта` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `клиент`
--

INSERT INTO `клиент` (`Код клиента`, `Имя`, `Отчество`, `Номер телефона`, `Электронная почта`) VALUES
(1, 'Яромир', 'Станиславович', '+79635499263', 'yaromir@ya.ru'),
(2, 'Дмитрий', 'Богданович', '+79059817422', 'lord.moscow@gmail.com'),
(3, 'Ананий', 'Брониславович', '+79092900869', 'ananiy24@mail.ru'),
(4, 'Марина', 'Даниловна', '+79632510749', 'marina.danilovna@mail.ru'),
(5, 'Жанна', 'Андреевна', '+79638920592', 'zhanna.andreevn@gmail.com'),
(6, 'Нонна', 'Богдановна', '+79097040167', 'nonna.52@bk.ru'),
(7, 'Гарри', 'Борисович', '+79253655392', 'harry.monster@mail.ru'),
(9, 'Сергей', 'Иванович', '+79356731221', 'leroysergey@mail.ru'),
(74, 'Иван', 'Федорович', '+79223461278', 'ivanpetrenko@mail.ru'),
(75, 'Петр', 'Сергеевич', '+79126831286', 'ivan.sergeevich@gmail.com'),
(77, 'Геннадий', 'Васильевич', '+79125671246', 'alex@bk.ru'),
(78, 'Михаил', 'Петрович', '+79471245612', 'pertro12@gmail.com');

-- --------------------------------------------------------

--
-- Структура таблицы `пилот`
--

CREATE TABLE `пилот` (
  `Код сотрудника` int(11) NOT NULL,
  `Дата продления лицензии` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `пилот`
--

INSERT INTO `пилот` (`Код сотрудника`, `Дата продления лицензии`) VALUES
(5, '2019-12-03 00:00:00'),
(6, '2019-11-22 00:00:00'),
(7, '2019-09-17 00:00:00'),
(9, '2020-04-26 00:00:00'),
(10, '2019-11-21 00:00:00'),
(11, '2019-06-14 00:00:00');

-- --------------------------------------------------------

--
-- Структура таблицы `переаттестация`
--

CREATE TABLE `переаттестация` (
  `Дата аттестации` datetime NOT NULL,
  `Код пилота` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `переаттестация`
--

INSERT INTO `переаттестация` (`Дата аттестации`, `Код пилота`) VALUES
('2017-02-07 00:00:00', 6),
('2018-06-06 00:00:00', 5),
('2018-06-20 00:00:00', 7),
('2018-06-21 00:00:00', 10),
('2018-12-04 00:00:00', 5),
('2018-12-11 00:00:00', 11),
('2019-01-31 00:00:00', 9),
('2019-05-09 00:00:00', 7);

-- --------------------------------------------------------

--
-- Структура таблицы `вертолет`
--

CREATE TABLE `вертолет` (
  `Код вертолета` int(11) NOT NULL,
  `Код модели` int(11) DEFAULT NULL,
  `Год выпуска` smallint(6) DEFAULT NULL,
  `Дата последнего тех осмотра` datetime DEFAULT NULL,
  `Код филиала` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `вертолет`
--

INSERT INTO `вертолет` (`Код вертолета`, `Код модели`, `Год выпуска`, `Дата последнего тех осмотра`, `Код филиала`) VALUES
(1, 1, 2015, '2016-10-13 00:00:00', 1),
(2, 6, 2017, '2017-08-22 00:00:00', 1),
(3, 6, 2013, '2014-10-06 00:00:00', 1),
(4, 11, 2016, '2020-10-04 00:00:00', 1),
(5, 10, 2018, '2019-09-12 00:00:00', 1),
(6, 10, 2019, '2019-09-16 00:00:00', 1),
(7, 11, 2016, '2018-09-26 00:00:00', 1),
(8, 2, 2017, '2018-09-26 00:00:00', 1),
(9, 12, 2019, '2020-11-05 00:00:00', 1),
(10, 2, 2013, '2013-07-28 00:00:00', 1),
(11, 1, 1998, '2005-09-16 00:00:00', 1),
(12, 8, 2000, '2012-09-06 00:00:00', 1),
(14, 11, 1996, '2015-10-07 00:00:00', 1),
(15, 3, 2015, '2015-05-12 00:00:00', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `сотрудник`
--

CREATE TABLE `сотрудник` (
  `Код сотрудника` int(11) NOT NULL,
  `Фамилия` varchar(25) DEFAULT NULL,
  `Имя` varchar(25) DEFAULT NULL,
  `Отчество` varchar(25) DEFAULT NULL,
  `Дата окончания исп срока` datetime DEFAULT NULL,
  `Дата трудоустройства` datetime DEFAULT NULL,
  `Код филиала` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `сотрудник`
--

INSERT INTO `сотрудник` (`Код сотрудника`, `Фамилия`, `Имя`, `Отчество`, `Дата окончания исп срока`, `Дата трудоустройства`, `Код филиала`) VALUES
(1, 'Гриневская', 'Тамара', 'Виталиевна', NULL, '2018-08-16 00:00:00', 1),
(2, 'Вишнякова', 'Светлана', 'Валерьевна', NULL, '2019-05-15 00:00:00', 1),
(3, 'Шуфрич', 'Пелагея', 'Юхимовна', NULL, '2019-09-20 00:00:00', 1),
(4, 'Евдокимова', 'Тамара', 'Валерьевна', NULL, '2018-04-11 00:00:00', 1),
(5, 'Лихачёва', 'Георгина', 'Фёдоровна', NULL, '2016-06-30 00:00:00', 1),
(6, 'Вишняков', 'Иван', 'Данилович', NULL, '2017-03-17 00:00:00', 1),
(7, 'Гребневска', 'Ольга', 'Эдуардовна', NULL, '2018-05-24 00:00:00', 1),
(8, 'Орехов', 'Назар', 'Виталиевич', NULL, '2016-11-10 00:00:00', 1),
(9, 'Хованский', 'Тит', 'Максимович', NULL, '2014-12-18 00:00:00', 1),
(10, 'Борисенко', 'Павел', 'Данилович', NULL, '2017-09-26 00:00:00', 1),
(11, 'Казаков', 'Иван', 'Сергеевич', NULL, '2016-04-21 00:00:00', 1),
(14, 'Петров', 'Сергей', 'Николаевич', NULL, '2020-05-04 00:00:00', 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branch_code`);

--
-- Индексы таблицы `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`company_code`),
  ADD UNIQUE KEY `Код компании` (`company_code`),
  ADD KEY `Код компании_2` (`company_code`);

--
-- Индексы таблицы `fuel_provider`
--
ALTER TABLE `fuel_provider`
  ADD PRIMARY KEY (`provider_code`);

--
-- Индексы таблицы `fuel_purchase`
--
ALTER TABLE `fuel_purchase`
  ADD PRIMARY KEY (`purchase_code`),
  ADD UNIQUE KEY `purchase_code` (`purchase_code`),
  ADD KEY `Код филиала` (`branch_code`),
  ADD KEY `Код поставщика` (`provider_code`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`Код заказа`),
  ADD KEY `Код заказа` (`Код заказа`),
  ADD KEY `Код филиала` (`Код филиала`),
  ADD KEY `Код диспетчера` (`Код диспетчера`,`Код пилота`,`Код клиента`,`Код вертолета`),
  ADD KEY `Код клиента` (`Код клиента`);

--
-- Индексы таблицы `менеджер`
--
ALTER TABLE `менеджер`
  ADD PRIMARY KEY (`Код сотрудника`),
  ADD UNIQUE KEY `Код сотрудника` (`Код сотрудника`),
  ADD KEY `Код сотрудника_2` (`Код сотрудника`);

--
-- Индексы таблицы `модель вертолета`
--
ALTER TABLE `модель вертолета`
  ADD PRIMARY KEY (`Код модели`),
  ADD UNIQUE KEY `Код модели` (`Код модели`),
  ADD KEY `Код модели_2` (`Код модели`);

--
-- Индексы таблицы `диспетчер`
--
ALTER TABLE `диспетчер`
  ADD PRIMARY KEY (`Код сотрудника`),
  ADD UNIQUE KEY `Код сотрудника` (`Код сотрудника`);

--
-- Индексы таблицы `клиент`
--
ALTER TABLE `клиент`
  ADD PRIMARY KEY (`Код клиента`),
  ADD UNIQUE KEY `Код клиента` (`Код клиента`),
  ADD KEY `Код клиента_2` (`Код клиента`);

--
-- Индексы таблицы `пилот`
--
ALTER TABLE `пилот`
  ADD PRIMARY KEY (`Код сотрудника`),
  ADD KEY `Код сотрудника` (`Код сотрудника`);

--
-- Индексы таблицы `переаттестация`
--
ALTER TABLE `переаттестация`
  ADD PRIMARY KEY (`Дата аттестации`,`Код пилота`),
  ADD KEY `Код пилота` (`Код пилота`);

--
-- Индексы таблицы `вертолет`
--
ALTER TABLE `вертолет`
  ADD PRIMARY KEY (`Код вертолета`),
  ADD UNIQUE KEY `Код вертолета` (`Код вертолета`),
  ADD KEY `Код вертолета_2` (`Код вертолета`),
  ADD KEY `Код филиала` (`Код филиала`),
  ADD KEY `Код модели` (`Код модели`);

--
-- Индексы таблицы `сотрудник`
--
ALTER TABLE `сотрудник`
  ADD PRIMARY KEY (`Код сотрудника`),
  ADD UNIQUE KEY `Код сотрудника` (`Код сотрудника`),
  ADD KEY `Код сотрудника_2` (`Код сотрудника`),
  ADD KEY `Код филиала` (`Код филиала`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `branch`
--
ALTER TABLE `branch`
  MODIFY `branch_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT для таблицы `fuel_provider`
--
ALTER TABLE `fuel_provider`
  MODIFY `provider_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT для таблицы `fuel_purchase`
--
ALTER TABLE `fuel_purchase`
  MODIFY `purchase_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `branch`
--
ALTER TABLE `branch`
  ADD CONSTRAINT `branch_ibfk_1` FOREIGN KEY (`company_code`) REFERENCES `company` (`company_code`);

--
-- Ограничения внешнего ключа таблицы `fuel_purchase`
--
ALTER TABLE `fuel_purchase`
  ADD CONSTRAINT `fuel_purchase_ibfk_1` FOREIGN KEY (`branch_code`) REFERENCES `branch` (`branch_code`),
  ADD CONSTRAINT `fuel_purchase_ibfk_2` FOREIGN KEY (`provider_code`) REFERENCES `fuel_provider` (`provider_code`);

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Код филиала`) REFERENCES `branch` (`branch_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`Код клиента`) REFERENCES `клиент` (`Код клиента`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `менеджер`
--
ALTER TABLE `менеджер`
  ADD CONSTRAINT `менеджер_ibfk_1` FOREIGN KEY (`Код сотрудника`) REFERENCES `сотрудник` (`Код сотрудника`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `диспетчер`
--
ALTER TABLE `диспетчер`
  ADD CONSTRAINT `диспетчер_ibfk_1` FOREIGN KEY (`Код сотрудника`) REFERENCES `сотрудник` (`Код сотрудника`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `пилот`
--
ALTER TABLE `пилот`
  ADD CONSTRAINT `пилот_ibfk_1` FOREIGN KEY (`Код сотрудника`) REFERENCES `сотрудник` (`Код сотрудника`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `переаттестация`
--
ALTER TABLE `переаттестация`
  ADD CONSTRAINT `переаттестация_ibfk_1` FOREIGN KEY (`Код пилота`) REFERENCES `пилот` (`Код сотрудника`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `вертолет`
--
ALTER TABLE `вертолет`
  ADD CONSTRAINT `вертолет_ibfk_1` FOREIGN KEY (`Код филиала`) REFERENCES `branch` (`branch_code`),
  ADD CONSTRAINT `вертолет_ibfk_2` FOREIGN KEY (`Код модели`) REFERENCES `модель вертолета` (`Код модели`);

--
-- Ограничения внешнего ключа таблицы `сотрудник`
--
ALTER TABLE `сотрудник`
  ADD CONSTRAINT `сотрудник_ibfk_1` FOREIGN KEY (`Код филиала`) REFERENCES `branch` (`branch_code`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
