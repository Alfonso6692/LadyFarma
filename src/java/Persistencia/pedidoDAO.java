/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Persistencia;

import Entidades.cliente;
import Entidades.detallePedido;
import Entidades.pedido;
import conexion.conexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author User
 */
public class pedidoDAO {

    pedido pedido = new pedido();
    detallePedido detallePedido = new detallePedido();
    conexionBD cn = new conexionBD();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public String numero_boleta() {
        String sql = "SELECT Id_Pedido FROM t_pedido ORDER BY CAST(SUBSTRING(Id_Pedido, 2, LENGTH(Id_Pedido) - 1) AS UNSIGNED) DESC LIMIT 1;";
        String numero = "";
        try {
            con = cn.Connected();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                numero = rs.getString("Id_Pedido");
            }
            return newCod(numero);
        } catch (Exception e) {
            return null;
        }
    }

    public boolean RegistrarPedido(pedido pedido) {
        con = cn.Connected();
        clienteDAO clienteDAO = new clienteDAO();
        cliente cliente = clienteDAO.BuscarxDNI(pedido.getId_Cliente());
        System.out.println(pedido.getId_Pedido() + "," + cliente.getId() + "," + pedido.getFecha() + "," + pedido.getSubTotal() + "," + pedido.getIGV() + "," + pedido.getTotalVenta());
        try {
            String sentenciaregistrarpedido = "INSERT INTO t_pedido(Id_Pedido,Id_Cliente,Fecha,SubTotal,IGV,TotalVenta) values(?,?,?,?,?,?)";
            ps = con.prepareStatement(sentenciaregistrarpedido);
            ps.setString(1, pedido.getId_Pedido());
            ps.setString(2, cliente.getId());
            ps.setDate(3, pedido.getFecha());
            ps.setDouble(4, pedido.getSubTotal());
            ps.setDouble(5, pedido.getIGV());
            ps.setDouble(6, pedido.getTotalVenta());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println("ERROR en " + ex);
            return false;
        }
    }

    public boolean RegistrarDetallePedido(detallePedido detallepedido) {
        try {
            con = cn.Connected();
            String sentenciaregistrarpedido = "INSERT INTO t_detalle_pedido(Id_Pedido,Id_Prod,cantidad,precio,TotalDeta) values(?,?,?,?,?)";
            ps = con.prepareStatement(sentenciaregistrarpedido);
            ps.setString(1, detallepedido.getId_Pedido());
            ps.setString(2, detallepedido.getId_Prod());
            ps.setDouble(3, detallepedido.getCantidad());
            ps.setDouble(4, detallepedido.getPrecio());
            ps.setDouble(5, detallepedido.getTotalDeta());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println("ERROR en " + ex);
            return false;
        }
    }

    private String newCod(java.lang.String pCodigo) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        //com.service.util.WebServiceUtil port = service.getWebServiceUtilPort();
        int Numero;
        Numero = Integer.parseInt(pCodigo.substring(2));
        Numero = Numero + 1;
        pCodigo = String.valueOf(Numero);
        while (pCodigo.length() < 4) {
            pCodigo = '0' + pCodigo;
        }
        pCodigo = 'P' + pCodigo;
        return (pCodigo);
    }

    public ArrayList<pedido> Listarpedidos() {
        ArrayList<pedido> pedidos = new ArrayList<>();
        try {
            con = cn.Connected();
            ps = con.prepareStatement("Select * from t_pedido ORDER BY Id_Pedido ASC");
            rs = ps.executeQuery();
            if (!rs.next()) {
                return null;
            } else {
                do {
                    pedido pedido = new pedido();
                    pedido.setId_Pedido(rs.getString("Id_Pedido"));
                    pedido.setId_Cliente(rs.getString("Id_Cliente"));
                    pedido.setSubTotal(rs.getFloat("SubTotal"));
                    pedido.setTotalVenta(rs.getFloat("TotalVenta"));
                    pedidos.add(pedido);
                } while (rs.next());
                return pedidos;
            }

        } catch (Exception e) {
            return null;
        }
    }

    public boolean Eliminar(String Id_Pedido) {
        try {
            con = cn.Connected();
            ps = con.prepareStatement("DELETE FROM t_pedido WHERE Id_Pedido=?");
            ps.setString(1, Id_Pedido);
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            return false;
        }
    }

    public pedido Buscar(String Id_Pedido) {
        try {
            pedido pedidoBuscado = new pedido();
            con = cn.Connected();
            ps = con.prepareStatement("SELECT * FROM t_pedido WHERE Id_Pedido=?");
            ps.setString(1, Id_Pedido);
            rs = ps.executeQuery();
            while (rs.next()) {
                pedidoBuscado.setId_Pedido(rs.getString(1));
                pedidoBuscado.setSubTotal(rs.getFloat(3));
                pedidoBuscado.setTotalVenta(rs.getFloat(4));
            }
            return pedidoBuscado;
        } catch (Exception e) {
            return null;
        }
    }
}
