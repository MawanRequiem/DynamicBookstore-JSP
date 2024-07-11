package controller;

import db.db;
import java.sql.*;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Random;

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

    private String generateRandomKodePembayaran() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        StringBuilder kodePembayaran = new StringBuilder(10);
        for (int i = 0; i < 10; i++) {
            kodePembayaran.append(characters.charAt(random.nextInt(characters.length())));
        }
        return kodePembayaran.toString();
    }

    public boolean placeOrder(String username, String name, String email, String address, String city, String postalCode, double total_price, String paymentMethod, Map<String, Integer> selectedItemQuantities, Timestamp expiryTime) throws SQLException {
        try (Connection connection = getConnection()) {
            if (connection == null) {
                return false;
            }

            connection.setAutoCommit(false); // Start transaction

            // Insert order details
            String insertOrderQuery = "INSERT INTO orders (username, name, email, address, city, postal_code, payment_method, total_price, status, kodepembayaran, expiry_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            String kodePembayaran = generateRandomKodePembayaran();
            String status = "belum_bayar";
            try (PreparedStatement preparedStatement = connection.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS)) {
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, name);
                preparedStatement.setString(3, email);
                preparedStatement.setString(4, address);
                preparedStatement.setString(5, city);
                preparedStatement.setString(6, postalCode);
                preparedStatement.setString(7, paymentMethod);
                preparedStatement.setDouble(8, total_price);
                preparedStatement.setString(9, status);
                preparedStatement.setString(10, kodePembayaran);
                preparedStatement.setTimestamp(11, expiryTime);
                int affectedRows = preparedStatement.executeUpdate();
                if (affectedRows == 0) {
                    connection.rollback();
                    return false;
                }

                try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int orderId = generatedKeys.getInt(1);

                        // Insert order items and reduce stock
                        String insertOrderItemsQuery = "INSERT INTO ordersitems (order_id, book_name, kuantitas) VALUES (?, ?, ?)";
                        String updateStockQuery = "UPDATE buku SET stock_buku = stock_buku - ? WHERE nama_buku = ?";
                        try (PreparedStatement orderItemsStatement = connection.prepareStatement(insertOrderItemsQuery);
                             PreparedStatement updateStockStatement = connection.prepareStatement(updateStockQuery)) {
                            for (Map.Entry<String, Integer> entry : selectedItemQuantities.entrySet()) {
                                String bookName = entry.getKey();
                                int quantity = entry.getValue();

                                // Insert order item
                                orderItemsStatement.setInt(1, orderId);
                                orderItemsStatement.setString(2, bookName);
                                orderItemsStatement.setInt(3, quantity);
                                orderItemsStatement.addBatch();

                                // Reduce stock
                                updateStockStatement.setInt(1, quantity);
                                updateStockStatement.setString(2, bookName);
                                updateStockStatement.addBatch();
                            }

                            int[] batchResult = orderItemsStatement.executeBatch();
                            int[] stockUpdateResult = updateStockStatement.executeBatch();
                            for (int result : batchResult) {
                                if (result == Statement.EXECUTE_FAILED) {
                                    connection.rollback();
                                    return false;
                                }
                            }
                            for (int result : stockUpdateResult) {
                                if (result == Statement.EXECUTE_FAILED) {
                                    connection.rollback();
                                    return false; // Stock update failed
                                }
                            }
                        }
                    } else {
                        connection.rollback();
                        return false;
                    }
                }
            }
            connection.commit(); // Commit transaction
        } catch (SQLException e) {
            Logger.getLogger(CheckoutDAO.class.getName()).log(Level.SEVERE, null, e);
            return false;
        }
        return true;
    }
}
