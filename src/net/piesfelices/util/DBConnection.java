package net.piesfelices.util;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection createConnection() {
        Connection con = null;
        String url = "jdbc.mysql://piesfelices.net:3306/piesfeli_control";
        String dbUser = "piesfelices_control";
        String dbPassword = "3$TR4t0s1985";

        try {
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            con = DriverManager.getConnection(url,dbUser,dbPassword);
            System.out.println("Creando la conexión " + con);
        } catch (Exception e ) {
            e.printStackTrace();
        }
        return con;
    }
}
