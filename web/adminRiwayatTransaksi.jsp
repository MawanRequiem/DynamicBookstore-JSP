<%@page import="controller.adminTransactionDAO"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.transaksiBeans" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Transaction History - Admin</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/admin.css">
    <style>
        body {
            background-color: #FAF4DB;
        }
        .navbar-brand, .nav-link, .btn-outline-warning {
            color: #FF7D29 !important;
        }
        .table img {
            width: 100px;
            height: auto;
        }
        .btn-tambah-buku {
            position: fixed;
            bottom: 40px;
            right: 20px;
        }
        .custom-dropdown-toggle {
            color: white;
            background-color: white;
            border-radius: 5px;
            margin-right: 40px;
            margin-left: 10px;
            padding: 5px 10px;
        }
        .custom-dropdown-toggle:hover {
            color: #ffc107;
            background-color: #495057;
        }
        .custom-dropdown-menu {
            background-color: #343a40;
            border: none;
        }
        .custom-dropdown-item {
            color: #fff;
        }
        .custom-dropdown-item:hover {
            color: #ffc107;
            background-color: #495057;
        }
        .welcome-message {
            display: inline-flex;
            align-items: center;
            padding-left: 20px;
            margin-left: auto;
        }
        .welcome-text {
            color: white;
            font-size: 30px;
            font-weight: bold;
            margin-left: 30px;
        }
        .username-text {
            color: white;
            font-weight: bold;
            margin-left: 8px;
            font-size: 20px;
        }
        .header {
            background-color: #FF7D29;
            padding: 20px;
            color: white;
            text-align: center;
        }
        .menu {
            position: absolute;
            top: 20px;
            right: 20px;
            color: white;
        }
        .content {
            margin: 20px;
            text-align: center; /* Center align the text */
        }
        .add-book-btn {
            background-color: #EB6611;
            color: white;
            font-weight: bold;
            border: none;
            padding: 10px 20px;
            margin: 20px 0;
            cursor: pointer;
            border-radius: 15px;
        }
        .add-book-btn:hover {
            background-color: #FF4500;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }
        .table th {
            background-color: #FF7D29;
            color: white;
        }
        .action-btn {
            margin: 5px;
        }
        .table-bordered {
            border: 2px solid black;
        }
        .table-bordered th,
        .table-bordered td {
            border: 2px solid black;
        }
        .btn-back {
            background-color: #FF7D29;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }
        .btn-back:hover {
            background-color: #EB6611;
        }
        .title {
            color: black;
        }
        .book-table th, .book-table td {
            background-color: #f8f9fa;
            border: none;
        }
    </style>
</head>
<body>
    <%
        adminTransactionDAO dao = new adminTransactionDAO();
        List<transaksiBeans> transaksiList = dao.getAllTransaksi();
        String username = (String) session.getAttribute("uName");
        boolean isLoggedIn = (username != null);
    %>
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #FF7D29;">
        <% if (isLoggedIn) { %>
            <span class="navbar-text mr-3">
                <span class="welcome-text">Welcome</span>
                <span class="username-text"><%= username %></span>
            </span>
        <% } %>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown"
            aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle custom-dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Menu
                    </a>
                    <div class="dropdown-menu dropdown-menu-right custom-dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                      <a class="dropdown-item custom-dropdown-item" href="index.jsp?user=admin">Home User</a>

                        <a class="dropdown-item custom-dropdown-item" href="admin.jsp">Home Admin</a>
                        <a class="dropdown-item custom-dropdown-item" href="AdminTransactionServlet">Pesanan</a>
                        <a class="dropdown-item custom-dropdown-item" href="logoutServlet">Logout</a>
                    </div>
                </li>
            </ul>
        </div>
    </nav>

    <div class="content">
        <h1 class="title">Pesanan</h1>
        <table class="table table-bordered table-custom">
            <thead>
                <tr>
                    <th rowspan="2">Order ID</th>
                    <th rowspan="2">User ID</th>
                        <th rowspan="2">Nama</th>
                    <th rowspan="2">Payment Method</th>
                    <th colspan="2">Books and Quantities</th>
                    <th rowspan="2">Total Price</th>
                    <th rowspan="2">Order Date</th>
                    <th rowspan="2">Payment Status</th>
                    <th rowspan="2">Payment Proof</th>
                </tr>
                <tr>
                    <th>Book Name</th>
                    <th>Quantity</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (transaksiList != null && !transaksiList.isEmpty()) {
                        for (transaksiBeans transaksi : transaksiList) {
                            String[] bookNames = transaksi.getBookNames().split(", ");
                            String[] quantities = transaksi.getQuantities().split(", ");
                %>
                <tr>
              
                    <td rowspan="<%= bookNames.length %>"><%= transaksi.getOrderId() %></td>
                    <td rowspan="<%= bookNames.length %>"><%= transaksi.getUserId() %></td>
                    <td rowspan="<%= bookNames.length %>"><%= transaksi.getUsername() %></td>
                    <td rowspan="<%= bookNames.length %>"><%= transaksi.getPaymentMethod() %></td>
                    <td><%= bookNames[0] %></td>
                    <td><%= quantities[0] %></td>
                    <td rowspan="<%= bookNames.length %>"><%= transaksi.getTotalPrice() %></td>
                    <td rowspan="<%= bookNames.length %>"><%= transaksi.getOrderDate() %></td>
                    <td rowspan="<%= bookNames.length %>">
                        <form action="AdminTransactionServlet?action=updatePaymentStatus" method="post">
                            <input type="hidden" name="orderId" value="<%= transaksi.getOrderId() %>">
                            <select name="paymentStatus" onchange="this.form.submit()" <%= transaksi.getStatus().equals("gagal") ? "disabled" : "" %> class="select-custom">
                                <option value="belum_bayar" <%= transaksi.getStatus().equals("belum_bayar") ? "selected" : "" %>>Belum Bayar</option>
                                <option value="sudah_bayar" <%= transaksi.getStatus().equals("sudah_bayar") ? "selected" : "" %>>Sudah Bayar</option>
                                <option value="diantar" <%= transaksi.getStatus().equals("diantar") ? "selected" : "" %>>Diantar</option>
                                <option value="diterima" <%= transaksi.getStatus().equals("diterima") ? "selected" : "" %>>Diterima</option>
                                <option value="gagal" <%= transaksi.getStatus().equals("gagal") ? "selected" : "" %>>Gagal</option>
                            </select>
                        </form>
                    </td>
                    <td rowspan="<%= bookNames.length %>">
                        <% if (transaksi.getStatus().equals("sudah_bayar") || transaksi.getStatus().equals("diantar")) { %>
                            <img src="AdminTransactionServlet?action=DisplayPaymentProof&orderId=<%= transaksi.getOrderId() %>" width="100" height="100" />
                        <% } else { %>
                            No Proof Available
                        <% } %>
                    </td>
                </tr>
                <% for (int i = 1; i < bookNames.length; i++) { %>
                <tr>
                    <td><%= bookNames[i] %></td>
                    <td><%= quantities[i] %></td>
                </tr>
                <% } %>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="13">No transactions found</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <a href="admin.jsp" class="btn btn-back">Back to Home</a>
    </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
