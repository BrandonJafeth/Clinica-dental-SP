use master 
go
drop database ClinicaDental
go



--1. Crear la base de datos
CREATE DATABASE ClinicaDental
ON PRIMARY (
    NAME = 'ClinicaDental_Data',       
    FILENAME = 'C:\SQLData\ClinicaDental_Data.mdf',  
    SIZE = 10MB,                      
    MAXSIZE = 100MB,                  
    FILEGROWTH = 5MB                   
)
LOG ON (
    NAME = 'ClinicaDental_Log',        
    FILENAME = 'C:\SQLLog\ClinicaDental_Log.ldf',   
    SIZE = 5MB,                        
    MAXSIZE = 50MB,                    
    FILEGROWTH = 5MB                   
);
GO

-- 2. Usar la base de datos
USE ClinicaDental;
GO

-- 3. Crear tablas en el orden correcto

-- Tabla: Estado_Pago
CREATE TABLE Estado_Pago (
    ID_EstadoPago CHAR(8) PRIMARY KEY,
    Nombre_EP VARCHAR(20),
    Descripcion_EP VARCHAR(200)
);

-- Tabla: Tipo_Tratamiento
CREATE TABLE Tipo_Tratamiento (
    ID_TipoTratamiento CHAR(8) PRIMARY KEY,
    Nombre_Tipo_Tratamiento VARCHAR(20),
    Descripcion_Tipo_Tratamiento VARCHAR(200)
);

-- Tabla: Tratamiento
CREATE TABLE Tratamiento (
    ID_Tratamiento CHAR(8) PRIMARY KEY,
    Nombre_Tra VARCHAR(20),
    Descripcion_Tra VARCHAR(200),
    ID_TipoTratamiento CHAR(8),
    FOREIGN KEY (ID_TipoTratamiento) REFERENCES Tipo_Tratamiento(ID_TipoTratamiento)
);

-- Tabla: Procedimiento
CREATE TABLE Procedimiento (
    ID_Procedimiento CHAR(8) PRIMARY KEY,
    Fecha_Proc DATE,
    Detalles_Proc VARCHAR(200),
    Hora_Inicio_Proc TIME,
    Hora_Fin_Proc TIME,
    ID_Tratamiento CHAR(8),
    FOREIGN KEY (ID_Tratamiento) REFERENCES Tratamiento(ID_Tratamiento)
);

-- Tabla: Factura
CREATE TABLE Factura (
    ID_Factura CHAR(8) PRIMARY KEY,
    MontoTotal_Fa MONEY,
    FechaEmision_Fa DATE,
    ID_EstadoPago CHAR(8),
    FOREIGN KEY (ID_EstadoPago) REFERENCES Estado_Pago(ID_EstadoPago)
);

-- Tabla: Tipo_Pago
CREATE TABLE Tipo_Pago (
    ID_Tipo_Pago CHAR(8) PRIMARY KEY,
    Nombre_TP VARCHAR(20),
    Descripcion_TP VARCHAR(200)
);

-- Tabla: Pago
CREATE TABLE Pago (
    ID_Pago uniqueidentifier PRIMARY KEY DEFAULT NEWID(),
    Monto_Pago MONEY,
    Fecha_Pago DATE,
    ID_Factura CHAR(8),
    ID_Tipo_Pago CHAR(8),
    FOREIGN KEY (ID_Factura) REFERENCES Factura(ID_Factura),
    FOREIGN KEY (ID_Tipo_Pago) REFERENCES Tipo_Pago(ID_Tipo_Pago)
);

-- Tabla: Estado_Cuenta
CREATE TABLE Estado_Cuenta (
    ID_Estado_Cuenta CHAR(8) PRIMARY KEY,
    Nombre_EC VARCHAR(20),
    Descripcion_EC VARCHAR(200)
);

-- Tabla: Paciente
CREATE TABLE Paciente (
    ID_Paciente CHAR(8) PRIMARY KEY,
    Nombre_Pac VARCHAR(20),
    Apellido1_Pac VARCHAR(20),
    Apellido2_Pac VARCHAR(20),
    Fecha_Nacimiento_Pac DATE,
    Telefono_Pac VARCHAR(20),
    Correo_Pac VARCHAR(30),
    Direccion_Pac VARCHAR(200),
    ID_HistorialMedico CHAR(8)
);

