<%-- 
    Document   : listarPedido
    Created on : 2 nov. 2024, 10:28:30
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menú Principal</title>
    </head>
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
            timer = setTimeout(function () {
                window.location.href = 'CerrarSesionServlet'; // Redirigir al servlet de cierre de sesión después de 20 segundos
            }, inactivityTime);
        }
        window.onload = resetTimer;
        window.onmousemove = resetTimer;
        window.onkeypress = resetTimer;
    </script>
</head>
<%@ include file="Menu.jsp"%>
<!-- Contenido principal -->
<div class="ml-55 flex-1 p-6">
    <h1 class="text-3xl font-bold mb-6 text-center">Listado de los Pedidos</h1>
    <div class="overflow-x-auto ml-auto w-3/4">
        <table class="min-w-full bg-white border border-gray-300">
            <thead>
                <tr>
                    <th class="px-6 py-3 border-b border-gray-300 text-left text-gray-600 font-medium">ID_PEDIDO</th>
                    <th class="px-6 py-3 border-b border-gray-300 text-left text-gray-600 font-medium">ID CLIENTE</th>
                    <th class="px-6 py-3 border-b border-gray-300 text-left text-gray-600 font-medium">Fecha</th>
                    <th class="px-6 py-3 border-b border-gray-300 text-left text-gray-600 font-medium">SubTotal</th>
                    <th class="px-6 py-3 border-b border-gray-300 text-left text-gray-600 font-medium">IGV</th>
                    <th class="px-6 py-3 border-b border-gray-300 text-left text-gray-600 font-medium">TotalVenta</th>
                    <th class="px-6 py-3 border-b border-gray-300 text-center text-gray-600 font-medium" colspan="3">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <% if (Listarpedidos != null && !Listarpedidos.isEmpty()) { %>
                <% for (int i = 0; i < Listarpedidos.size(); i++) {%>
                <tr class="hover:bg-gray-100">
                    <td class="px-6 py-4 border-b border-gray-300 text-gray-800"><%=Listarpedidos.get(i).getId_Pedido()%></td>
                    <td class="px-6 py-4 border-b border-gray-300 text-gray-800"><%=Listarpedidos.get(i).getId_Cliente()%></td>
                    <td class="px-6 py-4 border-b border-gray-300 text-gray-800"><%=Listarpedidos.get(i).getFecha()%></td>
                    <td class="px-6 py-4 border-b border-gray-300 text-gray-800"><%=Listarpedidos.get(i).getSubTotal()%></td>
                    <td class="px-6 py-4 border-b border-gray-300 text-gray-800"><%=Listarpedidos.get(i).getIGV()%></td>
                    <td class="px-6 py-4 border-b border-gray-300 text-gray-800"><%=Listarpedidos.get(i).getTotalVenta()%></td>
                    <td class="px-6 py-4 border-b border-gray-300 text-gray-800">
                        <input type="hidden" name="accionproducto" value="ver">
                        <input type="hidden" name="Id_Pedido" id="Id_Pedido" value="<%=Listarpedidos.get(i).getId_Pedido()%>">
                        <button onclick="verPedido('<%=Listarpedidos.get(i).getId_Pedido()%>')" type="button" class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600" data-toggle="modal" data-target="#consultaModal">Consultar</button>
                        <%@ include file="verProductos.jsp"%>
                    </td>

            <td class="px-6 py-4 border-b border-gray-300 text-gray-800">
                <input type="hidden" name="accionproducto" value="ver">
                <input type="hidden" name="Id_Producto" id="Id_Producto" value="<%=Listarpedidos.get(i).getId_Pedido()%>">
                <button onclick="actualizarPedido'<%=Listarpedidos.get(i).getId_Pedido()%>')" type="button" class="bg-yellow-500 text-white px-3 py-1 rounded hover:bg-yellow-600" data-toggle="modal" data-target="#consultaModal">Actualizar</button>
                <%@ include file="editarProductos.jsp"%>
            </td>
            <td class="px-6 py-4 border-b border-gray-300 text-gray-800">
                <input type="hidden" name="Id_Producto" id="Id_Producto" value="<%=productosListado.get(i).getId()%>">
                <input type="hidden" name="accionproducto" value="eliminar">
                <button onclick="eliminar('<%=Listarpedidos.get(i).getId_Pedido()%>')" type="button" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">Eliminar</button>
            </td>
            </tr>
            <% } %>
            <% } else { %>
            <tr>
                <td colspan="2" class="px-6 py-4 border-b border-gray-300 text-gray-800">No hay productos disponibles.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
<% }%>
<script>
    function eliminar(pedidoId) {
        Swal.fire({
            title: 'Estas seguro?',
            text: "Esta accion no se puede deshacer",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'S�, eliminar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                // Crear un formulario din�mico para enviar la solicitud POST
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'ProductoServlet'; // URL a la que se enviar� la solicitud
                form.style.display = 'none'; // Ocultarlo en el DOM

                // A�adir el campo hidden para la acci�n
                const accionField = document.createElement('input');
                accionField.type = 'hidden';
                accionField.name = 'accion';
                accionField.value = 'Eliminar';
                form.appendChild(accionField);

                // A�adir el campo hidden para el ID del cliente
                const idField = document.createElement('input');
                idField.type = 'hidden';
                idField.name = 'Id';
                idField.value = productoId;
                form.appendChild(idField);

                // A�adir el formulario al cuerpo y enviarlo
                document.body.appendChild(form);
                form.submit();
            }
        });
    }
    function verPedido(id) {
        // Realiza la llamada AJAX para obtener los detalles del cliente.
        fetch('ProductoServlet?Opcion=verPedido&id=' + id)
                .then(response => response.json())
                .then(data => {
                    // Rellenar el modal con los datos recibidos
                    document.getElementById('pedido-id').innerText = data.Id_pedido;
                    document.getElementById('pedido-cliente').innerText = data.Id_cliente;
                    document.getElementById('pedido-fecha').innerText = data.Fecha;
                    document.getElementById('pedido-subTotal').innerText = data.SubTotal;
                    document.getElementById('pedido-TotalVentas').innerText = data.TotalVentas;
                    // Mostrar el modal
                    var modal = new bootstrap.Modal(document.getElementById('consultaModal'));
                    modal.show();
                })
                .catch(error => console.error('Error al cargar los detalles del producto:', error));
    }
    function actualizarPedido(id) {
        // Realiza la llamada AJAX para obtener los detalles del cliente.
        fetch('ProductoServlet?Opcion=verPedido&id=' + id)
                .then(response => response.json())
                .then(data => {
                    // Rellenar el modal con los datos recibidos
                    console.log(data.Id);
                    document.getElementById('pedidoactualizar-id_pedido').value = data.Id;
                    document.getElementById('pedidoactualizar-id_cliente').value = data.Descripcion;
                    document.getElementById('pedidoactualizar-fecha').value = data.Costo;
                    document.getElementById('pedidoactualizar-SubTotal').value = data.Precio;
                    document.getElementById('pedidoactualizar-TotalVenta').value = data.Cantidad;
                    // Mostrar el modal
                    var modal = new bootstrap.Modal(document.getElementById('actualizaModal'));
                    modal.show();
                })
                .catch(error => console.error('Error al cargar los detalles del producto', error));

        // SE CAMBIA LOS ID DE LOS ELEMENTOS A PESAR DE QUE SEAN INCLUDE PARA EVITAR QUE LOS DATOS DEL ID QUE SE ENCUENTRA DEBAJO NO SE LLENE
    }

</script>
</body>
</html>

