# Sistema Europartes

Sistema de gestión para una distribuidora de autopartes: ventas, compras, inventario, despachos, analítica y autoevaluación de vendedores. Incluye una aplicación web, una app Android y una API REST desplegadas en Azure.

## Componentes

| Carpeta | Contenido | Tecnología |
|---|---|---|
| `Backend/` | API REST, reglas de negocio, ETL y reportes del Data Warehouse | Python 3.13, Django 6.1, Django REST Framework, JWT |
| `Frontend/` | Aplicación web de una sola página | HTML, CSS y JavaScript con módulos ES |
| `Android/` | App móvil con funcionamiento sin conexión | Kotlin, Jetpack Compose, Room (Android 8.0+) |
| `infra/adf/` | Pipeline de Azure Data Factory y rol personalizado para ejecutar la ETL | JSON de Azure |
| `docs/` | Documentación técnica de la ETL y de la paridad web-móvil | Markdown |

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

## Puesta en marcha

### Backend

Requisitos: Python 3.13, SQL Server y ODBC Driver 17 for SQL Server.

```bash
cd Backend
python -m venv venv
venv\Scripts\activate          # En Linux o macOS: source venv/bin/activate
pip install -r requirements.txt
```

Configura las variables de entorno a partir de `Backend/.env.example` y luego:

```bash
python manage.py migrate
python manage.py runserver
```

La documentación interactiva de la API queda en `http://localhost:8000/swagger/`.

### Frontend

Es una aplicación estática. Sirve la carpeta `Frontend/` con cualquier servidor web, por ejemplo:

```bash
cd Frontend
python -m http.server 5500
```

La URL de la API se define en `Frontend/js/core/config.js`.

### Android

Abre la carpeta `Android/` en Android Studio y ejecuta la configuración `app`. Por defecto la app usa la API desplegada en Azure; para usar un backend local:

```bash
./gradlew assembleDebug -Peuropartes.apiBaseUrl=http://10.0.2.2:8000/
```

## Pruebas

```bash
# Frontend (Node.js 20+)
node --test Frontend/tests

# Backend
cd Backend
python manage.py test apps.autoevaluacion apps.reportes_dw apps.movimientos.compra.tests apps.movimientos.venta.tests apps.catalogos.tests

# Android
cd Android
./gradlew testDebugUnitTest
```

## Documentación

- [ETL con Azure Data Factory](docs/etl-azure-data-factory.md)
- [Paridad entre la web y la app móvil](docs/paridad-web-movil.md)