-- Tabla: Historial_Medico
CREATE TABLE Historial_Medico (
    ID_HistorialMedico CHAR(8) PRIMARY KEY,
    Fecha_Historial DATE,
    Diagnostico VARCHAR(100),
    Tratamientos_Medicos VARCHAR(200)
);

-- Clave foránea de Historial_Medico en Paciente
ALTER TABLE Paciente
ADD CONSTRAINT FK_Paciente_HistorialMedico
FOREIGN KEY (ID_HistorialMedico) REFERENCES Historial_Medico(ID_HistorialMedico);

-- Tabla: Cuenta
CREATE TABLE Cuenta (
    ID_Cuenta CHAR(8) PRIMARY KEY,
    Saldo_Total MONEY,
    Fecha_Apertura DATE,
    Fecha_Cierre DATE,
    Fecha_Ultima_Actualizacion DATE,
    Observaciones VARCHAR(255),
    ID_Estado_Cuenta CHAR(8),
    ID_Factura CHAR(8),
    ID_Paciente CHAR(8),
    FOREIGN KEY (ID_Estado_Cuenta) REFERENCES Estado_Cuenta(ID_Estado_Cuenta),
    FOREIGN KEY (ID_Factura) REFERENCES Factura(ID_Factura),
    FOREIGN KEY (ID_Paciente) REFERENCES Paciente(ID_Paciente)
);

-- Tabla: Factura_Procedimiento
CREATE TABLE Factura_Procedimiento (
    ID_Factura_Procedimiento CHAR(8) PRIMARY KEY,
    ID_Factura CHAR(8),
    ID_Procedimiento CHAR(8),
    FOREIGN KEY (ID_Factura) REFERENCES Factura(ID_Factura),
    FOREIGN KEY (ID_Procedimiento) REFERENCES Procedimiento(ID_Procedimiento)
);

-- Tabla: Factura_Tratamiento
CREATE TABLE Factura_Tratamiento (
    ID_Factura_Tratamiento CHAR(8) PRIMARY KEY,
    ID_Factura CHAR(8),
    ID_Tratamiento CHAR(8),
    FOREIGN KEY (ID_Factura) REFERENCES Factura(ID_Factura),
    FOREIGN KEY (ID_Tratamiento) REFERENCES Tratamiento(ID_Tratamiento)
);

-- Tabla: Auditoria
CREATE TABLE Auditoria (
    ID_Auditoria uniqueidentifier PRIMARY KEY DEFAULT NEWID(),
    Fecha_Hora_Accion DATETIME NOT NULL,
    Acción VARCHAR(255) NOT NULL,
    DispositivoQueRealizo VARCHAR(50) NOT NULL,
    Usuario VARCHAR(128) NOT NULL
);
GO


-- Tabla: Funcionario
CREATE TABLE Funcionario (
    ID_Funcionario CHAR(8) PRIMARY KEY,
    Nombre VARCHAR(20),
    Apellido1 VARCHAR(200),
    Apellido2 VARCHAR(200),
    Email VARCHAR(20),
    Contraseña CHAR(12)
);

-- Tabla: Usuarios
CREATE TABLE Usuarios (
    ID_Usuario CHAR(8) PRIMARY KEY,
    Nombre VARCHAR(20),
    Apellido1 VARCHAR(200),
    Apellido2 VARCHAR(200),
    Email VARCHAR(50),
    Contraseña CHAR(12),
    Token VARCHAR(100),
    ID_Funcionario CHAR(8),
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionario(ID_Funcionario)
);

-- 4. Añadir nuevas tablas de Roles y Permisos



