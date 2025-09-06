/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Persistencia;

import Entidades.cliente;
import conexion.conexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author User
 */
public class clienteDAO {
    conexionBD cn=new conexionBD();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    String  nombre, apellidos, correo, direccion;
    int dni, celular;
    
    public ArrayList<cliente> ListarClientes() {
        ArrayList<cliente> clientes = new ArrayList<>();
        try {
            con=cn.Connected();
            ps=con.prepareStatement("Select * from t_cliente where Estado=1 ORDER BY Id_Cliente ASC");
            rs = ps.executeQuery();
            if (!rs.next()) {
                return null;
            } else {
                do {
                    cliente cliente=new cliente();
                    cliente.setId(rs.getString("Id_Cliente"));
                    cliente.setDNI(rs.getString("DNI"));
                    cliente.setNombres(rs.getString("Nombres"));
                    cliente.setApellidos(rs.getString("Apellidos"));
                    cliente.setMovil(rs.getString("Movil"));
                    cliente.setDireccion(rs.getString("Direccion"));
                    cliente.setTelefono(rs.getString("Telefono"));
                    clientes.add(cliente);
                } while (rs.next());
                return clientes;
            }

        } catch (Exception e) {
            return null;
        }
    }
   public boolean Eliminar(String Id_Cliente){
       try {
            con=cn.Connected();
            ps=con.prepareStatement("UPDATE t_cliente SET Estado=0 WHERE Id_Cliente=?");
            ps.setString(1, Id_Cliente);
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            return false;
        }
   }
   public cliente Buscar(String Id_Cliente){
       try {
           cliente ClienteBuscado=new cliente();
            con=cn.Connected();
            ps=con.prepareStatement("SELECT * FROM t_cliente WHERE Id_cliente=?");
            ps.setString(1, Id_Cliente);
            rs=ps.executeQuery();
            while(rs.next()){
                ClienteBuscado.setId(rs.getString(1));
                ClienteBuscado.setDNI(rs.getString(5));
                ClienteBuscado.setNombres(rs.getString(3));
                ClienteBuscado.setApellidos(rs.getString(2));
                ClienteBuscado.setMovil(rs.getString(7));
                ClienteBuscado.setDireccion(rs.getString(4));
                ClienteBuscado.setTelefono(rs.getString(6));
            }
            return ClienteBuscado;
        } catch (Exception e) {
            return null;
        }
   }
   public cliente BuscarxDNI(String DNI){
       try {
           cliente ClienteBuscado=new cliente();
            con=cn.Connected();
            ps=con.prepareStatement("SELECT * FROM t_cliente WHERE DNI=?");
            ps.setString(1, DNI);
            rs=ps.executeQuery();
            while(rs.next()){
                ClienteBuscado.setId(rs.getString(1));
                ClienteBuscado.setDNI(rs.getString(5));
                ClienteBuscado.setNombres(rs.getString(3));
                ClienteBuscado.setApellidos(rs.getString(2));
                ClienteBuscado.setMovil(rs.getString(7));
                ClienteBuscado.setDireccion(rs.getString(4));
                ClienteBuscado.setTelefono(rs.getString(6));
            }
            return ClienteBuscado;
        } catch (Exception e) {
            return null;
        }
   }
   public boolean Registrar(cliente cliente){
       try {
            con=cn.Connected();
            ps=con.prepareStatement("insert into t_cliente(Id_Cliente,Apellidos,Nombres,Direccion,DNI,Telefono,Movil) values(?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, cliente.getId());
            ps.setString(2, cliente.getApellidos());
            ps.setString(3, cliente.getNombres());
            ps.setString(4, cliente.getDireccion());
            ps.setString(5, cliente.getDNI());
            ps.setString(6, cliente.getTelefono());
            ps.setString(7, cliente.getMovil());
            ps.executeUpdate();
            System.out.println(ps.executeUpdate());
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
   }
   public boolean Actualizar(cliente cliente){
       try {
            con=cn.Connected();
            ps=con.prepareStatement("UPDATE t_cliente SET Apellidos=?,Nombres=?,Direccion=?,DNI=?,Telefono=?,Movil=? WHERE Id_Cliente=?");
            ps.setString(7, cliente.getId());
            ps.setString(1, cliente.getApellidos());
            ps.setString(2, cliente.getNombres());
            ps.setString(3, cliente.getDireccion());
            ps.setString(4, cliente.getDNI());
            ps.setString(5, cliente.getTelefono());
            ps.setString(6, cliente.getMovil());
            ps.executeUpdate();
            System.out.println(ps.executeUpdate());
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
   }
   public String Id_Cliente(){
        try {
            String Id_Cliente="";
            con=cn.Connected();
            ps=con.prepareStatement("select max(Id_Cliente) AS Id_Cliente from t_cliente");
            rs = ps.executeQuery();
            if (!rs.next()) {
                return null;
            } else {
                do {
                    Id_Cliente=rs.getString("Id_Cliente");
                } while (rs.next());
                Id_Cliente=newCod(Id_Cliente);
                System.out.println(Id_Cliente);
                return Id_Cliente;
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
        pCodigo='C'+pCodigo;        
        return (pCodigo);
    }
}
