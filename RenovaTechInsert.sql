-- INSERCIÓN Y VISUALIZACIÓN DE DATOS
INSERT INTO participantes (DNI, nombres, razon_social, tipo, correo, contrasena, fecha_registro, estado_cuenta) VALUES
('12345678','Juan Perez',NULL,'Ciudadano','juan@gmail.com','clave12345',GETDATE(),'Activo'),
('87654321','Maria Lopez','Empresa Verde SAC','Empresa','maria@gmail.com','verde2026',GETDATE(),'Activo'),
('11223344','Carlos Ruiz','EcoLife ONG','Organizacion','carlos@gmail.com','ecolife01',GETDATE(),'Activo');
 
INSERT INTO categorias (categoria) VALUES
('Reciclaje'),
('Energia');
 
INSERT INTO proyectos (nombre, descripcion, tipo, nivel_impacto, ubicacion, fecha_inicio, fecha_fin, estado) VALUES
('Reciclaje Urbano','Programa de reciclaje en zonas urbanas','Reciclaje','Alto','Lima',GETDATE(),GETDATE(),'En proceso'),
('Energia Solar','Implementacion de paneles solares','Energia','Alto','Cusco',GETDATE(),GETDATE(),'En proceso');
 
INSERT INTO recursos (nombre, tipo, stock) VALUES
('Contenedores','Material',20.00),
('Panel Solar','Equipo',15.00);
 
INSERT INTO actividades (ID_proyecto, nombre, descripcion, fecha_inicio, fecha_fin, estado) VALUES
(1,'Recoleccion','Recolectar residuos reciclables',GETDATE(),GETDATE(),'En proceso');
 
INSERT INTO direcciones (ID_participante, direccion) VALUES
(1,'Av. Los Alamos 123'),
(2,'Jr. Primavera 456'),
(3,'Av. Central 789');
 
INSERT INTO telefonos (ID_participante, telefono) VALUES
(1,'987654321'),
(2,'912345678'),
(3,'999888777');
 
INSERT INTO equipo_proyecto (ID_participante, ID_proyecto, rol_participante) VALUES
(1,1,'Coordinador'),
(2,1,'Supervisor'),
(3,2,'Asesor');
 
INSERT INTO proyecto_categorias (ID_proyecto, ID_categoria) VALUES
(1,1),
(2,2);
 
INSERT INTO responsables_actividad (ID_actividad, ID_participante) VALUES
(1,1),
(1,2);
 
INSERT INTO recursos_actividad (ID_recurso, ID_actividad) VALUES
(1,1);
 
INSERT INTO aportes (ID_proyecto, ID_participante, monto, fecha, medio_pago, estado_transaccion) VALUES
(1,1,150.00,GETDATE(),'Yape','Completado'),
(2,2,300.00,GETDATE(),'Transferencia','Pendiente');
 
INSERT INTO comentarios (ID_participante, ID_proyecto, mensaje, fecha, calificacion) VALUES
(1,1,'Excelente iniciativa ambiental',GETDATE(),5),
(2,2,'Muy buen proyecto sostenible',GETDATE(),4);
 
INSERT INTO metricas_ambientales (ID_proyecto, tipo_indicador, valor_medido, fecha_registro) VALUES
(1,'CO2 Reducido',250.50,GETDATE()),
(2,'Energia Ahorrada',500.75,GETDATE());
 
INSERT INTO reportes (ID_proyecto, titulo, descripcion, fecha_generacion, tipo_reporte) VALUES
(1,'Reporte Inicial','Reporte del avance del proyecto de reciclaje',GETDATE(),'Avance'),
(2,'Reporte Solar','Reporte de implementacion de paneles solares',GETDATE(),'Impacto');
 
SELECT * FROM participantes;
SELECT * FROM direcciones;
SELECT * FROM telefonos;
SELECT * FROM proyectos;
SELECT * FROM categorias;
SELECT * FROM actividades;
SELECT * FROM recursos;
SELECT * FROM aportes;
SELECT * FROM comentarios;
SELECT * FROM metricas_ambientales;
SELECT * FROM reportes;
SELECT * FROM equipo_proyecto;
SELECT * FROM proyecto_categorias;
SELECT * FROM responsables_actividad;
SELECT * FROM recursos_actividad;
