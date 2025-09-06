<%-- 
    Document   : registrarVenta
    Created on : 26 oct. 2024, 11:24:27
    Author     : User
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Menú Principal</title>

        <!-- Font Awesome para iconos -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
        <style>
            body {
                background-color: #f3f4f6;
                height: 100vh;
                display: flex;
            }
        </style>
        <script>
            // Tiempo de inactividad en milisegundos (20 segundos)
            var inactivityTime = 30000;
            var timer;

            function resetTimer() {
                clearTimeout(timer);
                timer = setTimeout(function () {
                    window.location.href = 'CerrarSesionServlet'; // Redirigir al servlet de cierre de sesión después de 20 segundos
                }, inactivityTime);
            }
            window.onload = resetTimer;
            window.onmousemove = resetTimer;
            window.onkeypress = resetTimer;
        </script>
    </head>
    <body class="bg-gray-100 flex h-screen">
        <%@ include file="Menu.jsp"%>
        <!-- Contenido principal -->
        <div class="flex-1 ml-64 p-6 space-y-6">
            <!-- Formulario de Pedido -->
            <div class="bg-white p-6 shadow-lg rounded-lg space-y-4">
                <!-- Búsqueda de Cliente -->
                <div class="flex space-x-4">
                    <div class="w-1/3">
                        <label class="text-gray-700 font-semibold">DNI:</label>
                        <div class="flex">
                            <input type="text" id="dni" class="w-full px-4 py-2 border rounded-md focus:outline-none" placeholder="Ingrese DNI">
                            <button  id="buscarClientexDNI" class="bg-blue-500 text-white px-4 py-2 ml-2 rounded-md">Buscar</button>
                        </div>
                    </div>
                    <div class="w-1/3">
                        <label class="text-gray-700 font-semibold">Nombre Completo:</label>
                        <input type="text" id="nombreCompleto" class="w-full px-4 py-2 border rounded-md bg-gray-100" readonly>
                    </div>
                    <div class="w-1/3">
                        <label class="text-gray-700 font-semibold">Dirección:</label>
                        <input type="text" id="direccion" class="w-full px-4 py-2 border rounded-md bg-gray-100" readonly>
                    </div>
                </div>

                <!-- Fecha y Número de Pedido -->
                <div class="flex space-x-4 mt-4">
                    <div class="w-1/2">
                        <label class="text-gray-700 font-semibold">Fecha:</label>
                        <input type="date" id="fecha" class="w-full px-4 py-2 border rounded-md focus:outline-none">
                    </div>

                    <div class="w-1/2">
                        <label class="text-gray-700 font-semibold">Número de Pedido:</label>
                        <input type="text" id="numerodeboleta" class="w-full px-4 py-2 border rounded-md bg-gray-100" value="<%=numerodeboleta%>" readonly>
                    </div>
                </div>

                <!-- Tabla de Ítems -->
                <div class="mt-6">
                    <button onclick="agregarItem()" class="bg-blue-500 text-white px-4 py-2 rounded-md">Agregar Ítem</button>
                    <table class="w-full mt-4 border">
                        <thead>
                            <tr class="bg-gray-200 text-gray-700">
                                <th class="p-2 border">Ítem</th>
                                <th class="p-2 border">Descripción</th>
                                <th class="p-2 border">Precio</th>
                                <th class="p-2 border">Cantidad</th>
                                <th class="p-2 border">Subtotal</th>
                                <th class="p-2 border">Eliminar</th>
                            </tr>
                        </thead>
                        <tbody id="tablaPedido">

                        </tbody>
                    </table>
                </div>

                <!-- Resumen de Totales -->
                <div class="flex justify-end mt-4 space-y-2">
                    <div class="w-2/4">
                        <div class="flex justify-between p-2 items-center">
                            <span class="text-gray-600 font-semibold">Subtotal: S/</span>
                            <input type="text" id="subtotalpedido" class="p-2 border text-gray-900" readonly>
                        </div>
                        <div class="flex justify-between p-2 items-center">
                            <span class="text-gray-700 font-semibold">IGV (18%): S/</span>
                            <input type="text" id="igvpedido" class="p-2 border text-gray-900" readonly>
                        </div>
                        <div class="flex justify-between p-2 bg-gray-100 items-center">
                            <span class="text-gray-700 font-semibold">Total: S/</span>
                            <input type="text" id="totalpedido" class="p-2 border text-gray-900" readonly>
                        </div>
                    </div>
                </div>

                <!-- Botón de Generar Pedido -->
                <div class="text-right mt-6">
                    <button onclick="enviarDatos()" class="bg-green-500 text-white px-6 py-2 rounded-md hover:bg-green-600">Generar Pedido</button>
                </div>
            </div>
        </div>
        <%
            }
        %>          
        <script>
            let tablaPedido;
            let productoId;
            let subtotaldelepdido;
            let totaldelpedido;
            let igvdelpedido;
            let montosubtotal = 0;
            let montototal = 0;
            let montoigv = 0;
            let itemsArray = [];
            // Función para establecer la fecha de hoy en el input
            document.addEventListener("DOMContentLoaded", function () {
                const inputFecha = document.getElementById("fecha");

                // Obtener la fecha actual en la zona horaria de Perú
                const fecha = new Date();
                const opciones = {timeZone: 'America/Lima', year: 'numeric', month: '2-digit', day: '2-digit'};
                const fechaPeru = fecha.toLocaleDateString('en-CA', opciones); // Formato 'YYYY-MM-DD'

                inputFecha.value = fechaPeru; // Asignar la fecha actual al campo
                tablaPedido = document.getElementById('tablaPedido');
                productoId = document.getElementById('productoId');
                subtotaldelepdido = document.getElementById("subtotalpedido");
                document.getElementById("subtotalpedido");
                totaldelpedido = document.getElementById("totalpedido");
                igvdelpedido = document.getElementById("igvpedido");
                tablaPedido.innerHTML = ``;
                console.log(document.documentElement.outerHTML);
            });
            document.getElementById("buscarClientexDNI").addEventListener("click", function () {
                const dni = document.getElementById("dni").value; // Obtener el DNI ingresado
                console.log("Esto es un mensaje simple.");
                // Realizamos una petición fetch a la API
                fetch(`ClienteServlet?Opcion=buscarClientexDNI&dni=` + dni) // Cambia la URL según tu backend
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('DNI no encontrado');
                            }
                            return response.json(); // Parsear la respuesta como JSON
                        })
                        .then(data => {
                            // Si se encuentra el cliente, mostrar nombre y dirección
                            document.getElementById("nombreCompleto").value = data.Nombres + " " + data.Apellidos;
                            document.getElementById("direccion").value = data.Direccion;
                            console.log(document.getElementById("direccion").value);
                        })
                        .catch(error => {
                            // Si hay un error, limpiar los campos y mostrar un mensaje
                            document.getElementById("nombreCompleto").value = "";
                            document.getElementById("direccion").value = "";
                            alert(error.message); // Mostrar el mensaje de error
                        });
            });

            function agregarItem() {
                Swal.fire({
                    title: 'Agregar Ítem',
                    html: `
                    <div class="flex items-center space-x-2 mb-4">
                        <select id="tipoBusqueda" class="w-1/4 p-2 border rounded-md focus:outline-none">
                            <option value="codigo">Código</option>
                            <option value="descripcion">Descripción</option>
                        </select>
                        <input type="text" id="campoBusqueda" class="w-1/2 p-2 border rounded-md focus:outline-none" placeholder="Ingrese valor de búsqueda">
                        <button onclick="buscarItem()" class="bg-blue-500 text-white px-4 py-2 rounded-md">Buscar</button>
                    </div>
                    <table class="w-full border mt-2" style="max-height: 200px; overflow-x: auto;">
                        <thead>
                            <tr class="bg-gray-200 text-gray-700">
                                <th class="p-2 border">Ítem</th>
                                <th class="p-2 border">Descripción</th>
                                <th class="p-2 border">Stock</th>
                                <th class="p-2 border">P.Venta</th>
                            </tr>
                        </thead>
                        <tbody id="tablaResultados" >
                        </tbody>
                    </table>
                `,
                    showConfirmButton: false,
                    width: '600px'
                });
            }

            function buscarItem() {
                const tipoBusqueda = document.getElementById('tipoBusqueda').value;
                const campoBusqueda = document.getElementById('campoBusqueda').value;
                console.log(tipoBusqueda + "," + campoBusqueda);
                fetch(`ProductoServlet?Opcion=Buscar&tipoBusqueda=` + tipoBusqueda + `&campoBusqueda=` + campoBusqueda)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error(' no encontrado');
                            }
                            return response.json(); // Parsear la respuesta como JSON
                        })
                        .then(data => {
                            //document.getElementById('producto-id').value = data.Id;
                            //document.getElementById('producto-descripcion').value = data.Descripcion;
                            //document.getElementById('producto-cantidad').value = data.Cantidad;
                            //const tablaResultados = document.getElementById('tablaResultados');
                            // Limpiamos la tabla
                            tablaResultados.innerHTML = '';
                            // Llenar la tabla con los datos obtenidos
                            const row = `
                                    <tr class="producto-row">
                                        <td class="p-2 border">` + data.Id + `</td>
                                        <td class="p-2 border">` + data.Descripcion + `</td>
                                        <td class="p-2 border">` + data.Cantidad + `</td>
                                        <td class="p-2 border">` + data.Precio + `</td>
                                    </tr>
                                `;
                            tablaResultados.innerHTML += row;
                        })
                        .catch(error => console.error('Error:', error));

            }
            // Escuchar el evento de doble clic en las filas de productos
            document.addEventListener("click", function (event) {
                if (event.target.closest(".producto-row")) {
                    const row = event.target.closest(".producto-row");
                    const productoId = row.children[0].textContent;
                    const descripcion = row.children[1].textContent;
                    const stock = parseInt(row.children[2].textContent);
                    const precio = parseInt(row.children[3].textContent);
                    // Mostrar ventana emergente con SweetAlert2
                    Swal.fire({
                        title: 'Producto: ' + descripcion,
                        html: `
                <p><strong>Stock Disponible :</strong>` + stock + `</p>
                <input type="number" id="cantidadIngresada" style="width: 80%;" class="swal2-input" placeholder="Ingrese la cantidad" min="1" max="` + stock + `">
            `,
                        confirmButtonText: 'Agregar',
                        showCancelButton: true,
                        preConfirm: () => {
                            const cantidad = parseInt(document.getElementById('cantidadIngresada').value);
                            if (isNaN(cantidad) || cantidad <= 0 || cantidad > stock) {
                                Swal.showValidationMessage(`Ingrese una cantidad válida (máximo: ` + stock + `)`);
                                return false;
                            }
                            return {productoId, descripcion, cantidad, precio};
                        }
                    }).then((result) => {
                        if (result.isConfirmed) {
                            const {productoId, descripcion, cantidad, precio} = result.value;
                            // Agregar el ítem a la tabla de pedido
                            agregaroeliminarProductoAlPedido(productoId, descripcion, cantidad, precio);
                            console.log(productoId);
                        } else {

                        }

                    });
                }
            });
            function agregaroeliminarProductoAlPedido(productoId, descripcion, cantidad, precio) {
                //console.log(document.documentElement.outerHTML);
                //const tablaPedido = document.getElementById(tablaPedido);
                //console.log(document.documentElement.outerHTML);
                console.log(productoId);
                let productoIdspedido = productoId;
                const rows = `
                        <tr id="` + productoId + `">
                            <td class="p-2 border" id="pedido_productoId">` + productoId + `</td>
                            <td class="p-2 border" id="pedido_productodescripcion">` + descripcion + `</td>
                            <td class="p-2 border" contenteditable="true" id="pedido_productoprecio">` + precio + `</td>
                            <td class="p-2 border" contenteditable="true" id="pedido_productocantidad"><input type="number" id="cantidad" min="0" max="` + cantidad + `" value="` + cantidad + `" /></td>
                            <td class="p-2 border bg-gray-100" contenteditable="true"><input type="text" id="pedido_productosubtotal` + productoId + `" class="p-2 border text-gray-900" readonly value=` + (precio * cantidad) + `></td>
                            <td class="p-2 border"><button onclick="EliminarItem(` + productoIdspedido + `)" class="bg-blue-500 text-white px-4 py-2 rounded-md">Eliminar</button></td>
                        </tr>
                `;
                const subtotal = precio * cantidad;
                tablaPedido.innerHTML += rows;
                montosubtotal += subtotal;
                montoigv += montosubtotal * 0.18;
                montototal = montosubtotal + montoigv;
                subtotaldelepdido.value = montosubtotal.toFixed(2);
                totaldelpedido.value = montototal.toFixed(2);
                igvdelpedido.value = montoigv.toFixed(2);
            }

            function EliminarItem(productoIdspedido) {

                const subtotal_item_Seleccionado = productoIdspedido.children[4].querySelector("input").value;
                console.log(subtotal_item_Seleccionado);
                montosubtotal -= subtotal_item_Seleccionado;
                montoigv = montosubtotal * 0.18;
                montototal = montosubtotal + montoigv;
                subtotaldelepdido.value = montosubtotal.toFixed(2);
                totaldelpedido.value = montototal.toFixed(2);
                igvdelpedido.value = montoigv.toFixed(2);
                productoIdspedido.remove();
            }
            function ActualizarTablaPedido() {
                // Seleccionamos el elemento <tbody> con el ID 'tablaPedido'
                const tablaPedido = document.getElementById("tablaPedido");

                // Obtenemos todas las filas del <tbody>
                const filas = tablaPedido.getElementsByTagName("tr");

                // Inicializamos la variable para almacenar el subtotal acumulado
                let montoSubtotal = 0;
                montosubtotal = 0;
                montoigv = 0;
                montototal = 0;
                // Recorremos cada fila
                Array.from(filas).forEach(fila => {
                    // Suponiendo que el subtotal está en una celda específica, por ejemplo, la tercera columna (índice 2)
                    const idproductoporactualizar = parseFloat(fila.cells[0].textContent) || 0;
                    const precio = parseFloat(fila.cells[2].textContent) || 0;
                    const cantidad = parseFloat(fila.cells[3].querySelector("input").value) || 0;
                    //console.log("el precio es " + precio + " y la cantidad es " + cantidad);
                    const subtotal = precio * cantidad;
                    fila.cells[4].querySelector("input").value = subtotal;
                    //console.log(subtotal);
                    //const actualizacionsubtotal=document.getElementById("pedido_productosubtotal").value = subtotal.toFixed(2);
                    //console.log(actualizacionsubtotal+"dddd");
                    // Sumamos el valor del subtotal a montoSubtotal
                    montosubtotal += subtotal;
                    montoigv += montosubtotal * 0.18;
                    montototal = montosubtotal + montoigv;
                    subtotaldelepdido.value = montosubtotal.toFixed(2);
                    totaldelpedido.value = montototal.toFixed(2);
                    igvdelpedido.value = montoigv.toFixed(2);
                });

            }
            setInterval(ActualizarTablaPedido, 1000);
            function obtenerFilasTabla() {
                
                // Seleccionar la tabla de pedido
                const tablaPedido = document.getElementById("tablaPedido");

                // Obtener todas las filas de la tabla, omitiendo el encabezado (si existe)
                const filas = Array.from(tablaPedido.getElementsByTagName("tr")); // Esto omite la primera fila que suele ser el encabezado

                // Convertir cada fila en un objeto
                return filas.map(fila => {
                    //const celdas = fila.getElementsByTagName("td"); // Obtener todas las celdas de la fila

                    // Asegúrate de que las celdas estén en el orden adecuado en tu tabla: Producto, Precio, Cantidad, Subtotal
                    return {
                        producto: fila.cells[0].textContent, // Columna Producto
                        precio: parseFloat(fila.cells[2].textContent), // Columna Precio
                        cantidad: parseInt(fila.cells[3].querySelector("input").value), // Columna Cantidad
                        subtotal: parseFloat(fila.cells[4].querySelector("input").value) // Columna Subtotal
                    };
                });
            }
            function enviarDatos() {
                const datosTabla = obtenerFilasTabla();
                const dni = document.getElementById('dni').value;
                const fecha = document.getElementById('fecha').value;
                const numeroBoleta = document.getElementById('numerodeboleta').value;
                const subtotalPedido = document.getElementById('subtotalpedido').value;
                const igvPedido = document.getElementById('igvpedido').value;
                const totalPedido = document.getElementById('totalpedido').value;
                console.log("hay una cadena de " + datosTabla.length);
                // Crear un objeto que contenga todos los datos a enviar
                const datosVenta = {
                    dni,
                    fecha,
                    numeroBoleta,
                    subtotalPedido,
                    igvPedido,
                    totalPedido,
                    datosTabla // Agregar los datos de la tabla en un array dentro del objeto
                };

                // Enviar datos al servlet como JSON
                fetch('VentaServlet?accion=registrar_Venta', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(datosVenta) // Convertir datosVenta a JSON y enviarlo en el cuerpo de la solicitud
                })
                        .then(response => response.text())
                        .then(data => console.log("Respuesta del servlet:", data))
                        .catch(error => console.error('Error:', error));
            }
        </script>
    </script>

</body>
</html>
