// controller/BookDAO.java
package controller;

import model.bookBeans;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import db.db;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BookDAO {

    private Connection connection;

    public BookDAO() {
        try {
            this.connection = new db().getConnection();
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public bookBeans getBookById(int id) throws SQLException {
        String query = "SELECT * FROM buku WHERE id_buku = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractBookFromResultSet(rs);
                }
            }
        }
        return null;
    }

    public List<bookBeans> getAllBooks() throws SQLException {
        List<bookBeans> books = new ArrayList<>();
        String query = "SELECT * FROM buku";
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                books.add(extractBookFromResultSet(rs));
            }
        }
        return books;
    }

    public List<bookBeans> searchBooks(String query) {
        return searchBooks(query, null, null, null);
    }

    public List<bookBeans> searchBooks(String query, String minPrice, String maxPrice, String stock) {
        List<bookBeans> books = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder("SELECT * FROM buku WHERE nama_buku LIKE ?");
            if (minPrice != null && !minPrice.isEmpty()) {
                sql.append(" AND harga_buku >= ").append(minPrice);
            }
            if (maxPrice != null && !maxPrice.isEmpty()) {
                sql.append(" AND harga_buku <= ").append(maxPrice);
            }
            if (stock != null && stock.equals("available")) {
                sql.append(" AND stock_buku > 0");
            }

            PreparedStatement stmt = connection.prepareStatement(sql.toString());
            stmt.setString(1, "%" + query + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                books.add(extractBookFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    private bookBeans extractBookFromResultSet(ResultSet rs) throws SQLException {
        bookBeans book = new bookBeans();
        book.setId(rs.getInt("id_buku"));
        book.setNama(rs.getString("nama_buku"));
        book.setHarga(rs.getDouble("harga_buku"));
        book.setGenre(rs.getString("genre_buku"));
        book.setSerial(rs.getString("series_buku"));
        book.setDeskripsi(rs.getString("deskripsi_buku"));
        book.setGambar(rs.getBinaryStream("gambar_buku"));
        book.setStock(rs.getInt("stock_buku"));
        return book;
    }

    public List<bookBeans> searchBooksStartingWith(String query) {
        List<bookBeans> books = new ArrayList<>();
        String sql = "SELECT * FROM buku WHERE nama_buku LIKE ?";
        try (Connection connection = new db().getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, query + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    books.add(extractBookFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
}
