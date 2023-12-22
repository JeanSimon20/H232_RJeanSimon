CREATE TABLE AREA (
    areaid int IDENTITY(1,1),
    name varchar(255)  NOT NULL,
    CONSTRAINT AREA_pk PRIMARY KEY  (areaid)
);

-- Validacion para ingresar solo numeros en los nombres de las areas a registrar.
ALTER TABLE area
ADD CONSTRAINT CHK_Nombre_Valido_Area CHECK (
    name NOT LIKE '%[^a-zA-Z ñÑáéíóúÁÉÍÓÚüÜ]%'
);

-- Validacion para que el estado ingrese por defecto con Activo, se crea el campo status.
ALTER TABLE area
ADD status char(1) DEFAULT 'A' NOT NULL;

-- Validacion para nombres de areas unicos y no duplicados.
ALTER TABLE area
ADD CONSTRAINT UC_NAME UNIQUE (name);

-- Tabla Maestra Persona
CREATE TABLE PERSON (
    personid int  IDENTITY(1,1),
    name varchar(255)  NOT NULL,
    dni char(8)  NOT NULL,
    email varchar(50)  NOT NULL,
    gender char(1)  NOT NULL,
    fecha_cumpleanos date  NOT NULL,
    CONSTRAINT PERSON_pk PRIMARY KEY  (personid)
);

-- Validacion para agregar solo letras al nombre de la persona
ALTER TABLE PERSON
ADD CONSTRAINT CHK_Nombre_Valido_Person CHECK (
    name NOT LIKE '%[^a-zA-Z ñÑáéíóúÁÉÍÓÚüÜ]%'
);

-- Validacion para que el estado ingrese por defecto con Activo, se crea el campo status.
ALTER TABLE PERSON
ADD status char(1) DEFAULT 'A' NOT NULL;

-- Validacion para que el Nombre, dni y email sean datos unicos
ALTER TABLE PERSON
ADD CONSTRAINT UC_NAME_PERSON_NAME UNIQUE (name);

ALTER TABLE PERSON
ADD CONSTRAINT UC_NAME_PERSON_DNI UNIQUE (dni);

ALTER TABLE PERSON
ADD CONSTRAINT UC_NAME_PERSON_EMAIL UNIQUE (email);

-- Validacion para que el dni solo permita ingresar numeros y permita ingresar 8 numeros exactos.
ALTER TABLE PERSON
ADD CONSTRAINT CHK_DNI CHECK (LEN(dni) = 8 AND dni NOT LIKE '%[^0-9]%');

-- Validacion para correo validos
ALTER TABLE PERSON
ADD CONSTRAINT CHK_Email_Valid CHECK (
    email LIKE '%@%.%' AND
    email NOT LIKE '%@%@%' AND
    email NOT LIKE '%..%' AND
    CHARINDEX('.', REVERSE(email)) > 2 AND
    LEN(email) - LEN(REPLACE(email, '@', '')) = 1
);

-- Validacion para ingreso de 9 numeros de Celular y solo permita numeros.
ALTER TABLE PERSON
ADD celular char(9);

ALTER TABLE PERSON
ADD CONSTRAINT UC_Celular UNIQUE (celular);

ALTER TABLE PERSON
ADD CONSTRAINT CHK_Celular CHECK (LEN(celular) = 9 AND dni NOT LIKE '%[^0-9]%');

CREATE TABLE BIENES (
    bienesid int IDENTITY(1,1),
    cantidad int NOT NULL,
    code varchar(255),
    detalle varchar(255) NOT NULL,
    valorlibro varchar(255) NOT NULL,
    fecha_ingreso varchar(255) NOT NULL,
    fecha_depreciacion varchar(255) NOT NULL,
    depreciacion_anual DECIMAL(10, 2),
    depreciacion_mensual DECIMAL(10, 2),
    depreciacion_acumulada AS (depreciacion_anual),
    status char(10) not null,
    CONSTRAINT BIENES_pk PRIMARY KEY (bienesid)
);

-- Validacion para que el codigo del bienes sea unico
ALTER TABLE BIENES
ADD CONSTRAINT UC_Bienes UNIQUE (code);

-- Table: ASIGNACION_AREA
CREATE TABLE ASIGNACION_AREA (
    asigareid int  IDENTITY(1,1),
    personid int  NOT NULL,
    areaid int  NOT NULL,
    status char(1)  NOT NULL,
    CONSTRAINT ASIGNACION_AREA_pk PRIMARY KEY  (asigareid)
);

-- Table: ASIGNACION_BIENES
CREATE TABLE ASIGNACION_BIENES (
    asigbieid int  IDENTITY(1,1),
    bienesid int  NOT NULL,
    areaid int  NOT NULL,
    status char(1)  NOT NULL,
    CONSTRAINT ASIGNACION_BIENES_pk PRIMARY KEY  (asigbieid)
);

-- Actualizar Registro por campo:
UPDATE PERSON
SET email = 'nuevoemail@email.com'
WHERE personid = 1;

