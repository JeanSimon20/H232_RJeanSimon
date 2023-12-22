use H232_RJeanSimon;

INSERT INTO area (name) VALUES ('Contabilidad');
INSERT INTO area (name) VALUES ('Produccion');
INSERT INTO area (name) VALUES ('Marketing');
INSERT INTO area (name) VALUES ('Recursos Humanos');
INSERT INTO area (name) VALUES ('Ventas');

SET DATEFORMAT dmy
INSERT INTO PERSON (name, dni, email, gender, fecha_cumpleanos, celular) VALUES ('Jean Simon', '76093168', 'jeansimon@gmail.com','M','10/05/2023','924584301');
INSERT INTO PERSON (name, dni, email, gender, fecha_cumpleanos, celular) VALUES ('Claudio Fernandez', '76093169', 'claudio@gmail.com','M','25/03/2001','924584302');
INSERT INTO PERSON (name, dni, email, gender, fecha_cumpleanos, celular) VALUES ('Mateo Arcos', '76090019', 'mateo@outlook.com','M','25/12/2001','924584306');
INSERT INTO PERSON (name, dni, email, gender, fecha_cumpleanos, celular) VALUES ('Jesus Gutierrez', '76093219', 'jgutierrez@hotmail.com','M','02/11/2001','924584631');
INSERT INTO PERSON (name, dni, email, gender, fecha_cumpleanos, celular) VALUES ('Maria Eulogio', '76193219', 'mgutierrez@hotmail.com','D','25/05/2001','924584633');

SET DATEFORMAT dmy
INSERT INTO BIENES (cantidad, detalle, valorlibro, fecha_ingreso, fecha_depreciacion, status) VALUES ('10', 'Escritorio color Gris', '800','1/02/2023','31/12/2023','Alta');
INSERT INTO BIENES (cantidad, detalle, valorlibro, fecha_ingreso, fecha_depreciacion, status) VALUES ('5','Escritorio color Gris', '800','1/02/2023','31/12/2023','Baja');
INSERT INTO BIENES (cantidad, detalle, valorlibro, fecha_ingreso, fecha_depreciacion, status) VALUES ('3','Escritorio color Gris', '800','1/02/2023','31/12/2023','Baja');
INSERT INTO BIENES (cantidad, detalle, valorlibro, fecha_ingreso, fecha_depreciacion, status) VALUES ('25','Escritorio color Gris', '800','1/02/2023','31/12/2023','Baja');
INSERT INTO BIENES (cantidad, detalle, valorlibro, fecha_ingreso, fecha_depreciacion, status) VALUES ('11','Escritorio color Gris', '800','1/02/2023','31/12/2023','Alta');

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
