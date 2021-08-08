
CREATE TABLE `direccion` (
  `id_direccion` int AUTO_INCREMENT,
  `calle` varchar(255) DEFAULT NULL,
  `numero` varchar(255) DEFAULT NULL,
  `ciudad` varchar(255) NOT NULL,
  PRIMARY KEY (`id_direccion`),
  UNIQUE KEY `id` (`id_direccion`)
);

CREATE TABLE `grado` (
  `id_grado` int AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id_grado`),
  UNIQUE KEY `id` (`id_grado`),
  UNIQUE KEY `id_grado` (`id_grado`)
);

CREATE TABLE `curso_escolar` (
  `id_curso` int AUTO_INCREMENT,
  `anno_inicio` year DEFAULT NULL,
  `anno_fin` year DEFAULT NULL,
  PRIMARY KEY (`id_curso`),
  UNIQUE KEY `id_curso` (`id_curso`)
);

CREATE TABLE `departamento` (
  `id_departamento` int AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id_departamento`),
  UNIQUE KEY `id_departamento` (`id_departamento`)
);


CREATE TABLE `persona` (
  `id_persona` int AUTO_INCREMENT,
  `nif` varchar(15) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellido_p` varchar(255) NOT NULL,
  `apellido_m` varchar(255) NOT NULL,
  `telefono` varchar(12) DEFAULT NULL,
  `sexo` enum('H','M') DEFAULT NULL,
  `id_direccion_fk` int DEFAULT NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE KEY `id_persona` (`id_persona`),
  KEY `id_direccion_fk` (`id_direccion_fk`),
  CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`id_direccion_fk`) REFERENCES `direccion` (`id_direccion`)
);


CREATE TABLE `profesor` (
  `id_profesor` int AUTO_INCREMENT,
  `id_persona_fk` int NOT NULL,
  `id_departamento_fk` int DEFAULT NULL,
  PRIMARY KEY (`id_profesor`),
  KEY `id_departamento_fk` (`id_departamento_fk`),
  KEY `id_persona_fk` (`id_persona_fk`),
  UNIQUE KEY `id_persona` (`id_persona_fk`),
  CONSTRAINT `profesor_ibfk_2` FOREIGN KEY (`id_departamento_fk`) REFERENCES `departamento` (`id_departamento`),
  CONSTRAINT `profesor_ibfk_3` FOREIGN KEY (`id_persona_fk`) REFERENCES `persona` (`id_persona`)
);

CREATE TABLE `alumno` (
  `id_alumno` int AUTO_INCREMENT,
  `matricula` varchar(10) DEFAULT NULL,
  `cuatrimestre` tinyint DEFAULT NULL,
  `id_persona_fk` int DEFAULT NULL,
  `anno_nacimiento` year NOT NULL,
  PRIMARY KEY (`id_alumno`),
  KEY `id_persona_fk` (`id_persona_fk`),
  UNIQUE KEY `id_persona` (`id_persona_fk`),
  CONSTRAINT `alumno_ibfk_1` FOREIGN KEY (`id_persona_fk`) REFERENCES `persona` (`id_persona`)
);

CREATE TABLE `asignatura` (
  `id_asignatura` int AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `creditos` tinyint DEFAULT NULL,
  `tipo` enum('básica','obligatoria','optativa') DEFAULT NULL,
  `cuatrimestre` tinyint DEFAULT NULL,
  `id_grado_fk` int DEFAULT NULL,
  `id_departamento_fk` int DEFAULT NULL,
  PRIMARY KEY (`id_asignatura`),
  UNIQUE KEY `id_asignatura` (`id_asignatura`),
  KEY `id_departamento_fk` (`id_departamento_fk`),
  CONSTRAINT `asignatura_ibfk_1` FOREIGN KEY (`id_departamento_fk`) REFERENCES `departamento` (`id_departamento`)
);


CREATE TABLE `grupo` (
  `id_grupo` int NOT NULL AUTO_INCREMENT,
  `id_asignatura_fk` int NOT NULL,
  `id_profesor_fk` int DEFAULT NULL,
  `id_curso_fk` int NOT NULL,
  PRIMARY KEY (`id_grupo`),
  KEY `id_asignatura_fk` (`id_asignatura_fk`),
  KEY `id_profesor_fk` (`id_profesor_fk`),
  KEY `id_curso_fk` (`id_curso_fk`),
  CONSTRAINT `grupo_ibfk_1` FOREIGN KEY (`id_asignatura_fk`) REFERENCES `asignatura` (`id_asignatura`),
  CONSTRAINT `grupo_ibfk_2` FOREIGN KEY (`id_profesor_fk`) REFERENCES `profesor` (`id_profesor`),
  CONSTRAINT `grupo_ibfk_3` FOREIGN KEY (`id_curso_fk`) REFERENCES `curso_escolar` (`id_curso`)
);


CREATE TABLE `grupo_alumno` (
  `id_grupoalumno` int NOT NULL AUTO_INCREMENT,
  `id_alumno_fk` int NOT NULL,
  `id_grupo_fk` int NOT NULL,
  PRIMARY KEY (`id_grupoalumno`),
  KEY `id_alumno_fk` (`id_alumno_fk`),
  KEY `id_grupo_fk` (`id_grupo_fk`),
  CONSTRAINT `grupo_alumno_ibfk_1` FOREIGN KEY (`id_alumno_fk`) REFERENCES `alumno` (`id_alumno`),
  CONSTRAINT `grupo_alumno_ibfk_2` FOREIGN KEY (`id_grupo_fk`) REFERENCES `grupo` (`id_grupo`)
);
