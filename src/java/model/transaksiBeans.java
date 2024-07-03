/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Arya Prathama
 */
    // TransaksiBeans.java

public class transaksiBeans {
    private String nameBuku;
    private String namaUser;
    private String namaPembeli;
    private double hargaBuku;
    private String tanggal;
    private int jumlah;
    private String email;
    private String alamat;
    private String metodePem;

    // Getters and setters
    public String getNameBuku() {
        return nameBuku;
    }

    public void setNameBuku(String nameBuku) {
        this.nameBuku = nameBuku;
    }

    public String getNamaUser() {
        return namaUser;
    }

    public void setNamaUser(String namaUser) {
        this.namaUser = namaUser;
    }

    public String getNamaPembeli() {
        return namaPembeli;
    }

    public void setNamaPembeli(String namaPembeli) {
        this.namaPembeli = namaPembeli;
    }

    public double getHargaBuku() {
        return hargaBuku;
    }

    public void setHargaBuku(double hargaBuku) {
        this.hargaBuku = hargaBuku;
    }

    public String getTanggal() {
        return tanggal;
    }

    public void setTanggal(String tanggal) {
        this.tanggal = tanggal;
    }

    public int getJumlah() {
        return jumlah;
    }

    public void setJumlah(int jumlah) {
        this.jumlah = jumlah;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAlamat() {
        return alamat;
    }

    public void setAlamat(String alamat) {
        this.alamat = alamat;
    }

    public String getMetodePem() {
        return metodePem;
    }

    public void setMetodePem(String metodePem) {
        this.metodePem = metodePem;
    }
}

