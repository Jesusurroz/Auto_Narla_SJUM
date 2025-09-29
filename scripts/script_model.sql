CREATE TABLE dbo.Marca (
    MarcaId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Marca PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL CONSTRAINT UQ_Marca_Nombre UNIQUE
);
GO

CREATE TABLE dbo.TipoVehiculo (
    TipoVehiculoId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_TipoVehiculo PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL CONSTRAINT UQ_TipoVehiculo_Nombre UNIQUE
);
GO

CREATE TABLE dbo.Combustible (
    CombustibleId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Combustible PRIMARY KEY,
    Tipo NVARCHAR(50) NOT NULL CONSTRAINT UQ_Combustible_Tipo UNIQUE
);
GO

CREATE TABLE dbo.Vehiculo (
    VehiculoId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Vehiculo PRIMARY KEY,
    Codigo NVARCHAR(50) NOT NULL CONSTRAINT UQ_Vehiculo_Codigo UNIQUE,
    MarcaId INT NOT NULL,
    TipoVehiculoId INT NOT NULL,
    CombustibleId INT NOT NULL,
    Modelo NVARCHAR(100) NOT NULL,
    AnioProduccion INT NOT NULL,
    NumeroChasis NVARCHAR(100) NOT NULL CONSTRAINT UQ_Vehiculo_NumeroChasis UNIQUE,
    Cilindraje DECIMAL(10,2) NOT NULL,
    PrecioCompra DECIMAL(12,2) NOT NULL,
    PrecioVenta  DECIMAL(12,2) NOT NULL,
    Estado NVARCHAR(20) NOT NULL CONSTRAINT DF_Vehiculo_Estado DEFAULT (N'Disponible'),
    FechaIngreso DATETIME2 NOT NULL CONSTRAINT DF_Vehiculo_FechaIngreso DEFAULT (SYSUTCDATETIME()),
    Observaciones NVARCHAR(MAX) NULL,
    CONSTRAINT FK_Vehiculo_Marca        FOREIGN KEY (MarcaId)        REFERENCES dbo.Marca(MarcaId),
    CONSTRAINT FK_Vehiculo_TipoVehiculo FOREIGN KEY (TipoVehiculoId) REFERENCES dbo.TipoVehiculo(TipoVehiculoId),
    CONSTRAINT FK_Vehiculo_Combustible  FOREIGN KEY (CombustibleId)  REFERENCES dbo.Combustible(CombustibleId)
);
GO

CREATE TABLE dbo.VehiculoFoto (
    FotoId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_VehiculoFoto PRIMARY KEY,
    VehiculoId INT NOT NULL,
    Url NVARCHAR(200) NOT NULL,
    Orden INT NOT NULL,
    CONSTRAINT FK_VehiculoFoto_Vehiculo FOREIGN KEY (VehiculoId) REFERENCES dbo.Vehiculo(VehiculoId)
);
GO

CREATE TABLE dbo.Cliente (
    ClienteId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Cliente PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(20) NULL,
    Email NVARCHAR(100) NULL,
    Direccion NVARCHAR(200) NULL
);
GO

CREATE TABLE dbo.Empleado (
    EmpleadoId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Empleado PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    Cargo NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE dbo.Venta (
    VentaId INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Venta PRIMARY KEY,
    VehiculoId INT NOT NULL,
    ClienteId INT NOT NULL,
    EmpleadoId INT NOT NULL,
    FechaVenta DATETIME2 NOT NULL CONSTRAINT DF_Venta_FechaVenta DEFAULT (SYSUTCDATETIME()),
    PrecioFinal DECIMAL(12,2) NOT NULL,
    MetodoPago NVARCHAR(50) NOT NULL,
    DescuentoPorc DECIMAL(5,2) NOT NULL CONSTRAINT DF_Venta_Descuento DEFAULT (0.00),
    CONSTRAINT FK_Venta_Vehiculo FOREIGN KEY (VehiculoId) REFERENCES dbo.Vehiculo(VehiculoId),
    CONSTRAINT FK_Venta_Cliente  FOREIGN KEY (ClienteId)  REFERENCES dbo.Cliente(ClienteId),
    CONSTRAINT FK_Venta_Empleado FOREIGN KEY (EmpleadoId) REFERENCES dbo.Empleado(EmpleadoId)
);
GO

-- Seed data
INSERT INTO dbo.Marca (Nombre) VALUES
(N'Toyota'),(N'Tesla'),(N'Honda'), (N'Ford'),(N'Chevrolet'),(N'Abarth'),(N'Nissan'),(N'BMW'),(N'Porsche'), (N'Mercedes'), (N'Kia'), (N'Hyundai'), (N'Volkswagen'),(N'Alfa Romeo'),(N'Cupra');
GO

INSERT INTO dbo.TipoVehiculo (Nombre) VALUES
(N'Sedan'), (N'Hatchback'), (N'Camioneta Pickup'),(N'Camioneta Cerrada'),(N'vehiculos Electricos'),(N'Deportivo'),(N'Minivan'),(N'Camioneta Extracabina'),(N'Crossover'),(N'Doble Cabina'),(N'Microbus'),(N'Camión hasta 5T');
GO

INSERT INTO dbo.Combustible (Tipo) VALUES
(N'Gasolina'), (N'Diesel'), (N'Eléctrico'),(N'Etanol'),(N'GNC'),(N'GNL'),(N'Híbrido');
GO

INSERT INTO dbo.Vehiculo (Codigo, MarcaId, TipoVehiculoId, CombustibleId, Modelo, AnioProduccion, NumeroChasis, Cilindraje, PrecioCompra, PrecioVenta)
VALUES
(N'VH001', 1, 1, 1, N'Corolla', 2018, N'CHS001', 1800, 12000, 14500),
(N'VH002', 2, 2, 1, N'Civic',   2020, N'CHS002', 2000, 15000, 17000),
(N'VH003', 3, 3, 2, N'F-150',   2017, N'CHS003', 3500, 25000, 28000);
GO

INSERT INTO dbo.VehiculoFoto (VehiculoId, Url, Orden)
VALUES
(1, N'foto1.jpg', 1),
(1, N'foto2.jpg', 2),
(2, N'foto1.jpg', 1);
GO

INSERT INTO dbo.Cliente (Nombre, Apellido, Telefono, Email, Direccion)
VALUES
(N'Daniel', N'Aleman', N'555-1111', N'daniel@mail.com', N'Masaya'),
(N'Maria',  N'Perez',  N'555-2222', N'maria@mail.com',  N'Managua'),
(N'Gabriel',N'Rivas',  N'555-2234', N'gabo@mail.com',   N'Managua'),
(N'cristiana', N'Garcia', N'555-2242', N'cris@mail.com', N'Granada'),
(N'Nestor', N'Gutierrez', N'555-22782', N'cris@mail.com', N'Masaya');
GO

INSERT INTO dbo.Empleado (Nombre, Apellido, Cargo)
VALUES
(N'Mauricio',  N'Valle',     N'Vendedor'),
(N'Alejandro', N'Martinez',  N'Asistente'),
(N'Johansse',  N'Roque',     N'Coordinador de tienda'),
(N'Jeymi',     N'Artola',    N'Administrador');
GO

INSERT INTO dbo.Venta (VehiculoId, ClienteId, EmpleadoId, PrecioFinal, MetodoPago, DescuentoPorc)
VALUES
(1, 1, 1, 14500, N'Efectivo', 0.00),
(2, 2, 2, 16150, N'Tarjeta',  5.00);
GO
