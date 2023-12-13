use H232_RJeanSimon;

-- Insercion de 5 registros en tablas Maestras:
-- Tabla Area:
--- Insertar 5 registros de la tabla Maestra, Area
INSERT INTO area (name) VALUES ('Contabilidad');
INSERT INTO area (name) VALUES ('Produccion');
INSERT INTO area (name) VALUES ('Marketing');
INSERT INTO area (name) VALUES ('Recursos Humanos');
INSERT INTO area (name) VALUES ('Ventas');

-- Insertar 5 registros en la tabla Maestra, Persona
SET DATEFORMAT dmy
INSERT INTO PERSON (name, dni, email, gender, fecha_cumpleanos, celular) VALUES ('Jean Simon', '76093168', 'jeansimon@gmail.com','M','10/05/2023','924584301');
INSERT INTO PERSON (name, dni, email, gender, fecha_cumpleanos, celular) VALUES ('Claudio Fernandez', '76093169', 'claudio@gmail.com','M','25/03/2001','924584302');
INSERT INTO PERSON (name, dni, email, gender, fecha_cumpleanos, celular) VALUES ('Mateo Arcos', '76090019', 'mateo@outlook.com','M','25/12/2001','924584306');
INSERT INTO PERSON (name, dni, email, gender, fecha_cumpleanos, celular) VALUES ('Jesus Gutierrez', '76093219', 'jgutierrez@hotmail.com','M','02/11/2001','924584631');
INSERT INTO PERSON (name, dni, email, gender, fecha_cumpleanos, celular) VALUES ('Maria Eulogio', '76193219', 'mgutierrez@hotmail.com','D','25/05/2001','924584633');

-- Insertar 5 registros en la tabla Maestra, Bienes
SET DATEFORMAT dmy
INSERT INTO BIENES (cantidad, code, detalle, valorlibro, fecha_ingreso, fecha_depreciacion, depreciacion_anual, depreciacion_mensual, depreciacion_acumulada, status) VALUES ('1','EQ-001', 'Escritorio color Gris', '800 c/u','1/02/2023','31/12/2023','0.80','0.007','0.80','Baja');
INSERT INTO BIENES (cantidad, code, detalle, valorlibro, fecha_ingreso, fecha_depreciacion, depreciacion_anual, depreciacion_mensual, depreciacion_acumulada, status) VALUES ('1','EQ-002', 'Escritorio color Gris', '800 c/u','1/02/2023','31/12/2023','0.80','0.007','0.80','Baja');
INSERT INTO BIENES (cantidad, code, detalle, valorlibro, fecha_ingreso, fecha_depreciacion, depreciacion_anual, depreciacion_mensual, depreciacion_acumulada, status) VALUES ('1','EQ-003', 'Escritorio color Gris', '800 c/u','1/02/2023','31/12/2023','0.80','0.007','0.80','Baja');
INSERT INTO BIENES (cantidad, code, detalle, valorlibro, fecha_ingreso, fecha_depreciacion, depreciacion_anual, depreciacion_mensual, depreciacion_acumulada, status) VALUES ('1','EQ-004', 'Escritorio color Gris', '800 c/u','1/02/2023','31/12/2023','0.80','0.007','0.80','Baja');
INSERT INTO BIENES (cantidad, code, detalle, valorlibro, fecha_ingreso, fecha_depreciacion, depreciacion_anual, depreciacion_mensual, depreciacion_acumulada, status) VALUES ('1','EQ-005', 'Escritorio color Gris', '800 c/u','1/02/2023','31/12/2023','0.80','0.007','0.80','Baja');

-- Insertar 10 registros en la tabla Transaccional, Asignacion de Area
INSERT INTO ASIGNACION_AREA (personid, areaid, status) VALUES (1, 2, 'A');
INSERT INTO ASIGNACION_AREA (personid, areaid, status) VALUES (1, 3, 'A');
INSERT INTO ASIGNACION_AREA (personid, areaid, status) VALUES (3, 5, 'A');
INSERT INTO ASIGNACION_AREA (personid, areaid, status) VALUES (5, 2, 'A');
INSERT INTO ASIGNACION_AREA (personid, areaid, status) VALUES (4, 1, 'A');
INSERT INTO ASIGNACION_AREA (personid, areaid, status) VALUES (3, 2, 'A');
INSERT INTO ASIGNACION_AREA (personid, areaid, status) VALUES (5, 1, 'A');
INSERT INTO ASIGNACION_AREA (personid, areaid, status) VALUES (5, 5, 'A');
INSERT INTO ASIGNACION_AREA (personid, areaid, status) VALUES (4, 4, 'A');
INSERT INTO ASIGNACION_AREA (personid, areaid, status) VALUES (5, 4, 'A');

-- Insertar 10 registros en la tabla Transaccional, Asignacion de Bienes
INSERT INTO ASIGNACION_BIENES (bienesid, areaid, status) VALUES (1, 2, 'A');
INSERT INTO ASIGNACION_BIENES (bienesid, areaid, status) VALUES (1, 3, 'A');
INSERT INTO ASIGNACION_BIENES (bienesid, areaid, status) VALUES (3, 5, 'A');
INSERT INTO ASIGNACION_BIENES (bienesid, areaid, status) VALUES (5, 2, 'A');
INSERT INTO ASIGNACION_BIENES (bienesid, areaid, status) VALUES (4, 1, 'A');
INSERT INTO ASIGNACION_BIENES (bienesid, areaid, status) VALUES (3, 2, 'A');
INSERT INTO ASIGNACION_BIENES (bienesid, areaid, status) VALUES (5, 1, 'A');
INSERT INTO ASIGNACION_BIENES (bienesid, areaid, status) VALUES (5, 5, 'A');
INSERT INTO ASIGNACION_BIENES (bienesid, areaid, status) VALUES (4, 4, 'A');
INSERT INTO ASIGNACION_BIENES (bienesid, areaid, status) VALUES (5, 4, 'A');
