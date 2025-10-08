
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
