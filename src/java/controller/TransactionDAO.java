package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import db.db;
import java.io.InputStream;
import model.transaksiBeans;

public class TransactionDAO {

    public List<transaksiBeans> getTransaksiByUsername(String username) {
        String sql = "SELECT o.order_id, o.username, o.name, o.email, o.address, o.city, o.postal_code, o.payment_method, o.total_price, o.order_date, o.status, o.kodepembayaran, o.expiry_time, o.is_stock_returned, " +
                     "GROUP_CONCAT(oi.book_name SEPARATOR ', ') as book_names, GROUP_CONCAT(oi.kuantitas SEPARATOR ', ') as quantities " +
                     "FROM orders o " +
                     "JOIN ordersitems oi ON o.order_id = oi.order_id " +
                     "WHERE o.username = ? " +
                     "GROUP BY o.order_id";
        List<transaksiBeans> transaksiList = new ArrayList<>();
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                transaksiBeans transaksi = new transaksiBeans();
                transaksi.setOrderId(rs.getInt("order_id"));
                transaksi.setUsername(rs.getString("username"));
                transaksi.setName(rs.getString("name"));
                transaksi.setEmail(rs.getString("email"));
                transaksi.setAddress(rs.getString("address"));
                transaksi.setCity(rs.getString("city"));
                transaksi.setPostalCode(rs.getString("postal_code"));
                transaksi.setPaymentMethod(rs.getString("payment_method"));
                transaksi.setTotalPrice(rs.getDouble("total_price"));
                transaksi.setOrderDate(rs.getTimestamp("order_date"));
                transaksi.setStatus(rs.getString("status"));
                transaksi.setKodePembayaran(rs.getString("kodepembayaran"));
                transaksi.setExpiryTime(rs.getTimestamp("expiry_time")); // Set expiry time
                transaksi.setStockReturned(rs.getBoolean("is_stock_returned")); // Set is_stock_returned
                transaksi.setBookNames(rs.getString("book_names"));
                transaksi.setQuantities(rs.getString("quantities"));
                transaksiList.add(transaksi);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
        }
        return transaksiList;
    }

    public boolean updatePaymentStatus(int orderId, InputStream paymentProof) {
        String sql = "UPDATE orders SET status = ?, bukti_bayar = ? WHERE order_id = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "sudah_bayar");  // Set the status to "sudah_bayar"
            ps.setBlob(2, paymentProof);
            ps.setInt(3, orderId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
            return false;
        }
    }

    public boolean updateStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0 && "gagal".equals(status)) {
                returnStock(orderId);
            }
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
            return false;
        }
    }

    public InputStream getPaymentProof(int orderId) {
        String sql = "SELECT bukti_bayar FROM orders WHERE order_id = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBlob("bukti_bayar").getBinaryStream();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
        }
        return null;
    }

    public void returnStock(int orderId) throws SQLException {
        String checkStockReturnedQuery = "SELECT is_stock_returned FROM orders WHERE order_id = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement checkPs = conn.prepareStatement(checkStockReturnedQuery)) {
            checkPs.setInt(1, orderId);
            ResultSet rs = checkPs.executeQuery();
            if (rs.next()) {
                boolean isStockReturned = rs.getBoolean("is_stock_returned");
                if (isStockReturned) {
                    // Stok sudah dikembalikan, tidak perlu mengembalikan lagi
                    return;
                }
            }
        }

        String sql = "SELECT book_name, kuantitas FROM ordersitems WHERE order_id = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            String updateStockQuery = "UPDATE buku SET stock_buku = stock_buku + ? WHERE nama_buku = ?";
            try (PreparedStatement updateStockPs = conn.prepareStatement(updateStockQuery)) {
                while (rs.next()) {
                    String bookName = rs.getString("book_name");
                    int quantity = rs.getInt("kuantitas");

                    updateStockPs.setInt(1, quantity);
                    updateStockPs.setString(2, bookName);
                    updateStockPs.executeUpdate();
                }
            }
        }

        // Tandai stok sebagai sudah dikembalikan
        String markStockReturnedQuery = "UPDATE orders SET is_stock_returned = TRUE WHERE order_id = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement markPs = conn.prepareStatement(markStockReturnedQuery)) {
            markPs.setInt(1, orderId);
            markPs.executeUpdate();
        }
    }
}
