# Sistema Europartes

Sistema de gestión para una distribuidora de autopartes: ventas, compras, inventario, despachos, analítica y autoevaluación de vendedores. Incluye una aplicación web, una app Android y una API REST desplegadas en Azure.

## Componentes

| Carpeta | Contenido | Tecnología |
|---|---|---|
| `Backend/` | API REST, reglas de negocio, reportes y scripts SQL del Data Warehouse (`Backend/sql/dw`) | Python 3.13, Django 6.1, Django REST Framework, JWT |
| `Frontend/` | Aplicación web de una sola página | HTML, CSS y JavaScript con módulos ES |
| `Android/` | App móvil con funcionamiento sin conexión | Kotlin, Jetpack Compose, Room (Android 8.0+) |
| `etl/` | Proyecto SSIS que carga el Data Warehouse (dimensiones y hechos) | SQL Server Integration Services |
| `docs/` | Instalación local, usuarios de prueba y paridad web-móvil | Markdown |

## Arquitectura

```
App web (Azure Static Web Apps) ─┐
                                 ├─► API Django (Azure App Service) ─┬─► Azure SQL: AutoPartes (operación)
App Android (Kotlin) ────────────┘        JWT + roles               ├─► Azure SQL: DWAutoPartes (Data Warehouse)
                                                                    ├─► Azure Synapse (consultas serverless)
                                                                    └─► MongoDB Atlas (autoevaluaciones)

Azure Data Factory + SSIS ─► carga DWAutoPartes ─► Power BI
```

## Funcionalidades

- **Siete roles** con permisos por módulo y acción, validados en la web, en la app y en la API: Administrador General, Asesor Financiero, Vendedor, Coordinador de Logística, Oficial de Logística, Soporte TI y Asesor de Marketing.
- **Ventas:** punto de venta con validación de stock, IVA, facturación y despachos.
- **Abastecimiento:** solicitudes de compra, órdenes de compra, aprobación financiera y recepción en almacén.
- **Inventario:** catálogo de productos, stock crítico y kardex de movimientos.
- **Catálogos:** clientes, marcas, proveedores, países, empleados y departamentos.
- **Analítica:** dashboard, resumen ejecutivo y desempeño de vendedores sobre el Data Warehouse; ejecución de la ETL desde la web.
- **Autoevaluación mensual de vendedores** guardada en MongoDB Atlas y exportada al Data Warehouse.
- **Reportes** de ventas, compras y kardex con exportación a Excel.
- **App Android sin conexión:** los cambios se guardan en el dispositivo y se sincronizan al recuperar la red.

## Inicio rápido (local)

Requisitos: Windows, Python 3.13, SQL Server con ODBC Driver 17 y `sqlcmd`. La guía completa, con el Data Warehouse, la ETL, MongoDB y la app Android, está en **[docs/instalacion-local.md](docs/instalacion-local.md)**.

```bash
sqlcmd -S . -E -C -Q "CREATE DATABASE AutoPartes; CREATE DATABASE DWAutoPartes;"
cd Backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

```powershell
$env:DJANGO_SECRET_KEY = "una-clave-larga-y-aleatoria"
$env:DJANGO_DEBUG = "True"
```

```bash
python manage.py migrate
python manage.py crear_roles
python manage.py reconstruir_datos_desarrollo --confirmar
python manage.py runserver
```

En otra terminal, sirve la web y abre `http://localhost:5500`:

```bash
cd Frontend
python -m http.server 5500
```

## Usuarios de prueba

`reconstruir_datos_desarrollo` crea 12 usuarios que cubren los 7 roles, todos con la contraseña de demostración `Demo.Europartes2026`. La lista completa está en **[docs/usuarios-de-prueba.md](docs/usuarios-de-prueba.md)**. Por ejemplo:

| Usuario | Rol |
|---|---|
| `alejandro.jimenez` | Administrador General |
| `maria.garcia` | Vendedor |
| `fernando.espinoza` | Coordinador de Logística |
| `carlos.martinez` | Asesor Financiero |
| `paola.vargas` | Oficial de Logística |
| `ricardo.castillo` | Soporte TI |
| `gabriela.martinez` | Asesor de Marketing |

## Pruebas

```bash
# Frontend (Node.js 20+)
node --test Frontend/tests

# Backend
cd Backend
python manage.py test apps.autoevaluacion apps.reportes_dw apps.movimientos.compra.tests apps.movimientos.venta.tests apps.catalogos.tests

# Android
cd Android
gradlew.bat testDebugUnitTest
```

## Documentación

- [Instalación local](docs/instalacion-local.md)
- [Usuarios de prueba](docs/usuarios-de-prueba.md)
- [Paridad entre la web y la app móvil](docs/paridad-web-movil.md)
