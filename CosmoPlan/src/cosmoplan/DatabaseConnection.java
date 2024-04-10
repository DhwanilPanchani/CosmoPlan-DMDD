/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cosmoplan;
import java.sql.Connection;
import java.sql.DriverManager;
/**
 *
 * @author dhwanilpanchani
 */

public class DatabaseConnection {
    public static Connection getConnection() {
        try {
            // Load the JDBC driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // Set up the connection parameters
            String dbURL = "jdbc:sqlserver://localhost:1433;databaseName=CosmoPlan;encrypt=true;trustServerCertificate=true;";
            // For SQL Server authentication, you can use:
            // String dbURL = "jdbc:sqlserver://localhost:1433;databaseName=CosmoPlan;user=yourUsername;password=yourPassword;";
            Connection con = DriverManager.getConnection(dbURL);
            return con;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
}

