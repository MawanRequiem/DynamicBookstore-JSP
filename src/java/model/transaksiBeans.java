package model;

import java.sql.Timestamp;

public class transaksiBeans {
    private int orderItem;
    private int orderId;
    private String username;
    private String name;
    private String email;
    private String address;
    private String city;
    private String postalCode;
    private String paymentMethod;
    private double totalPrice;
    private Timestamp orderDate;
    private String status;
    private String kodePembayaran;
    private String bookNames; // Combined book names
    private String quantities; // Combined quantities
    private Timestamp expiryTime; // New field for expiry time
    private boolean isStockReturned; // New field for stock returned status

    public Timestamp getExpiryTime() {
        return expiryTime;
    }

    public void setExpiryTime(Timestamp expiryTime) {
        this.expiryTime = expiryTime;
    }

    public boolean isStockReturned() {
        return isStockReturned;
    }

    public void setStockReturned(boolean isStockReturned) {
        this.isStockReturned = isStockReturned;
    }

    // Getters and Setters for all fields
    public int getOrderItem() {
        return orderItem;
    }

    public void setOrderItem(int orderItem) {
        this.orderItem = orderItem;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getKodePembayaran() {
        return kodePembayaran;
    }

    public void setKodePembayaran(String kodePembayaran) {
        this.kodePembayaran = kodePembayaran;
    }

    public String getBookNames() {
        return bookNames;
    }

    public void setBookNames(String bookNames) {
        this.bookNames = bookNames;
    }

    public String getQuantities() {
        return quantities;
    }

    public void setQuantities(String quantities) {
        this.quantities = quantities;
    }
}
