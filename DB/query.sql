SELECT persona.nombre, persona.apellido_m, persona.apellido_p from persona INNER JOIN alumno ON alumno.id_persona_fk = persona.id_persona;



SELECT persona.nombre, persona.apellido_p, persona.apellido_m, departamento.nombre FROM departamento 
	INNER JOIN profesor ON departamento.id_departamento = profesor.id_departamento_fk
	INNER JOIN persona ON persona.id_persona = profesor.id_persona_fk; 
	


SELECT persona.nombre, persona.apellido_p, persona.apellido_m, persona.sexo FROM profesor
	INNER JOIN persona ON profesor.id_persona_fk = persona.id_persona AND profesor.id_departamento_fk IS NULL;


SELECT COUNT(*) FROM alumno;


SELECT asignatura.nombre, CONCAT(persona.nombre, ' ' , persona.apellido_p, ' ' , persona.apellido_m) FROM persona
	INNER JOIN alumno ON alumno.id_persona_fk = persona.id_persona AND alumno.id_alumno = 1
	INNER JOIN grupo_alumno ON alumno.id_alumno = grupo_alumno.id_alumno_fk
	INNER JOIN grupo ON grupo.id_grupo = grupo_alumno.id_grupo_fk
	INNER JOIN asignatura ON asignatura.id_asignatura = grupo.id_asignatura_fk;


SELECT persona.nombre, persona.apellido_p, persona.apellido_m, asignatura.nombre FROM persona
	INNER JOIN profesor ON persona.id_persona = profesor.id_persona_fk
	INNER JOIN grupo ON grupo.id_profesor_fk = profesor.id_profesor
	INNER JOIN asignatura ON asignatura.id_asignatura = grupo.id_asignatura_fk;
	
	
SELECT asignatura.nombre, CONCAT(persona.nombre, ' ' , persona.apellido_p, ' ' , persona.apellido_m) FROM persona
	INNER JOIN alumno ON alumno.id_persona_fk = persona.id_persona
	INNER JOIN grupo_alumno ON alumno.id_alumno = grupo_alumno.id_alumno_fk
	INNER JOIN grupo ON grupo.id_grupo = grupo_alumno.id_grupo_fk AND grupo.id_asignatura_fk = 1
	INNER JOIN asignatura ON asignatura.id_asignatura = grupo.id_asignatura_fk;
