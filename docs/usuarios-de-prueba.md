# Usuarios de prueba

Estos usuarios se crean en una **instalación local** con:

```bash
python manage.py crear_roles
python manage.py reconstruir_datos_desarrollo --confirmar
```

`reconstruir_datos_desarrollo` llama a `crear_usuarios_iniciales`, que crea los departamentos, los empleados y una cuenta por persona con su rol.

**Contraseña de todos los usuarios:** `Demo.Europartes2026`

> Es una contraseña de demostración pública. No la uses en un entorno publicado. Para elegir otra, ejecuta `python manage.py crear_usuarios_iniciales --password "TuClave"`, o define la variable `EUROPARTES_DEMO_PASSWORD` antes de crear los usuarios.

| Usuario | Nombre | Rol | Qué puede hacer |
|---|---|---|---|
| `alejandro.jimenez` | Alejandro Jiménez | Administrador General | Dashboard, resumen ejecutivo, desempeño de vendedores, ETL, consulta de inventario, compras e historiales |
| `carlos.martinez` | Carlos Martínez | Asesor Financiero | Lo mismo que el administrador y, además, aprobar órdenes de compra |
| `laura.rodriguez` | Laura Rodríguez | Asesor Financiero | Igual que Carlos Martínez |
| `maria.garcia` | María García | Vendedor | Punto de venta, clientes, solicitudes de compra, su historial y, en la app Android, la autoevaluación |
| `jose.lopez` | José López | Vendedor | Igual que María García |
| `andrea.mendoza` | Andrea Mendoza | Vendedor | Igual que María García |
| `daniel.torres` | Daniel Torres | Vendedor | Igual que María García |
| `sofia.herrera` | Sofía Herrera | Vendedor | Igual que María García |
| `fernando.espinoza` | Fernando Espinoza | Coordinador de Logística | Dashboards y ETL, gestionar solicitudes, crear e iniciar órdenes de compra, catálogos de marcas, proveedores, países y productos |
| `paola.vargas` | Paola Vargas | Oficial de Logística | Recibir compras, despachar ventas, kardex e historiales, consultar empleados y departamentos |
| `ricardo.castillo` | Ricardo Castillo | Soporte TI | Usuarios y roles, empleados, departamentos, todos los catálogos y la exportación anticipada de autoevaluaciones |
| `gabriela.martinez` | Gabriela Martínez | Asesor de Marketing | Solo configuración de su cuenta |

## Cambiar o restablecer contraseñas

- **Cada usuario:** desde *Configuración → Cambiar contraseña*, en la web o en la app.
- **Soporte TI:** puede restablecer la contraseña de cualquier cuenta desde *Usuarios y roles*.
- **Desde la terminal**, para todos los usuarios de prueba a la vez:

```bash
python manage.py crear_usuarios_iniciales --restablecer-contrasenas
```

## Administrador del panel de Django

Para entrar a `/admin/` crea un superusuario propio:

```bash
python manage.py createsuperuser
```
