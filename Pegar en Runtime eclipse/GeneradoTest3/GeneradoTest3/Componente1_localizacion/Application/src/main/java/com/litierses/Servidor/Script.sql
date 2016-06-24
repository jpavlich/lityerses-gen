
CREATE TABLE IF NOT EXISTS `dieta` (
  `nombre` varchar(20) NOT NULL,
  `desayuno` varchar(30) NOT NULL,
  `almuerzo` varchar(30) NOT NULL,
  `cena` varchar(30) NOT NULL,
  `merienda` varchar(30) NOT NULL,
  `id` varchar(20) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/
INSERT INTO `dieta` (`nombre`, `desayuno`, `almuerzo`, `cena`, `merienda`, `id`) VALUES
('Dieta Lunes', 'Huevos sin sal', 'Ensalada de tomtate', 'Verduras con patatas', 'Manzana', '1'),
('Dieta Martes', 'Batido de frutas', 'Pollo', 'Arroz o sarraceno', 'Sopa de Verduras', '2'),
('Dieta Miercoles', 'Leche vegetal o kefir', 'Verdura como primer plato', 'Vegetales a la plancha', 'Mani', '3'),
('Dieta Jueves', 'Cereales calientes', 'Purés vegetales', 'Ensalada ', 'Yogurth', '4');

