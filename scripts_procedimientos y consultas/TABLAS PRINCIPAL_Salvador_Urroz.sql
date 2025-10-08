
USE Auto_Narla_SJUM;

GO
----------------------------------------------------------
-- TABLA: Vehiculo


-- Listar todos los vehículos
CREATE OR ALTER PROCEDURE sp_ListarVehiculos
AS
BEGIN
    SELECT * FROM Vehiculo;
END;

GO

-- Filtrar vehículos por marca
CREATE OR ALTER PROCEDURE sp_FiltrarVehiculosPorMarca
    @MarcaId INT
AS
BEGIN
    SELECT * FROM Vehiculo
    WHERE MarcaId = @MarcaId;
END;
GO

--  Actualizar precio de un vehículo
CREATE OR ALTER PROCEDURE sp_ActualizarPrecioVehiculo
    @VehiculoId INT,
    @NuevoPrecio DECIMAL(10,2)
AS
BEGIN
    UPDATE Vehiculo
    SET PrecioVenta = @NuevoPrecio
    WHERE VehiculoId = @VehiculoId;
END;
GO

----------------------------------------------------------
-- TABLA: Cliente


--Listar todos los clientes
CREATE OR ALTER PROCEDURE sp_ListarClientes
AS
BEGIN
    SELECT * FROM Cliente;
END;
GO

--Buscar cliente por Nombre
CREATE OR ALTER PROCEDURE sp_BuscarClientePorNombre
    @Nombre NVARCHAR(100)
AS
BEGIN
    SELECT * FROM Cliente
    WHERE Nombre LIKE '%' + @Nombre + '%';
END;
GO

--Actualizar número de teléfono del cliente
CREATE OR ALTER PROCEDURE sp_ActualizarTelefonoCliente
    @ClienteId INT,
    @NuevoTelefono NVARCHAR(20)
AS
BEGIN
    UPDATE Cliente
    SET Telefono = @NuevoTelefono
    WHERE ClienteId = @ClienteId;
END;
GO

----------------------------------------------------------
-- TABLA: Empleado


--Listar todos los empleados
CREATE OR ALTER PROCEDURE sp_ListarEmpleados
AS
BEGIN
    SELECT * FROM Empleado;
END;
GO

--Filtrar empleados por cargo
CREATE OR ALTER PROCEDURE sp_FiltrarEmpleadoPorCargo
    @Cargo NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Empleado
    WHERE Cargo = @Cargo;
END;
GO

--Actualizar salario de empleado
CREATE OR ALTER PROCEDURE sp_ActualizarSalarioEmpleado
    @EmpleadoId INT,
    @NuevoCargo NVARCHAR(50)
AS
BEGIN
    UPDATE Empleado
    SET Cargo = @NuevoCargo
    WHERE EmpleadoId = @EmpleadoId;
END;
GO

----------------------------------------------------------
-- TABLA: Venta


--Listar todas las ventas
CREATE OR ALTER PROCEDURE sp_ListarVentas
AS
BEGIN
    SELECT * FROM Venta;
END;
GO

--Filtrar ventas por fecha
CREATE OR ALTER PROCEDURE sp_FiltrarVentasPorFecha
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SELECT * FROM Venta
    WHERE FechaVenta BETWEEN @FechaInicio AND @FechaFin;
END;
GO

-- Actualizar descuento de una venta
CREATE OR ALTER PROCEDURE sp_ActualizarDescuentoVenta
    @VentaId INT,
    @NuevoDescuento DECIMAL(5,2)
AS
BEGIN
    UPDATE Venta
    SET DescuentoPorc = @NuevoDescuento
    WHERE VentaId = @VentaId;
END;
GO

