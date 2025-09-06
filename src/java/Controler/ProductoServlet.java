/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controler;

import Entidades.producto;
import Entidades.usuarios;
import Persistencia.productoDAO;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet para manejar operaciones con productos.
 */
public class ProductoServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ProductoServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        usuarios usuarioSesion = (usuarios) session.getAttribute("usuario");
        productoDAO productoDao = new productoDAO();
        String accion = request.getParameter("Opcion");

        if (accion == null) {
            request.getRequestDispatcher("listarProductos.jsp").forward(request, response);
            return;
        }

        switch (accion) {
        case "Listar":
    List<producto> productos = productoDao.ListarProductos();
    if (productos == null) {
        productos = new ArrayList<>(); // Evita el NullPointerException
    }
    request.setAttribute("productosListado", productos);
    request.setAttribute("usuario", usuarioSesion);
    request.getRequestDispatcher("listarProductos.jsp").forward(request, response);
    break;


            case "Nuevo":
                request.setAttribute("usuario", usuarioSesion);
                request.getRequestDispatcher("nuevoProductos.jsp").forward(request, response);
                break;

            case "verProducto":
            case "verProductoModificar":
                enviarProductoComoJSON(request, response, productoDao);
                break;

            case "Buscar":
                buscarProducto(request, response, productoDao);
                break;

            default:
                request.getRequestDispatcher("listarProductos.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        usuarios usuarioSesion = (usuarios) session.getAttribute("usuario");
        productoDAO productoDao = new productoDAO();
        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("listarProductos.jsp");
            return;
        }

        switch (accion) {
            case "Registrar":
                registrarProducto(request, productoDao);
                break;
                
            case "Eliminar":
                eliminarProducto(request, productoDao);
                break;

            case "Actualizar":
                actualizarProducto(request, productoDao);
                break;
        }

        List<producto> productosListado = productoDao.ListarProductos();
        request.setAttribute("productosListado", productosListado);
        request.setAttribute("usuario", usuarioSesion);
        request.getRequestDispatcher("listarProductos.jsp").forward(request, response);
    }

    private void enviarProductoComoJSON(HttpServletRequest request, HttpServletResponse response, productoDAO productoDao)
            throws IOException {
        String idProducto = request.getParameter("id");
        if (idProducto == null || idProducto.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de producto no válido");
            return;
        }

        producto productoEncontrado = productoDao.BuscarxItem(idProducto);
        if (productoEncontrado == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Producto no encontrado");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(productoEncontrado));
        out.flush();
    }

    private void buscarProducto(HttpServletRequest request, HttpServletResponse response, productoDAO productoDao)
            throws IOException {
        String tipoBusqueda = request.getParameter("tipoBusqueda");
        String campoBusqueda = request.getParameter("campoBusqueda");

        if (tipoBusqueda == null || campoBusqueda == null || campoBusqueda.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Datos de búsqueda inválidos");
            return;
        }

        producto productoEncontrado = null;
        if ("codigo".equals(tipoBusqueda)) {
            productoEncontrado = productoDao.BuscarxItem(campoBusqueda);
        } else if ("descripcion".equals(tipoBusqueda)) {
            productoEncontrado = productoDao.BuscarxDescripcion(campoBusqueda);
        }

        if (productoEncontrado == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Producto no encontrado");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(productoEncontrado));
        out.flush();
    }

    private void registrarProducto(HttpServletRequest request, productoDAO productoDao) {
        try {
            producto nuevoProducto = new producto();
            nuevoProducto.setId(productoDao.Id_Prod());
            nuevoProducto.setDescripcion(request.getParameter("Descripcion"));
            nuevoProducto.setCosto(Float.parseFloat(request.getParameter("costo")));
            nuevoProducto.setPrecio(Float.parseFloat(request.getParameter("precio")));
            nuevoProducto.setCantidad(Integer.parseInt(request.getParameter("cantidad")));

            productoDao.Registrar(nuevoProducto);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Error en formato de datos al registrar producto", e);
        }
    }

    private void eliminarProducto(HttpServletRequest request, productoDAO productoDao) {
        String idProducto = request.getParameter("Id");
        if (idProducto != null) {
            productoDao.Eliminar(idProducto);
        }
    }

    private void actualizarProducto(HttpServletRequest request, productoDAO productoDao) {
        try {
            producto productoActualizado = new producto();
            productoActualizado.setId(request.getParameter("productoId"));
            productoActualizado.setDescripcion(request.getParameter("productoDescripcion"));
            productoActualizado.setCosto(Float.parseFloat(request.getParameter("productocosto")));
            productoActualizado.setPrecio(Float.parseFloat(request.getParameter("productoprecio")));
            productoActualizado.setCantidad(Integer.parseInt(request.getParameter("productocantidad")));

            productoDao.Actualizar(productoActualizado);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Error en formato de datos al actualizar producto", e);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para la gestión de productos";
    }
}