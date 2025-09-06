<%-- 
    Document   : listarClientes
    Created on : 6 oct. 2024, 10:19:12
    Author     : User
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="Entidades.usuarios"%>
<%@page import="Entidades.cliente"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page session="true" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Menú Principal</title>
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
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
                timer = setTimeout(function() {
                    window.location.href = 'CerrarSesionServlet'; // Redirigir al servlet de cierre de sesión después de 20 segundos
                }, inactivityTime);
            }
            window.onload = resetTimer;
            window.onmousemove = resetTimer;
            window.onkeypress = resetTimer;
        </script>
    </head>
    <body>

        <%@ include file="Menu.jsp"%>
        <!-- Contenido principal -->
        <div class="ml-55 flex-1 p-6">
            <h1 class="text-3xl font-bold mb-6 text-center">Listado de Clientes</h1>
            <div class="overflow-x-auto ml-auto w-3/4">
                <table class="min-w-full bg-white border border-gray-300">
                    <thead>
                        <tr>
                            <th class="px-6 py-3 border-b border-gray-300 text-left text-gray-600 font-medium">ID</th>
                            <th class="px-6 py-3 border-b border-gray-300 text-left text-gray-600 font-medium">Apellidos</th>
                            <th class="px-6 py-3 border-b border-gray-300 text-left text-gray-600 font-medium">Nombres</th>
                            <th class="px-6 py-3 border-b border-gray-300 text-left text-gray-600 font-medium">DNI</th>
                            <th class="px-6 py-3 border-b border-gray-300 text-center text-gray-600 font-medium" colspan="3">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (int i=0;i<clientesListado.size();i++){%>
                        <tr class="hover:bg-gray-100">
                            <td class="px-6 py-4 border-b border-gray-300 text-gray-800"><%=clientesListado.get(i).getId()%></td>
                            <td class="px-6 py-4 border-b border-gray-300 text-gray-800"><%=clientesListado.get(i).getApellidos()%></td>
                            <td class="px-6 py-4 border-b border-gray-300 text-gray-800"><%=clientesListado.get(i).getNombres()%></td>
                            <td class="px-6 py-4 border-b border-gray-300 text-gray-800"><%=clientesListado.get(i).getDNI()%></td>
                            <td class="px-6 py-4 border-b border-gray-300 text-gray-800">
                                <input type="hidden" name="accioncliente" value="ver">
                                <input type="hidden" name="Id_Cliente" id="Id_Cliente" value="<%=clientesListado.get(i).getId()%>">
                                <button onclick="verCliente('<%=clientesListado.get(i).getId()%>')" type="button" class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600" data-toggle="modal" data-target="#consultaModal">Consultar</button>
                                <%@ include file="verClientes.jsp"%>
                            </td>
                            <td class="px-6 py-4 border-b border-gray-300 text-gray-800">
                                <input type="hidden" name="accioncliente" value="ver">
                                <input type="hidden" name="Id_Cliente" id="Id_Cliente" value="<%=clientesListado.get(i).getId()%>">
                                <button onclick="actualizarCliente('<%=clientesListado.get(i).getId()%>')" type="button" class="bg-yellow-500 text-white px-3 py-1 rounded hover:bg-yellow-600" data-toggle="modal" data-target="#consultaModal">Actualizar</button>
                                <%@ include file="editarClientes.jsp"%>
                            </td>
                            <td class="px-6 py-4 border-b border-gray-300 text-gray-800">
                                <input type="hidden" name="Id_Cliente" id="Id_Cliente" value="<%=clientesListado.get(i).getId()%>">
                                <input type="hidden" name="accioncliente" value="eliminar">
                                <button onclick="eliminar('<%=clientesListado.get(i).getId()%>')" type="button" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">Eliminar</button>
                            </td>
                        </tr>
                       <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <% } %>
        <script>
        function eliminar(clienteId) {
            Swal.fire({
                title: '¿Estás seguro?',
                text: "Esta acción no se puede deshacer",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Sí, eliminar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Crear un formulario dinámico para enviar la solicitud POST
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'ClienteServlet'; // URL a la que se enviará la solicitud
                    form.style.display = 'none'; // Ocultarlo en el DOM

                    // Añadir el campo hidden para la acción
                    const accionField = document.createElement('input');
                    accionField.type = 'hidden';
                    accionField.name = 'accion';
                    accionField.value = 'Eliminar';
                    form.appendChild(accionField);

                    // Añadir el campo hidden para el ID del cliente
                    const idField = document.createElement('input');
                    idField.type = 'hidden';
                    idField.name = 'Id';
                    idField.value = clienteId;
                    form.appendChild(idField);

                    // Añadir el formulario al cuerpo y enviarlo
                    document.body.appendChild(form);
                    form.submit();
                }
            });
        }
        function verCliente(id) {
            // Realiza la llamada AJAX para obtener los detalles del cliente.
            fetch('ClienteServlet?Opcion=verCliente&id=' + id)
              .then(response => response.json())
              .then(data => {
                // Rellenar el modal con los datos recibidos
                document.getElementById('cliente-id').innerText = data.Id;
                document.getElementById('cliente-apellidos').innerText = data.Apellidos;
                document.getElementById('cliente-nombres').innerText = data.Nombres;
                document.getElementById('cliente-dni').innerText = data.DNI;
                document.getElementById('cliente-direccion').innerText = data.Direccion;
                document.getElementById('cliente-telefono').innerText = data.Telefono;
                document.getElementById('cliente-movil').innerText = data.Movil;
                // Mostrar el modal
                var modal = new bootstrap.Modal(document.getElementById('consultaModal'));
                modal.show();
              })
              .catch(error => console.error('Error al cargar los detalles del cliente:', error));
          }
        function actualizarCliente(id) {
            // Realiza la llamada AJAX para obtener los detalles del cliente.
            fetch('ClienteServlet?Opcion=verCliente&id=' + id)
              .then(response => response.json())
              .then(data => {
                // Rellenar el modal con los datos recibidos
                console.log(data.Id);
                document.getElementById('clienteactualizar-id').value = data.Id;
                document.getElementById('clienteactualizar-apellidos').value  = data.Apellidos;
                document.getElementById('clienteactualizar-nombres').value  = data.Nombres;
                document.getElementById('clienteactualizar-dni').value  = data.DNI;
                document.getElementById('clienteactualizar-direccion').value  = data.Direccion;
                document.getElementById('clienteactualizar-telefono').value  = data.Telefono;
                document.getElementById('clienteactualizar-movil').value  = data.Movil;
                // Mostrar el modal
                var modal = new bootstrap.Modal(document.getElementById('actualizaModal'));
                modal.show();
              })
              .catch(error => console.error('Error al cargar los detalles del cliente:', error));
      
      // SE CAMBIA LOS ID DE LOS ELEMENTOS A PESAR DE QUE SEAN INCLUDE PARA EVITAR QUE LOS DATOS DEL ID QUE SE ENCUENTRA DEBAJO NO SE LLENE
          }
          
    </script>
    </body>
</html>
