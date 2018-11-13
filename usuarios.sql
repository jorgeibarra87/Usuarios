-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-11-2018 a las 18:39:10
-- Versión del servidor: 10.1.34-MariaDB
-- Versión de PHP: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `usuarios`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `identificacion` int(11) NOT NULL,
  `fechanac` date NOT NULL,
  `genero` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `estadocivil` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(300) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `nombre`, `identificacion`, `fechanac`, `genero`, `estadocivil`, `direccion`, `telefono`, `created_at`) VALUES
(1, 'usuario 1', 111, '1980-01-01', 'M', 'soltero', 'Carrera 1', '1111111111', '2018-11-12 13:20:19'),
(2, 'usuario 2', 222, '1985-02-02', 'F', 'casado', 'Carrera 2', '2222222222', '2018-11-12 13:20:19'),
(3, 'usuario 3', 333, '1980-03-03', 'M', 'casado', 'Carrera 3', '3333333333', '2018-11-12 13:20:19'),
(4, 'usuario 4', 444, '1985-04-04', 'M', 'casado', 'Carrera 4', '4444444444', '2018-11-12 13:20:19'),
(5, 'usuario 5', 555, '1980-05-05', 'M', 'soltero', 'Carrera 5', '5555555555', '2018-11-12 13:20:19'),
(6, 'usuario 6', 1, '1980-06-06', 'F', 'soltero', 'Carrera 6', '0000101010', '2018-11-12 13:20:19'),
(7, 'usuario 7', 777, '1985-07-07', 'F', 'soltero', 'Carrera 7', '7777777', '2018-11-12 13:20:19'),
(8, 'usuario 8', 888, '1980-05-08', 'M', 'soltero', 'Carrera 8', '888888', '2018-11-12 13:20:19'),
(9, 'usuario 9', 999, '1985-02-09', 'F', 'soltero', 'carrera 9', '9999999999', '2018-11-12 13:20:19');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
