package controller;

import db.db;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.transaksiBeans;

public class adminTransactionDAO {

  public List<transaksiBeans> getAllTransaksi() {
    String sql = "SELECT o.order_id, u.id_user as user_id, u.nama_user, o.payment_method, o.total_price, o.order_date, " +
                 "GROUP_CONCAT(oi.book_id SEPARATOR ', ') as book_ids, GROUP_CONCAT(oi.kuantitas SEPARATOR ', ') as quantities, " +
                 "o.status, o.kodepembayaran, o.expiry_time, o.is_stock_returned " +
                 "FROM orders o " +
                 "JOIN orderitems oi ON o.order_id = oi.order_id " +
                 "JOIN user_db u ON o.user_id = u.id_user " +
                 "GROUP BY o.order_id";
    List<transaksiBeans> transaksiList = new ArrayList<>();
    try (Connection conn = new db().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            transaksiBeans transaksi = new transaksiBeans();
            transaksi.setOrderId(rs.getInt("order_id"));
            transaksi.setUserId(rs.getInt("user_id"));
            transaksi.setUsername(rs.getString("nama_user")); // Set username dari hasil query
            transaksi.setPaymentMethod(rs.getString("payment_method"));
            transaksi.setTotalPrice(rs.getDouble("total_price"));
            transaksi.setOrderDate(rs.getTimestamp("order_date"));
            transaksi.setBookIds(rs.getString("book_ids"));
            transaksi.setQuantities(rs.getString("quantities"));
            transaksi.setStatus(rs.getString("status"));
            transaksi.setKodePembayaran(rs.getString("kodepembayaran"));
            transaksi.setExpiryTime(rs.getTimestamp("expiry_time"));
            transaksi.setStockReturned(rs.getBoolean("is_stock_returned"));

            // Fetch book names based on book IDs
            transaksi.setBookNames(getBookNamesByIds(transaksi.getBookIds(), conn));

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


    private String getBookNamesByIds(String bookIds, Connection conn) throws SQLException {
        if (bookIds == null || bookIds.isEmpty()) {
            return "";
        }
        String[] idsArray = bookIds.split(", ");
        StringBuilder query = new StringBuilder("SELECT nama_buku FROM buku WHERE id_buku IN (");
        for (int i = 0; i < idsArray.length; i++) {
            query.append("?");
            if (i < idsArray.length - 1) {
                query.append(",");
            }
        }
        query.append(")");
        
        try (PreparedStatement ps = conn.prepareStatement(query.toString())) {
            for (int i = 0; i < idsArray.length; i++) {
                ps.setInt(i + 1, Integer.parseInt(idsArray[i]));
            }
            ResultSet rs = ps.executeQuery();
            List<String> bookNames = new ArrayList<>();
            while (rs.next()) {
                bookNames.add(rs.getString("nama_buku"));
            }
            return String.join(", ", bookNames);
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
                    // Stock already returned, no need to return again
                    return;
                }
            }
        }

        String sql = "SELECT book_id, kuantitas FROM orderitems WHERE order_id = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            String updateStockQuery = "UPDATE buku SET stock_buku = stock_buku + ? WHERE id_buku = ?";
            try (PreparedStatement updateStockPs = conn.prepareStatement(updateStockQuery)) {
                while (rs.next()) {
                    int bookId = rs.getInt("book_id");
                    int quantity = rs.getInt("kuantitas");

                    updateStockPs.setInt(1, quantity);
                    updateStockPs.setInt(2, bookId);
                    updateStockPs.executeUpdate();
                }
            }
        }

        // Mark stock as returned
        String markStockReturnedQuery = "UPDATE orders SET is_stock_returned = TRUE WHERE order_id = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement markPs = conn.prepareStatement(markStockReturnedQuery)) {
            markPs.setInt(1, orderId);
            markPs.executeUpdate();
        }
    }
}
