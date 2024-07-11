<%@ page import="model.userBeans"%>
<%@ page import="controller.UserDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.cartBeans"%>
<%@ page import="java.util.List"%>
<%@ page import="controller.CartDAO"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%
    String username = (String) session.getAttribute("uName");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String[] selectedItemsParam = request.getParameterValues("selectedItems");
    if (selectedItemsParam == null || selectedItemsParam.length == 0) {
        response.sendRedirect("cart.jsp");
        return;
    }

    List<Integer> selectedItemIds = new ArrayList<>();
    for (String itemId : selectedItemsParam) {
        selectedItemIds.add(Integer.parseInt(itemId));
    }

    Connection connection = (Connection) getServletContext().getAttribute("DBConnection");
    CartDAO cartDAO = new CartDAO();
    List<cartBeans> selectedItems = cartDAO.getSelectedItems(selectedItemIds);

    double totalPrice = 0;
    for (cartBeans item : selectedItems) {
        totalPrice += item.getBookPrice() * item.getQuantity();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
       @import url('https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic&display=swap');
        body, html {
            font-family: 'Zen Maru Gothic', sans-serif;
            background-color: #FFFFEF;
        }
        .container {
            margin-top: 50px;
            background-color: #FFFFEF;
        }
        .checkout-container {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .order-summary-card {
            padding: 20px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
        }
        .order-summary-card img {
            width: 80px;
            height: auto;
        }
        .checkout-form-card {
            background-color: #f8f9fa;
            padding: 20px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .cancel-button {
            margin-bottom: 20px;
        }
        .btn-danger {
            color: #fff;
            background-color: red;
            border-color: red;
        }
        .total-price {
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .submit-button-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .submit-button {
            width: 200px;
            height: 50px;
        }
        .btn-success {
            color: #fff;
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-secondary {
            color: #fff;
            background-color: red;
            border-color: red;
        }
        .modal-body {
            text-align: center;
        }
        .modal-footer {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <a href="cart.jsp" class="btn btn-danger cancel-button">Cancel</a>
    <h1 class="mt-3 mb-4">Checkout</h1>
    
    <% 
        String message = (String) session.getAttribute("message");
        if (message != null) {
    %>
        <div class="alert alert-info" role="alert">
            <%= message %>
        </div>
    <% 
        session.removeAttribute("message");
        } 
    %>
    
    <%
    UserDAO userDAO = new UserDAO();
    userBeans user = userDAO.getUserByUsername(username);
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
    
    <div class="checkout-container">
        <!-- Card for Order Summary -->
        <div class="order-summary-card">
            <h3>Order Summary</h3>
            <% for (cartBeans item : selectedItems) { %>
                <div class="d-flex align-items-center mb-2">
                    <img src="data:image/png;base64,<%= item.getImageBase64() %>" alt="<%= item.getBookName() %>" class="img-thumbnail mr-2">
                    <div>
                        <div><%= item.getBookName() %> - <%= item.getQuantity() %> x Rp <%= item.getBookPrice() %></div>
                    </div>
                </div>
            <% } %>
            <div class="total-price">
                Total: Rp <%= String.format("%,.2f", totalPrice) %>
            </div>
        </div>

        <!-- Card for Checkout Form -->
        <div class="checkout-form-card">
            <form id="checkout-form" action="CheckoutServlet" method="POST" onsubmit="event.preventDefault(); $('#checkoutModal').modal('show');">
                
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" class="form-control" id="username" name="username" value="<%= user.getUsername() %>" required readonly>
                </div>

                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" required>
                </div>
                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" class="form-control" id="address" name="address" value="<%= user.getAddress() %>" required>
                </div>
                <div class="form-group">
                    <label for="city">City</label>
                    <select class="form-control" id="city" name="city" required>
                        <% String[] cities = {"Ambon", "Atambua", "Balikpapan", "Banda Aceh", "Bandar Lampung", "Bandung", "Banyuwangi", "Bau-Bau", "Bekasi", "Bengkulu", "Bima", "Binjai", "Bitung", "Bogor", "Bukittinggi", "Cilegon", "Cimahi", "Cirebon", "Denpasar", "Depok", "Dumai", "Ende", "Gorontalo", "Jakarta", "Jambi", "Jayapura", "Kendari", "Kotamobagu", "Kupang", "Langsa", "Lhokseumawe", "Lubuklinggau", "Luwuk", "Makassar", "Magelang", "Malang", "Manado", "Mataram", "Maumere", "Medan", "Padang", "Padang Sidempuan", "Palangkaraya", "Palembang", "Palopo", "Palu", "Pangkal Pinang", "Pariaman", "Pekanbaru", "Pematang Siantar", "Pontianak", "Praya", "Probolinggo", "Purwokerto", "Ruteng", "Sabang", "Salatiga", "Samarinda", "Semarang", "Serang", "Sibolga", "Singkawang", "Solo", "Sorong", "Sungai Penuh", "Surabaya", "Tanjung Balai", "Tanjung Pandan", "Tanjung Pinang", "Tanjung Selor", "Tarakan", "Tebing Tinggi", "Ternate", "Tomohon", "Waingapu", "Yogyakarta"};

                        for(String city : cities) {
                            if (city.equals(user.getCity())) {
                                %>
                                <option value="<%= city %>" selected><%= city %></option>
                                <%
                            } else {
                                %>
                                <option value="<%= city %>"><%= city %></option>
                                <%
                            }
                        }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="postalCode">Postal Code</label>
                    <input type="text" class="form-control" id="postalCode" name="postalCode" value="<%= user.getPostCode() %>" required>
                </div>
                <div class="form-group">
                    <label for="paymentMethod">Payment Method</label>
                    <select class="form-control" id="paymentMethod" name="paymentMethod" required>
                        <option value="credit_card">Credit Card</option>
                        <option value="bank_transfer">Bank Transfer</option>
                        <option value="paypal">PayPal</option>
                    </select>
                </div>
                <input type="hidden" name="selectedItems" value="<%= String.join(",", selectedItemsParam) %>">
                
                <div class="submit-button-container">
                    <button type="submit" class="btn btn-primary submit-button">Submit</button>
                </div>
                
            </form>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="checkoutModal" tabindex="-1" aria-labelledby="checkoutModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="checkoutModalLabel">Checkout Successful</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Checkout berhasil, segera selesaikan pembayaran!
            </div>
            <div class="modal-footer">
                <a href="cart.jsp" class="btn btn-secondary" id="cancelBtn">Cancel</a>
                <button type="button" class="btn btn-success" id="completePaymentBtn">Selesaikan Pembayaran</button>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('completePaymentBtn').addEventListener('click', function() {
        document.getElementById('checkout-form').submit();
    });

    document.getElementById('cancelBtn').addEventListener('click', function() {
        $('#checkoutModal').modal('hide');
    });
</script>
</body>
</html>
