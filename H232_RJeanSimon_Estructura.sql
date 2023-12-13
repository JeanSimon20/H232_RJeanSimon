-- Crear la base de datos
create database H232_RJeanSimon;

--Poner en uso la base de datos
use H232_RJeanSimon;

-- Tabla Maestra Area
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

-- Tabla Maestra BIENES
CREATE TABLE BIENES (
    bienesid int  IDENTITY(1,1),
	cantidad int NOT NULL,
    code char(10)  NOT NULL,
    detalle varchar(255)  NOT NULL,
    valorlibro varchar(25)  NOT NULL,
    fecha_ingreso date  NOT NULL,
    fecha_depreciacion date  NOT NULL,
    depreciacion_anual varchar(255)  NOT NULL,
    depreciacion_mensual varchar(255)  NOT NULL,
    depreciacion_acumulada varchar(255)  NOT NULL,
	status char(10) not null,
    CONSTRAINT BIENES_pk PRIMARY KEY  (bienesid)
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
DECLARE person_cursor CURSOR  
    FOR SELECT * FROM PERSON 
OPEN person_cursor  
FETCH NEXT FROM person_cursor;
