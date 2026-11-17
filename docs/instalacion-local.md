# Instalación local

Esta guía deja el sistema funcionando en un equipo Windows: la API, la web, la app Android, los datos de demostración, los usuarios de prueba y, si quieres, el Data Warehouse con su ETL.

| Parte | Obligatoria | Sin ella |
|---|---|---|
| SQL Server + base `AutoPartes` | Sí | No funciona nada |
| Data Warehouse `DWAutoPartes` + ETL | No | Dashboard, resumen ejecutivo y desempeño de vendedores aparecen vacíos o con error |
| MongoDB | No | La autoevaluación de vendedores queda deshabilitada |

## 1. Requisitos

- [Python 3.13](https://www.python.org/downloads/)
- [SQL Server 2022 Developer o Express](https://www.microsoft.com/sql-server/sql-server-downloads), con *Integration Services* si vas a usar la ETL
- [ODBC Driver 17 for SQL Server](https://learn.microsoft.com/sql/connect/odbc/download-odbc-driver-for-sql-server)
- `sqlcmd` (se instala con SQL Server)
- Opcional: [Node.js 20+](https://nodejs.org/) para las pruebas del frontend, [Android Studio](https://developer.android.com/studio) para la app, [MongoDB Community](https://www.mongodb.com/try/download/community) para la autoevaluación, y Visual Studio con la extensión *SQL Server Integration Services Projects* para la ETL.

## 2. Bases de datos

Crea las dos bases (con autenticación de Windows en la instancia local):

```bash
sqlcmd -S . -E -C -Q "CREATE DATABASE AutoPartes; CREATE DATABASE DWAutoPartes;"
```

La base `AutoPartes` la llenan las migraciones de Django en el paso 4. El Data Warehouse se crea con los scripts de `Backend/sql/dw`, en este orden:

```bash
cd Backend/sql/dw
sqlcmd -S . -E -C -f 65001 -d DWAutoPartes -b -i 000_dimtiempo.sql
sqlcmd -S . -E -C -f 65001 -d DWAutoPartes -b -i 000b_esquema_dw.sql
sqlcmd -S . -E -C -f 65001 -d DWAutoPartes -b -i 001_stg_autoevaluacion.sql
sqlcmd -S . -E -C -f 65001 -d DWAutoPartes -b -i 002_fact_autoevaluacion.sql
```

`000_dimtiempo.sql` genera una fila por minuto desde el año anterior hasta dos años adelante (unos 2,1 millones de filas) y puede tardar varios minutos.

## 3. Variables de entorno

Copia `Backend/.env.example` como referencia y define al menos estas variables en la terminal donde ejecutarás Django (PowerShell):

```powershell
$env:DJANGO_SECRET_KEY = "una-clave-larga-y-aleatoria"
$env:DJANGO_DEBUG = "True"
```

Por defecto la API se conecta a la instancia local `.` con autenticación de Windows y a las bases `AutoPartes` y `DWAutoPartes`. Si tu SQL Server está en otro equipo, en Docker o usa usuario y contraseña, define también `DB_HOST`, `DB_USER` y `DB_PASSWORD` (y, si cambian, `DB_NAME` y `DW_DB_NAME`).

## 4. API (Backend)

```bash
cd Backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
python manage.py migrate
python manage.py crear_roles
python manage.py reconstruir_datos_desarrollo --confirmar
python manage.py runserver
```

`reconstruir_datos_desarrollo` crea los usuarios de prueba, los catálogos (países, marcas, proveedores, productos y clientes) y un historial de compras, ventas, despachos y movimientos de inventario coherente con el stock. **Borra los datos operativos que ya existan**, así que úsalo solo en una base local.

La API queda en `http://127.0.0.1:8000` y su documentación en `http://127.0.0.1:8000/swagger/`.

## 5. Aplicación web

En otra terminal:

```bash
cd Frontend
python -m http.server 5500
```

Abre `http://localhost:5500`. Cuando la web se abre desde `localhost`, usa automáticamente la API local. Entra con cualquiera de los [usuarios de prueba](usuarios-de-prueba.md).

## 6. App Android

Abre la carpeta `Android/` en Android Studio. Para que el emulador use tu API local (`10.0.2.2` es tu equipo visto desde el emulador):

```bash
cd Android
gradlew.bat installDebug -Peuropartes.apiBaseUrl=http://10.0.2.2:8000/
```

Para que Django acepte esas peticiones, agrega `10.0.2.2` a `DJANGO_ALLOWED_HOSTS` antes de `runserver`:

```powershell
$env:DJANGO_ALLOWED_HOSTS = "localhost,127.0.0.1,10.0.2.2"
```

## 7. Data Warehouse y ETL (opcional)

Los indicadores salen de `DWAutoPartes`, que se llena con el proyecto SSIS de la carpeta `etl/`.

1. **Login de la ETL.** Activa la autenticación mixta en tu SQL Server y crea el login que usa el proyecto:

   ```sql
   CREATE LOGIN etl_europartes WITH PASSWORD = 'UnaClaveSegura!2026';
   USE AutoPartes;   CREATE USER etl_europartes FOR LOGIN etl_europartes; ALTER ROLE db_datareader ADD MEMBER etl_europartes;
   USE DWAutoPartes; CREATE USER etl_europartes FOR LOGIN etl_europartes; ALTER ROLE db_owner ADD MEMBER etl_europartes;
   ```

2. **Catálogo SSISDB.** En SQL Server Management Studio, crea el catálogo (*Integration Services Catalogs → Create Catalog*) y dentro una carpeta llamada `Europartes`.
3. **Despliegue.** Abre `etl/ETL_Europartes.slnx` en Visual Studio y despliega el proyecto (*clic derecho → Deploy*) en `localhost`, carpeta `/SSISDB/Europartes`. El proyecto debe llamarse `ETL_Europartes`.
4. **Parámetros.** En SSMS, *Configure* sobre el proyecto: `pServidorSQL` = `localhost`, `pUsuarioSQL` = `etl_europartes` y `pContrasenaSQL` = la contraseña del paso 1. La contraseña no se guarda en el repositorio.
5. **Ejecución.** Entra a la web con un rol de Administrador General, Asesor Financiero o Coordinador de Logística y pulsa **Actualizar** en el Dashboard. En local, la API lanza `00_Master_ETL.dtsx` desde el SSISDB y muestra su estado.

En Azure, la API lanza la misma ETL con Azure Data Factory (`ETL_EJECUTOR=adf`).

## 8. Autoevaluación con MongoDB (opcional)

Con MongoDB Community en el equipo:

```powershell
$env:MONGODB_URI = "mongodb://localhost:27017"
```

```bash
python manage.py crear_indices_mongo
python manage.py cargar_cuestionario
python manage.py sincronizar_empleados_mongo
python manage.py verificar_mongo
```

También sirve un clúster gratuito de MongoDB Atlas: usa su cadena de conexión en `MONGODB_URI`.

## 9. Pruebas

```bash
node --test Frontend/tests
cd Backend
python manage.py test apps.autoevaluacion apps.reportes_dw apps.movimientos.compra.tests apps.movimientos.venta.tests apps.catalogos.tests
```

Las pruebas del backend crean y borran una base temporal `test_AutoPartes` en tu SQL Server local.
