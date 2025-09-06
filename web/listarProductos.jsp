<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Productos</title>
    <!-- CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="Menu.jsp"%>
    
    <div class="ml-55 flex-1 p-6">
        <h1 class="text-3xl font-bold mb-6 text-center">Listado de los Productos</h1>

        <div class="overflow-x-auto ml-auto w-3/4">
            <table class="min-w-full bg-white border border-gray-300">
                <thead>
                    <tr>
                        <th class="px-6 py-3 border-b text-left text-gray-600 font-medium">ID</th>
                        <th class="px-6 py-3 border-b text-left text-gray-600 font-medium">Descripción</th>
                        <th class="px-6 py-3 border-b text-left text-gray-600 font-medium">Costo</th>
                        <th class="px-6 py-3 border-b text-left text-gray-600 font-medium">Precio</th>
                        <th class="px-6 py-3 border-b text-left text-gray-600 font-medium">Cantidad</th>
                        <th class="px-6 py-3 border-b text-center text-gray-600 font-medium" colspan="3">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty productosListado}">
                            <c:forEach var="producto" items="${productosListado}">
                                <tr class="hover:bg-gray-100">
                                    <td class="px-6 py-4 border-b">${producto.id}</td>
                                    <td class="px-6 py-4 border-b">${producto.descripcion}</td>
                                    <td class="px-6 py-4 border-b">${producto.costo}</td>
                                    <td class="px-6 py-4 border-b">${producto.precio}</td>
                                    <td class="px-6 py-4 border-b">${producto.cantidad}</td>
                                    <td class="px-6 py-4 border-b text-center">
                                        <button onclick="verProducto('${producto.id}')" class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600">Consultar</button>
                                    </td>
                                    <td class="px-6 py-4 border-b text-center">
                                        <button onclick="actualizarProducto('${producto.id}')" class="bg-yellow-500 text-white px-3 py-1 rounded hover:bg-yellow-600">Actualizar</button>
                                    </td>
                                    <td class="px-6 py-4 border-b text-center">
                                        <button onclick="eliminar('${producto.id}')" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">Eliminar</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" class="text-center py-4 text-gray-600">No hay productos disponibles.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
