package controller;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Blob;
import java.util.ArrayList;
import java.util.List;
import db.db;
import model.bookBeans;

public class adminDao {

public boolean addBook(bookBeans book) {
    String query = "INSERT INTO buku (gambar_buku, nama_buku, harga_buku, genre_buku, series_buku, deskripsi_buku, stock_buku) VALUES (?, ?, ?, ?, ?, ?, ?)";
    try (Connection conn = new db().getConnection();
         PreparedStatement pstmt = conn.prepareStatement(query)) {
        if (book.getGambar() == null || book.getNama() == null || book.getGenre() == null || book.getSerial() == null || book.getDeskripsi() == null || book.getStock() < 0) {
            return false;
        }
        pstmt.setBinaryStream(1, book.getGambar());
        pstmt.setString(2, book.getNama());
        pstmt.setDouble(3, book.getHarga());
        pstmt.setString(4, book.getGenre());
        pstmt.setString(5, book.getSerial());
        pstmt.setString(6, book.getDeskripsi());
        pstmt.setInt(7, book.getStock());
        return pstmt.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

   public boolean updateBook(bookBeans book) {
    String query = "UPDATE buku SET ";
    boolean hasImage = book.getGambar() != null;
    if (!hasImage && (book.getNama() == null || book.getGenre() == null || book.getSerial() == null || book.getDeskripsi() == null || book.getStock() < 0)) {
        return false;
    }
    if (hasImage) {
        query += "gambar_buku = ?, ";
    }
    query += "nama_buku = ?, harga_buku = ?, genre_buku = ?, series_buku = ?, deskripsi_buku = ?, stock_buku = ? WHERE id_buku = ?";
    try (Connection conn = new db().getConnection();
         PreparedStatement pstmt = conn.prepareStatement(query)) {
        int paramIndex = 1;
        if (hasImage) {
            pstmt.setBinaryStream(paramIndex++, book.getGambar());
        }
        pstmt.setString(paramIndex++, book.getNama());
        pstmt.setDouble(paramIndex++, book.getHarga());
        pstmt.setString(paramIndex++, book.getGenre());
        pstmt.setString(paramIndex++, book.getSerial());
        pstmt.setString(paramIndex++, book.getDeskripsi());
        pstmt.setInt(paramIndex++, book.getStock());
        pstmt.setInt(paramIndex, book.getId());
        return pstmt.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

    public boolean deleteBook(int bookId) {
        String query = "DELETE FROM buku WHERE id_buku = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, bookId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public bookBeans getBookById(int bookId) {
        String query = "SELECT * FROM buku WHERE id_buku = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, bookId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    bookBeans book = new bookBeans();
                    book.setId(rs.getInt("id_buku"));

                    Blob blob = rs.getBlob("gambar_buku");
                    if (blob != null) {
                        InputStream inputStream = blob.getBinaryStream();
                        book.setGambar(inputStream);
                    }

                    book.setNama(rs.getString("nama_buku"));
                    book.setHarga(rs.getDouble("harga_buku"));
                    book.setGenre(rs.getString("genre_buku"));
                    book.setSerial(rs.getString("series_buku"));
                    book.setDeskripsi(rs.getString("deskripsi_buku"));
                    book.setStock(rs.getInt("stock_buku"));
                    return book;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<bookBeans> getAllBooks() {
        List<bookBeans> books = new ArrayList<>();
        String query = "SELECT * FROM buku";
        try (Connection conn = new db().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                bookBeans book = new bookBeans();
                book.setId(rs.getInt("id_buku"));

                Blob blob = rs.getBlob("gambar_buku");
                if (blob != null) {
                    InputStream inputStream = blob.getBinaryStream();
                    book.setGambar(inputStream);
                }

                book.setNama(rs.getString("nama_buku"));
                book.setHarga(rs.getDouble("harga_buku"));
                book.setGenre(rs.getString("genre_buku"));
                book.setSerial(rs.getString("series_buku"));
                book.setDeskripsi(rs.getString("deskripsi_buku"));
                book.setStock(rs.getInt("stock_buku"));
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public InputStream getBookImageStream(int bookId) {
        String query = "SELECT gambar_buku FROM buku WHERE id_buku = ?";
        try (Connection conn = new db().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, bookId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getBinaryStream("gambar_buku");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static String formatSerial(String serial) {
        switch (serial) {
            case "aksi":
                return "Serial Aksi";
            case "cerpen":
                return "Cerpen";
            case "duniaParalel":
                return "Dunia Paralel";
            case "gogons":
                return "Gogons";
            case "nonSeri":
                return "Non Serial";
            case "anak":
                return "Serial Anak";
            default:
                return serial;
        }
    }
    
}


