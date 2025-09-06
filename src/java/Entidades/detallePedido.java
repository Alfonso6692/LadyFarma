/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidades;

/**
 *
 * @author User
 */
public class detallePedido {
    private String Id_Pedido;
    private String Id_Prod;
    private String Descripcion;
    private double Cantidad;
    private double Precio;
    private double TotalDeta;

    public detallePedido() {
        this.Id_Pedido="";
        this.Id_Prod="";
        this.Descripcion="";
        this.Cantidad=0;
        this.Precio=0;
        this.TotalDeta=0;
    }

    public String getId_Pedido() {
        return Id_Pedido;
    }

    public void setId_Pedido(String Id_Pedido) {
        this.Id_Pedido = Id_Pedido;
    }

    public String getId_Prod() {
        return Id_Prod;
    }

    public void setId_Prod(String Id_Prod) {
        this.Id_Prod = Id_Prod;
    }

    public String getDescripcion() {
        return Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }

    public double getCantidad() {
        return Cantidad;
    }

    public void setCantidad(double Cantidad) {
        this.Cantidad = Cantidad;
    }

    public double getPrecio() {
        return Precio;
    }

    public void setPrecio(double Precio) {
        this.Precio = Precio;
    }

    public double getTotalDeta() {
        return TotalDeta;
    }

    public void setTotalDeta(double TotalDeta) {
        this.TotalDeta = TotalDeta;
    }
}
