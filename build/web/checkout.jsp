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
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic&display=swap');
        html, body {
            font-family: 'Zen Maru Gothic', sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        .checkout-container {
            display: flex;
            justify-content: space-between;
        }
        .order-summary {
            width: 40%;
            padding: 20px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-right: 20px;
        }
        .total-price {
            font-size: 18px;
            font-weight: bold;
            margin-top: 20px;
        }
        .checkout-form {
            width: 55%;
        }
        .cancel-button {
            margin-bottom: 20px;
        }
        .img-thumbnail {
            width: 100px;
            height: auto;
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
        <div class="order-summary">
            <h3>Order Summary</h3>
            <ul>
                <% for (cartBeans item : selectedItems) { %>
                    <li>
                        <img src="data:image/png;base64,<%= item.getImageBase64() %>" alt="<%= item.getBookName() %>" class="img-thumbnail">
                        <%= item.getBookName() %> - <%= item.getQuantity() %> x Rp <%= item.getBookPrice() %>
                    </li>
                <% } %>
            </ul>
            <div class="total-price">
                Total: Rp <%= String.format("%,.2f", totalPrice) %>
            </div>
        </div>

        <div class="checkout-form">
            <form id="checkout-form" action="CheckoutServlet" method="POST">
                
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
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
    </div>
</div>
              
</body>

</html>