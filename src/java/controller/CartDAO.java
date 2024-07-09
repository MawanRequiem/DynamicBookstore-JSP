package controller;

import db.db;
import model.cartBeans;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CartDAO {

    public Connection getConnection() {
        Connection connection = null;
        try {
            connection = new db().getConnection();
            return connection;
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return connection;
    }

    public void addToCart(cartBeans cart) throws SQLException {
        String query = "INSERT INTO keranjang (gambar_buku, nama_buku, harga, total_beli, username) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setBlob(1, cart.getBookImage());
            ps.setString(2, cart.getBookName());
            ps.setDouble(3, cart.getBookPrice());
            ps.setInt(4, cart.getQuantity());
            ps.setString(5, cart.getUsername());
            ps.executeUpdate();
        }
    }

    public List<cartBeans> getCartItems(String username) throws SQLException {
        List<cartBeans> cartItems = new ArrayList<>();
        String query = "SELECT * FROM keranjang WHERE username = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cartBeans book = new cartBeans();
                    book.setId(rs.getInt("id_keranjang"));
                    book.setBookName(rs.getString("nama_buku"));
                    book.setBookPrice(rs.getDouble("harga"));
                    book.setQuantity(rs.getInt("total_beli"));
                    book.setBookImage(rs.getBlob("gambar_buku").getBinaryStream());
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

        StringBuilder query = new StringBuilder("SELECT * FROM keranjang WHERE id_keranjang IN (");
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
                    item.setBookPrice(rs.getDouble("harga"));
                    item.setQuantity(rs.getInt("total_beli"));
                    item.setBookImage(rs.getBlob("gambar_buku").getBinaryStream());
                    selectedItems.add(item);
                }
            }
        }
        return selectedItems;
    }

    public cartBeans getCartItemById(int id) throws SQLException {
        String query = "SELECT * FROM keranjang WHERE id_keranjang = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cartBeans item = new cartBeans();
                    item.setId(rs.getInt("id_keranjang"));
                    item.setBookName(rs.getString("nama_buku"));
                    item.setBookPrice(rs.getDouble("harga"));
                    item.setQuantity(rs.getInt("total_beli"));
                    item.setBookImage(rs.getBlob("gambar_buku").getBinaryStream());
                    return item;
                }
            }
        }
        return null;
    }

    public double getTotalPrice(String username) throws SQLException {
        String query = "SELECT SUM(harga * total_beli) as total FROM keranjang WHERE username = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, username);
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

    public boolean checkIfItemExists(String bookName, String username) throws SQLException {
        String query = "SELECT id_keranjang, total_beli FROM keranjang WHERE nama_buku = ? AND username = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, bookName);
            ps.setString(2, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        }
        return false;
    }

    public void updateItemQuantity(String bookName, String username, int quantity) throws SQLException {
        String query = "UPDATE keranjang SET total_beli = total_beli + ? WHERE nama_buku = ? AND username = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, quantity);
            ps.setString(2, bookName);
            ps.setString(3, username);
            ps.executeUpdate();
        }
    }

    public void updateItemSelection(int cartId, boolean selected) throws SQLException {
        String query = "UPDATE keranjang SET selected = ? WHERE id_keranjang = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setBoolean(1, selected);
            ps.setInt(2, cartId);
            ps.executeUpdate();
        }
    }

    public void clearCart(Map<String, Integer> selectedItemQuantities) throws SQLException {
        String query = "DELETE FROM keranjang WHERE nama_buku = ?";
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
           for (Map.Entry<String, Integer> entry : selectedItemQuantities.entrySet()) {
                                    ps.setString(1, entry.getKey());
                                    ps.executeUpdate();
        }
    }
    }
}