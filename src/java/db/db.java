package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class db {
    private Connection connection = null;

    public Connection setConnection() throws SQLException {
        try {
            String url = "jdbc:mysql://localhost:3306/tereliyebook";
            String username = "root";
            String password = ""; // Ganti dengan password yang benar jika ada
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);
            System.out.println("Connection established");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found");
            throw new SQLException("MySQL JDBC Driver not found", e);
        } catch (SQLException e) {
            System.err.println("Failed to establish connection");
            throw e; // Melempar kembali SQLException agar dapat ditangani oleh servlet
        }
        return connection;
    }

    public Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                connection = setConnection();
            } catch (SQLException e) {
                System.err.println("Failed to reconnect");
                throw e; // Melempar kembali SQLException agar dapat ditangani oleh servlet
            }
        }
        return connection;
    }
}
