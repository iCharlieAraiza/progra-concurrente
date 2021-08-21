DELIMITER //
	
CREATE PROCEDURE alumno_informacion (IN id_alumno_sp INT)
BEGIN

	SELECT asignatura.nombre, CONCAT(persona.nombre, ' ' , persona.apellido_p, ' ' , persona.apellido_m) FROM persona
	INNER JOIN alumno ON alumno.id_persona_fk = persona.id_persona AND alumno.id_alumno = id_alumno_sp
	INNER JOIN grupo_alumno ON alumno.id_alumno = grupo_alumno.id_alumno_fk
	INNER JOIN grupo ON grupo.id_grupo = grupo_alumno.id_grupo_fk
	INNER JOIN asignatura ON asignatura.id_asignatura = grupo.id_asignatura_fk;

END//
DELIMITER ;



DELIMITER //
	
CREATE PROCEDURE lista_asignaturas ( IN id_asignatura_sp INT)
BEGIN


SELECT asignatura.nombre, CONCAT(persona.nombre, ' ' , persona.apellido_p, ' ' , persona.apellido_m) FROM persona
	INNER JOIN alumno ON alumno.id_persona_fk = persona.id_persona
	INNER JOIN grupo_alumno ON alumno.id_alumno = grupo_alumno.id_alumno_fk
	INNER JOIN grupo ON grupo.id_grupo = grupo_alumno.id_grupo_fk AND grupo.id_asignatura_fk = id_asignatura_sp
	INNER JOIN asignatura ON asignatura.id_asignatura = grupo.id_asignatura_fk;


END//
DELIMITER ;




DROP PROCEDURE IF EXISTS alumno_informacion_lista_asignaturas;

DELIMITER //
	
	
	SELECT asignatura.nombre, CONCAT(persona.nombre, ' ' , persona.apellido_p, ' ' , persona.apellido_m) 
	, (
			SELECT asignatura.nombre, CONCAT(persona.nombre, ' ' , persona.apellido_p, ' ' , persona.apellido_m) FROM persona
		INNER JOIN alumno ON alumno.id_persona_fk = persona.id_persona AND alumno.id_alumno = id_alumno_sp
		INNER JOIN grupo_alumno ON alumno.id_alumno = grupo_alumno.id_alumno_fk
		INNER JOIN grupo ON grupo.id_grupo = grupo_alumno.id_grupo_fk
		INNER JOIN asignatura ON asignatura.id_asignatura = grupo.id_asignatura_fk;
	)AS alumno_info
	FROM persona
	INNER JOIN alumno ON alumno.id_persona_fk = persona.id_persona
	INNER JOIN grupo_alumno ON alumno.id_alumno = grupo_alumno.id_alumno_fk
	INNER JOIN grupo ON grupo.id_grupo = grupo_alumno.id_grupo_fk AND grupo.id_asignatura_fk = id_asignatura_sp
	INNER JOIN asignatura ON asignatura.id_asignatura = grupo.id_asignatura_fk;


END//
DELIMITER ;



CALL alumno_informacion(2);
CALL lista_asignaturas(2);

