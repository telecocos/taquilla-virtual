// Configura la conexión con la base de datos MySQL

const mysql = require('mysql');
const config = { // datos para conectarse a la BD
    host: 'mysql',
    user: 'taquillavirtual',
    password: 'tvsinf000',
    database: 'TaquillaVirtual',
};

const pool = mysql.createPool(config); // crea un pool MySQL, permitiendo así conexiones simultáneas
module.exports = pool; // exporta el pool recién creado al resto del proyecto