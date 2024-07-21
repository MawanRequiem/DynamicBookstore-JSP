package controller;

import db.db;
import model.cartBeans;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CartDAO {

    public Connection getConnection() {
        Connection connection = null;
        try {
            connection = new db().getConnection();
            return connection;
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return connection;
    }

    public void addToCart(cartBeans cart) throws SQLException {
        if (checkIfItemExists(cart.getBookId(), cart.getUserId())) {
            updateItemQuantity(cart.getBookId(), cart.getUserId(), cart.getQuantity());
        } else {
            String query = "INSERT INTO keranjang (user_id, book_id, total_beli) VALUES (?, ?, ?)";
            try (Connection connection = getConnection();
                 PreparedStatement ps = connection.prepareStatement(query)) {
                ps.setInt(1, cart.getUserId());
                ps.setInt(2, cart.getBookId());
                ps.setInt(3, cart.getQuantity());
                ps.executeUpdate();
            }
        }
    }

    public List<cartBeans> getCartItems(int userId) throws SQLException {
        List<cartBeans> cartItems = new ArrayList<>();
        String query = "SELECT k.id_keranjang, k.total_beli, b.nama_buku, b.harga_buku, b.gambar_buku, b.stock_buku " +
                       "FROM keranjang k " +
                       "JOIN buku b ON k.book_id = b.id_buku " +
                       "WHERE k.user_id = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cartBeans book = new cartBeans();
                    book.setId(rs.getInt("id_keranjang"));
                    book.setBookName(rs.getString("nama_buku"));
                    book.setBookPrice(rs.getDouble("harga_buku"));
                    book.setQuantity(rs.getInt("total_beli"));
                    book.setBookImage(rs.getBlob("gambar_buku").getBinaryStream());
                    book.setStock(rs.getInt("stock_buku"));
                    cartItems.add(book);
                }
            }
        }
        return cartItems;
    }

    public List<cartBeans> getSelectedItems(List<Integer> itemIds) throws SQLException {
        List<cartBeans> selectedItems = new ArrayList<>();
        if (itemIds == null || itemIds.isEmpty()) {
            return selectedItems;
        }

        StringBuilder query = new StringBuilder("SELECT k.*, b.nama_buku, b.harga_buku, b.gambar_buku FROM keranjang k JOIN buku b ON k.book_id = b.id_buku WHERE k.id_keranjang IN (");
        for (int i = 0; i < itemIds.size(); i++) {
            query.append("?");
            if (i < itemIds.size() - 1) {
                query.append(",");
            }
        }
        query.append(")");

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query.toString())) {
            for (int i = 0; i < itemIds.size(); i++) {
                ps.setInt(i + 1, itemIds.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cartBeans item = new cartBeans();
                    item.setId(rs.getInt("id_keranjang"));
                    item.setBookName(rs.getString("nama_buku"));
                    item.setBookPrice(rs.getDouble("harga_buku"));
                    item.setQuantity(rs.getInt("total_beli"));
                    item.setBookImage(rs.getBlob("gambar_buku").getBinaryStream());
                    selectedItems.add(item);
                }
            }
        }
        return selectedItems;
    }

    public cartBeans getCartItemById(int id) throws SQLException {
        String query = "SELECT k.*, b.nama_buku, b.harga_buku, b.gambar_buku FROM keranjang k JOIN buku b ON k.book_id = b.id_buku WHERE k.id_keranjang = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cartBeans item = new cartBeans();
                    item.setId(rs.getInt("id_keranjang"));
                    item.setBookId(rs.getInt("book_id"));
                    item.setBookPrice(rs.getDouble("harga_buku"));
                    item.setQuantity(rs.getInt("total_beli"));
                    item.setBookImage(rs.getBlob("gambar_buku").getBinaryStream());
                    return item;
                }
            }
        }
        return null;
    }

    public double getTotalPrice(int userId) throws SQLException {
        String query = "SELECT SUM(b.harga_buku * k.total_beli) as total FROM keranjang k JOIN buku b ON k.book_id = b.id_buku WHERE k.user_id = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total");
                }
            }
        }
        return 0;
    }

    public void updateCartItem(int cartId, int quantity) throws SQLException {
        String query = "UPDATE keranjang SET total_beli = ? WHERE id_keranjang = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, quantity);
            ps.setInt(2, cartId);
            ps.executeUpdate();
        }
    }

    public void deleteCartItem(int cartId) throws SQLException {
        String query = "DELETE FROM keranjang WHERE id_keranjang = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, cartId);
            ps.executeUpdate();
        }
    }

    public boolean checkIfItemExists(int bookId, int userId) throws SQLException {
        String query = "SELECT id_keranjang, total_beli FROM keranjang WHERE book_id = ? AND user_id = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, bookId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        }
        return false;
    }

    public void updateItemQuantity(int bookId, int userId, int quantity) throws SQLException {
        String query = "UPDATE keranjang SET total_beli = total_beli + ? WHERE book_id = ? AND user_id = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, quantity);
            ps.setInt(2, bookId);
            ps.setInt(3, userId);
            ps.executeUpdate();
        }
    }

    public void clearSelectedItems(List<Integer> itemIds) throws SQLException {
        if (itemIds == null || itemIds.isEmpty()) {
            return;
        }

        String query = "DELETE FROM keranjang WHERE id_keranjang = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            for (int itemId : itemIds) {
                ps.setInt(1, itemId);
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }
    
    public int getUserIdByUsername(String username) throws SQLException {
        String query = "SELECT id_user FROM user_db WHERE username = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id_user");
                }
            }
        }
        return -1; // Return -1 if user is not found
    }
}
