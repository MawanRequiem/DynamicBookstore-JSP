package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import db.db;
import model.registerBeans;
import model.userBeans;

public class UserDAO {

    // Method to check if the email is already in use
    public boolean isEmailUsed(String email) {
        String sql = "SELECT 1 FROM user_db WHERE email = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
            return true; // Assume email is used in case of error to prevent duplicate entry
        }
    }

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

    // Method to get user by username
    public userBeans getUserByUsername(String username) {
        String sql = "SELECT * FROM user_db WHERE username = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                userBeans user = new userBeans();
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
        StringBuilder sqlBuilder = new StringBuilder("UPDATE user_db SET ");
        boolean first = true;

        if (user.getName() != null) {
            sqlBuilder.append("nama_user = ?");
            first = false;
        }
        if (user.getEmail() != null) {
            if (!first) sqlBuilder.append(", ");
            sqlBuilder.append("email = ?");
            first = false;
        }
        if (user.getPassword() != null) {
            if (!first) sqlBuilder.append(", ");
            sqlBuilder.append("password = ?");
            first = false;
        }
        if (user.getAddress() != null) {
            if (!first) sqlBuilder.append(", ");
            sqlBuilder.append("address = ?");
            first = false;
        }
        if (user.getCity() != null) {
            if (!first) sqlBuilder.append(", ");
            sqlBuilder.append("city = ?");
            first = false;
        }
        if (user.getPostCode() != null) {
            if (!first) sqlBuilder.append(", ");
            sqlBuilder.append("postal_code = ?");
        }

        sqlBuilder.append(" WHERE username = ?");

        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sqlBuilder.toString())) {
            int index = 1;

            if (user.getName() != null) {
                ps.setString(index++, user.getName());
            }
            if (user.getEmail() != null) {
                ps.setString(index++, user.getEmail());
            }
            if (user.getPassword() != null) {
                ps.setString(index++, user.getPassword());
            }
            if (user.getAddress() != null) {
                ps.setString(index++, user.getAddress());
            }
            if (user.getCity() != null) {
                ps.setString(index++, user.getCity());
            }
            if (user.getPostCode() != null) {
                ps.setString(index++, user.getPostCode());
            }
            ps.setString(index, user.getUsername());

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
