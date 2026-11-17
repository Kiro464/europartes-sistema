/**
 * js/core/config.js
 * Variables de entorno y configuración global de la aplicación.
 */

// En local (localhost o 127.0.0.1) se usa la API de `python manage.py runserver`;
// publicada, la API de Azure App Service.
const ES_LOCAL = ['localhost', '127.0.0.1'].includes(globalThis.location?.hostname);

export const CONFIG = {
    // URL base del backend Django
    API_URL: ES_LOCAL
        ? 'http://127.0.0.1:8000'
        : 'https://europartes-api-h0dcb5dhddgngxcr.westus-01.azurewebsites.net',

    // Rutas de Autenticación (únicas rutas oficiales de JWT)
    AUTH_LOGIN_ENDPOINT: '/api/token/',
    AUTH_REFRESH_ENDPOINT: '/api/token/refresh/',

    // Llaves para localStorage
    TOKEN_KEY: 'europartes_access',
    REFRESH_KEY: 'europartes_refresh',
    USER_KEY: 'europartes_user',

    // Rutas protegidas y públicas
    DEFAULT_AUTH_ROUTE: '#/dashboard',
    PUBLIC_ROUTES: ['#/login']
};
