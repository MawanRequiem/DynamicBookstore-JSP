package controller;

import db.db;
import java.sql.*;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CheckoutDAO {

    public Connection getConnection() {
        Connection connection = null;
        try {
            connection = new db().getConnection();
            return connection;
        } catch (SQLException ex) {
            Logger.getLogger(CheckoutDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return connection;
    }

    public boolean placeOrder(String username, String name, String email, String address, String city, String postalCode, double total_price, String paymentMethod, Map<String, Integer> selectedItemQuantities) throws SQLException {
        try (Connection connection = getConnection()) {
            if (connection == null) {
                return false;
            }
            
            // Insert order details
            String insertOrderQuery = "INSERT INTO orders (username, name, email, address, city, postal_code, payment_method, total_price) VALUES (?, ?, ?, ?, ?, ?, ?,?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS)) {
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, name);
                preparedStatement.setString(3, email);
                preparedStatement.setString(4, address);
                preparedStatement.setString(5, city);
                preparedStatement.setString(6, postalCode);
                preparedStatement.setString(7, paymentMethod);
                preparedStatement.setDouble(8, total_price);
                int affectedRows = preparedStatement.executeUpdate();
                if (affectedRows == 0) {
                    return false;
                }

                try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int orderId = generatedKeys.getInt(1);

                        // Insert order items
                        String insertOrderItemsQuery = "INSERT INTO ordersitems (order_id, book_name, kuantitas) VALUES (?, ?, ?)";
                        try (PreparedStatement orderItemsStatement = connection.prepareStatement(insertOrderItemsQuery)) {
                            for (Map.Entry<String, Integer> entry : selectedItemQuantities.entrySet()) {
                                orderItemsStatement.setInt(1, orderId);
                                orderItemsStatement.setString(2, entry.getKey());
                                orderItemsStatement.setInt(3, entry.getValue());
                                orderItemsStatement.addBatch();
                            }

                            int[] batchResult = orderItemsStatement.executeBatch();
                            for (int result : batchResult) {
                                if (result == Statement.EXECUTE_FAILED) {
                                    return false;
                                }
                            }

                            // Reduce stock for each book
                            String updateStockQuery = "UPDATE buku SET stock_buku = stock_buku - ? WHERE nama_buku = ?";
                            try (PreparedStatement updateStockStatement = connection.prepareStatement(updateStockQuery)) {
                                for (Map.Entry<String, Integer> entry : selectedItemQuantities.entrySet()) {
                                    updateStockStatement.setInt(1, entry.getValue());
                                    updateStockStatement.setString(2, entry.getKey());
                                    int rowsUpdated = updateStockStatement.executeUpdate();
                                    if (rowsUpdated == 0) {
                                        return false; // Stock update failed
                                    }
                                }
                            }
                        }
                    } else {
                        return false;
                    }
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(CheckoutDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
        return true;
    }
}
