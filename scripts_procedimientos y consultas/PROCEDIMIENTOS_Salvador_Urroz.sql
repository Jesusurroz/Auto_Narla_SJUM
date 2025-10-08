USE Auto_Narla_SJUM;

GO
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
    @FechaInicio = '2025-01-01', 
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
