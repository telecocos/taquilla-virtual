/**
 * API REST del servicio Taquilla Virtual. 
 * Permite llamar a los procedimientos almacenados a través de peticiones HTTP.
 * Para arrancar la API: `node api.js` en la Terminal
 */

 // Configuración inicial
const express = require('express'); // usaremos el framework Express para construir la API
const bodyParser = require('body-parser'); // framework para manejar JSON
const port = 80; // API disponible en el puerto 80 del contenedor (2080 externo)
const routes = require('./routes/routes'); // enlaza a routes/routes.js, donde definimos todos los endpoints de nuestra API
const app = express(); // crea un servidor en Express

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true,
}));

// Definimos los endpoints HTTP en el fichero routes/routes.js
routes(app);

// Arranca el servidor Express:
const server = app.listen(port, '0.0.0.0', (error) => {
    if (error) return console.log(`Error: ${error}`);
    console.log(`Servidor escuchando en el puerto ${server.address().port}`);
});