--Actualizar varios registros:
UPDATE PERSON
SET name = 'NuevoNombre',
    email = 'nuevoemail2@email.com'
WHERE personid = 2;

-- Borrado Logico:
UPDATE PERSON
SET status = 'I'
WHERE personid = 5;

--Borrado Logico a mas registros:
UPDATE PERSON
SET status = 'I'
WHERE personid IN (2, 3);

-- Listar Registros Activos
SELECT * FROM PERSON
WHERE status = 'A';

-- Listar Registros Inactivos
SELECT * FROM PERSON
WHERE status = 'I';

--Uso de BETWEEN y LIKE
--BETWEEN 10 AND 20 selecciona usuarios con UsuarioID en el rango de 10 a 20.
--LIKE '%a%' selecciona usuarios cuyos nombres contengan la letra 'a'.
SELECT * FROM PERSON
WHERE personid BETWEEN 1 AND 5
AND name LIKE '%J%';

--Uso de IN y LIKE
--IN (1, 2, 3, 4, 5) selecciona usuarios con UsuarioID de 1, 2, 3, 4 o 5.
--LIKE '%@dominio.com' selecciona usuarios cuyos correos electrónicos terminen en "@dominio.com".
SELECT * FROM PERSON
WHERE personid IN (1, 2, 3, 4, 5)
AND Email LIKE '%@email.com';

--Uso de BETWEEN, LIKE, y IN juntos
--BETWEEN 5 AND 15 selecciona usuarios con UsuarioID entre 1 y 5.
--LIKE 'J%' selecciona usuarios cuyos nombres comiencen con la letra 'J'.
--LIKE '%@gmail.com' OR Email LIKE '%@yahoo.com' selecciona usuarios cuyos correos electrónicos terminen en "@email.com" o "@hotmail.com".
SELECT * FROM PERSON
WHERE personid BETWEEN 5 AND 5
AND name LIKE 'J%'
AND Email LIKE '%@email.com' OR Email LIKE '%@hotmail.com';


--Procedimiento Almacenado con IF y CASE
--Este procedimiento verifica si un usuario está activo (Estado = 'A') y, dependiendo de su estado, realiza una actualización en el campo Email
CREATE PROCEDURE ActualizarEmailUsuario
    @personid int,
    @NuevoEmail varchar(255)
AS
BEGIN
    DECLARE @Estado char(1);

    SELECT @Estado = status FROM person WHERE personid = @personid;

    IF @Estado = 'A'
    BEGIN
        UPDATE person
        SET Email = @NuevoEmail
        WHERE personid = @personid;
    END
    ELSE
    BEGIN
        PRINT 'El usuario no está activo y no se puede actualizar el email.';
    END
END;

--Ejecutar ActualizarEmailUsuario
EXEC ActualizarEmailUsuario @personid = 4, @NuevoEmail = 'nuevoemail5@email.com';



-- Procedimiento Almacenado con WHILE
--Este procedimiento asigna un valor por defecto a las personas que no tienen un email registrado, utilizando un bucle WHILE.
CREATE PROCEDURE AsignarEmailPorDefecto
AS
BEGIN
    DECLARE @personid int;
    DECLARE PersonCursor CURSOR FOR 
        SELECT personid FROM Person WHERE Email IS NULL OR Email = '';

    OPEN PersonCursor;

    FETCH NEXT FROM PersonCursor INTO @personid;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE PERSON
        SET Email = 'default@email.com'
        WHERE personid = @personid;

        FETCH NEXT FROM PersonCursor INTO @personid;
    END;

    CLOSE PersonCursor;
    DEALLOCATE PersonCursor;
END;

-- Ejecutar AsignarEmailPorDefecto
EXEC AsignarEmailPorDefecto;

--3. Procedimiento Almacenado con Combinación de IF, CASE, y WHILE
--Este procedimiento actualiza el estado de un usuario y, dependiendo del nuevo estado, realiza acciones adicionales.
CREATE PROCEDURE ActualizarEstadoUsuario
    @personid int,
    @NuevoEstado char(1)
AS
BEGIN
    UPDATE PERSON
    SET status = @NuevoEstado
    WHERE personid = @personid;

    IF @NuevoEstado = 'I'
    BEGIN
        PRINT 'Usuario marcado como inactivo.';
    END
    ELSE IF @NuevoEstado = 'A'
    BEGIN
        PRINT 'Usuario marcado como activo.';
    END
    ELSE
    BEGIN
        PRINT 'Estado no reconocido.';
    END
END;

-- Ejecutar ActualizarEstadoUsuario
EXEC ActualizarEstadoUsuario @personid = 2, @NuevoEstado = 'A';

-- Cursor: 
DECLARE @bienesid int, @cantidad int, @code varchar(255), @detalle varchar(255), @valorlibro varchar(255), @fecha_ingreso varchar(255), @fecha_depreciacion varchar(255), @depreciacion_anual DECIMAL(10, 2), @depreciacion_mensual DECIMAL(10, 2), @depreciacion_acumulada DECIMAL(10, 2), @status char(10);

