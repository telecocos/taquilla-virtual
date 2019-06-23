/**
 * Archivo routes.js.
 * Define todos los endpoints de nuestra API HTTP mediante un router, un tipo de objeto
 * que para un endpoint determinado genera una respuesta HTTP.
 * Hay que importar el router en api.js.
 */

const pool = require('../data/config'); // referencia a /data/config.json, donde creamos el pool MySQL

// Endpoints HTTP
const router = app => {
    // Métodos GET:
    app.get('/eventos', (request, response) => { // consultar_eventos()
        // Parámetros opcionales de consultar_eventos:         
        var fecha_inicio = request.query.fecha_inicio;
        var fecha_final = request.query.fecha_final;
        var id_recinto = request.query.id_recinto;
        var ciudad = request.query.ciudad;
        var tipo_usuario = request.query.tipo_usuario;

        // Llama al procedimiento SQL
        pool.query('CALL consultar_eventos(?, ?, ?, ?, ?)', [fecha_inicio, fecha_final, id_recinto, ciudad, tipo_usuario], (error, results) => {
            if (error) console.log(error);
            else response.send(results[0]); // IMPORTANTE quedarse con el elemento [0] => el elemento [1] son metadatos sobre la consulta SQL que no conviene exponer en nuestra API!
        });

    });

    app.get('/eventos/:evento', (request, response) => { // consultar_evento()
        const id_evento = request.params.evento;
        
        // Llama al procedimiento SQL
        pool.query('CALL consultar_evento(?)', id_evento, (error, results) => {
            if(error) console.log(error);
            else response.send(results[0]);
        });

    });

    app.get('/eventos/:evento/gradas', (request, response) => { // consultar_gradas()
        const id_evento = request.params.evento;

        // Llama al procedimiento SQL
        pool.query('CALL consultar_gradas(?)', id_evento, (error, results) => {
            if(error) console.log(error);
            else response.send(results[0]);
        });
    });

    app.get('/eventos/:evento/gradas/:grada/localidades', (request, response) => { // consultar_localidades()
        const id_evento = request.params.evento;
        const id_grada = request.params.grada;

        // Llama al procedimiento SQL
        pool.query('CALL consultar_localidades(?,?)', [id_evento, id_grada], (error, results) => {
            if(error) console.log(error);
            else response.send(results[0]);
        });
    });

    app.get('/eventos/:evento/gradas/:grada/precios', (request, response) => { // consultar_precios()
        const id_evento = request.params.evento;
        const id_grada = request.params.grada;

        // Llama al procedimiento SQL
        pool.query('CALL consultar_precios(?,?)', [id_evento, id_grada], (error, results) => {
            if(error) console.log(error);
            else response.send(results[0]);
        });
    });

    app.get('/eventos/:evento/gradas/:grada/precios/:usuario', (request, response) => { // consultar_precio()
        const id_evento = request.params.evento;
        const id_grada = request.params.grada;
        const tipo_usuario = request.params.usuario;

        // Llama al procedimiento SQL
        pool.query('CALL consultar_precio(?,?,?)', [id_evento, id_grada, tipo_usuario], (error, results) => {
            if(error) console.log(error);
            else response.send(results[0]);
        });
    });

    app.get('/eventos/:evento/asistencia', (request, response) => { // consultar_asistencia()
        const id_evento = request.params.evento;

        // Llama al procedimiento SQL
        pool.query('CALL consultar_asistencia(?)', id_evento, (error, results) => {
            if(error) console.log(error);
            else response.send(results[0]);
        });
    });

    app.get('/eventos/:evento/asistencia/:usuario', (request, response) => { // comprobar_asistencia()
        const id_evento = request.params.evento;
        const tipo_usuario = request.params.usuario;

        // Llama al procedimiento SQL
        pool.query('CALL comprobar_asistencia(?,?)', [id_evento, tipo_usuario], (error, results) => {
            if(error) console.log(error);
            else response.send(results[0]);
        });
    });

    // Métodos POST/DELETE:
    app.post('/clientes', (request, response) => { // registrar_cliente()
        const dni = request.body.dni;
        const nombre = request.body.nombre;
        const primer_apellido = request.body.primer_apellido;
        const segundo_apellido = request.body.segundo_apellido;
        const cuenta_bancaria = request.body.cuenta_bancaria;

        pool.query('CALL registrar_cliente(?,?,?,?,?)', [dni, nombre, primer_apellido, segundo_apellido, cuenta_bancaria], (error, result) => {
            if(error) console.log(error);
            else response.status(201).send(`${results[0]}`); // devuelve el ID del cliente recién registrado
        });
    });

    app.post('/clientes/:cliente/compras/comprar', (request, response) => { // comprar()
        const id_evento = request.body.evento;
        const id_grada = request.body.grada;
        const id_localidad = request.body.localidad;
        const id_cliente = request.params.cliente;
        const tipo_usuario = request.body.tipo_usuario;

        pool.query('CALL comprar(?,?,?,?,?)', [id_localidad, id_cliente, id_evento, tipo_usuario, id_grada], (error, result) => {
            if(error) console.log(error);
            else response.status(201).send(`${results[0]}`);
        });
    });

    app.post('/clientes/:cliente/compras/prerreservar', (request, response) => { // prerreservar()
        const id_evento = request.body.evento;
        const id_grada = request.body.grada;
        const id_localidad = request.body.localidad;
        const id_cliente = request.params.cliente;
        const tipo_usuario = request.body.tipo_usuario;

        pool.query('CALL prerreservar(?,?,?,?,?)', [id_localidad, id_cliente, id_evento, tipo_usuario, id_grada], (error, result) => {
            if(error) console.log(error);
            else response.status(201).send(`${results[0]}`);    
        });
    });  
    
    app.delete('/clientes/:cliente/compras/:compra', (request, response) => { // anular()
        const id_compra = request.params.compra;
        const id_cliente = request.params.cliente;

        pool.query('CALL anular(?,?)', [id_compra, id_cliente], (error, result) => {
            if(error) console.log(error);
            else response.status(201).send(`${results[0]}`);    
        });
    });  

    // Administrador:
    app.post('/recintos', (request, response) => { // add_recinto()
        const nombre = request.body.nombre;
        const tipo = request.body.tipo;
        const direccion = request.body.direccion;
        const ciudad = request.body.ciudad;

        pool.query('CALL add_recinto(?,?,?,?)', [nombre, tipo, direccion, ciudad], (error, result) => {
            if(error) console.log(error);
            else response.status(201).send(`${results[0]}`);  
        });
    });

    app.post('/espectaculos', (request, response) => { // add_espectaculo()
        const nombre = request.body.nombre;
        const descripcion = request.body.descripcion;

        pool.query('CALL add_espectaculo(?,?)', [nombre, descripcion], (error, result) => {
            if(error) console.log(error);
            else response.status(201).send(`${results[0]}`);  
        });
    });

    app.post('/eventos', (request, response) => { // add_evento()
        const id_espectaculo = request.body.espectaculo;
        const id_recinto = request.body.recinto;
        const fecha = request.body.fecha;
        const estado = request.body.estado;
        const t1 = request.body.t1;
        const t2 = request.body.t2;
        const t3 = request.body.t3;
        const aforo_bebe = request.body.aforo_bebe;
        const aforo_parado = request.body.aforo_parado;
        const aforo_jubilado = request.body.aforo_jubilado;
        const aforo_adulto = request.body.aforo_adulto;
        const aforo_infantil = request.body.aforo_infantil;
        const max_pre_cliente = request.body.max_pre_cliente;
        const max_compra_cliente = request.body.max_compra_cliente;

        pool.query('CALL add_evento(?,?,?,?,?,?,?,?,?,?,?,?,?,?)', [id_espectaculo, id_recinto, fecha, estado, t1, t2, t3, aforo_bebe, aforo_parado,
            aforo_jubilado, aforo_adulto, aforo_infantil, max_pre_cliente, max_compra_cliente], (error, result) => {
            if(error) console.log(error);
            else response.status(201).send(`${results[0]}`);  
        });
    });

    app.post('/espectaculos/:espectaculo/participantes', (request, response) => { // add_participante()
        const id_espectaculo = request.params.espectaculo;
        const nombre = request.body.nombre;
        const primer_apellido = request.body.primer_apellido;
        const segundo_apellido = request.body.segundo_apellido;

        pool.query('CALL add_participante(?,?,?,?)', [id_espectaculo, nombre, primer_apellido, segundo_apellido], (error, result) => {
            if(error) console.log(error);
            else response.status(201).send(`${results[0]}`);  
        });
    });

    app.post('/eventos/:evento/gradas', (request, response) => { // add_grada()
        const id_evento = request.params.evento;
        const nombre = request.body.nombre;
        const precio_bebe = request.body.precio_bebe;
        const precio_parado = request.body.precio_parado;
        const precio_jubilado = request.body.precio_jubilado;
        const precio_adulto = request.body.precio_adulto;
        const precio_infantil = request.body.precio_infantil;

        pool.query('CALL add_espectaculo(?,?,?,?,?,?,?)', [id_evento, nombre, precio_bebe, precio_parado, 
            precio_jubilado, precio_adulto, precio_infantil], (error, result) => {
            if(error) console.log(error);
            else response.status(201).send(`${results[0]}`);  
        });
    });

    app.post('/eventos/:evento/gradas/:grada/localidades/:localidad', (request, response) => { // add_localidad()
        const id_evento = request.params.evento;
        const id_grada = request.params.grada;
        const id_localidad = request.params.localidad;
        const estado = request.body.estado;

        pool.query('CALL add_localidad(?,?,?,?)', [id_localidad, id_evento, id_grada, estado], (error, result) => {
            if(error) console.log(error);
            else response.status(201).send(`${results[0]}`);  
        });
    });

}

module.exports = router; // exporta el router al resto del proyecto