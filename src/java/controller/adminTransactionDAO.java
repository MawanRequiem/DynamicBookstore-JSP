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
        String sql = "SELECT o.order_id, o.username, o.name, o.email, o.address, o.city, o.postal_code, o.payment_method, o.total_price, o.order_date, " +
                     "GROUP_CONCAT(oi.book_name SEPARATOR ', ') as book_names, GROUP_CONCAT(oi.kuantitas SEPARATOR ', ') as quantities, " +
                     "o.status " +
                     "FROM orders o " +
                     "JOIN ordersitems oi ON o.order_id = oi.order_id " +
                     "GROUP BY o.order_id";
        List<transaksiBeans> transaksiList = new ArrayList<>();
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
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
                transaksi.setBookNames(rs.getString("book_names"));
                transaksi.setQuantities(rs.getString("quantities"));
                transaksi.setStatus(rs.getString("status"));
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

    public boolean updateStatus(int orderId, String paymentStatus) {
        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, paymentStatus);
            ps.setInt(2, orderId);
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
}
