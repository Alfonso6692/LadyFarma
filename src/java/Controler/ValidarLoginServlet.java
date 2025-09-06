/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controler;

import Entidades.usuarios;
import conexion.conexionBD;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */

@WebServlet(name = "ValidarLogin", urlPatterns = {"/ValidarLogin"})
public class ValidarLoginServlet extends HttpServlet {

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
        processRequest(request, response);
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
            String accion=request.getParameter("accion");
             switch(accion){
                 case "Ingresar":
                    String vUsuario = request.getParameter("txtUsuario");
                    String vClave = request.getParameter("txtClave");
                    usuarios usuario=new usuarios(vUsuario,vClave);
                    String vPaswd="";
                    String vUser="";
                    String vCargo="";
                    conexionBD conBD = new conexionBD();
                    Connection conn = conBD.Connected();
                    PreparedStatement ps;
                    ResultSet rs; 
                    try{
                            String sql="select * from t_usuario where IdUsuario=? and Passwd=?";
                            ps= conn.prepareStatement(sql);
                            ps.setString(1, usuario.getUser());
                            ps.setString(2, usuario.getPass());
                            rs= ps.executeQuery();
                            while(rs.next()){
                                vUser = rs.getString(1);
                                vPaswd= rs.getString(2);
                                vCargo=rs.getString(3);
                            }
                            if(vUser.equals( usuario.getUser()) && vPaswd.equals(usuario.getPass())){
                                usuario.setCargo(vCargo);
                                HttpSession sesion=request.getSession();
                                sesion.setAttribute("usuario", usuario);
                                conBD.Discconet();
                                response.sendRedirect("index.jsp");
                                
                            }else{
                                response.sendRedirect("login.jsp");
                            }
        
                        }catch(SQLException ex){
                            System.out.println("Error de SQL..."+ex.getMessage());
                        } 
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
