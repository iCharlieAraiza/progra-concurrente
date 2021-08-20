CREATE VIEW lista_datos AS
SELECT persona.nombre, persona.apellido_m, persona.apellido_p from persona INNER JOIN alumno ON alumno.id_persona_fk = persona.id_persona;
