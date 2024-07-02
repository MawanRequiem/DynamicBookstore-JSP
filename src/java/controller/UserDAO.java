package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import db.db;
import model.registerBeans;

public class UserDAO {
    public boolean registerUser(registerBeans user) {
        String sql = "INSERT INTO user_db (nama_user, username, password, email) VALUES (?, ?, ?, ?)";
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getEmail());
            int result = ps.executeUpdate(); // Use executeUpdate for INSERT statements
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
            return false;
        }
    }
}
