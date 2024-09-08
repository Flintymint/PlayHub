package Controller.DataBaseConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataBaseConnection {
	private static Connection con;
	// Method to establish a database connection
	public static Connection connection() throws ClassNotFoundException, SQLException {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");
        
        // Database connection details
        String url = "jdbc:mysql://localhost:3306/playzone";
        String user = "root";
        String pass = "";
        
        // Establish and return the connection
        return con = DriverManager.getConnection(url, user, pass);
    }
}
