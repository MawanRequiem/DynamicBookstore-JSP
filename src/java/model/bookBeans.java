package model;

import java.io.InputStream;
import java.util.Base64;
import java.io.ByteArrayOutputStream;

public class bookBeans {
    private int id;
    private InputStream gambar;
    private String nama;
    private double harga;
    private String genre;
    private String deskripsi;
    private int stock;
    private String serial;

    // Getters and Setters
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

    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }
    
    

    // Convert InputStream to Base64 for image display in HTML
    public String getImageBase64() {
        try {
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = gambar.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            byte[] imageBytes = outputStream.toByteArray();
            String base64Image = Base64.getEncoder().encodeToString(imageBytes);
            outputStream.close();
            return base64Image;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
