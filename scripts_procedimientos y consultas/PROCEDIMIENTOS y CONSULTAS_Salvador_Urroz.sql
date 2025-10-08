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


---------------------------------------------------
-- PROCEDIMIENTOS 
-- Ejecuta el procedimiento
EXEC sp_ActualizarPrecioVehiculo @VehiculoId = 1, @NuevoPrecio = 15600.00;

-- Comprueba el cambio
SELECT Codigo, PrecioVenta FROM Vehiculo WHERE Codigo='XYZ789';
EXEC sp_BuscarClientePorNombre @Nombre = 'MARIA';
-- Antes
SELECT Nombre, Telefono FROM Cliente WHERE ClienteId = 2;

-- Ejecuta el procedimiento
EXEC sp_ActualizarTelefonoCliente @ClienteId = 2, @NuevoTelefono = '555-2222';

-- Después
SELECT Nombre, Telefono FROM Cliente WHERE ClienteId = 2;
EXEC sp_FiltrarVentasPorFecha 
    @FechaInicio = '2025-06-01', 
    @FechaFin = '2025-12-31';
-- Antes
SELECT VentaId, DescuentoPorc FROM Venta WHERE VentaId = 2;

-- Ejecuta procedimiento con valor válido
EXEC sp_ActualizarDescuentoVenta @VentaId = 2, @NuevoDescuento = 5;

-- Después
SELECT VentaId, DescuentoPorc FROM Venta WHERE VentaId = 2;

-- Ejecuta procedimiento con valor inválido (>10)
EXEC sp_ActualizarDescuentoVenta @VentaId = 2, @NuevoDescuento = 15;




-- Ver precio antes de la actualización
SELECT Codigo, PrecioVenta FROM Vehiculo WHERE Codigo='VH001';

-- Actualización
EXEC sp_ActualizarPrecioVehiculo @VehiculoId = 2, @NuevoPrecio = 15600.00;

-- Ver precio después de la actualización
SELECT Codigo, PrecioVenta FROM Vehiculo WHERE Codigo='XYZ789';



----------------------------------------------------------
-- CONSULTAS CON FUNCIONES AGREGADAS

--Total de vehículos disponibles
SELECT COUNT(*) AS TotalVehiculosDisponibles
FROM Vehiculo
WHERE Estado = 'Disponible';

--Total de ventas realizadas
SELECT COUNT(*) AS TotalVentas
FROM Venta;

--Total de ingresos por ventas
SELECT SUM(PrecioFinal) AS TotalIngresosVentas
FROM Venta;

--Precio promedio de los vehículos disponibles
SELECT AVG(PrecioVenta) AS PrecioPromedio
FROM Vehiculo
WHERE Estado = 'Disponible';

--Precio máximo y mínimo de los vehículos 
SELECT MAX(PrecioVenta) AS PrecioMaximo,
       MIN(PrecioVenta) AS PrecioMinimo
FROM Vehiculo
WHERE Estado = 'Disponible';

--Total de vehículos agrupados por marca
SELECT M.Nombre AS Marca,
       COUNT(V.VehiculoId) AS TotalPorMarca
FROM Vehiculo V
INNER JOIN Marca M ON V.MarcaId = M.MarcaId
GROUP BY M.Nombre;

--Total de ventas por empleado
SELECT E.Nombre + ' ' + E.Apellido AS Empleado,
       SUM(VE.PrecioFinal) AS TotalVendido
FROM Venta VE
INNER JOIN Empleado E ON VE.EmpleadoId = E.EmpleadoId
GROUP BY E.Nombre, E.Apellido;

--Promedio de descuento aplicado
SELECT AVG(DescuentoPorc) AS PromedioDescuento
FROM Venta;



SELECT COUNT(*) FROM Cliente; -- cuenta cuántos clientes hay
SELECT AVG(PrecioVenta) FROM Vehiculo; -- calcula el promedio de precios
SELECT MAX(PrecioVenta) FROM Vehiculo; -- muestra el precio más alto
SELECT MIN(PrecioVenta) FROM Vehiculo; -- muestra el más bajo
SELECT SUM(PrecioFinal) FROM Venta; -- suma total de ventas
