<%-- 
    Document   : nuevoClientes
    Created on : 6 oct. 2024, 10:19:53
    Author     : User
--%>

<%@page import="Entidades.usuarios"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html lang="es">
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
            <!-- Formulario para insertar clientes -->
            <div class="mt-8">
                <h1 class="text-3xl font-bold mb-6 text-center">Nuevo Cliente</h1>
                <form action="ClienteServlet" method="POST" class="space-y-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Apellidos -->
                        <div>
                            <label for="apellidos" class="block text-sm font-medium text-gray-700">Apellidos</label>
                            <input type="text" name="apellidos" id="apellidos" class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                        </div>

                        <!-- Nombres -->
                        <div>
                            <label for="nombres" class="block text-sm font-medium text-gray-700">Nombres</label>
                            <input type="text" name="nombres" id="nombres" class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                        </div>

                        <!-- DNI -->
                        <div>
                            <label for="DNI" class="block text-sm font-medium text-gray-700">DNI</label>
                            <input type="text" name="DNI" id="DNI" class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                        </div>

                        <!-- Dirección -->
                        <div>
                            <label for="direccion" class="block text-sm font-medium text-gray-700">Dirección</label>
                            <input type="text" name="direccion" id="direccion" class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                        </div>

                        <!-- Teléfono -->
                        <div>
                            <label for="telefono" class="block text-sm font-medium text-gray-700">Teléfono</label>
                            <input type="text" name="telefono" id="telefono" class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                        </div>

                        <!-- Móvil -->
                        <div>
                            <label for="movil" class="block text-sm font-medium text-gray-700">Móvil</label>
                            <input type="text" name="movil" id="movil" class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                        </div>
                    </div>

                    <!-- Botón de envío -->
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
