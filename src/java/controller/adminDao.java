package controller;

import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import db.db;
import model.bookBeans;

public class adminDao {

    // Method to add a new book
    public boolean addBook(bookBeans book) {
        String query = "INSERT INTO buku (gambar_buku, nama_buku, harga_buku, genre_buku, deskripsi_buku, stock_buku) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = new db().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setBinaryStream(1, book.getGambar()); // Set InputStream for LONG BLOB
            pstmt.setString(2, book.getNama());
            pstmt.setDouble(3, book.getHarga());
            pstmt.setString(4, book.getGenre());
            pstmt.setString(5, book.getDeskripsi());
            pstmt.setInt(6, book.getStock());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            // Consider using a logging framework here
            e.printStackTrace();
            return false;
        }
    }

    // Method to update an existing book
    public boolean updateBook(bookBeans book) {
        String query = "UPDATE buku SET gambar_buku = ?, nama_buku = ?, harga_buku = ?, genre_buku = ?, deskripsi_buku = ?, stock_buku = ? WHERE id_buku = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setBinaryStream(1, book.getGambar()); // Set InputStream for LONG BLOB
            pstmt.setString(2, book.getNama());
            pstmt.setDouble(3, book.getHarga());
            pstmt.setString(4, book.getGenre());
            pstmt.setString(5, book.getDeskripsi());
            pstmt.setInt(6, book.getStock());
            pstmt.setInt(7, book.getId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            // Consider using a logging framework here
            e.printStackTrace();
            return false;
        }
    }

    // Method to delete a book
    public boolean deleteBook(int bookId) {
        String query = "DELETE FROM buku WHERE id_buku = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, bookId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            // Consider using a logging framework here
            e.printStackTrace();
            return false;
        }
    }

    // Method to get a book by ID
    public bookBeans getBookById(int bookId) {
        String query = "SELECT * FROM buku WHERE id_buku = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, bookId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    bookBeans book = new bookBeans();
                    book.setId(rs.getInt("id_buku"));
                    
                    // Handling BLOB for gambar_buku
                    Blob blob = rs.getBlob("gambar_buku");
                    if (blob != null) {
                        InputStream inputStream = blob.getBinaryStream();
                        book.setGambar(inputStream);
                    }
                    
                    book.setNama(rs.getString("nama_buku"));
                    book.setHarga(rs.getDouble("harga_buku"));
                    book.setGenre(rs.getString("genre_buku"));
                    book.setDeskripsi(rs.getString("deskripsi_buku"));
                    book.setStock(rs.getInt("stock_buku"));
                    return book;
                }
            }
        } catch (SQLException e) {
            // Consider using a logging framework here
            e.printStackTrace();
        }
        return null;
    }

    // Method to get all books
    public List<bookBeans> getAllBooks() {
        List<bookBeans> books = new ArrayList<>();
        String query = "SELECT * FROM buku";
        try (Connection conn = new db().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                bookBeans book = new bookBeans();
                book.setId(rs.getInt("id_buku"));
                
                // Handling BLOB for gambar_buku
                Blob blob = rs.getBlob("gambar_buku");
                if (blob != null) {
                    InputStream inputStream = blob.getBinaryStream();
                    book.setGambar(inputStream);
                }
                
                book.setNama(rs.getString("nama_buku"));
                book.setHarga(rs.getDouble("harga_buku"));
                book.setGenre(rs.getString("genre_buku"));
                book.setDeskripsi(rs.getString("deskripsi_buku"));
                book.setStock(rs.getInt("stock_buku"));
                books.add(book);
            }
        } catch (SQLException e) {
            // Consider using a logging framework here
            e.printStackTrace();
        }
        return books;
    }

    // Method to get a book's image
    public InputStream getBookImageStream(int bookId) {
        String query = "SELECT gambar_buku FROM buku WHERE id_buku = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, bookId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getBinaryStream("gambar_buku"); // Return InputStream for image
                }
            }
        } catch (SQLException e) {
            // Consider using a logging framework here
            e.printStackTrace();
        }
        return null;
    }
}
