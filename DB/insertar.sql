

INSERT INTO `direccion` (`calle`, `numero`, `ciudad`) VALUES
( 'Calle 123', '1', 'Ciudad de México'),
( 'Unidad 2', '30', 'Edo. de Mex.'),
( 'Calle norte', '2', 'Puebla'),
( 'Av Principal', '202', 'Monterrey'),
( 'Calle sut', '2', 'Ciudad de México'),
( 'Calle 34', '1', 'Ciudad de México');

INSERT INTO `persona` ( `nif`, `nombre`, `apellido_p`, `apellido_m`, `telefono`, `sexo`, `id_direccion_fk`) VALUES
( '0001', 'Juan', 'Pérez', 'Gonzalez', '22-2233-32', 'H', 2),
( '10203', 'María', 'Hernández', 'López', '11-4442-33', 'M', 1),
( '01923', 'Carlos', 'Suárez', 'Díaz', '55-2224-3', 'H', 4),
( '45332', 'Brenda', 'Guerrero', 'Ríos', '22-3456-21', 'M', 3),
( '33414', 'Lucas', 'González', 'Dominguez', '23-5532-123', 'H', 5),
( '12345', 'Adriana', 'Zavala', 'Villagómez', '32-3423-53', 'M', 6);

INSERT INTO `alumno` ( `matricula`, `cuatrimestre`, `id_persona_fk`, `anno_nacimiento`) VALUES
('1234', 2, 1, '1999'),
('1235', 2, 3, '1993'),
('1342', 1, 4, '1999'),
('2344', 3, 5, '2002');

INSERT INTO `departamento` (`id_departamento`, `nombre`) VALUES
(1, 'Matemáticas'),
(2, 'Informática');

INSERT INTO `profesor` (`id_profesor`, `id_persona_fk`, `id_departamento_fk`) VALUES
(1, 2, 1),
(2, 6, 2);

INSERT INTO `curso_escolar` (`id_curso`, `anno_inicio`, `anno_fin`) VALUES
(1, '2018', '2019'),
(2, '2019', '2020'),
(3, '2020', '2021'),
(4, '2021', '2022');

INSERT INTO `asignatura` (`id_asignatura`, `nombre`, `creditos`, `tipo`, `cuatrimestre`, `id_grado_fk`, `id_departamento_fk`) VALUES
(1, 'Calculo', 12, 'básica', 1, NULL, 1),
(2, 'Ec. Diferenciales', 10, 'básica', 2, NULL, 1),
(3, 'Programación concurente', 12, 'obligatoria', 4, NULL, 2);

INSERT INTO `grupo` (`id_grupo`, `id_asignatura_fk`, `id_profesor_fk`, `id_curso_fk`) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2);

INSERT INTO `grupo_alumno` (`id_grupoalumno`, `id_alumno_fk`, `id_grupo_fk`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 2, 2),
(5, 4, 2);
