package controller;

import db.db;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Map;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CheckoutDAO {

    private static final Logger LOGGER = Logger.getLogger(CheckoutDAO.class.getName());

    public Connection getConnection() {
        Connection connection = null;
        try {
            connection = new db().getConnection();
            return connection;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error establishing connection", ex);
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

    public boolean placeOrder(int userId, String name, String email, String address, String city, String postalCode, double total_price, String paymentMethod, Map<Integer, Integer> selectedItemQuantities, Timestamp expiryTime) throws SQLException {
        try (Connection connection = getConnection()) {
            if (connection == null) {
                LOGGER.log(Level.SEVERE, "Failed to establish connection");
                return false;
            }

            connection.setAutoCommit(false); // Start transaction

            // Insert order details
            String insertOrderQuery = "INSERT INTO orders (user_id, payment_method, total_price, order_date, status, kodepembayaran, expiry_time) VALUES (?, ?, ?, ?, ?, ?, ?)";
            String kodePembayaran = generateRandomKodePembayaran();
            String status = "belum_bayar";
            try (PreparedStatement preparedStatement = connection.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS)) {
                preparedStatement.setInt(1, userId);
                preparedStatement.setString(2, paymentMethod);
                preparedStatement.setDouble(3, total_price);
                preparedStatement.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
                preparedStatement.setString(5, status);
                preparedStatement.setString(6, kodePembayaran);
                preparedStatement.setTimestamp(7, expiryTime);
                int affectedRows = preparedStatement.executeUpdate();
                if (affectedRows == 0) {
                    connection.rollback();
                    LOGGER.log(Level.SEVERE, "Failed to insert order details");
                    return false;
                }

                try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int orderId = generatedKeys.getInt(1);

                        // Insert order items and reduce stock
                        String insertOrderItemsQuery = "INSERT INTO orderitems (order_id, book_id, kuantitas) VALUES (?, ?, ?)";
                        String updateStockQuery = "UPDATE buku SET stock_buku = stock_buku - ? WHERE id_buku = ?";
                        try (PreparedStatement orderItemsStatement = connection.prepareStatement(insertOrderItemsQuery);
                             PreparedStatement updateStockStatement = connection.prepareStatement(updateStockQuery)) {
                            for (Map.Entry<Integer, Integer> entry : selectedItemQuantities.entrySet()) {
                                int bookId = entry.getKey();
                                int quantity = entry.getValue();
                                if (bookId <= 0) {
                                    LOGGER.log(Level.SEVERE, "Invalid Book ID: {0}", bookId);
                                    continue;
                                }
                                if (quantity <= 0) {
                                    LOGGER.log(Level.SEVERE, "Invalid quantity for Book ID {0}: {1}", new Object[]{bookId, quantity});
                                    continue;
                                }

                                // Verify that the book ID exists
                                if (!doesBookExist(connection, bookId)) {
                                    connection.rollback();
                                    LOGGER.log(Level.SEVERE, "Book ID {0} does not exist", bookId);
                                    return false;
                                }

                                // Insert order item
                                orderItemsStatement.setInt(1, orderId);
                                orderItemsStatement.setInt(2, bookId);
                                orderItemsStatement.setInt(3, quantity);
                                orderItemsStatement.addBatch();

                                // Reduce stock
                                updateStockStatement.setInt(1, quantity);
                                updateStockStatement.setInt(2, bookId);
                                updateStockStatement.addBatch();
                            }

                            int[] batchResult = orderItemsStatement.executeBatch();
                            int[] stockUpdateResult = updateStockStatement.executeBatch();
                            for (int result : batchResult) {
                                if (result == Statement.EXECUTE_FAILED) {
                                    connection.rollback();
                                    LOGGER.log(Level.SEVERE, "Failed to insert order items");
                                    return false;
                                }
                            }
                            for (int result : stockUpdateResult) {
                                if (result == Statement.EXECUTE_FAILED) {
                                    connection.rollback();
                                    LOGGER.log(Level.SEVERE, "Failed to update stock");
                                    return false;
                                }
                            }
                        }
                    } else {
                        connection.rollback();
                        LOGGER.log(Level.SEVERE, "Failed to retrieve order ID");
                        return false;
                    }
                }
            }
            connection.commit(); // Commit transaction
            LOGGER.log(Level.INFO, "Order placed successfully for User ID: {0}", userId);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error placing order", e);
            return false;
        }
        return true;
    }

    private boolean doesBookExist(Connection connection, int bookId) throws SQLException {
        String query = "SELECT id_buku FROM buku WHERE id_buku = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, bookId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
}
