IF DB_ID('RenovaTech') IS NOT NULL
BEGIN
    ALTER DATABASE RenovaTech SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RenovaTech;
END
GO

CREATE DATABASE RenovaTech;
GO

USE RenovaTech;
GO

CREATE TABLE participantes(
    ID_participante INT IDENTITY(1,1) PRIMARY KEY,
    DNI CHAR(8) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    razon_social VARCHAR(200) NULL,
    tipo VARCHAR(50) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    contrasena VARCHAR(120) NOT NULL,
    fecha_registro DATETIME NOT NULL,
    estado_cuenta VARCHAR(12) NOT NULL
);

CREATE TABLE direcciones(
    ID_direccion INT IDENTITY(1,1) PRIMARY KEY,
    ID_participante INT NOT NULL,
    direccion VARCHAR(150) NOT NULL
);

CREATE TABLE telefonos(
    ID_telefono INT IDENTITY(1,1) PRIMARY KEY,
    ID_participante INT NOT NULL,
    telefono VARCHAR(9) NOT NULL
);

CREATE TABLE proyectos(
    ID_proyecto INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(300) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    nivel_impacto VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(150) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE categorias(
    ID_categoria INT IDENTITY(1,1) PRIMARY KEY,
    categoria VARCHAR(40) NOT NULL
);

CREATE TABLE actividades(
    ID_actividad INT IDENTITY(1,1) PRIMARY KEY,
    ID_proyecto INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(300) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado VARCHAR(15) NOT NULL
);

CREATE TABLE recursos(
    ID_recurso INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    stock NUMERIC(10,2) NOT NULL
);

CREATE TABLE aportes(
    ID_aporte INT IDENTITY(1,1) PRIMARY KEY,
    ID_proyecto INT NOT NULL,
    ID_participante INT NOT NULL,
    monto NUMERIC(10,2) NOT NULL,
    fecha DATETIME NOT NULL,
    medio_pago VARCHAR(20) NOT NULL,
    estado_transaccion VARCHAR(15) NOT NULL
);

CREATE TABLE comentarios(
    ID_comentario INT IDENTITY(1,1) PRIMARY KEY,
    ID_participante INT NOT NULL,
    ID_proyecto INT NOT NULL,
    mensaje VARCHAR(300) NOT NULL,
    fecha DATETIME NOT NULL,
    calificacion INT NOT NULL
);

CREATE TABLE metricas_ambientales(
    ID_metricas INT IDENTITY(1,1) PRIMARY KEY,
    ID_proyecto INT NOT NULL,
    tipo_indicador VARCHAR(50) NOT NULL,
    valor_medido NUMERIC(10,2) NOT NULL,
    fecha_registro DATETIME NOT NULL
);

CREATE TABLE reportes(
    ID_reporte INT IDENTITY(1,1) PRIMARY KEY,
    ID_proyecto INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    descripcion VARCHAR(300) NOT NULL,
    fecha_generacion DATETIME NOT NULL,
    tipo_reporte VARCHAR(50) NOT NULL
);

CREATE TABLE equipo_proyecto(
    ID_participante INT NOT NULL,
    ID_proyecto INT NOT NULL,
    rol_participante VARCHAR(30) NOT NULL,
    PRIMARY KEY (ID_participante, ID_proyecto)
);

CREATE TABLE proyecto_categorias(
    ID_proyecto INT NOT NULL,
    ID_categoria INT NOT NULL,
    PRIMARY KEY (ID_proyecto, ID_categoria)
);

CREATE TABLE responsables_actividad(
    ID_actividad INT NOT NULL,
    ID_participante INT NOT NULL,
    PRIMARY KEY (ID_actividad, ID_participante)
);

CREATE TABLE recursos_actividad(
    ID_recurso INT NOT NULL,
    ID_actividad INT NOT NULL,
    PRIMARY KEY (ID_recurso, ID_actividad)
);

ALTER TABLE participantes
ADD CONSTRAINT UQ_participantes_DNI UNIQUE(DNI);

ALTER TABLE participantes
ADD CONSTRAINT UQ_participantes_correo UNIQUE(correo);

ALTER TABLE participantes
ADD CONSTRAINT CHK_participantes_DNI
CHECK (DNI LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');

ALTER TABLE participantes
ADD CONSTRAINT CHK_participantes_contrasena
CHECK (LEN(contrasena) >= 8);

ALTER TABLE participantes
ADD CONSTRAINT CHK_participantes_tipo
CHECK (tipo IN ('Ciudadano','Empresa','Organizacion'));

ALTER TABLE participantes
ADD CONSTRAINT CHK_estado_cuenta
CHECK (estado_cuenta IN ('Activo','Inactivo','Suspendido'));

ALTER TABLE telefonos
ADD CONSTRAINT CHK_telefonos_formato
CHECK (telefono LIKE '9[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]');

ALTER TABLE proyectos
ADD CONSTRAINT CHK_nivel_impacto
CHECK (nivel_impacto IN ('Bajo','Medio','Alto'));

ALTER TABLE proyectos
ADD CONSTRAINT CHK_estado_proyecto
CHECK (estado IN ('Planeado','En proceso','Finalizado','Cancelado'));

ALTER TABLE proyectos
ADD CONSTRAINT CHK_fechas_proyecto
CHECK (fecha_fin >= fecha_inicio);

ALTER TABLE actividades
ADD CONSTRAINT CHK_estado_actividad
CHECK (estado IN ('Pendiente','En proceso','Finalizado'));

ALTER TABLE actividades
ADD CONSTRAINT CHK_fechas_actividad
CHECK (fecha_fin >= fecha_inicio);

ALTER TABLE recursos
ADD CONSTRAINT CHK_recursos_stock
CHECK (stock >= 0);

ALTER TABLE aportes
ADD CONSTRAINT CHK_medio_pago
CHECK (medio_pago IN ('Yape','Plin','Transferencia','Efectivo','Tarjeta'));

ALTER TABLE aportes
ADD CONSTRAINT CHK_estado_transaccion
CHECK (estado_transaccion IN ('Pendiente','Completado','Fallido','Cancelado'));

ALTER TABLE comentarios
ADD CONSTRAINT CHK_calificacion
CHECK (calificacion BETWEEN 1 AND 5);

ALTER TABLE metricas_ambientales
ADD CONSTRAINT CHK_valor_medido
CHECK (valor_medido >= 0);

ALTER TABLE direcciones
ADD CONSTRAINT FK_direcciones_participantes
FOREIGN KEY(ID_participante) REFERENCES participantes(ID_participante);

ALTER TABLE telefonos
ADD CONSTRAINT FK_telefonos_participantes
FOREIGN KEY(ID_participante) REFERENCES participantes(ID_participante);

ALTER TABLE actividades
ADD CONSTRAINT FK_actividades_proyectos
FOREIGN KEY(ID_proyecto) REFERENCES proyectos(ID_proyecto);

ALTER TABLE aportes
ADD CONSTRAINT FK_aportes_proyectos
FOREIGN KEY(ID_proyecto) REFERENCES proyectos(ID_proyecto);

ALTER TABLE aportes
ADD CONSTRAINT FK_aportes_participantes
FOREIGN KEY(ID_participante) REFERENCES participantes(ID_participante);

ALTER TABLE comentarios
ADD CONSTRAINT FK_comentarios_proyectos
FOREIGN KEY(ID_proyecto) REFERENCES proyectos(ID_proyecto);

ALTER TABLE comentarios
ADD CONSTRAINT FK_comentarios_participantes
FOREIGN KEY(ID_participante) REFERENCES participantes(ID_participante);

ALTER TABLE metricas_ambientales
ADD CONSTRAINT FK_metricas_proyectos
FOREIGN KEY(ID_proyecto) REFERENCES proyectos(ID_proyecto);

ALTER TABLE reportes
ADD CONSTRAINT FK_reportes_proyectos
FOREIGN KEY(ID_proyecto) REFERENCES proyectos(ID_proyecto);

ALTER TABLE equipo_proyecto
ADD CONSTRAINT FK_equipo_participantes
FOREIGN KEY(ID_participante) REFERENCES participantes(ID_participante);

ALTER TABLE equipo_proyecto
ADD CONSTRAINT FK_equipo_proyectos
FOREIGN KEY(ID_proyecto) REFERENCES proyectos(ID_proyecto);

ALTER TABLE proyecto_categorias
ADD CONSTRAINT FK_proyectoCategorias_proyectos
FOREIGN KEY(ID_proyecto) REFERENCES proyectos(ID_proyecto);

ALTER TABLE proyecto_categorias
ADD CONSTRAINT FK_proyectoCategorias_categorias
FOREIGN KEY(ID_categoria) REFERENCES categorias(ID_categoria);

ALTER TABLE responsables_actividad
ADD CONSTRAINT FK_responsablesActividad_actividades
FOREIGN KEY(ID_actividad) REFERENCES actividades(ID_actividad);

ALTER TABLE responsables_actividad
ADD CONSTRAINT FK_responsablesActividad_participantes
FOREIGN KEY(ID_participante) REFERENCES participantes(ID_participante);

ALTER TABLE recursos_actividad
ADD CONSTRAINT FK_recursosActividad_recursos
FOREIGN KEY(ID_recurso) REFERENCES recursos(ID_recurso);

ALTER TABLE recursos_actividad
ADD CONSTRAINT FK_recursosActividad_actividades
FOREIGN KEY(ID_actividad) REFERENCES actividades(ID_actividad);

CREATE INDEX IX_direcciones_participante ON direcciones(ID_participante);
CREATE INDEX IX_telefonos_participante ON telefonos(ID_participante);
CREATE INDEX IX_actividades_proyecto ON actividades(ID_proyecto);
CREATE INDEX IX_aportes_proyecto ON aportes(ID_proyecto);
CREATE INDEX IX_aportes_participante ON aportes(ID_participante);
CREATE INDEX IX_comentarios_proyecto ON comentarios(ID_proyecto);
CREATE INDEX IX_comentarios_participante ON comentarios(ID_participante);
CREATE INDEX IX_reportes_proyecto ON reportes(ID_proyecto);
CREATE INDEX IX_metricas_proyecto_fecha ON metricas_ambientales(ID_proyecto, fecha_registro DESC);

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
