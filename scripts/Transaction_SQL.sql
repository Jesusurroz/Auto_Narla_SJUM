/* =============================================================
   1) Registrar una venta
   Entidades afectadas: Venta, Vehiculo
   Reglas:
   - El vehículo debe estar Disponible.
   - Se inserta en Venta y luego se actualiza el estado del Vehiculo a 'Vendido'.
   - Si algo falla, se revierte todo.
*/
DECLARE 
    @vehiculoId   INT         = 1,
    @clienteId    INT         = 1,
    @empleadoId   INT         = 1,
    @precioFinal  DECIMAL(12,2) = 15000.00,
    @metodoPago   NVARCHAR(50)  = N'Efectivo',
    @descuentoPorc DECIMAL(5,2) = 0.00;

BEGIN TRANSACTION;

    -- Verificar que el vehículo esté disponible
    IF NOT EXISTS (SELECT 1 FROM dbo.Vehiculo WHERE VehiculoId = @vehiculoId AND Estado = N'Disponible')
    BEGIN
        RAISERROR(N'El vehículo no está disponible o no existe.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Insertar venta
    INSERT INTO dbo.Venta (VehiculoId, ClienteId, EmpleadoId, PrecioFinal, MetodoPago, DescuentoPorc)
    VALUES (@vehiculoId, @clienteId, @empleadoId, @precioFinal, @metodoPago, @descuentoPorc);

    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Actualizar estado del vehículo
    UPDATE dbo.Vehiculo
       SET Estado = N'Vendido'
     WHERE VehiculoId = @vehiculoId;

    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION;
        RETURN;
    END

COMMIT TRANSACTION;
GO

/* =============================================================
   2) Alta de vehículo con sus fotos
   Entidades afectadas: Vehiculo, VehiculoFoto
   Reglas:
   - Insertar el vehículo maestro y obtener su ID.
   - Insertar múltiples fotos detalle.
   - Si alguna inserción de detalle falla, se revierte todo.
*/
DECLARE 
    @Codigo NVARCHAR(50) = N'VH999',
    @MarcaId INT = 1,
    @TipoVehiculoId INT = 1,
    @CombustibleId INT = 1,
    @Modelo NVARCHAR(100) = N'Modelo Demo',
    @AnioProduccion INT = 2022,
    @NumeroChasis NVARCHAR(100) = N'CHS999',
    @Cilindraje DECIMAL(10,2) = 2000,
    @PrecioCompra DECIMAL(12,2) = 12000.00,
    @PrecioVenta DECIMAL(12,2) = 14500.00,
    @Observaciones NVARCHAR(MAX) = N'Ingreso por lote de demostración';

BEGIN TRANSACTION;

    DECLARE @NewVehiculoId INT;

    INSERT INTO dbo.Vehiculo (
        Codigo, MarcaId, TipoVehiculoId, CombustibleId, Modelo, AnioProduccion,
        NumeroChasis, Cilindraje, PrecioCompra, PrecioVenta, Estado, Observaciones
    ) VALUES (
        @Codigo, @MarcaId, @TipoVehiculoId, @CombustibleId, @Modelo, @AnioProduccion,
        @NumeroChasis, @Cilindraje, @PrecioCompra, @PrecioVenta, N'Disponible', @Observaciones
    );

    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION;
        RETURN;
    END

    SET @NewVehiculoId = SCOPE_IDENTITY();

    -- Insertar fotos (detalle)
    INSERT INTO dbo.VehiculoFoto (VehiculoId, Url, Orden)
    VALUES
        (@NewVehiculoId, N'vh999_1.jpg', 1),
        (@NewVehiculoId, N'vh999_2.jpg', 2);

    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION;
        RETURN;
    END

COMMIT TRANSACTION;
GO

/* =============================================================
   3) Guardar cliente (insert/update con validación de duplicados)
   Entidad afectada: Cliente
   Reglas:
   - Si @ClienteId es NULL -> insertar nuevo cliente.
   - Si @ClienteId tiene valor -> actualizar ese cliente.
   - Validar que no exista otro cliente con el mismo Email (si se proporciona Email).
*/
DECLARE @ClienteId INT = NULL; -- NULL = insertar, valor = actualizar
DECLARE @Nombre NVARCHAR(100) = N'Nuevo';
DECLARE @Apellido NVARCHAR(100) = N'Cliente';
DECLARE @Telefono NVARCHAR(20) = N'555-0000';
DECLARE @Email NVARCHAR(100) = N'nuevo.cliente@mail.com';
DECLARE @Direccion NVARCHAR(200) = N'Ciudad';

BEGIN TRANSACTION;

    -- Validación de duplicado por Email (si se proporciona)
    IF (@Email IS NOT NULL AND LEN(LTRIM(RTRIM(@Email))) > 0)
    BEGIN
        IF EXISTS (
            SELECT 1
            FROM dbo.Cliente c
            WHERE c.Email = @Email
              AND (@ClienteId IS NULL OR c.ClienteId <> @ClienteId)
        )
        BEGIN
            RAISERROR(N'Ya existe un cliente con el mismo Email.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
    END

    IF (@ClienteId IS NULL)
    BEGIN
        -- Insertar
        INSERT INTO dbo.Cliente (Nombre, Apellido, Telefono, Email, Direccion)
        VALUES (@Nombre, @Apellido, @Telefono, @Email, @Direccion);

        IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION;
            RETURN;
        END

        SET @ClienteId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        -- Actualizar
        IF NOT EXISTS (SELECT 1 FROM dbo.Cliente WHERE ClienteId = @ClienteId)
        BEGIN
            RAISERROR(N'El cliente a actualizar no existe.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        UPDATE dbo.Cliente
           SET Nombre = @Nombre,
               Apellido = @Apellido,
               Telefono = @Telefono,
               Email = @Email,
               Direccion = @Direccion
         WHERE ClienteId = @ClienteId;

        IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION;
            RETURN;
        END
    END

COMMIT TRANSACTION;
GO