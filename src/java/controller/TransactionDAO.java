// TransaksiDAO.java
package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import db.db;
import model.transaksiBeans;

public class TransactionDAO {
    public List<transaksiBeans> getTransaksiByUsername(String username) {
        String sql = "SELECT * FROM pembayaran WHERE nama_user = ?";
        List<transaksiBeans> transaksiList = new ArrayList<transaksiBeans>();
        try (Connection conn = new db().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                transaksiBeans transaksi = new transaksiBeans();
                transaksi.setNameBuku(rs.getString("nama_buku"));
                transaksi.setNamaUser(rs.getString("nama_user"));
                transaksi.setNamaPembeli(rs.getString("nama_pembeli"));
                transaksi.setHargaBuku(rs.getDouble("harga_buku"));
                transaksi.setTanggal(rs.getString("tanggal"));
                transaksi.setJumlah(rs.getInt("jumlah"));
                transaksi.setEmail(rs.getString("email"));
                transaksi.setAlamat(rs.getString("alamat"));
                transaksi.setMetodePem(rs.getString("metode_pem"));
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
 
}
