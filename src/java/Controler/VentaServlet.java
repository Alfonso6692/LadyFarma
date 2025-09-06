/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controler;

import Entidades.detallePedido;
import Entidades.pedido;
import Entidades.producto;
import Entidades.usuarios;
import Persistencia.clienteDAO;
import Persistencia.pedidoDAO;
import Persistencia.productoDAO;
import com.google.gson.Gson;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import conexion.conexionBD;
import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author User
 */
public class VentaServlet extends HttpServlet {

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
        pedidoDAO pedidoDAO = new pedidoDAO();
        productoDAO productodao = new productoDAO();
        HttpSession session = request.getSession();
        usuarios usuariosesion = (usuarios) session.getAttribute("usuario");
        System.out.println(usuariosesion.getUser());
        String accion = "";
        String boleta = pedidoDAO.numero_boleta();
        accion = request.getParameter("Opcion");
        switch (accion) {
            case "Nuevo":
                request.setAttribute("numerodeboleta", boleta);
                request.setAttribute("usuario", usuariosesion);
                List<producto> productosListado;
                productosListado = productodao.ListarProductos();
                request.setAttribute("productosListado", productosListado);
                request.getRequestDispatcher("registrarVenta.jsp").forward(request, response);
                break;
            case "Listar":
                HttpSession sessions = request.getSession();
                usuarios usuariosesions = (usuarios) sessions.getAttribute("usuario");
                request.setAttribute("usuario", usuariosesions);
                List<pedido> pedidoListado = pedidoDAO.Listarpedidos();
                request.setAttribute("Listarpedidos", pedidoListado);
                request.getRequestDispatcher("listarPedido.jsp").forward(request, response);
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
        String accion = request.getParameter("accion");
        if ("registrar_Venta".equals(accion)) {
            // Leer el cuerpo de la solicitud
            StringBuilder jsonBuffer = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }

            // Convertir a JSONObject
            JSONObject jsonData = new JSONObject(jsonBuffer.toString());
            pedidoDAO pedidodao = new pedidoDAO();
            // Extraer los datos del JSON
            String dni = jsonData.getString("dni");
            String fechaString = jsonData.getString("fecha");
            String[] partesFecha = fechaString.split("-");
            int anio = 0;
            int mes = 0;
            int dia = 0;
            if (partesFecha.length == 3) {
                anio = Integer.parseInt(partesFecha[0]); // Año
                mes = Integer.parseInt(partesFecha[1]);   // Mes
                dia = Integer.parseInt(partesFecha[2]);   // Día
                // Imprimir los resultados
                System.out.println("Año: " + anio);
                System.out.println("Mes: " + mes);
                System.out.println("Día: " + dia);
            } else {
                System.out.println("La cadena no tiene el formato correcto.");
            }
            Date fecha = new Date(anio - 1900, mes - 1, dia);
            System.out.println(fecha);
            /*try {
                fecha = (Date) formato.parse(fechaString);
            } catch (ParseException ex) {
                Logger.getLogger(VentaServlet.class.getName()).log(Level.SEVERE, null, ex);
            }*/
            String numeroBoleta = jsonData.getString("numeroBoleta");
            String subtotalPedido = jsonData.getString("subtotalPedido");
            String igvPedido = jsonData.getString("igvPedido");
            String totalPedido = jsonData.getString("totalPedido");
            double subtotalPedidoparseado = Double.parseDouble(subtotalPedido);
            double igvPedidosubtotalPedidoparseado = Double.parseDouble(igvPedido);
            double totalPedidoparseado = Double.parseDouble(totalPedido);
            System.out.println(numeroBoleta + "," + subtotalPedidoparseado + "," + igvPedidosubtotalPedidoparseado + "," + totalPedidoparseado);
            pedido pedido = new pedido();
            pedido.setId_Pedido(numeroBoleta);
            pedido.setId_Cliente(dni);
            pedido.setFecha(fecha);
            System.out.println(pedido.getFecha());
            pedido.setSubTotal(subtotalPedidoparseado);
            pedido.setIGV(igvPedidosubtotalPedidoparseado);
            pedido.setTotalVenta(totalPedidoparseado);
            pedidodao.RegistrarPedido(pedido);
            JSONArray detallesArray = jsonData.getJSONArray("datosTabla");
            for (int i = 0; i < detallesArray.length(); i++) {
                detallePedido detallePedido = new detallePedido();              
                JSONObject detalle = detallesArray.getJSONObject(i);
                String producto = detalle.getString("producto");
                double precio = detalle.getDouble("precio");
                double cantidad = detalle.getDouble("cantidad");
                double subtotal = detalle.getDouble("subtotal");
                producto productodesc =new producto();
                productodesc.setId(producto);
                productodesc.setCantidad(cantidad);
                productoDAO productodaos=new productoDAO();
                detallePedido.setId_Pedido(numeroBoleta);
                detallePedido.setId_Prod(producto);
                detallePedido.setPrecio(precio);
                detallePedido.setCantidad(cantidad);
                detallePedido.setTotalDeta(subtotal);
                pedidodao.RegistrarDetallePedido(detallePedido);
                productodaos.ActualizarCantidadProd(productodesc);
            }
            System.out.println(dni + "," + fechaString + "," + numeroBoleta + "," + subtotalPedido + "," + igvPedido + "," + totalPedido);
            Document documento = new Document();
            try {
                PreparedStatement ps;
                ResultSet rs;
                conexionBD cn = new conexionBD();
                Connection con;
                con = cn.Connected();
                String ruta = System.getProperty("user.home");
                PdfWriter.getInstance(documento, new FileOutputStream(ruta + "/ReporteOrdenVenta" + numeroBoleta + ".pdf"));
                documento.open();
                Image img = Image.getInstance("C:\\Users\\User\\Documentos\\NetBeansProjects\\SistemaWebLadyFarma\\web\\imagen\\Logo.png");
                PdfPTable Logo = new PdfPTable(1);
                float[] ColumnaEncabezadoImg = new float[]{50f};
                Logo.setWidths(ColumnaEncabezadoImg);
                Logo.setWidthPercentage(100);
                Logo.getDefaultCell().setBorder(0);
                Logo.addCell(img);
                documento.add(Logo);
                Paragraph parrafo = new Paragraph();
                Font negrita = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);
                PdfPTable Encabezado = new PdfPTable(2);
                //Encabezado.setWidthPercentage(100);
                //Encabezado.getDefaultCell().setBorder(0);
                float[] ColumnaEncabezado = new float[]{50f, 50f};
                ps = con.prepareStatement("SELECT p.Id_Pedido,c.DNI,c.Nombres,c.Apellidos,c.Direccion,c.Movil,c.Telefono FROM t_cliente c INNER JOIN t_pedido p on(p.Id_Cliente=c.Id_Cliente) WHERE p.Id_Pedido=?");
                ps.setString(1, numeroBoleta);
                rs = ps.executeQuery();
                String DNI="";
                String Nombres="";
                String Apellidos="";
                String Direccion="";
                String Movil="";
                String Telefono="";
                while (rs.next()) {
                    DNI = rs.getString("DNI");
                    Nombres = rs.getString("Nombres");
                    Apellidos = rs.getString("Apellidos");
                    Direccion = rs.getString("Direccion");
                    Movil = rs.getString("Movil");
                    Telefono = rs.getString("Telefono");
                }
                System.out.println("correcto");
                parrafo.add("Fecha de emisión: " + fecha);
                parrafo.add("\n\n");
                documento.add(parrafo);
                Encabezado.setWidths(ColumnaEncabezado);
                Encabezado.setWidthPercentage(100);
                Encabezado.getDefaultCell().setBorder(0);
                //Encabezado.addCell(img);
                Encabezado.addCell("Datos de la empresa");
                //Encabezado.addCell("RUC: 23343221121"  + "\nNombre de la Empresa: LADYFARMA"+ "\nTeléfono: 2432312");
                Encabezado.addCell("Datos del Cliente");
                //Encabezado.addCell("RUC: "  +RUC+"\nNombre de la Empresa: "+nombrelab+ "\nTeléfono: "+telefono+"\nDirección: "+direccion);
                //Encabezado.addCell(parrafo);
                documento.add(Encabezado);
                PdfPTable Encabezado2 = new PdfPTable(2);
                float[] ColumnaEncabezado2 = new float[]{50f, 50f};
                Encabezado2.setWidths(ColumnaEncabezado2);
                Encabezado2.setWidthPercentage(100);
                Encabezado2.getDefaultCell().setBorder(0);
                Encabezado2.addCell("RUC: 23343221121" + "\nNombre de la Empresa: LADYFARMA" + "\nTeléfono: 2432312");
                Encabezado2.addCell("DNI: " + DNI + "\nNombre: " + Nombres + "\nApellidos: " + Apellidos + "\nDireccion: " + Direccion + "\nMovil: " + Movil + "\nTelefono: " + Telefono);
                documento.add(Encabezado2);
                Paragraph parrafo2 = new Paragraph();
                parrafo2.add("\n\n");
                parrafo2.add("Lista de Productos Comprados");
                parrafo2.add("\n\n");
                documento.add(parrafo2);
                PdfPTable tabla = new PdfPTable(5);
                System.out.println("correcto");
                tabla.addCell("Id_Prod");
                tabla.addCell("Descripcion");
                tabla.addCell("cantidad");
                tabla.addCell("precio");
                tabla.addCell("Subtotal");
                ps = con.prepareStatement("SELECT p.Id_Prod,p.Descripcion,d.cantidad,d.precio,d.TotalDeta"
                        + " FROM t_producto p INNER JOIN t_detalle_pedido d on (d.Id_Prod=p.Id_Prod)  WHERE d.Id_Pedido=?");
                ps.setString(1, numeroBoleta);
                rs = ps.executeQuery();
                while (rs.next()) {
                    tabla.addCell(rs.getString("Id_Prod"));
                    tabla.addCell(rs.getString("Descripcion"));
                    tabla.addCell(rs.getString("cantidad"));
                    tabla.addCell(rs.getString("precio"));
                    tabla.addCell(rs.getString("TotalDeta"));
                }
                documento.add(tabla);
               
                Paragraph parrafo4 = new Paragraph();
                parrafo4.add("\n\n");
                parrafo4.add("Subtotal: S/" + subtotalPedido);
                parrafo4.add("\n\n");
                documento.add(parrafo4);
                Paragraph parrafo5 = new Paragraph();
                parrafo5.add("\n\n");
                parrafo5.add("IGV(18%): S/" + igvPedido);
                parrafo5.add("\n\n");
                documento.add(parrafo5);
                Paragraph parrafo6 = new Paragraph();
                parrafo6.add("\n\n");
                parrafo6.add("Total: S/" + totalPedido);
                parrafo6.add("\n\n");
                documento.add(parrafo6);
                documento.close();
            } catch (Exception z) {
                System.out.println(z);
            }
            ProcessBuilder p = new ProcessBuilder();
            System.out.println(numeroBoleta+"es es mi numero de boleta");
            p.command("C:\\Program Files\\Adobe\\Acrobat DC\\Acrobat\\Acrobat.exe", "C:\\Users\\User\\ReporteOrdenVenta"+numeroBoleta+".pdf");
            System.out.println(p.command());
            try {
                p.start();
                HttpSession session = request.getSession();
                usuarios usuariosesion = (usuarios) session.getAttribute("usuario");
                request.setAttribute("usuario", usuariosesion);
                List<pedido> pedidoListado = pedidodao.Listarpedidos();
                request.setAttribute("Listarpedidos", pedidoListado);
                request.getRequestDispatcher("listarPedido.jsp").forward(request, response);
            } catch (IOException ex) {
                System.out.println("");
                //Logger.getLogger(Factura.class.getName()).log(Level.SEVERE, null, ex);
            }
            //request.getRequestDispatcher("RegistrarVenta.jsp").forward(request, response);
        }
    }
}
/**
 * Returns a short description of the servlet.
 *
 * @return a String containing servlet description
 */
