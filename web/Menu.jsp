<%-- 
    Document   : Menu
    Created on : 12 oct. 2024, 12:55:20
    Author     : User
--%>
<%@page import="Entidades.pedido"%>
<%@page import="Entidades.producto"%>
<%@page import="java.util.List"%>
<%@page import="Entidades.cliente"%>
<%@page import="Entidades.cliente"%>
<%@page import="Entidades.usuarios"%>
<%  
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");  
            if (session.getAttribute("usuario") == null) {
                response.sendRedirect("login.jsp");
            }else{
                usuarios usuario = (usuarios) session.getAttribute("usuario");
                List<cliente> clientesListado=(List) request.getAttribute("clientesListado");
                List<producto> productosListado=(List) request.getAttribute("productosListado");
                List<pedido> Listarpedidos=(List) request.getAttribute("Listarpedidos");
                String numerodeboleta=(String) request.getAttribute("numerodeboleta");
        %>

<!-- Sidebar (barra lateral) -->
        <div class="bg-blue-600 text-white w-64 h-full fixed top-0 left-0 flex flex-col py-6">
            <!-- Sección de imagen y nombre de usuario -->
            <div class="flex flex-col items-center px-6 mb-6">
                <img src="imagen/<%= usuario.getUser() %>.png" alt="Usuario" class="w-24 h-24 rounded-full mb-3 border-4 border-white">
                <h2 class="text-xl font-semibold"><%= usuario.getUser() %></h2>
            </div>
            <% if (usuario.getCargo().equals("vendedor")) { %>
            <!-- Menú Vendedor -->
            <nav class="flex flex-col space-y-4 px-6">
                <div class="group">
                    <a class="flex items-center text-lg font-medium hover:bg-blue-500 py-2 px-4 rounded-md cursor-pointer focus:outline-none group-focus-within:text-white">
                        <i class="fas fa-users mr-3"></i> Clientes
                        <i class="fas fa-chevron-down ml-auto"></i>
                    </a>
                    <!-- Submenú oculto hasta que el padre tenga el foco o se pase el mouse -->
                    <div class="ml-6 hidden group-hover:block group-focus-within:block space-y-2">
                        <a href="ClienteServlet?Opcion=Listar" class="block text-lg hover:bg-blue-500 py-2 px-4 rounded-md">Listar Clientes</a>
                        <a href="ClienteServlet?Opcion=Nuevo" class="block text-lg hover:bg-blue-500 py-2 px-4 rounded-md">Nuevo Cliente</a>
                    </div>
                </div>
                <div class="group">
                    <a class="flex items-center text-lg font-medium hover:bg-blue-500 py-2 px-4 rounded-md cursor-pointer focus:outline-none group-focus-within:text-white">
                        <i class="fas fa-box mr-3"></i> Productos
                        <i class="fas fa-chevron-down ml-auto"></i>
                    </a>
                    <!-- Submenú oculto hasta que el padre tenga el foco o se pase el mouse -->
                    <div class="ml-6 hidden group-hover:block group-focus-within:block space-y-2">
                        <a href="ProductoServlet?Opcion=Listar" class="block text-lg hover:bg-blue-500 py-2 px-4 rounded-md">Listar Productos</a>
                        <a href="ProductoServlet?Opcion=Nuevo" class="block text-lg hover:bg-blue-500 py-2 px-4 rounded-md">Nuevo Producto</a>
                    </div>
                </div>
                <div class="group">
                    <a class="flex items-center text-lg font-medium hover:bg-blue-500 py-2 px-4 rounded-md cursor-pointer focus:outline-none group-focus-within:text-white">
                        <i class="fas fa-receipt mr-3"></i> Pedido
                        <i class="fas fa-chevron-down ml-auto"></i>
                    </a>
                    <!-- Submenú oculto hasta que el padre tenga el foco o se pase el mouse -->
                    <div class="ml-6 hidden group-hover:block group-focus-within:block space-y-2">
                        <a href="VentaServlet?Opcion=Listar" class="block text-lg hover:bg-blue-500 py-2 px-4 rounded-md">Listar Pedido</a>
                        <a href="VentaServlet?Opcion=Nuevo" class="block text-lg hover:bg-blue-500 py-2 px-4 rounded-md">Nuevo Pedido</a>
                    </div>
                </div>
            </nav>
            <% } %>
            <% if (usuario.getCargo().equals("administrador")) { %>
            <!-- Menú Administrador -->
            <nav class="flex flex-col space-y-4 px-6">
                <div class="group">
                    <a class="flex items-center text-lg font-medium hover:bg-blue-500 py-2 px-4 rounded-md cursor-pointer focus:outline-none group-focus-within:text-white">
                        <i class="fas fa-users mr-3"></i> Clientes
                        <i class="fas fa-chevron-down ml-auto"></i>
                    </a>
                    <!-- Submenú oculto hasta que el padre tenga el foco o se pase el mouse -->
                    <div class="ml-6 hidden group-hover:block group-focus-within:block space-y-2">
                        <a href="ClienteServlet?Opcion=Listar" class="block text-lg hover:bg-blue-500 py-2 px-4 rounded-md">Listar Clientes</a>
                        <a href="ClienteServlet?Opcion=Nuevo" class="block text-lg hover:bg-blue-500 py-2 px-4 rounded-md">Nuevo Cliente</a>
                    </div>
                </div>
                <div class="group">
                    <a class="flex items-center text-lg font-medium hover:bg-blue-500 py-2 px-4 rounded-md cursor-pointer focus:outline-none group-focus-within:text-white">
                        <i class="fas fa-box mr-3"></i> Productos
                        <i class="fas fa-chevron-down ml-auto"></i>
                    </a>
                    <!-- Submenú oculto hasta que el padre tenga el foco o se pase el mouse -->
                    <div class="ml-6 hidden group-hover:block group-focus-within:block space-y-2">
                        <a href="ProductoServlet?Opcion=Listar" class="block text-lg hover:bg-blue-500 py-2 px-4 rounded-md">Listar Productos</a>
                        <a href="ProductoServlet?Opcion=Nuevo" class="block text-lg hover:bg-blue-500 py-2 px-4 rounded-md">Nuevo Producto</a>
                    </div>
                </div>
                <div class="group">
                    <a class="flex items-center text-lg font-medium hover:bg-blue-500 py-2 px-4 rounded-md cursor-pointer focus:outline-none group-focus-within:text-white">
                        <i class="fas fa-receipt mr-3"></i> Pedido
                        <i class="fas fa-chevron-down ml-auto"></i>
                    </a>
                    <!-- Submenú oculto hasta que el padre tenga el foco o se pase el mouse -->
                    <div class="ml-6 hidden group-hover:block group-focus-within:block space-y-2">
                        <a href="VentaServlet?Opcion=Listar" class="block text-lg hover:bg-blue-500 py-2 px-4 rounded-md">Listar Pedido</a>
                        <a href="VentaServlet?Opcion=Nuevo" class="block text-lg hover:bg-blue-500 py-2 px-4 rounded-md">Nuevo Pedido</a>
                    </div>
                </div>
                <div class="group">
                    <a class="flex items-center text-lg font-medium hover:bg-blue-500 py-2 px-4 rounded-md cursor-pointer focus:outline-none group-focus-within:text-white">
                        <i class="fas fa-users mr-3"></i> Usuarios
                        <i class="fas fa-chevron-down ml-auto"></i>
                    </a>
                    <!-- Submenú oculto hasta que el padre tenga el foco o se pase el mouse -->
                    <div class="ml-6 hidden group-hover:block group-focus-within:block space-y-2">
                        <a href="UsuarioServlet?Opcion=Listar" class="block text-lg hover:bg-blue-500 py-2 px-4 rounded-md">Listar Usuarios</a>
                        <a href="UsuarioServlet?Opcion=Nuevo" class="block text-lg hover:bg-blue-500 py-2 px-4 rounded-md">Nuevo Usuario</a>
                    </div>
                </div>
            </nav>
            <% } %>
            <!-- Cerrar sesión -->
            <div class="px-6 mt-auto">
                <a href="CerrarSesionServlet" class="flex items-center text-lg font-medium hover:bg-blue-500 py-2 px-4 rounded-md">
                    <i class="fas fa-sign-out-alt mr-3"></i> Cerrar Sesión
                </a>
            </div>
  
        </div>                   