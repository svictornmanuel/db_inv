-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-08-2025 a las 21:11:27
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_inv`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id_categorias` int(15) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id_categorias`, `nombre`, `descripcion`) VALUES
(1, 'Crasuláceas', 'suculentas de las especies Echeverias, Sedums'),
(2, 'Aizoáceas', 'suculentas Lithops o piedras vivas'),
(3, 'Cactáceas', 'Cactus ornamentales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `existencias`
--

CREATE TABLE `existencias` (
  `id_existencias` int(11) NOT NULL,
  `id_productos` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `existencias`
--

INSERT INTO `existencias` (`id_existencias`, `id_productos`, `cantidad`) VALUES
(1, 1, 97),
(2, 2, 65),
(3, 3, 50),
(4, 4, 92),
(5, 5, 84);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_productos` int(15) NOT NULL,
  `id_categorias` int(15) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `precio` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_productos`, `id_categorias`, `nombre`, `descripcion`, `precio`) VALUES
(1, 2, 'Planta Piedra', 'Lithops karasmontana: especie de planta suculenta perteneciente a la familia Aizoaceae nativa de Namibia.', 10000.00),
(2, 1, 'Rosa de Alabastro', 'La Echeveria elegans o rosa de alabastro es una de las suculentas más bonitas y conocidas del mundo pertenenciente a la familia Crassulaceae', 8500.00),
(3, 1, 'Cola de borrego', 'Sedum morganianum es una especie de planta suculenta, nativa del sur de México.pertenece a la familia Crassulaceae', 8500.00),
(4, 3, 'Cactus Mammillaria elongata', 'Mammillaria elongata endémica del estado de Hidalgo, Guanajuato y estado de Querétaro en México.', 8500.00),
(5, 3, 'Cactus erizo', 'Kroenleinia grusonii, llamado comúnmente cactus erizo. Es endémico del centro de México, desde Tamaulipas hasta el Estado de Hidalgo, y a pesar de ser uno de los cactus más populares', 8500.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_ventas` int(15) NOT NULL,
  `fecha` varchar(50) NOT NULL,
  `valor` decimal(30,2) NOT NULL,
  `nombre_cliente` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id_ventas`, `fecha`, `valor`, `nombre_cliente`) VALUES
(1, '30-07-2025', 38500.00, 'Victor Sanchez');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ven_productos`
--

CREATE TABLE `ven_productos` (
  `id_ven_productos` int(11) NOT NULL,
  `id_ventas` int(15) NOT NULL,
  `id_productos` int(15) NOT NULL,
  `cantidad` int(15) NOT NULL,
  `precio_unidad` decimal(30,2) NOT NULL,
  `subtotal` decimal(10,2) GENERATED ALWAYS AS (`cantidad` * `precio_unidad`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `ven_productos`
--

INSERT INTO `ven_productos` (`id_ven_productos`, `id_ventas`, `id_productos`, `cantidad`, `precio_unidad`) VALUES
(1, 1, 1, 3, 10000.00),
(2, 1, 4, 1, 8500.00);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categorias`);

--
-- Indices de la tabla `existencias`
--
ALTER TABLE `existencias`
  ADD PRIMARY KEY (`id_existencias`),
  ADD KEY `id_productos` (`id_productos`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_productos`),
  ADD KEY `id_categorias` (`id_categorias`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_ventas`);

--
-- Indices de la tabla `ven_productos`
--
ALTER TABLE `ven_productos`
  ADD PRIMARY KEY (`id_ven_productos`),
  ADD KEY `id_ventas` (`id_ventas`,`id_productos`),
  ADD KEY `id_productos` (`id_productos`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `existencias`
--
ALTER TABLE `existencias`
  ADD CONSTRAINT `existencias_ibfk_1` FOREIGN KEY (`id_productos`) REFERENCES `productos` (`id_productos`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categorias`) REFERENCES `categorias` (`id_categorias`);

--
-- Filtros para la tabla `ven_productos`
--
ALTER TABLE `ven_productos`
  ADD CONSTRAINT `ven_productos_ibfk_1` FOREIGN KEY (`id_productos`) REFERENCES `productos` (`id_productos`),
  ADD CONSTRAINT `ven_productos_ibfk_2` FOREIGN KEY (`id_ventas`) REFERENCES `ventas` (`id_ventas`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
