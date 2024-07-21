package model;

import java.io.InputStream;
import java.sql.Timestamp;

public class transaksiBeans {
    private int orderItem;
    private int orderId;
    private int userId;
    private String paymentMethod;
    private double totalPrice;
    private Timestamp orderDate;
    private String status;
    private String kodePembayaran;
    private InputStream buktiBayar;
    private Timestamp expiryTime;
    private boolean isStockReturned;
    private String bookNames; // Combined book names
    private String quantities; // Combined quantities
    private String bookIds;
    private String username;

    public boolean isIsStockReturned() {
        return isStockReturned;
    }

    public void setIsStockReturned(boolean isStockReturned) {
        this.isStockReturned = isStockReturned;
    }

    public String getBookIds() {
        return bookIds;
    }

    public void setBookIds(String bookIds) {
        this.bookIds = bookIds;
    }



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

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public InputStream getBuktiBayar() {
        return buktiBayar;
    }

    public void setBuktiBayar(InputStream buktiBayar) {
        this.buktiBayar = buktiBayar;
    }

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
    
    
      public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
