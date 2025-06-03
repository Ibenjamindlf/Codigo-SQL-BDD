CREATE TABLE Persona (
    idPersona INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL, 
    apellido VARCHAR(50) NOT NULL,
    tipoDoc VARCHAR(20) NOT NULL,
    numDoc INT NOT NULL UNIQUE,
    fechaNac DATE NOT NULL,
    -- edad INT NOT NULL, --  Atributo calculado
    telefono VARCHAR(15) UNIQUE,
    direccion VARCHAR(100)
);

CREATE TABLE Chofer (
    idPersona INT UNSIGNED PRIMARY KEY,
    categoria VARCHAR(20) NOT NULL,
    nroLegajo VARCHAR(20) NOT NULL UNIQUE,
    FOREIGN KEY (idPersona) REFERENCES Persona(idPersona) 
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Pasajero (
    idPersona INT UNSIGNED PRIMARY KEY,
    sitFiscal VARCHAR(20),
    FOREIGN KEY (idPersona) REFERENCES Persona(idPersona)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Colectivo (
    idColectivo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    patente VARCHAR(8) NOT NULL UNIQUE,
    marca VARCHAR (10) NOT NULL,
    color VARCHAR (10) NOT NULL,
    -- cantAsientos INT es un atributo calculado
);

CREATE TABLE Ciudad (
    idCiudad INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    codigo INT UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL
);
CREATE TABLE Viaje (
    idViaje INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL, 
    hora TIME NOT NULL,
    idColectivo INT UNSIGNED,
    idPersonaChofer INT UNSIGNED,
    idCiudadDesde INT UNSIGNED,
    idCiudadHacia INT UNSIGNED,
    FOREIGN KEY (idColectivo) REFERENCES Colectivo(idColectivo)
        ON DELETE SET NULL -- poner restrict
        ON UPDATE RESTRICT,
    FOREIGN KEY (idPersonaChofer) REFERENCES Chofer(idPersona)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT;
    FOREIGN KEY (idCiudadDesde) REFERENCES Ciudad(idCiudad)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    FOREIGN KEY (idCiudadHacia) REFERENCES Ciudad(idCiudad)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT 
);
CREATE TABLE Pasaje (
    idPasaje  INT UNSIGNED PRIMARY KEY  AUTO_INCREMENT,
    fecha DATE NOT NULL,
    idPasajero INT UNSIGNED,
    idViaje INT UNSIGNED,
    idAsiento INT UNSIGNED,
    FOREIGN KEY (idViaje) REFERENCES Viaje (idViaje)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    FOREIGN KEY (idPasajero) REFERENCES Pasajero (idPersona)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT,
    FOREIGN KEY (idAsiento) REFERENCES Asiento (idAsiento)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);
-- ASIENTO ( nro, lado, patenteColectivo, idPasajeAsignado)
CREATE TABLE Asiento (
    idAsiento INT UNSIGNED AUTO_INCREMENT,
    numero INT(11) NOT NULL,
    lado VARCHAR(10) NOT NULL,
    idColectivo INT(10) UNSIGNED DEFAULT NULL,
    UNIQUE KEY (idAsiento),
    PRIMARY KEY (numero,lado,idColectivo),
    FOREIGN KEY (idColectivo) REFERENCES Colectivo(idColectivo)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
-- PREFIERE (motivo, idPasajero, codigoCiudad )
CREATE TABLE Prefiere (
    idPasajero INT UNSIGNED NOT NULL,
    idCiudad INT UNSIGNED,
    motivo VARCHAR(250),
    PRIMARY KEY (idPasajero, idCiudad),
    FOREIGN KEY (idPasajero) REFERENCES Pasajero(idPersona)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (idCiudad) REFERENCES Ciudad(idCiudad)
        ON DELETE CASCADE 
        ON UPDATE RESTRICT
);

INSERT INTO Viaje (idViaje, fecha,hora,patenteColectivo,idPersonaChofer,codigoCiudadDesde,codigoCiudadHasta) VALUES (7,'2025/05/30','14:30','ABC123',1,10,1);
