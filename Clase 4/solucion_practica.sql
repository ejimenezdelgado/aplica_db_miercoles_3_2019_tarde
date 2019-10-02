
CREATE VIEW vista_1 AS

	SELECT socios.nombre,socios.documento,
	       socios.domicilio,
	       cursos.deporte,cursos.dia,
	       profesores.nombre as profesor,
	       inscriptos.matricula
	FROM   socios JOIN inscriptos
	ON     socios.documento=inscriptos.documentosocio
	JOIN   cursos 
	ON     inscriptos.numero=cursos.numero
	JOIN   profesores
	ON     cursos.documentoprofesor= profesores.documento


SELECT nombre FROM vista_1


SELECT
  deporte,
  dia,
  COUNT(nombre) AS cantidad
FROM vista_1
WHERE deporte IS NOT NULL
GROUP BY deporte,
         dia
ORDER BY cantidad;