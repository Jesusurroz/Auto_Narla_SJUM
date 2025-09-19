 Auto_Narla_SJUM
Autos NARLA – Base de Datos

Este repositorio contiene el desarrollo del caso de estudio Autos NARLA, un auto lote que requiere organizar su información a través de una base de datos en SQL Server 2022 (v21).  
El proyecto incluye diseño de tablas, relaciones, población de datos y consultas Transact-SQL.
Objetivo
Diseñar e implementar una base de datos normalizada para gestionar inventario, ventas, clientes y empleados, optimizando los procesos de búsqueda, registro y control de vehículos.

Contenido del repositorio

- sql/modelo_Autos_NARLA_SJUM.sql → Script de creación de base de datos y tablas.  
- sql/datos_Autos_NARLA_SJUM.sql → Scripts de inserción de datoS- 
- sql/consultas_Autos_NARLA_SJUM.sql → Consultas requeridas por la gerencia (filtros 1–11).  
- docs/diagrama_Autos_NARLA_SJUM.png → Diagrama ER del modelo de base de datos (exportado desde dbdiagram.io).  
- docs/diccionario_Autos_NARLA_SJUM → Diccionario de datos y descripciones de tablas y campos.  
  
<img width="1263" height="938" alt="Untitled" src="https://github.com/user-attachments/assets/3628f483-78e0-4e46-98b2-718e6b0c94c5" />

 Entidades principales

1. Marca – Registro de marcas de vehículos.  
2.  TipoVehiculo – Clasificación de vehículos (sedán, minivan, clásico, etc.).  
3.  Combustible – Tipos de combustible disponibles.  
4.  Vehiculo – Información detallada de cada vehículo en stock.  
5. VehiculoFoto– Hasta 6 fotos por vehículo.  
6.  Cliente – Información de los clientes.  
7.  Empleado – Personal encargado de ventas.  
8. Venta – Registro de transacciones realizadas.

 Requisitos

- SQL Server 2022 (v21 o superior)  
- SQL Server Management Studio (SSMS)  
- Herramienta de modelado: [dbdiagram.io](https://dbdiagram.io) (Fue una 2da pocion ya que no tenia ER/STUDIO)

<img width="1263" height="938" alt="Untitled" src="https://github.com/user-attachments/assets/186bd794-3523-440f-9ad5-fd76fd65c4c7" />
