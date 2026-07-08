
-- Proyectos con al menos un aporte COMPLETADO.
SELECT p.ID_proyecto, p.nombre
FROM proyectos p
WHERE EXISTS (
    SELECT 1
    FROM aportes a
    WHERE a.ID_proyecto = p.ID_proyecto
      AND a.estado_transaccion = 'Completado'
);
 
-- Calificacion promedio por proyecto
SELECT
    p.nombre,
    (SELECT AVG(c.calificacion * 1.0)
     FROM comentarios c
     WHERE c.ID_proyecto = p.ID_proyecto) AS calificacion_promedio
FROM proyectos p;
 
 
-- Impacto ambiental total por proyecto.
SELECT ip.ID_proyecto, ip.impacto_total
FROM (
    SELECT ID_proyecto, SUM(valor_medido) AS impacto_total
    FROM metricas_ambientales
    GROUP BY ID_proyecto
) AS ip
WHERE ip.impacto_total > 0;
 
 
-- Proyectos cuyo total recaudado supera el promedio de recaudacion por proyecto
SELECT rp.ID_proyecto, rp.total_recaudado
FROM (
    SELECT ID_proyecto, SUM(monto) AS total_recaudado
    FROM aportes
    GROUP BY ID_proyecto
) AS rp
WHERE rp.total_recaudado > (
    SELECT AVG(t.total_recaudado)
    FROM (
        SELECT ID_proyecto, SUM(monto) AS total_recaudado
        FROM aportes
        GROUP BY ID_proyecto
    ) AS t
);
GO

  
-- Proyectos con mas de un aporte.
CREATE VIEW ProyectosConVariosAportes AS
SELECT p.ID_proyecto, p.nombre, COUNT(a.ID_aporte) AS total_aportes
FROM proyectos p
JOIN aportes a ON a.ID_proyecto = p.ID_proyecto
GROUP BY p.ID_proyecto, p.nombre
HAVING COUNT(a.ID_aporte) > 1;
GO
SELECT * FROM ProyectosConVariosAportes;
GO
 
 
-- Proyectos con al menos un aporte por encima del promedio global de aportes.
CREATE VIEW ProyectosAporteSobrePromedio AS
SELECT p.ID_proyecto, p.nombre
FROM proyectos p
WHERE EXISTS (
    SELECT 1
    FROM aportes a
    WHERE a.ID_proyecto = p.ID_proyecto
      AND a.monto > (SELECT AVG(monto) FROM aportes)
);
GO
SELECT * FROM ProyectosAporteSobrePromedio;
GO
