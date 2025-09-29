-- 1) Mostrar todos los vehículos en stock (Estado = 'Disponible')
SELECT v.VehiculoId,
       v.Codigo,
       m.Nombre       AS Marca,
       tv.Nombre      AS Tipo,
       c.Tipo         AS Combustible,
       v.Modelo,
       v.AnioProduccion,
       v.Cilindraje,
       v.PrecioVenta,
       v.FechaIngreso
FROM   dbo.Vehiculo v
JOIN   dbo.Marca m          ON m.MarcaId = v.MarcaId
JOIN   dbo.TipoVehiculo tv  ON tv.TipoVehiculoId = v.TipoVehiculoId
JOIN   dbo.Combustible c    ON c.CombustibleId = v.CombustibleId
WHERE  v.Estado = N'Disponible'
ORDER BY v.FechaIngreso DESC;

-- 2) Información detallada por código
--    Parámetro: 'ABC123'
SELECT v.VehiculoId,
       v.Codigo,
       m.Nombre       AS Marca,
       tv.Nombre      AS Tipo,
       c.Tipo         AS Combustible,
       v.Modelo,
       v.AnioProduccion,
       v.NumeroChasis,
       v.Cilindraje,
       v.PrecioCompra,
       v.PrecioVenta,
       (v.PrecioVenta - v.PrecioCompra) AS MargenEsperado,
       v.Estado,
       v.FechaIngreso,
       v.Observaciones
FROM   dbo.Vehiculo v
JOIN   dbo.Marca m          ON m.MarcaId = v.MarcaId
JOIN   dbo.TipoVehiculo tv  ON tv.TipoVehiculoId = v.TipoVehiculoId
JOIN   dbo.Combustible c    ON c.CombustibleId = v.CombustibleId
WHERE  v.Codigo = 'ABC123';

-- 3) Ingresar nuevos vehículos para venta
--    Parámetros: 'XYZ789', 1, 2, 1, 'Civic', 2020, '1HGBH41JXMN109186', 2.0, 15000.00, 18000.00, 'Vehículo en buen estado'
INSERT INTO dbo.Vehiculo (
    Codigo, MarcaId, TipoVehiculoId, CombustibleId, Modelo, AnioProduccion,
    NumeroChasis, Cilindraje, PrecioCompra, PrecioVenta, Estado, Observaciones
)
VALUES (
    'XYZ789', 1, 2, 1, 'Civic', 2020,
    '1HGBH41JXMN109186', 2.0, 15000.00, 18000.00, N'Disponible', 'Vehículo en buen estado'
);

-- 4) Inventario ordenable por Modelo, Marca o Año
--    Parámetro opcional: 'Modelo'
SELECT v.VehiculoId, v.Codigo, m.Nombre AS Marca, v.Modelo, v.AnioProduccion, v.PrecioVenta
FROM   dbo.Vehiculo v
JOIN   dbo.Marca m ON m.MarcaId = v.MarcaId
WHERE  v.Estado = N'Disponible'
ORDER BY CASE WHEN N'Modelo' = N'Modelo' THEN v.Modelo END ASC,
         CASE WHEN N'Modelo' = N'Marca'  THEN m.Nombre END ASC,
         CASE WHEN N'Modelo' = N'Año'    THEN v.AnioProduccion END DESC,
         v.Modelo ASC;

-- 5) Filtros por Modelo (LIKE) y rango de Año
--    Parámetros: '%Civic%', 2018, 2022
SELECT v.VehiculoId, v.Codigo, m.Nombre AS Marca, v.Modelo, v.AnioProduccion, v.PrecioVenta
FROM   dbo.Vehiculo v
JOIN   dbo.Marca m ON m.MarcaId = v.MarcaId
WHERE  v.Estado = N'Disponible'
  AND  v.Modelo LIKE '%Civic%'
  AND  v.AnioProduccion BETWEEN 2018 AND 2022
ORDER BY v.AnioProduccion DESC, v.Modelo ASC;

-- 6) Filtro por rango de precio y categoría (tipo de vehículo)
--    Parámetros: 15000.00, 25000.00, 'Sedán'
SELECT v.VehiculoId, v.Codigo, m.Nombre AS Marca, tv.Nombre AS Tipo, v.Modelo, v.PrecioVenta
FROM   dbo.Vehiculo v
JOIN   dbo.Marca m         ON m.MarcaId = v.MarcaId
JOIN   dbo.TipoVehiculo tv ON tv.TipoVehiculoId = v.TipoVehiculoId
WHERE  v.Estado = N'Disponible'
  AND  v.PrecioVenta BETWEEN 15000.00 AND 25000.00
  AND  tv.Nombre = 'Sedán'
ORDER BY v.PrecioVenta ASC;

-- 7) Registrar una venta (transacción): insertar en Venta y marcar Vehiculo como 'Vendido'
--    Parámetros: 1, 100, 50, 17000.00, 'Efectivo', 5.00
BEGIN TRAN;
    INSERT INTO dbo.Venta (VehiculoId, ClienteId, EmpleadoId, PrecioFinal, MetodoPago, DescuentoPorc)
    VALUES (1, 100, 50, 17000.00, 'Efectivo', 5.00);

    UPDATE dbo.Vehiculo
       SET Estado = N'Vendido'
     WHERE VehiculoId = 1
       AND Estado = N'Disponible';
COMMIT;

-- 8) Calcular precio con descuento (máx 10%) sobre un monto mínimo (no destructivo)
--    Parámetros: 8.0, 20000.00
SELECT v.VehiculoId,
       v.Codigo,
       v.PrecioVenta,
       CASE WHEN 8.0 <= 10.0 THEN 8.0 ELSE 10.0 END AS PorcentajeAplicado,
       ROUND(v.PrecioVenta * (1 - (CASE WHEN 8.0 <= 10.0 THEN 8.0 ELSE 10.0 END)/100.0), 2) AS PrecioConDescuento
FROM   dbo.Vehiculo v
WHERE  v.Estado = N'Disponible'
  AND  v.PrecioVenta >= 20000.00
ORDER BY PrecioConDescuento ASC;

-- 9) Vehículo más antiguo en stock
SELECT TOP 1 v.VehiculoId, v.Codigo, m.Nombre AS Marca, v.Modelo, v.AnioProduccion
FROM   dbo.Vehiculo v
JOIN   dbo.Marca m ON m.MarcaId = v.MarcaId
WHERE  v.Estado = N'Disponible'
ORDER BY v.AnioProduccion ASC, v.Modelo ASC;

-- 10) Vehículo de mayor cilindraje en stock
SELECT TOP 1 v.VehiculoId, v.Codigo, m.Nombre AS Marca, v.Modelo, v.Cilindraje, v.PrecioVenta
FROM   dbo.Vehiculo v
JOIN   dbo.Marca m ON m.MarcaId = v.MarcaId
WHERE  v.Estado = N'Disponible'
ORDER BY v.Cilindraje DESC, v.PrecioVenta DESC;

-- 11) Vehículo con el precio más bajo en stock
SELECT TOP 1 v.VehiculoId, v.Codigo, m.Nombre AS Marca, v.Modelo, v.PrecioVenta
FROM   dbo.Vehiculo v
JOIN   dbo.Marca m ON m.MarcaId = v.MarcaId
WHERE  v.Estado = N'Disponible'
ORDER BY v.PrecioVenta ASC, v.Modelo ASC;