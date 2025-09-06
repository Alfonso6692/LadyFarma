<%-- 
    Document   : nuevoProductos
    Created on : 19 oct. 2024, 10:55:57
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Menú Principal</title>
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Font Awesome para iconos -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
        <div class="ml-64 p-6 flex-grow bg-white rounded-lg shadow-lg">
            <!-- Formulario para insertar productos -->
            <div class="mt-8">
                <h1 class="text-3xl font-bold mb-6 text-center">Nuevo Producto</h1>
                <form action="ProductoServlet" method="POST" class="space-y-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Descripcion -->
                        <div>
                            <label for="Descripcion" class="block text-sm font-medium text-gray-700">Descripcion</label>
                            <input type="text" name="Descripcion" id="Descripcion" class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                        </div>

                        <!-- Costo -->
                        <div>
                            <label for="costo" class="block text-sm font-medium text-gray-700">Costo</label>
                            <input type="text" name="costo" id="costo" class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                        </div>

                        <!-- Precio -->
                        <div>
                            <label for="precio" class="block text-sm font-medium text-gray-700">Precio</label>
                            <input type="text" name="precio" id="precio" class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                        </div>

                        <!-- Cantidad -->
                        <div>
                            <label for="cantidad" class="block text-sm font-medium text-gray-700">Cantidad</label>
                            <input type="text" name="cantidad" id="cantidad" class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                        </div>

                    <!-- Bot�n de env�o -->
                    <div class="text-right">
                        <input type="submit" name="accion" value="Registrar" class="bg-blue-600 hover:bg-blue-700 text-white py-2 px-6 rounded-md shadow-lg transition duration-300">
                    </div>
                </form>
            </div>
        </div>
        <%  
            }
        %>
    </body>
</html>
