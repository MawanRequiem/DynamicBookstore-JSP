package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import db.db;
import model.registerBeans;
import model.userBeans;

public class UserDAO {

    // Updated registerUser method to return status strings
    public String registerUser(registerBeans user) {
        if (isEmailUsed(user.getEmail())) {
            return "emailUsed";
        }

        String sql = "INSERT INTO user_db (nama_user, username, password, email) VALUES (?, ?, ?, ?)";
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getEmail());
            int result = ps.executeUpdate();
            return result > 0 ? "success" : "failure";
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
            return "failure";
        }
    }

    // Method to check if the email is already in use
    public boolean isEmailUsed(String email) {
        String sql = "SELECT COUNT(*) FROM user_db WHERE email = ?";
        
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
        }
        return false;
    }

    // Method to get user by username
    public userBeans getUserByUsername(String username) {
        String sql = "SELECT u.*, a.address, a.city, a.postal_code " +
                     "FROM user_db u " +
                     "LEFT JOIN user_address a ON u.id_user = a.user_id " +
                     "WHERE u.username = ?";
        
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                userBeans user = new userBeans();
                user.setId(rs.getInt("id_user"));
                user.setName(rs.getString("nama_user"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setAddress(rs.getString("address"));
                user.setCity(rs.getString("city"));
                user.setPostCode(rs.getString("postal_code"));
                
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
        }
        return null;
    }

    // Method to update user details
    public boolean updateUser(userBeans user) {
        String userSql = "UPDATE user_db SET nama_user = ?, email = ?, password = ? WHERE id_user = ?";
        String addressCheckSql = "SELECT COUNT(*) FROM user_address WHERE user_id = ?";
        String addressUpdateSql = "UPDATE user_address SET address = ?, city = ?, postal_code = ? WHERE user_id = ?";
        String addressInsertSql = "INSERT INTO user_address (user_id, address, city, postal_code) VALUES (?, ?, ?, ?)";

        try (Connection conn = new db().getConnection()) {
            conn.setAutoCommit(false);

            // Update user_db
            try (PreparedStatement userPs = conn.prepareStatement(userSql)) {
                userPs.setString(1, user.getName());
                userPs.setString(2, user.getEmail());
                userPs.setString(3, user.getPassword());
                userPs.setInt(4, user.getId());
                userPs.executeUpdate();
            }

            // Check if address entry exists
            boolean addressExists;
            try (PreparedStatement addressCheckPs = conn.prepareStatement(addressCheckSql)) {
                addressCheckPs.setInt(1, user.getId());
                ResultSet rs = addressCheckPs.executeQuery();
                addressExists = rs.next() && rs.getInt(1) > 0;
            }

            // Update or insert address
            if (addressExists) {
                try (PreparedStatement addressPs = conn.prepareStatement(addressUpdateSql)) {
                    addressPs.setString(1, user.getAddress());
                    addressPs.setString(2, user.getCity());
                    addressPs.setString(3, user.getPostCode());
                    addressPs.setInt(4, user.getId());
                    addressPs.executeUpdate();
                }
            } else {
                try (PreparedStatement addressPs = conn.prepareStatement(addressInsertSql)) {
                    addressPs.setInt(1, user.getId());
                    addressPs.setString(2, user.getAddress());
                    addressPs.setString(3, user.getCity());
                    addressPs.setString(4, user.getPostCode());
                    addressPs.executeUpdate();
                }
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
            return false;
        }
    }

    // Method to delete user by username
    public boolean deleteUser(String username) {
        String sql = "DELETE FROM user_db WHERE username = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            int result = ps.executeUpdate();
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
