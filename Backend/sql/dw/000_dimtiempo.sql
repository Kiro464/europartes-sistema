/*
  DimTiempo: una fila por minuto. Crea la tabla y la llena para el rango
  indicado. Ejecutar primero, en la base DWAutoPartes, antes de 000b_esquema_dw.sql
  (las tablas de hechos tienen claves foráneas hacia DimTiempo).

  Convenciones (iguales a las del Data Warehouse en producción):
    - DiaSemana: lunes = 1 ... domingo = 7.
    - SemanaAnio: semana ISO 8601.
    - FranjaHoraria: Madrugada (0-5 h), Mañana (6-11 h), Tarde (12-17 h), Noche (18-23 h).

  El rango por defecto (año anterior a dos años adelante, unos 2,1 millones de
  filas) cubre los datos de demostración, que se generan relativos a la fecha
  actual. Ajusta @Desde y @Hasta si necesitas otro periodo.
*/
SET NOCOUNT ON;
SET DATEFIRST 1;
GO

IF OBJECT_ID(N'dbo.DimTiempo', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.DimTiempo (
        TiempoKey      INT IDENTITY(1,1) NOT NULL,
        FechaHora      DATETIME2(0)  NOT NULL,
        Fecha          DATE          NOT NULL,
        Anio           SMALLINT      NOT NULL,
        Semestre       TINYINT       NOT NULL,
        Trimestre      TINYINT       NOT NULL,
        Mes            TINYINT       NOT NULL,
        NombreMes      NVARCHAR(20)  NOT NULL,
        Dia            TINYINT       NOT NULL,
        DiaSemana      TINYINT       NOT NULL,
        NombreDia      NVARCHAR(20)  NOT NULL,
        SemanaAnio     TINYINT       NOT NULL,
        Hora           TINYINT       NOT NULL,
        Minuto         TINYINT       NOT NULL,
        FranjaHoraria  NVARCHAR(30)  NOT NULL,
        CONSTRAINT PK_DimTiempo PRIMARY KEY CLUSTERED (TiempoKey),
        CONSTRAINT UQ_DimTiempo_FechaHora UNIQUE NONCLUSTERED (FechaHora)
    );
    CREATE NONCLUSTERED INDEX IX_DimTiempo_Medianoche ON dbo.DimTiempo (Fecha, TiempoKey);
END
GO

-- Del 1 de enero del año anterior al 31 de diciembre de dentro de dos años.
DECLARE @Desde DATE = DATEFROMPARTS(YEAR(GETDATE()) - 1, 1, 1);
DECLARE @Hasta DATE = DATEFROMPARTS(YEAR(GETDATE()) + 2, 12, 31);

IF EXISTS (SELECT 1 FROM dbo.DimTiempo)
BEGIN
    PRINT 'DimTiempo ya tiene datos; no se modifica.';
    RETURN;
END

-- Una inserción por año (unas 525 000 filas cada una), en orden de FechaHora
-- para que TiempoKey quede secuencial.
DECLARE @Inicio DATE = @Desde;
WHILE @Inicio <= @Hasta
BEGIN
    DECLARE @Fin DATE = DATEADD(DAY, -1, DATEADD(YEAR, 1, DATEFROMPARTS(YEAR(@Inicio), 1, 1)));
    IF @Fin > @Hasta SET @Fin = @Hasta;
    DECLARE @Minutos INT = (DATEDIFF(DAY, @Inicio, @Fin) + 1) * 1440;

    ;WITH E1 AS (SELECT 1 AS x FROM (VALUES (1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) v(x)),
          E6 AS (SELECT 1 AS x FROM E1 a, E1 b, E1 c, E1 d, E1 e, E1 f),
          N  AS (SELECT TOP (@Minutos) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS M FROM E6),
          T  AS (SELECT DATEADD(MINUTE, M, CAST(@Inicio AS DATETIME2(0))) AS FH FROM N)
    INSERT INTO dbo.DimTiempo WITH (TABLOCK)
          (FechaHora, Fecha, Anio, Semestre, Trimestre, Mes, NombreMes, Dia,
           DiaSemana, NombreDia, SemanaAnio, Hora, Minuto, FranjaHoraria)
    SELECT
        FH,
        CAST(FH AS DATE),
        YEAR(FH),
        CASE WHEN MONTH(FH) <= 6 THEN 1 ELSE 2 END,
        DATEPART(QUARTER, FH),
        MONTH(FH),
        CHOOSE(MONTH(FH), N'Enero', N'Febrero', N'Marzo', N'Abril', N'Mayo', N'Junio', N'Julio',
               N'Agosto', N'Septiembre', N'Octubre', N'Noviembre', N'Diciembre'),
        DAY(FH),
        DATEPART(WEEKDAY, FH),
        CHOOSE(DATEPART(WEEKDAY, FH), N'Lunes', N'Martes', N'Mi' + NCHAR(233) + N'rcoles', N'Jueves', N'Viernes',
               N'S' + NCHAR(225) + N'bado', N'Domingo'),
        DATEPART(ISO_WEEK, FH),
        DATEPART(HOUR, FH),
        DATEPART(MINUTE, FH),
        CASE WHEN DATEPART(HOUR, FH) < 6 THEN N'Madrugada'
             WHEN DATEPART(HOUR, FH) < 12 THEN N'Ma' + NCHAR(241) + N'ana'
             WHEN DATEPART(HOUR, FH) < 18 THEN N'Tarde'
             ELSE N'Noche' END
    FROM T
    ORDER BY FH;

    PRINT CONCAT('DimTiempo: ', YEAR(@Inicio), ' cargado.');
    SET @Inicio = DATEADD(DAY, 1, @Fin);
END

PRINT 'DimTiempo cargada.';
GO
