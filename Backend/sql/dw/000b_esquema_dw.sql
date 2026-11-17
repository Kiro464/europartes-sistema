/* Esquema del Data Warehouse DWAutoPartes (dimensiones, hechos, staging y control de la ETL).
   Ejecutar en la base DWAutoPartes despues de 000_dimtiempo.sql. */
/****** Objeto: Schema [stg] Fecha de script: 28/9/2026 03:44:40 ******/
CREATE SCHEMA [stg]
GO
/****** Objeto: Table [dbo].[DimCliente] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimCliente](
	[ClienteKey] [int] IDENTITY(1,1) NOT NULL,
	[ClienteID] [int] NOT NULL,
	[Nombres] [nvarchar](100) NOT NULL,
	[Apellidos] [nvarchar](100) NOT NULL,
	[Telefono] [nvarchar](30) NULL,
	[Direccion] [nvarchar](255) NULL,
	[Correo] [nvarchar](150) NULL,
	[Estado] [bit] NOT NULL,
	[VigenteDesde] [datetime2](0) NOT NULL,
	[VigenteHasta] [datetime2](0) NULL,
	[EsActual] [bit] NOT NULL,
 CONSTRAINT [PK_DimCliente] PRIMARY KEY CLUSTERED 
(
	[ClienteKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[DimDepartamento] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimDepartamento](
	[DepartamentoKey] [int] IDENTITY(1,1) NOT NULL,
	[DepartamentoID] [int] NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
 CONSTRAINT [PK_DimDepartamento] PRIMARY KEY CLUSTERED 
(
	[DepartamentoKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_DimDepartamento_DepartamentoID] UNIQUE NONCLUSTERED 
(
	[DepartamentoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[DimEmpleado] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimEmpleado](
	[EmpleadoKey] [int] IDENTITY(1,1) NOT NULL,
	[EmpleadoID] [int] NOT NULL,
	[Nombres] [nvarchar](100) NOT NULL,
	[Apellidos] [nvarchar](100) NOT NULL,
	[Cargo] [nvarchar](100) NULL,
	[DepartamentoKey] [int] NULL,
	[Telefono] [nvarchar](30) NULL,
	[Correo] [nvarchar](150) NULL,
	[Estado] [bit] NOT NULL,
	[VigenteDesde] [datetime2](0) NOT NULL,
	[VigenteHasta] [datetime2](0) NULL,
	[EsActual] [bit] NOT NULL,
 CONSTRAINT [PK_DimEmpleado] PRIMARY KEY CLUSTERED 
(
	[EmpleadoKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[DimMarca] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimMarca](
	[MarcaKey] [int] IDENTITY(1,1) NOT NULL,
	[MarcaID] [int] NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_DimMarca] PRIMARY KEY CLUSTERED 
(
	[MarcaKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_DimMarca_MarcaID] UNIQUE NONCLUSTERED 
(
	[MarcaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[DimPais] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimPais](
	[PaisKey] [int] IDENTITY(1,1) NOT NULL,
	[PaisID] [int] NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_DimPais] PRIMARY KEY CLUSTERED 
(
	[PaisKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_DimPais_PaisID] UNIQUE NONCLUSTERED 
(
	[PaisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[DimProducto] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimProducto](
	[ProductoKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductoID] [int] NOT NULL,
	[Nombre] [nvarchar](150) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[PrecioUnitario] [decimal](10, 2) NOT NULL,
	[MarcaKey] [int] NULL,
	[ProveedorKey] [int] NULL,
	[Estado] [bit] NOT NULL,
	[VigenteDesde] [datetime2](0) NOT NULL,
	[VigenteHasta] [datetime2](0) NULL,
	[EsActual] [bit] NOT NULL,
 CONSTRAINT [PK_DimProducto] PRIMARY KEY CLUSTERED 
(
	[ProductoKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[DimProveedor] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimProveedor](
	[ProveedorKey] [int] IDENTITY(1,1) NOT NULL,
	[ProveedorID] [int] NOT NULL,
	[Nombre] [nvarchar](150) NOT NULL,
	[PaisKey] [int] NULL,
	[Telefono] [nvarchar](30) NULL,
	[Email] [nvarchar](150) NULL,
	[SitioWeb] [nvarchar](255) NULL,
	[Estado] [bit] NOT NULL,
	[VigenteDesde] [datetime2](0) NOT NULL,
	[VigenteHasta] [datetime2](0) NULL,
	[EsActual] [bit] NOT NULL,
 CONSTRAINT [PK_DimProveedor] PRIMARY KEY CLUSTERED 
(
	[ProveedorKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[DimTipoMovimiento] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimTipoMovimiento](
	[TipoMovimientoKey] [int] IDENTITY(1,1) NOT NULL,
	[TipoMovimientoCodigo] [varchar](30) NOT NULL,
	[TipoMovimientoNombre] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_DimTipoMovimiento] PRIMARY KEY CLUSTERED 
(
	[TipoMovimientoKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_DimTipoMovimiento_Codigo] UNIQUE NONCLUSTERED 
(
	[TipoMovimientoCodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ETL_ControlCarga] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_ControlCarga](
	[ControlKey] [int] IDENTITY(1,1) NOT NULL,
	[Entidad] [nvarchar](100) NOT NULL,
	[UltimaFechaCarga] [datetime2](0) NULL,
	[UltimoIDCarga] [bigint] NULL,
	[UltimaEjecucionKey] [bigint] NULL,
	[FechaActualizacion] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_ETL_ControlCarga] PRIMARY KEY CLUSTERED 
(
	[ControlKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_ETL_ControlCarga_Entidad] UNIQUE NONCLUSTERED 
(
	[Entidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ETL_Ejecucion] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_Ejecucion](
	[EjecucionKey] [bigint] IDENTITY(1,1) NOT NULL,
	[Paquete] [nvarchar](200) NOT NULL,
	[FechaInicio] [datetime2](0) NOT NULL,
	[FechaFin] [datetime2](0) NULL,
	[Estado] [nvarchar](30) NOT NULL,
	[RegistrosExtraidos] [bigint] NOT NULL,
	[RegistrosInsertados] [bigint] NOT NULL,
	[RegistrosActualizados] [bigint] NOT NULL,
	[RegistrosRechazados] [bigint] NOT NULL,
	[Mensaje] [nvarchar](2000) NULL,
 CONSTRAINT [PK_ETL_Ejecucion] PRIMARY KEY CLUSTERED 
(
	[EjecucionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[ETL_Error] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_Error](
	[ErrorKey] [bigint] IDENTITY(1,1) NOT NULL,
	[EjecucionKey] [bigint] NOT NULL,
	[Paquete] [nvarchar](200) NOT NULL,
	[Entidad] [nvarchar](100) NOT NULL,
	[BusinessKey] [nvarchar](500) NULL,
	[FechaError] [datetime2](0) NOT NULL,
	[MensajeError] [nvarchar](2000) NOT NULL,
	[Detalle] [nvarchar](max) NULL,
 CONSTRAINT [PK_ETL_Error] PRIMARY KEY CLUSTERED 
(
	[ErrorKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FactCompra] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactCompra](
	[CompraKey] [bigint] IDENTITY(1,1) NOT NULL,
	[CompraID] [int] NOT NULL,
	[FacturaCompraID] [int] NULL,
	[SolicitudCompraID] [int] NULL,
	[FechaCompraKey] [int] NOT NULL,
	[FechaRegistroKey] [int] NOT NULL,
	[FechaInicioKey] [int] NULL,
	[FechaAprobacionKey] [int] NULL,
	[FechaRecepcionKey] [int] NULL,
	[ProductoKey] [int] NOT NULL,
	[ProveedorKey] [int] NOT NULL,
	[EmpleadoKey] [int] NOT NULL,
	[EmpleadoIniciadorKey] [int] NULL,
	[EmpleadoAprobadorKey] [int] NULL,
	[EmpleadoReceptorKey] [int] NULL,
	[EstadoCompra] [nvarchar](40) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[CostoUnitario] [decimal](10, 2) NOT NULL,
	[Subtotal] [decimal](12, 2) NOT NULL,
	[IVA]  AS (CONVERT([decimal](12,2),[Subtotal]*(0.15))) PERSISTED,
	[Total]  AS (CONVERT([decimal](12,2),[Subtotal]+[Subtotal]*(0.15))) PERSISTED,
	[DetalleCompraID] [int] NOT NULL,
 CONSTRAINT [PK_FactCompra] PRIMARY KEY CLUSTERED 
(
	[CompraKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_FactCompra_DetalleCompraID] UNIQUE NONCLUSTERED 
(
	[DetalleCompraID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FactMovimientoInventario] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactMovimientoInventario](
	[MovimientoKey] [bigint] IDENTITY(1,1) NOT NULL,
	[MovimientoInventarioID] [int] NOT NULL,
	[FechaMovimientoKey] [int] NOT NULL,
	[ProductoKey] [int] NOT NULL,
	[EmpleadoKey] [int] NOT NULL,
	[TipoMovimientoKey] [int] NOT NULL,
	[ReferenciaTipo] [varchar](50) NULL,
	[ReferenciaID] [int] NULL,
	[Cantidad] [int] NOT NULL,
	[CantidadNeta] [int] NOT NULL,
	[StockAnterior] [int] NOT NULL,
	[StockPosterior] [int] NOT NULL,
	[Observaciones] [nvarchar](500) NULL,
 CONSTRAINT [PK_FactMovimientoInventario] PRIMARY KEY CLUSTERED 
(
	[MovimientoKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_FactMovimientoInventario_ID] UNIQUE NONCLUSTERED 
(
	[MovimientoInventarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FactSolicitudCompra] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactSolicitudCompra](
	[SolicitudKey] [bigint] IDENTITY(1,1) NOT NULL,
	[SolicitudCompraID] [int] NOT NULL,
	[DetalleSolicitudCompraID] [int] NOT NULL,
	[FechaSolicitudKey] [int] NOT NULL,
	[FechaRegistroKey] [int] NOT NULL,
	[FechaRespuestaKey] [int] NULL,
	[ProductoKey] [int] NOT NULL,
	[EmpleadoKey] [int] NOT NULL,
	[EmpleadoRespuestaKey] [int] NULL,
	[EstadoSolicitud] [nvarchar](40) NOT NULL,
	[CantidadSolicitada] [int] NOT NULL,
 CONSTRAINT [PK_FactSolicitudCompra] PRIMARY KEY CLUSTERED 
(
	[SolicitudKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_FactSolicitudCompra_DetalleSolicitudCompraID] UNIQUE NONCLUSTERED 
(
	[DetalleSolicitudCompraID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FactStockDiario] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactStockDiario](
	[StockDiarioKey] [bigint] IDENTITY(1,1) NOT NULL,
	[FechaKey] [int] NOT NULL,
	[ProductoKey] [int] NOT NULL,
	[StockInicial] [int] NOT NULL,
	[Entradas] [int] NOT NULL,
	[Salidas] [int] NOT NULL,
	[AjustesPositivos] [int] NOT NULL,
	[AjustesNegativos] [int] NOT NULL,
	[CantidadNeta] [int] NOT NULL,
	[StockFinal] [int] NOT NULL,
 CONSTRAINT [PK_FactStockDiario] PRIMARY KEY CLUSTERED 
(
	[StockDiarioKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_FactStockDiario_FechaProducto] UNIQUE NONCLUSTERED 
(
	[FechaKey] ASC,
	[ProductoKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [dbo].[FactVenta] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactVenta](
	[VentaKey] [bigint] IDENTITY(1,1) NOT NULL,
	[VentaID] [int] NOT NULL,
	[FacturaVentaID] [int] NOT NULL,
	[FechaVentaKey] [int] NOT NULL,
	[FechaRegistroKey] [int] NOT NULL,
	[ProductoKey] [int] NOT NULL,
	[ClienteKey] [int] NOT NULL,
	[EmpleadoKey] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[PrecioUnitario] [decimal](10, 2) NOT NULL,
	[Subtotal] [decimal](12, 2) NOT NULL,
	[IVA]  AS (CONVERT([decimal](12,2),[Subtotal]*(0.15))) PERSISTED,
	[Total]  AS (CONVERT([decimal](12,2),[Subtotal]+[Subtotal]*(0.15))) PERSISTED,
	[DetalleVentaID] [int] NOT NULL,
 CONSTRAINT [PK_FactVenta] PRIMARY KEY CLUSTERED 
(
	[VentaKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [stg].[Cliente] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[Cliente](
	[StgClienteKey] [bigint] IDENTITY(1,1) NOT NULL,
	[ClienteID] [int] NOT NULL,
	[Nombres] [nvarchar](200) NOT NULL,
	[Apellidos] [nvarchar](200) NOT NULL,
	[Telefono] [nvarchar](60) NULL,
	[Direccion] [nvarchar](510) NULL,
	[Correo] [nvarchar](300) NULL,
	[Estado] [bit] NOT NULL,
	[FechaCarga] [datetime2](0) NOT NULL,
	[EjecucionKey] [bigint] NOT NULL,
 CONSTRAINT [PK_stg_Cliente] PRIMARY KEY CLUSTERED 
(
	[StgClienteKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [stg].[Empleado] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[Empleado](
	[StgEmpleadoKey] [bigint] IDENTITY(1,1) NOT NULL,
	[EmpleadoID] [int] NOT NULL,
	[Nombres] [nvarchar](200) NOT NULL,
	[Apellidos] [nvarchar](200) NOT NULL,
	[Cargo] [nvarchar](200) NULL,
	[DepartamentoKey] [int] NOT NULL,
	[Telefono] [nvarchar](60) NULL,
	[Correo] [nvarchar](300) NULL,
	[Estado] [bit] NOT NULL,
	[FechaCarga] [datetime2](0) NOT NULL,
	[EjecucionKey] [bigint] NOT NULL,
 CONSTRAINT [PK_stg_Empleado] PRIMARY KEY CLUSTERED 
(
	[StgEmpleadoKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [stg].[FactCompra] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[FactCompra](
	[StgFactCompraKey] [bigint] IDENTITY(1,1) NOT NULL,
	[DetalleCompraID] [int] NOT NULL,
	[CompraID] [int] NOT NULL,
	[FacturaCompraID] [int] NULL,
	[SolicitudCompraID] [int] NULL,
	[FechaCompra] [datetime2](0) NOT NULL,
	[FechaRegistro] [datetime2](0) NOT NULL,
	[FechaInicio] [datetime2](0) NULL,
	[FechaAprobacion] [datetime2](0) NULL,
	[FechaRecepcion] [datetime2](0) NULL,
	[ProductoID] [int] NOT NULL,
	[ProveedorID] [int] NOT NULL,
	[EmpleadoID] [int] NOT NULL,
	[EmpleadoIniciadorID] [int] NULL,
	[EmpleadoAprobadorID] [int] NULL,
	[EmpleadoReceptorID] [int] NULL,
	[EstadoCompra] [nvarchar](40) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[CostoUnitario] [decimal](10, 2) NOT NULL,
	[SubtotalDetalle] [decimal](12, 2) NOT NULL,
	[IVADetalle] [decimal](12, 2) NULL,
	[TotalDetalle] [decimal](12, 2) NULL,
	[FechaCarga] [datetime2](0) NOT NULL,
	[EjecucionKey] [bigint] NOT NULL,
 CONSTRAINT [PK_stg_FactCompra] PRIMARY KEY CLUSTERED 
(
	[StgFactCompraKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [stg].[FactMovimientoInventario] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[FactMovimientoInventario](
	[StgFactMovimientoInventarioKey] [bigint] IDENTITY(1,1) NOT NULL,
	[MovimientoInventarioID] [int] NOT NULL,
	[FechaMovimiento] [datetime2](0) NOT NULL,
	[ProductoID] [int] NOT NULL,
	[EmpleadoID] [int] NOT NULL,
	[TipoMovimiento] [nvarchar](40) NOT NULL,
	[ReferenciaTipo] [nvarchar](100) NULL,
	[ReferenciaID] [int] NULL,
	[Cantidad] [int] NOT NULL,
	[CantidadNeta] [int] NOT NULL,
	[StockAnterior] [int] NOT NULL,
	[StockPosterior] [int] NOT NULL,
	[Observaciones] [nvarchar](max) NULL,
	[FechaCarga] [datetime2](0) NOT NULL,
	[EjecucionKey] [bigint] NOT NULL,
 CONSTRAINT [PK_stg_FactMovimientoInventario] PRIMARY KEY CLUSTERED 
(
	[StgFactMovimientoInventarioKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [stg].[FactSolicitudCompra] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[FactSolicitudCompra](
	[StgFactSolicitudCompraKey] [bigint] IDENTITY(1,1) NOT NULL,
	[SolicitudCompraID] [int] NOT NULL,
	[DetalleSolicitudCompraID] [int] NOT NULL,
	[FechaSolicitud] [datetime2](0) NOT NULL,
	[FechaRegistro] [datetime2](0) NOT NULL,
	[FechaRespuesta] [datetime2](0) NULL,
	[ProductoID] [int] NOT NULL,
	[EmpleadoID] [int] NOT NULL,
	[EmpleadoRespuestaID] [int] NULL,
	[EstadoSolicitud] [nvarchar](40) NOT NULL,
	[CantidadSolicitada] [int] NOT NULL,
	[Observaciones] [nvarchar](max) NULL,
	[FechaCarga] [datetime2](0) NOT NULL,
	[EjecucionKey] [bigint] NOT NULL,
 CONSTRAINT [PK_stg_FactSolicitudCompra] PRIMARY KEY CLUSTERED 
(
	[StgFactSolicitudCompraKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Objeto: Table [stg].[FactVenta] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[FactVenta](
	[StgFactVentaKey] [bigint] IDENTITY(1,1) NOT NULL,
	[DetalleVentaID] [int] NOT NULL,
	[VentaID] [int] NOT NULL,
	[FacturaVentaID] [int] NOT NULL,
	[FechaVenta] [datetime2](0) NOT NULL,
	[FechaRegistro] [datetime2](0) NOT NULL,
	[ProductoID] [int] NOT NULL,
	[ClienteID] [int] NOT NULL,
	[EmpleadoID] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[PrecioUnitario] [decimal](10, 2) NOT NULL,
	[SubtotalDetalle] [decimal](12, 2) NOT NULL,
	[IVADetalle] [decimal](12, 2) NOT NULL,
	[TotalDetalle] [decimal](12, 2) NOT NULL,
	[FechaCarga] [datetime2](0) NOT NULL,
	[EjecucionKey] [bigint] NOT NULL,
 CONSTRAINT [PK_stg_FactVenta] PRIMARY KEY CLUSTERED 
(
	[StgFactVentaKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [stg].[Producto] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[Producto](
	[StgProductoKey] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductoID] [int] NOT NULL,
	[Nombre] [nvarchar](150) NOT NULL,
	[Descripcion] [nvarchar](255) NULL,
	[PrecioUnitario] [decimal](10, 2) NOT NULL,
	[MarcaKey] [int] NOT NULL,
	[ProveedorKey] [int] NOT NULL,
	[Estado] [bit] NOT NULL,
	[FechaCarga] [datetime2](0) NOT NULL,
	[EjecucionKey] [bigint] NOT NULL,
 CONSTRAINT [PK_stg_Producto] PRIMARY KEY CLUSTERED 
(
	[StgProductoKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Objeto: Table [stg].[Proveedor] Fecha de script: 28/9/2026 03:44:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[Proveedor](
	[StgProveedorKey] [bigint] IDENTITY(1,1) NOT NULL,
	[ProveedorID] [int] NOT NULL,
	[Nombre] [nvarchar](150) NOT NULL,
	[PaisKey] [int] NULL,
	[Telefono] [nvarchar](30) NULL,
	[Email] [nvarchar](150) NULL,
	[SitioWeb] [nvarchar](255) NULL,
	[Estado] [bit] NOT NULL,
	[FechaCarga] [datetime2](0) NOT NULL,
	[EjecucionKey] [bigint] NOT NULL,
 CONSTRAINT [PK_stg_Proveedor] PRIMARY KEY CLUSTERED 
(
	[StgProveedorKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ETL_ControlCarga] ADD  CONSTRAINT [DF_ETL_ControlCarga_FechaActualizacion]  DEFAULT (sysdatetime()) FOR [FechaActualizacion]
GO
ALTER TABLE [dbo].[ETL_Ejecucion] ADD  CONSTRAINT [DF_ETL_Ejecucion_RegistrosExtraidos]  DEFAULT ((0)) FOR [RegistrosExtraidos]
GO
ALTER TABLE [dbo].[ETL_Ejecucion] ADD  CONSTRAINT [DF_ETL_Ejecucion_RegistrosInsertados]  DEFAULT ((0)) FOR [RegistrosInsertados]
GO
ALTER TABLE [dbo].[ETL_Ejecucion] ADD  CONSTRAINT [DF_ETL_Ejecucion_RegistrosActualizados]  DEFAULT ((0)) FOR [RegistrosActualizados]
GO
ALTER TABLE [dbo].[ETL_Ejecucion] ADD  CONSTRAINT [DF_ETL_Ejecucion_RegistrosRechazados]  DEFAULT ((0)) FOR [RegistrosRechazados]
GO
ALTER TABLE [dbo].[ETL_Error] ADD  CONSTRAINT [DF_ETL_Error_FechaError]  DEFAULT (sysdatetime()) FOR [FechaError]
GO
ALTER TABLE [dbo].[DimEmpleado]  WITH CHECK ADD  CONSTRAINT [FK_DimEmpleado_DimDepartamento] FOREIGN KEY([DepartamentoKey])
REFERENCES [dbo].[DimDepartamento] ([DepartamentoKey])
GO
ALTER TABLE [dbo].[DimEmpleado] CHECK CONSTRAINT [FK_DimEmpleado_DimDepartamento]
GO
ALTER TABLE [dbo].[DimProducto]  WITH CHECK ADD  CONSTRAINT [FK_DimProducto_DimMarca] FOREIGN KEY([MarcaKey])
REFERENCES [dbo].[DimMarca] ([MarcaKey])
GO
ALTER TABLE [dbo].[DimProducto] CHECK CONSTRAINT [FK_DimProducto_DimMarca]
GO
ALTER TABLE [dbo].[DimProducto]  WITH CHECK ADD  CONSTRAINT [FK_DimProducto_DimProveedor] FOREIGN KEY([ProveedorKey])
REFERENCES [dbo].[DimProveedor] ([ProveedorKey])
GO
ALTER TABLE [dbo].[DimProducto] CHECK CONSTRAINT [FK_DimProducto_DimProveedor]
GO
ALTER TABLE [dbo].[DimProveedor]  WITH CHECK ADD  CONSTRAINT [FK_DimProveedor_DimPais] FOREIGN KEY([PaisKey])
REFERENCES [dbo].[DimPais] ([PaisKey])
GO
ALTER TABLE [dbo].[DimProveedor] CHECK CONSTRAINT [FK_DimProveedor_DimPais]
GO
ALTER TABLE [dbo].[ETL_ControlCarga]  WITH CHECK ADD  CONSTRAINT [FK_ETL_ControlCarga_Ejecucion] FOREIGN KEY([UltimaEjecucionKey])
REFERENCES [dbo].[ETL_Ejecucion] ([EjecucionKey])
GO
ALTER TABLE [dbo].[ETL_ControlCarga] CHECK CONSTRAINT [FK_ETL_ControlCarga_Ejecucion]
GO
ALTER TABLE [dbo].[ETL_Error]  WITH CHECK ADD  CONSTRAINT [FK_ETL_Error_Ejecucion] FOREIGN KEY([EjecucionKey])
REFERENCES [dbo].[ETL_Ejecucion] ([EjecucionKey])
GO
ALTER TABLE [dbo].[ETL_Error] CHECK CONSTRAINT [FK_ETL_Error_Ejecucion]
GO
ALTER TABLE [dbo].[FactCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactCompra_Empleado] FOREIGN KEY([EmpleadoKey])
REFERENCES [dbo].[DimEmpleado] ([EmpleadoKey])
GO
ALTER TABLE [dbo].[FactCompra] CHECK CONSTRAINT [FK_FactCompra_Empleado]
GO
ALTER TABLE [dbo].[FactCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactCompra_EmpleadoAprobador] FOREIGN KEY([EmpleadoAprobadorKey])
REFERENCES [dbo].[DimEmpleado] ([EmpleadoKey])
GO
ALTER TABLE [dbo].[FactCompra] CHECK CONSTRAINT [FK_FactCompra_EmpleadoAprobador]
GO
ALTER TABLE [dbo].[FactCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactCompra_EmpleadoIniciador] FOREIGN KEY([EmpleadoIniciadorKey])
REFERENCES [dbo].[DimEmpleado] ([EmpleadoKey])
GO
ALTER TABLE [dbo].[FactCompra] CHECK CONSTRAINT [FK_FactCompra_EmpleadoIniciador]
GO
ALTER TABLE [dbo].[FactCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactCompra_EmpleadoReceptor] FOREIGN KEY([EmpleadoReceptorKey])
REFERENCES [dbo].[DimEmpleado] ([EmpleadoKey])
GO
ALTER TABLE [dbo].[FactCompra] CHECK CONSTRAINT [FK_FactCompra_EmpleadoReceptor]
GO
ALTER TABLE [dbo].[FactCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactCompra_FechaAprobacion] FOREIGN KEY([FechaAprobacionKey])
REFERENCES [dbo].[DimTiempo] ([TiempoKey])
GO
ALTER TABLE [dbo].[FactCompra] CHECK CONSTRAINT [FK_FactCompra_FechaAprobacion]
GO
ALTER TABLE [dbo].[FactCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactCompra_FechaCompra] FOREIGN KEY([FechaCompraKey])
REFERENCES [dbo].[DimTiempo] ([TiempoKey])
GO
ALTER TABLE [dbo].[FactCompra] CHECK CONSTRAINT [FK_FactCompra_FechaCompra]
GO
ALTER TABLE [dbo].[FactCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactCompra_FechaInicio] FOREIGN KEY([FechaInicioKey])
REFERENCES [dbo].[DimTiempo] ([TiempoKey])
GO
ALTER TABLE [dbo].[FactCompra] CHECK CONSTRAINT [FK_FactCompra_FechaInicio]
GO
ALTER TABLE [dbo].[FactCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactCompra_FechaRecepcion] FOREIGN KEY([FechaRecepcionKey])
REFERENCES [dbo].[DimTiempo] ([TiempoKey])
GO
ALTER TABLE [dbo].[FactCompra] CHECK CONSTRAINT [FK_FactCompra_FechaRecepcion]
GO
ALTER TABLE [dbo].[FactCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactCompra_FechaRegistro] FOREIGN KEY([FechaRegistroKey])
REFERENCES [dbo].[DimTiempo] ([TiempoKey])
GO
ALTER TABLE [dbo].[FactCompra] CHECK CONSTRAINT [FK_FactCompra_FechaRegistro]
GO
ALTER TABLE [dbo].[FactCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactCompra_Producto] FOREIGN KEY([ProductoKey])
REFERENCES [dbo].[DimProducto] ([ProductoKey])
GO
ALTER TABLE [dbo].[FactCompra] CHECK CONSTRAINT [FK_FactCompra_Producto]
GO
ALTER TABLE [dbo].[FactCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactCompra_Proveedor] FOREIGN KEY([ProveedorKey])
REFERENCES [dbo].[DimProveedor] ([ProveedorKey])
GO
ALTER TABLE [dbo].[FactCompra] CHECK CONSTRAINT [FK_FactCompra_Proveedor]
GO
ALTER TABLE [dbo].[FactMovimientoInventario]  WITH CHECK ADD  CONSTRAINT [FK_FactMovimientoInventario_Empleado] FOREIGN KEY([EmpleadoKey])
REFERENCES [dbo].[DimEmpleado] ([EmpleadoKey])
GO
ALTER TABLE [dbo].[FactMovimientoInventario] CHECK CONSTRAINT [FK_FactMovimientoInventario_Empleado]
GO
ALTER TABLE [dbo].[FactMovimientoInventario]  WITH CHECK ADD  CONSTRAINT [FK_FactMovimientoInventario_Producto] FOREIGN KEY([ProductoKey])
REFERENCES [dbo].[DimProducto] ([ProductoKey])
GO
ALTER TABLE [dbo].[FactMovimientoInventario] CHECK CONSTRAINT [FK_FactMovimientoInventario_Producto]
GO
ALTER TABLE [dbo].[FactMovimientoInventario]  WITH CHECK ADD  CONSTRAINT [FK_FactMovimientoInventario_Tiempo] FOREIGN KEY([FechaMovimientoKey])
REFERENCES [dbo].[DimTiempo] ([TiempoKey])
GO
ALTER TABLE [dbo].[FactMovimientoInventario] CHECK CONSTRAINT [FK_FactMovimientoInventario_Tiempo]
GO
ALTER TABLE [dbo].[FactMovimientoInventario]  WITH CHECK ADD  CONSTRAINT [FK_FactMovimientoInventario_Tipo] FOREIGN KEY([TipoMovimientoKey])
REFERENCES [dbo].[DimTipoMovimiento] ([TipoMovimientoKey])
GO
ALTER TABLE [dbo].[FactMovimientoInventario] CHECK CONSTRAINT [FK_FactMovimientoInventario_Tipo]
GO
ALTER TABLE [dbo].[FactSolicitudCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactSolicitudCompra_Empleado] FOREIGN KEY([EmpleadoKey])
REFERENCES [dbo].[DimEmpleado] ([EmpleadoKey])
GO
ALTER TABLE [dbo].[FactSolicitudCompra] CHECK CONSTRAINT [FK_FactSolicitudCompra_Empleado]
GO
ALTER TABLE [dbo].[FactSolicitudCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactSolicitudCompra_EmpleadoRespuesta] FOREIGN KEY([EmpleadoRespuestaKey])
REFERENCES [dbo].[DimEmpleado] ([EmpleadoKey])
GO
ALTER TABLE [dbo].[FactSolicitudCompra] CHECK CONSTRAINT [FK_FactSolicitudCompra_EmpleadoRespuesta]
GO
ALTER TABLE [dbo].[FactSolicitudCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactSolicitudCompra_FechaRegistro] FOREIGN KEY([FechaRegistroKey])
REFERENCES [dbo].[DimTiempo] ([TiempoKey])
GO
ALTER TABLE [dbo].[FactSolicitudCompra] CHECK CONSTRAINT [FK_FactSolicitudCompra_FechaRegistro]
GO
ALTER TABLE [dbo].[FactSolicitudCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactSolicitudCompra_FechaRespuesta] FOREIGN KEY([FechaRespuestaKey])
REFERENCES [dbo].[DimTiempo] ([TiempoKey])
GO
ALTER TABLE [dbo].[FactSolicitudCompra] CHECK CONSTRAINT [FK_FactSolicitudCompra_FechaRespuesta]
GO
ALTER TABLE [dbo].[FactSolicitudCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactSolicitudCompra_FechaSolicitud] FOREIGN KEY([FechaSolicitudKey])
REFERENCES [dbo].[DimTiempo] ([TiempoKey])
GO
ALTER TABLE [dbo].[FactSolicitudCompra] CHECK CONSTRAINT [FK_FactSolicitudCompra_FechaSolicitud]
GO
ALTER TABLE [dbo].[FactSolicitudCompra]  WITH CHECK ADD  CONSTRAINT [FK_FactSolicitudCompra_Producto] FOREIGN KEY([ProductoKey])
REFERENCES [dbo].[DimProducto] ([ProductoKey])
GO
ALTER TABLE [dbo].[FactSolicitudCompra] CHECK CONSTRAINT [FK_FactSolicitudCompra_Producto]
GO
ALTER TABLE [dbo].[FactStockDiario]  WITH CHECK ADD  CONSTRAINT [FK_FactStockDiario_Producto] FOREIGN KEY([ProductoKey])
REFERENCES [dbo].[DimProducto] ([ProductoKey])
GO
ALTER TABLE [dbo].[FactStockDiario] CHECK CONSTRAINT [FK_FactStockDiario_Producto]
GO
ALTER TABLE [dbo].[FactStockDiario]  WITH CHECK ADD  CONSTRAINT [FK_FactStockDiario_Tiempo] FOREIGN KEY([FechaKey])
REFERENCES [dbo].[DimTiempo] ([TiempoKey])
GO
ALTER TABLE [dbo].[FactStockDiario] CHECK CONSTRAINT [FK_FactStockDiario_Tiempo]
GO
ALTER TABLE [dbo].[FactVenta]  WITH CHECK ADD  CONSTRAINT [FK_FactVenta_Cliente] FOREIGN KEY([ClienteKey])
REFERENCES [dbo].[DimCliente] ([ClienteKey])
GO
ALTER TABLE [dbo].[FactVenta] CHECK CONSTRAINT [FK_FactVenta_Cliente]
GO
ALTER TABLE [dbo].[FactVenta]  WITH CHECK ADD  CONSTRAINT [FK_FactVenta_Empleado] FOREIGN KEY([EmpleadoKey])
REFERENCES [dbo].[DimEmpleado] ([EmpleadoKey])
GO
ALTER TABLE [dbo].[FactVenta] CHECK CONSTRAINT [FK_FactVenta_Empleado]
GO
ALTER TABLE [dbo].[FactVenta]  WITH CHECK ADD  CONSTRAINT [FK_FactVenta_FechaRegistro] FOREIGN KEY([FechaRegistroKey])
REFERENCES [dbo].[DimTiempo] ([TiempoKey])
GO
ALTER TABLE [dbo].[FactVenta] CHECK CONSTRAINT [FK_FactVenta_FechaRegistro]
GO
ALTER TABLE [dbo].[FactVenta]  WITH CHECK ADD  CONSTRAINT [FK_FactVenta_FechaVenta] FOREIGN KEY([FechaVentaKey])
REFERENCES [dbo].[DimTiempo] ([TiempoKey])
GO
ALTER TABLE [dbo].[FactVenta] CHECK CONSTRAINT [FK_FactVenta_FechaVenta]
GO
ALTER TABLE [dbo].[FactVenta]  WITH CHECK ADD  CONSTRAINT [FK_FactVenta_Producto] FOREIGN KEY([ProductoKey])
REFERENCES [dbo].[DimProducto] ([ProductoKey])
GO
ALTER TABLE [dbo].[FactVenta] CHECK CONSTRAINT [FK_FactVenta_Producto]
GO
ALTER TABLE [stg].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_stg_Cliente_Ejecucion] FOREIGN KEY([EjecucionKey])
REFERENCES [dbo].[ETL_Ejecucion] ([EjecucionKey])
GO
ALTER TABLE [stg].[Cliente] CHECK CONSTRAINT [FK_stg_Cliente_Ejecucion]
GO
ALTER TABLE [stg].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK_stg_Empleado_Departamento] FOREIGN KEY([DepartamentoKey])
REFERENCES [dbo].[DimDepartamento] ([DepartamentoKey])
GO
ALTER TABLE [stg].[Empleado] CHECK CONSTRAINT [FK_stg_Empleado_Departamento]
GO
ALTER TABLE [stg].[Empleado]  WITH CHECK ADD  CONSTRAINT [FK_stg_Empleado_Ejecucion] FOREIGN KEY([EjecucionKey])
REFERENCES [dbo].[ETL_Ejecucion] ([EjecucionKey])
GO
ALTER TABLE [stg].[Empleado] CHECK CONSTRAINT [FK_stg_Empleado_Ejecucion]
GO
ALTER TABLE [stg].[FactCompra]  WITH CHECK ADD  CONSTRAINT [FK_stg_FactCompra_Ejecucion] FOREIGN KEY([EjecucionKey])
REFERENCES [dbo].[ETL_Ejecucion] ([EjecucionKey])
GO
ALTER TABLE [stg].[FactCompra] CHECK CONSTRAINT [FK_stg_FactCompra_Ejecucion]
GO
ALTER TABLE [stg].[FactMovimientoInventario]  WITH CHECK ADD  CONSTRAINT [FK_stg_FactMovimientoInventario_Ejecucion] FOREIGN KEY([EjecucionKey])
REFERENCES [dbo].[ETL_Ejecucion] ([EjecucionKey])
GO
ALTER TABLE [stg].[FactMovimientoInventario] CHECK CONSTRAINT [FK_stg_FactMovimientoInventario_Ejecucion]
GO
ALTER TABLE [stg].[FactSolicitudCompra]  WITH CHECK ADD  CONSTRAINT [FK_stg_FactSolicitudCompra_Ejecucion] FOREIGN KEY([EjecucionKey])
REFERENCES [dbo].[ETL_Ejecucion] ([EjecucionKey])
GO
ALTER TABLE [stg].[FactSolicitudCompra] CHECK CONSTRAINT [FK_stg_FactSolicitudCompra_Ejecucion]
GO
ALTER TABLE [stg].[FactVenta]  WITH CHECK ADD  CONSTRAINT [FK_stg_FactVenta_Ejecucion] FOREIGN KEY([EjecucionKey])
REFERENCES [dbo].[ETL_Ejecucion] ([EjecucionKey])
GO
ALTER TABLE [stg].[FactVenta] CHECK CONSTRAINT [FK_stg_FactVenta_Ejecucion]
GO
ALTER TABLE [stg].[Producto]  WITH CHECK ADD  CONSTRAINT [FK_stg_Producto_Ejecucion] FOREIGN KEY([EjecucionKey])
REFERENCES [dbo].[ETL_Ejecucion] ([EjecucionKey])
GO
ALTER TABLE [stg].[Producto] CHECK CONSTRAINT [FK_stg_Producto_Ejecucion]
GO
ALTER TABLE [stg].[Producto]  WITH CHECK ADD  CONSTRAINT [FK_stg_Producto_Marca] FOREIGN KEY([MarcaKey])
REFERENCES [dbo].[DimMarca] ([MarcaKey])
GO
ALTER TABLE [stg].[Producto] CHECK CONSTRAINT [FK_stg_Producto_Marca]
GO
ALTER TABLE [stg].[Producto]  WITH CHECK ADD  CONSTRAINT [FK_stg_Producto_Proveedor] FOREIGN KEY([ProveedorKey])
REFERENCES [dbo].[DimProveedor] ([ProveedorKey])
GO
ALTER TABLE [stg].[Producto] CHECK CONSTRAINT [FK_stg_Producto_Proveedor]
GO
ALTER TABLE [stg].[Proveedor]  WITH CHECK ADD  CONSTRAINT [FK_stg_Proveedor_Ejecucion] FOREIGN KEY([EjecucionKey])
REFERENCES [dbo].[ETL_Ejecucion] ([EjecucionKey])
GO
ALTER TABLE [stg].[Proveedor] CHECK CONSTRAINT [FK_stg_Proveedor_Ejecucion]
GO
ALTER TABLE [stg].[Proveedor]  WITH CHECK ADD  CONSTRAINT [FK_stg_Proveedor_Pais] FOREIGN KEY([PaisKey])
REFERENCES [dbo].[DimPais] ([PaisKey])
GO
ALTER TABLE [stg].[Proveedor] CHECK CONSTRAINT [FK_stg_Proveedor_Pais]
GO
ALTER TABLE [dbo].[ETL_Ejecucion]  WITH CHECK ADD  CONSTRAINT [CK_ETL_Ejecucion_Estado] CHECK  (([Estado]='FALLIDA' OR [Estado]='CON_ERRORES' OR [Estado]='EXITOSA' OR [Estado]='INICIADA'))
GO
ALTER TABLE [dbo].[ETL_Ejecucion] CHECK CONSTRAINT [CK_ETL_Ejecucion_Estado]
GO
ALTER TABLE [dbo].[FactCompra]  WITH CHECK ADD  CONSTRAINT [CK_FactCompra_Cantidad] CHECK  (([Cantidad]>(0)))
GO
ALTER TABLE [dbo].[FactCompra] CHECK CONSTRAINT [CK_FactCompra_Cantidad]
GO
ALTER TABLE [dbo].[FactCompra]  WITH CHECK ADD  CONSTRAINT [CK_FactCompra_Costo] CHECK  (([CostoUnitario]>=(0)))
GO
ALTER TABLE [dbo].[FactCompra] CHECK CONSTRAINT [CK_FactCompra_Costo]
GO
ALTER TABLE [dbo].[FactCompra]  WITH CHECK ADD  CONSTRAINT [CK_FactCompra_Subtotal] CHECK  (([Subtotal]>=(0)))
GO
ALTER TABLE [dbo].[FactCompra] CHECK CONSTRAINT [CK_FactCompra_Subtotal]
GO
ALTER TABLE [dbo].[FactMovimientoInventario]  WITH CHECK ADD  CONSTRAINT [CK_FactMovimientoInventario_Cantidad] CHECK  (([Cantidad]>(0)))
GO
ALTER TABLE [dbo].[FactMovimientoInventario] CHECK CONSTRAINT [CK_FactMovimientoInventario_Cantidad]
GO
ALTER TABLE [dbo].[FactMovimientoInventario]  WITH CHECK ADD  CONSTRAINT [CK_FactMovimientoInventario_StockAnterior] CHECK  (([StockAnterior]>=(0)))
GO
ALTER TABLE [dbo].[FactMovimientoInventario] CHECK CONSTRAINT [CK_FactMovimientoInventario_StockAnterior]
GO
ALTER TABLE [dbo].[FactMovimientoInventario]  WITH CHECK ADD  CONSTRAINT [CK_FactMovimientoInventario_StockPosterior] CHECK  (([StockPosterior]>=(0)))
GO
ALTER TABLE [dbo].[FactMovimientoInventario] CHECK CONSTRAINT [CK_FactMovimientoInventario_StockPosterior]
GO
ALTER TABLE [dbo].[FactSolicitudCompra]  WITH CHECK ADD  CONSTRAINT [CK_FactSolicitudCompra_Cantidad] CHECK  (([CantidadSolicitada]>(0)))
GO
ALTER TABLE [dbo].[FactSolicitudCompra] CHECK CONSTRAINT [CK_FactSolicitudCompra_Cantidad]
GO
ALTER TABLE [dbo].[FactStockDiario]  WITH CHECK ADD  CONSTRAINT [CK_FactStockDiario_AjustesNegativos] CHECK  (([AjustesNegativos]>=(0)))
GO
ALTER TABLE [dbo].[FactStockDiario] CHECK CONSTRAINT [CK_FactStockDiario_AjustesNegativos]
GO
ALTER TABLE [dbo].[FactStockDiario]  WITH CHECK ADD  CONSTRAINT [CK_FactStockDiario_AjustesPositivos] CHECK  (([AjustesPositivos]>=(0)))
GO
ALTER TABLE [dbo].[FactStockDiario] CHECK CONSTRAINT [CK_FactStockDiario_AjustesPositivos]
GO
ALTER TABLE [dbo].[FactStockDiario]  WITH CHECK ADD  CONSTRAINT [CK_FactStockDiario_Entradas] CHECK  (([Entradas]>=(0)))
GO
ALTER TABLE [dbo].[FactStockDiario] CHECK CONSTRAINT [CK_FactStockDiario_Entradas]
GO
ALTER TABLE [dbo].[FactStockDiario]  WITH CHECK ADD  CONSTRAINT [CK_FactStockDiario_Salidas] CHECK  (([Salidas]>=(0)))
GO
ALTER TABLE [dbo].[FactStockDiario] CHECK CONSTRAINT [CK_FactStockDiario_Salidas]
GO
ALTER TABLE [dbo].[FactStockDiario]  WITH CHECK ADD  CONSTRAINT [CK_FactStockDiario_StockFinal] CHECK  (([StockFinal]>=(0)))
GO
ALTER TABLE [dbo].[FactStockDiario] CHECK CONSTRAINT [CK_FactStockDiario_StockFinal]
GO
ALTER TABLE [dbo].[FactStockDiario]  WITH CHECK ADD  CONSTRAINT [CK_FactStockDiario_StockInicial] CHECK  (([StockInicial]>=(0)))
GO
ALTER TABLE [dbo].[FactStockDiario] CHECK CONSTRAINT [CK_FactStockDiario_StockInicial]
GO
ALTER TABLE [dbo].[FactVenta]  WITH CHECK ADD  CONSTRAINT [CK_FactVenta_Cantidad] CHECK  (([Cantidad]>(0)))
GO
ALTER TABLE [dbo].[FactVenta] CHECK CONSTRAINT [CK_FactVenta_Cantidad]
GO
ALTER TABLE [dbo].[FactVenta]  WITH CHECK ADD  CONSTRAINT [CK_FactVenta_Precio] CHECK  (([PrecioUnitario]>=(0)))
GO
ALTER TABLE [dbo].[FactVenta] CHECK CONSTRAINT [CK_FactVenta_Precio]
GO
ALTER TABLE [dbo].[FactVenta]  WITH CHECK ADD  CONSTRAINT [CK_FactVenta_Subtotal] CHECK  (([Subtotal]>=(0)))
GO
ALTER TABLE [dbo].[FactVenta] CHECK CONSTRAINT [CK_FactVenta_Subtotal]
GO