-- Tabla: Dentista
CREATE TABLE Dentista (
    ID_Dentista CHAR(8) PRIMARY KEY,
    Nombre_Den VARCHAR(20),
    Apellido1_Den VARCHAR(20),
    Apellido2_Den VARCHAR(20),
    Direccion_Den VARCHAR(200),
    FechaNacimiento_Den DATE,
    Telefono_Den VARCHAR(20),
    Correo_Den VARCHAR(30),
    ID_Funcionario CHAR(8),
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionario(ID_Funcionario)
);
-- Tabla: Especialidad
CREATE TABLE Especialidad (
    ID_Especialidad CHAR(8) PRIMARY KEY,
    Nombre_Esp VARCHAR(20),
    Descripcion_Esp VARCHAR(200)
);
-- Tabla: Dentista_Especialidad
CREATE TABLE Dentista_Especialidad (
    ID_Dentista_Especialidad CHAR(8) PRIMARY KEY,
    ID_Dentista CHAR(8),
    ID_Especialidad CHAR(8),
    FOREIGN KEY (ID_Dentista) REFERENCES Dentista(ID_Dentista),
    FOREIGN KEY (ID_Especialidad) REFERENCES Especialidad(ID_Especialidad)
);



-- Tabla: Cita
CREATE TABLE Cita (
    ID_Cita CHAR(8) PRIMARY KEY,
    Fecha_Cita DATE,
    Motivo VARCHAR(200),
    Hora_Inicio TIME,
    Hora_Fin TIME,
    ID_Paciente CHAR(8),
    ID_Dentista CHAR(8),
    ID_Funcionario CHAR(8),
    ID_EstadoCita CHAR(8),
    FOREIGN KEY (ID_Paciente) REFERENCES Paciente(ID_Paciente),
    FOREIGN KEY (ID_Dentista) REFERENCES Dentista(ID_Dentista),
    FOREIGN KEY (ID_Funcionario) REFERENCES Funcionario(ID_Funcionario)
);

--ALTER TABLE Cita
--ADD Hora_Fin TIME;

-- Tabla: Estado_Citas
CREATE TABLE Estado_Citas (
    ID_EstadoCita CHAR(8) PRIMARY KEY,
    Nombre_Estado VARCHAR(20),
    Descripcion_Estado VARCHAR(200)
);

-- Clave foránea en Cita hacia Estado_Citas
ALTER TABLE Cita
ADD CONSTRAINT FK_Cita_EstadoCita
FOREIGN KEY (ID_EstadoCita) REFERENCES Estado_Citas(ID_EstadoCita);

GO

-- Tabla Intermedia: Historial_Tratamiento
CREATE TABLE Historial_Tratamiento (
    ID_Historial_Tratamiento CHAR(8) PRIMARY KEY,
    ID_HistorialMedico CHAR(8) NOT NULL,
    ID_Tratamiento CHAR(8) NOT NULL,
    Fecha_Tratamiento DATE,
    FOREIGN KEY (ID_HistorialMedico) REFERENCES Historial_Medico(ID_HistorialMedico),
    FOREIGN KEY (ID_Tratamiento) REFERENCES Tratamiento(ID_Tratamiento)
);




-- Tabla: Roles
CREATE TABLE Roles (
    ID_Roles CHAR(8) PRIMARY KEY,
    Nombre VARCHAR(20),
    Descripcion VARCHAR(200)
);

-- Tabla: Permisos
CREATE TABLE Permisos (
    ID_Permisos CHAR(8) PRIMARY KEY,
    Nombre VARCHAR(20),
    Descripcion VARCHAR(200)
);



-- Tabla: Roles_Permisos (relación muchos a muchos entre Roles y Permisos)
CREATE TABLE Roles_Permisos (
    ID_Roles_Permisos CHAR(8) PRIMARY KEY,
    ID_Roles CHAR(8),
    ID_Permisos CHAR(8),
    FOREIGN KEY (ID_Roles) REFERENCES Roles(ID_Roles),
    FOREIGN KEY (ID_Permisos) REFERENCES Permisos(ID_Permisos)
);

-- Tabla: Usuario_Roles (relación entre los usuarios y sus roles)
CREATE TABLE Usuario_Roles (
    ID_Usuario_Roles CHAR(8) PRIMARY KEY,
    ID_Usuario CHAR(8),
    ID_Roles CHAR(8),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario),
    FOREIGN KEY (ID_Roles) REFERENCES Roles(ID_Roles)
);

GO


