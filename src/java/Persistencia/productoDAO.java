/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Persistencia;

import Entidades.producto;
import conexion.conexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author User
 */
public class productoDAO {
    conexionBD cn=new conexionBD();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    String descripcion;
    int costo, precio, cantidad;     
    
    public ArrayList<producto> ListarProductos() {
        ArrayList<producto> productos = new ArrayList<>();
        try {
            con=cn.Connected();
            ps=con.prepareStatement("Select * from t_producto ORDER BY Id_Prod ASC");
            rs = ps.executeQuery();
            if (!rs.next()){
                return null;
            } else {
                do {
                    producto producto= new producto ();
                    producto.setId(rs.getString("Id_Prod"));
                    producto.setDescripcion(rs.getString("Descripcion"));
                    producto.setCosto(rs.getFloat("costo"));
                    producto.setPrecio(rs.getFloat("precio"));
                    producto.setCantidad(rs.getInt("cantidad"));
                    productos.add(producto);
                } while (rs.next());
                return productos;
            }
            
        } catch (Exception e) {
          e.printStackTrace();
        
        }
        return ListarProductos();
    }
    public boolean Eliminar(String Id_Prod){
        try {
            con=cn.Connected();
            ps=con.prepareStatement("DELETE FROM t_producto WHERE Id_Prod=?");
            ps.setString(1, Id_Prod);
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            return false;
        }
    }
    public producto BuscarxItem(String Id_Prod){
        try {
           producto ProductoBuscado=new producto();
            con=cn.Connected();
            ps=con.prepareStatement("SELECT * FROM t_producto WHERE Id_Prod=? AND cantidad>0");
            ps.setString(1, Id_Prod);
            rs=ps.executeQuery();
            while(rs.next()){
                System.out.println("ffffffffffffffffffffffffffffffffffffffffffffffff");
                ProductoBuscado.setId(rs.getString(1));
                ProductoBuscado.setDescripcion(rs.getString(2));
                ProductoBuscado.setCosto(rs.getFloat(3));
                ProductoBuscado.setPrecio(rs.getFloat(4));
                ProductoBuscado.setCantidad(rs.getInt(5));
            }
            return ProductoBuscado;
        } catch (Exception e) {
             System.out.println(e);
            return null;
        }
    }
    public producto BuscarxDescripcion(String Descripcion){
        try {
           producto ProductoBuscado=new producto();
            con=cn.Connected();
            ps=con.prepareStatement("SELECT * FROM t_producto WHERE Descripcion=? AND cantidad>0");
            ps.setString(1, Descripcion);
            rs=ps.executeQuery();
            while(rs.next()){
                ProductoBuscado.setId(rs.getString(1));
                ProductoBuscado.setDescripcion(rs.getString(2));
                ProductoBuscado.setCosto(rs.getFloat(3));
                ProductoBuscado.setPrecio(rs.getFloat(4));
                ProductoBuscado.setCantidad(rs.getInt(5));
            }
            return ProductoBuscado;
        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
    }
    /*
    public ArrayList<producto> BuscarxDescripcion(String Descripcion){
        ArrayList<producto> productos = new ArrayList<>();
        try {
           producto ProductoBuscado=new producto();
            con=cn.Connected();
            ps=con.prepareStatement("SELECT * FROM t_producto WHERE Descripcion=?");
            ps.setString(1, Descripcion);
            rs=ps.executeQuery();
            while(rs.next()){
                producto producto= new producto ();
                producto.setId(rs.getString("Id_Prod"));
                producto.setDescripcion(rs.getString("Descripcion"));
                producto.setCosto(rs.getFloat("costo"));
                producto.setPrecio(rs.getFloat("precio"));
                producto.setCantidad(rs.getInt("cantidad"));
                productos.add(producto);
            }
            return productos;
        } catch (Exception e) {
            return null;
        }
    }
    public ArrayList<producto> BuscarxId(String Id_Prod){
        ArrayList<producto> productos = new ArrayList<>();
        try {
           producto ProductoBuscado=new producto();
            con=cn.Connected();
            ps=con.prepareStatement("SELECT * FROM t_producto WHERE Id_Prod=?");
            ps.setString(1, Id_Prod);
            rs=ps.executeQuery();
            while(rs.next()){
                producto producto= new producto ();
                producto.setId(rs.getString("Id_Prod"));
                producto.setDescripcion(rs.getString("Descripcion"));
                producto.setCosto(rs.getFloat("costo"));
                producto.setPrecio(rs.getFloat("precio"));
                producto.setCantidad(rs.getInt("cantidad"));
                productos.add(producto);
            }
            return productos;
        } catch (Exception e) {
            return null;
        }
    }
*/
    public boolean Registrar(producto producto){
       try {
            con=cn.Connected();
            ps=con.prepareStatement("insert into t_producto(Id_Prod,Descripcion,costo,precio,cantidad) values(?, ?, ?, ?, ?)");
            ps.setString(1, producto.getId());
            ps.setString(2, producto.getDescripcion());
            ps.setFloat(3, producto.getCosto());
            ps.setFloat(4, producto.getPrecio());
            ps.setDouble(5, producto.getCantidad());
            ps.executeUpdate();
            System.out.println(ps.executeUpdate());
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
   }
   public boolean Actualizar(producto producto){
       try {
            con=cn.Connected();
            ps=con.prepareStatement("UPDATE t_producto SET Descripcion=?,Costo=?,Precio=?,Cantidad=? WHERE Id_Prod=?");
            ps.setString(5, producto.getId());
            ps.setString(1, producto.getDescripcion());
            ps.setFloat(2, producto.getCosto());
            ps.setFloat(3, producto.getPrecio());
            ps.setDouble(4, producto.getCantidad());
            ps.executeUpdate();
            System.out.println(ps.executeUpdate());
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
   }
   public boolean ActualizarCantidadProd(producto producto){
       try {
            producto producto_original=BuscarxItem(producto.getId());
            double cantidad_original= producto_original.getCantidad();
            double cantidad_actualizada=cantidad_original-producto.getCantidad();
            con=cn.Connected();
            ps=con.prepareStatement("UPDATE t_producto SET Cantidad=? WHERE Id_Prod=?");
            ps.setString(2, producto.getId());
            ps.setDouble(1, cantidad_actualizada);
            ps.executeUpdate();
            System.out.println(ps.executeUpdate());
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
   }
   public String Id_Prod(){
        try {
            String Id_Prod="";
            con=cn.Connected();
            ps=con.prepareStatement("select max(Id_Prod) AS Id_Prod from t_producto");
            rs = ps.executeQuery();
            if (!rs.next()) {
                return null;
            } else {
                do {
                    Id_Prod=rs.getString("Id_Prod");
                } while (rs.next());
                Id_Prod=newCod(Id_Prod);
                System.out.println(Id_Prod);
                return Id_Prod;
            }

        } catch (Exception e) {
            return null;
        }
   }
   private String newCod(java.lang.String pCodigo) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        //com.service.util.WebServiceUtil port = service.getWebServiceUtilPort();
        int Numero;
        Numero=Integer.parseInt(pCodigo.substring(2));
        Numero=Numero+1;
        pCodigo=String.valueOf(Numero);
        while (pCodigo.length()<5){
            pCodigo='0'+ pCodigo;
        }
        pCodigo='P'+pCodigo;        
        return (pCodigo);
    }
}
