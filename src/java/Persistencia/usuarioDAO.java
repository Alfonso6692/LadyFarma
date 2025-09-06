/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Persistencia;

import Entidades.usuarios;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import conexion.conexionBD;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * DAO para la gestión de usuarios en la base de datos.
 */
public class usuarioDAO {
    private static final Logger LOGGER = Logger.getLogger(usuarioDAO.class.getName());
    private final conexionBD cn = new conexionBD();

    public usuarios validar(String usuario, String contraseña) {
        String sql = "SELECT * FROM t_usuario WHERE IdUsuario = ? AND Passwd = ?";
        try (Connection con = cn.Connected();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, usuario);
            ps.setString(2, contraseña);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuarios user = new usuarios(usuario, contraseña);
                    user.setCargo(rs.getString("cargo"));
                    return user; // Usuario válido, retornamos el objeto con datos completos
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error al validar usuario", e);
        }
        return null; // Si las credenciales no son correctas, devolvemos null
    }
}