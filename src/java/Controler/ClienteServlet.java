/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controler;

import Entidades.cliente;
import Entidades.usuarios;
import Persistencia.clienteDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;
/**
 *
 * @author User
 */
@WebServlet(name = "ClienteServlet", urlPatterns = {"/ClienteServlet"})
public class ClienteServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
      
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println(" METHOD GET");
        HttpSession session=request.getSession();
        usuarios usuariosesion=(usuarios)session.getAttribute("usuario");
        System.out.println(usuariosesion.getUser());
            clienteDAO clientedao=new clienteDAO();
            String accion="";
            accion=request.getParameter("Opcion");
            switch (accion){
                case "Listar":
                    List<cliente> clientesListado;
                    clientesListado=clientedao.ListarClientes();
                    request.setAttribute("clientesListado",clientesListado);
                    request.setAttribute("usuario", usuariosesion);
                    System.out.println("Listar cliente JSP");
                    request.getRequestDispatcher("listarClientes.jsp").forward(request, response);
                    break;
                case "Nuevo":
                    request.setAttribute("usuario", usuariosesion);
                    request.getRequestDispatcher("nuevoClientes.jsp").forward(request, response);
                    break;
                case "verCliente":
                    System.out.println("VerCliente");
                     String idCliente = request.getParameter("id");
                    // Busca el cliente en la base de datos
                    cliente cliente = clientedao.Buscar(idCliente);
                    // Configura la respuesta en formato JSON
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    // Crea el objeto JSON
                    PrintWriter out = response.getWriter();
                    out.print("{\"Id\":\"" + cliente.getId() + "\","
                            + "\"Apellidos\":\"" + cliente.getApellidos() + "\","
                            + "\"Nombres\":\"" + cliente.getNombres() + "\","
                            + "\"DNI\":\"" + cliente.getDNI()+ "\","
                            + "\"Direccion\":\"" + cliente.getDireccion() + "\","
                            + "\"Telefono\":\"" + cliente.getTelefono() + "\","
                            + "\"Movil\":\"" + cliente.getMovil() + "\"}");
                    System.out.println(cliente.getId()+""+cliente.getDNI());
                    out.flush();
                    break;
                case "verClienteModificar":
                    System.out.println("VerCliente");
                    idCliente = request.getParameter("id");
                    // Busca el cliente en la base de datos
                    cliente = clientedao.Buscar(idCliente);
                    // Configura la respuesta en formato JSON
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    // Crea el objeto JSON
                    out = response.getWriter();
                    out.print("{\"Id\":\"" + cliente.getId() + "\","
                            + "\"Apellidos\":\"" + cliente.getApellidos() + "\","
                            + "\"Nombres\":\"" + cliente.getNombres() + "\","
                            + "\"DNI\":\"" + cliente.getDNI()+ "\","
                            + "\"Direccion\":\"" + cliente.getDireccion() + "\","
                            + "\"Telefono\":\"" + cliente.getTelefono() + "\","
                            + "\"Movil\":\"" + cliente.getMovil() + "\"}");
                    System.out.println(cliente.getId()+""+cliente.getDNI());
                    out.flush();
                    break;
                case "buscarClientexDNI":
                    System.out.println("VerCliente");
                    String dni = request.getParameter("dni");
                    // Busca el cliente en la base de datos
                    cliente = clientedao.BuscarxDNI(dni);
                    // Configura la respuesta en formato JSON
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    // Crea el objeto JSON
                    out = response.getWriter();
                    out.print("{\"Id\":\"" + cliente.getId() + "\","
                            + "\"Apellidos\":\"" + cliente.getApellidos() + "\","
                            + "\"Nombres\":\"" + cliente.getNombres() + "\","
                            + "\"DNI\":\"" + cliente.getDNI()+ "\","
                            + "\"Direccion\":\"" + cliente.getDireccion() + "\","
                            + "\"Telefono\":\"" + cliente.getTelefono() + "\","
                            + "\"Movil\":\"" + cliente.getMovil() + "\"}");
                    System.out.println(cliente.getId()+""+cliente.getDNI()+"dddddddddddddddddddddddddd");
                    out.flush();
                    break;
                default:
                    request.getRequestDispatcher("listarClientes.jsp").forward(request, response);
                    break;
           }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("METHOD POST");
        HttpSession session=request.getSession();
        usuarios usuario=(usuarios)session.getAttribute("usuario");
        System.out.println(usuario.getUser());
        clienteDAO clientedao=new clienteDAO();
        String accion;
        accion=request.getParameter("accion");
        switch (accion){
            case "Registrar":
                cliente clientenuevo=new cliente();
                clientenuevo.setId(clientedao.Id_Cliente());
                clientenuevo.setDNI(String.valueOf(request.getParameter("DNI")));
                clientenuevo.setApellidos(String.valueOf(request.getParameter("apellidos")));
                clientenuevo.setNombres(String.valueOf(request.getParameter("nombres")));
                clientenuevo.setDireccion(String.valueOf(request.getParameter("direccion")));
                clientenuevo.setMovil(String.valueOf(request.getParameter("movil")));
                clientenuevo.setTelefono(String.valueOf(request.getParameter("telefono")));
                System.out.println(clientenuevo.getId()+""+clientenuevo.getApellidos());
                clientedao.Registrar(clientenuevo);
                List<cliente> clientesListado;
                clientesListado=clientedao.ListarClientes();
                System.out.println("dddddddddddddddddddddddddddddddddddddddd");
                request.setAttribute("clientesListado", clientesListado);
                request.setAttribute("usuario", usuario);
                request.getRequestDispatcher("listarClientes.jsp").forward(request, response);
                break;
            case "Eliminar":
                cliente clientenuevo2=new cliente();
                clientenuevo2.setId(String.valueOf(request.getParameter("Id")));
                clientedao.Eliminar(clientenuevo2.getId());
                List<cliente> clientesListado2;
                clientesListado2=clientedao.ListarClientes();
                request.setAttribute("clientesListado", clientesListado2);
                request.setAttribute("usuario", usuario);
                request.getRequestDispatcher("listarClientes.jsp").forward(request, response);
                break;
            case "Actualizar":
                cliente clientenuevo3=new cliente();
                clientenuevo3.setId(String.valueOf(request.getParameter("clienteId")));
                clientenuevo3.setDNI(String.valueOf(request.getParameter("clienteDNI")));
                clientenuevo3.setApellidos(String.valueOf(request.getParameter("clienteApellidos")));
                clientenuevo3.setNombres(String.valueOf(request.getParameter("clienteNombres")));
                clientenuevo3.setDireccion(String.valueOf(request.getParameter("clienteDireccion")));
                clientenuevo3.setMovil(String.valueOf(request.getParameter("clienteMovil")));
                clientenuevo3.setTelefono(String.valueOf(request.getParameter("clienteTelefono")));
                clientedao.Actualizar(clientenuevo3);
                List<cliente> clientesListado3;
                clientesListado3=clientedao.ListarClientes();
                request.setAttribute("clientesListado", clientesListado3);
                request.setAttribute("usuario", usuario);
                request.getRequestDispatcher("listarClientes.jsp").forward(request, response);
                break;
        } 
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
}
