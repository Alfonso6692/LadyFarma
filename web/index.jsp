<%-- 
    Document   : index
    Created on : 5 oct. 2024, 19:34:01
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
        <div class="col-xl-4">
        <div class="ml-64 p-6 row">
            <h1 class="text-4xl font-bold text-gray-700">Bienvenido al Menú Principal</h1>
            <p class="mt-4 text-gray-600">Seleccione una opción del menú lateral.</p>
        </div>
        <%  
            }
        %>
        <div class="ml-64 flex-grow justify-center row w-[92%] h-[82%]">
            <img src="imagen/tienda.png" alt="Descripción de la imagen" class="w-full h-full object-cover"/>
        </div>
        </div>
    </body>
</html>