-- Declarar el cursor
DECLARE bienes_cursor CURSOR FOR 
SELECT bienesid, cantidad, code, detalle, valorlibro, fecha_ingreso, fecha_depreciacion, depreciacion_anual, depreciacion_mensual, depreciacion_acumulada, status 
FROM BIENES;

-- Abrir el cursor
OPEN bienes_cursor;

-- Recuperar la primera fila del cursor
FETCH NEXT FROM bienes_cursor 
INTO @bienesid, @cantidad, @code, @detalle, @valorlibro, @fecha_ingreso, @fecha_depreciacion, @depreciacion_anual, @depreciacion_mensual, @depreciacion_acumulada, @status;

-- Loop para recorrer todas las filas
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Aquí puedes realizar operaciones con los datos de cada fila
    -- Por ejemplo, imprimirlos
    PRINT 'ID: ' + CAST(@bienesid AS varchar) + ', Cantidad: ' + CAST(@cantidad AS varchar) + ', Detalle: ' + @detalle + ', valorlibro: ' + CAST(@valorlibro AS varchar);

    -- Pasar a la siguiente fila
    FETCH NEXT FROM bienes_cursor 
    INTO @bienesid, @cantidad, @code, @detalle, @valorlibro, @fecha_ingreso, @fecha_depreciacion, @depreciacion_anual, @depreciacion_mensual, @depreciacion_acumulada, @status;
END

-- Cerrar el cursor
CLOSE bienes_cursor;

-- Liberar los recursos del cursor
DEALLOCATE bienes_cursor;


-- Calcular Depreciacion Anual, mensual y acumulado
CREATE TRIGGER CalcularDepreciacion
ON BIENES
AFTER INSERT
AS
BEGIN
    DECLARE @factorDepreciacion DECIMAL(18, 15) = 0.001; -- Factor de depreciación para calcular la depreciación anual.

    UPDATE BIENES
    SET depreciacion_anual = CAST(ROUND(CAST(i.valorlibro AS DECIMAL(10, 2)) * @factorDepreciacion, 2) AS DECIMAL(10, 2)),
        depreciacion_mensual = CAST(ROUND((CAST(i.valorlibro AS DECIMAL(10, 2)) * @factorDepreciacion) / 12, 2) AS DECIMAL(10, 2))
    FROM inserted i
    WHERE BIENES.bienesid = i.bienesid;
END;

--- Crear Codigo de manera secuencial
CREATE TRIGGER AsignarCodigoSecuencial
ON BIENES
AFTER INSERT
AS
BEGIN
    DECLARE @maxNumber int
    DECLARE @newCode varchar(255)

    -- Encuentra el máximo número actual después del prefijo 'EQ-'
    SELECT @maxNumber = ISNULL(MAX(CAST(SUBSTRING(code, 4, LEN(code) - 3) AS int)), 0)
    FROM BIENES
    WHERE code LIKE 'EQ-%'

    -- Incrementa el número para el nuevo código
    SET @maxNumber = @maxNumber + 1

    -- Crea el nuevo código con el formato 'EQ-xxx'
    SET @newCode = 'EQ-' + RIGHT('000' + CAST(@maxNumber AS varchar), 3)

    -- Actualiza el último registro insertado con el nuevo código
    UPDATE BIENES
    SET code = @newCode
    WHERE bienesid = (SELECT MAX(bienesid) FROM BIENES)
END

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

select * from PERSON;

SELECT 
    AA.asigareid,
    AA.personid,
    P.name AS person_name,
    AA.areaid,
    A.name AS area_name,
    AA.status
FROM 
    ASIGNACION_AREA AA
INNER JOIN 
    PERSON P ON AA.personid = P.personid
INNER JOIN 
    AREA A ON AA.areaid = A.areaid;


SELECT 
    AB.asigbieid,
    AB.bienesid,
    B.detalle AS bien_detalle,
    B.valorlibro,
    B.status AS bien_status,
    AB.areaid,
    A.name AS area_name,
    AB.status AS asignacion_status
FROM 
    ASIGNACION_BIENES AB
INNER JOIN 
    BIENES B ON AB.bienesid = B.bienesid
INNER JOIN 
    AREA A ON AB.areaid = A.areaid;


SELECT 
    AA.asigareid,
    AA.personid,
    P.name AS person_name,
    AA.areaid AS areaid_asignacion_area,
    AA.status AS status_asignacion_area,
    AB.asigbieid,
    AB.bienesid,
    B.detalle AS bien_detalle,
	b.valorlibro as Valor,
    AB.areaid AS areaid_asignacion_bienes,
    AB.status AS status_asignacion_bienes,
    A.name AS area_name
FROM 
    ASIGNACION_AREA AA
INNER JOIN 
    PERSON P ON AA.personid = P.personid
INNER JOIN 
    AREA A ON AA.areaid = A.areaid
INNER JOIN 
    ASIGNACION_BIENES AB ON A.areaid = AB.areaid
INNER JOIN 
    BIENES B ON AB.bienesid = B.bienesid;


