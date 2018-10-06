package net.piesfelices.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import net.piesfelices.bean.LoginBean;
import net.piesfelices.util.DBConnection;

public class LoginDao {
    public String authenticateUser( LoginBean loginBean) {
        String usuario = loginBean.getUsuario();
        String password = loginBean.getPassword();

        Connection con = null;
        Statement stm = null;
        ResultSet rs = null;

        String userNameDB = "";
        String passwordDB = "";

        try {
            con = DBConnection.createConnection();
            stm = con.createStatement();
            rs = stm.executeQuery("select usuario, password from usuarios");

            while (rs.next()){
                userNameDB = rs.getString("usuario");
                passwordDB = rs.getString("password");

                if ( usuario.equals(userNameDB) && password.equals(passwordDB)) {
                    return "SUCCESS";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Datos para ingreso invalidos.";
    }
}
