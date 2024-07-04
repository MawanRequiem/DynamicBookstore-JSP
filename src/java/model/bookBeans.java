// bookBeans.java
 package model;
import java.io.InputStream;

public class bookBeans {
    private int id;
    private InputStream gambar; // Store image as InputStream
    private String nama;
    private double harga;
    private String genre;
    private String deskripsi;
    private int stock;

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public InputStream getGambar() { return gambar; }
    public void setGambar(InputStream gambar) { this.gambar = gambar; }

    public String getNama() { return nama; }
    public void setNama(String nama) { this.nama = nama; }

    public double getHarga() { return harga; }
    public void setHarga(double harga) { this.harga = harga; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public String getDeskripsi() { return deskripsi; }
    public void setDeskripsi(String deskripsi) { this.deskripsi = deskripsi; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
}
