<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.transaksiBeans" %>
<%@ page import="java.util.List"%>
<%@ page import="model.bookBeans"%>
<%@ page import="controller.adminDao"%>
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
        /* Modal Styles */
        .modal-content {
            border-radius: 10px;
            padding: 20px;
            background-color: #fffbe6;
            border: 2px solid #ff8800;
        }
        .modal-header {
            border-bottom: none;
        }
        .modal-title {
            color: #ff8800;
            font-weight: bold;
        }
        .close {
            font-size: 1.5rem;
            color: #ff8800;
        }
        .form-group label {
            font-weight: bold;
            color: #ff8800;
        }
        .form-control, .form-control-file {
            border: 2px solid #ff8800;
            border-radius: 10px;
            padding: 10px;
            background-color: #fffbe6;
        }
        textarea.form-control {
            resize: none;
        }
        .btn-primary {
            background-color: #ff8800;
            border: none;
            border-radius: 20px;
            padding: 10px 20px;
            font-weight: bold;
            color: white;
            cursor: pointer;
        }
        .btn-primary:hover {
            background-color: #e07b00;
        }
        .btn-primary:focus {
            outline: none;
            box-shadow: none;
        }
        .form-group select {
            width: 100%;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 1em;
            text-align: left;
            background-color: #FAF4DB;
        }
        th, td {
            padding: 12px 15px;
        }
        th {
            background-color: #FF7D29;
            color: white;
        }
        tr:nth-of-type(even) {
            background-color: #f3f3f3;
        }
        tr:hover {
            background-color: #ddd;
        }
        .centered {
            display: flex;
            justify-content: center;
            align-items: center;
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
    </style>
</head>
<body>
    <%
        adminDao dao = new adminDao();
        List<bookBeans> books = dao.getAllBooks();
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
                        <a class="dropdown-item custom-dropdown-item" href="admin.jsp">Home</a>
                        <a class="dropdown-item custom-dropdown-item" href="AdminTransactionServlet">Pesanan</a>
                        <a class="dropdown-item custom-dropdown-item" href="logoutServlet">Logout</a>
                    </div>
                </li>
            </ul>
        </div>
    </nav>

    <div class="content">
        <h1 class="title">Pesanan</h1>
        <table class="table table-bordered">
            <tr>
                <th>Book Name</th>
                <th>Username</th>
                <th>Buyer Name</th>
                <th>Book Price</th>
                <th>Date</th>
                <th>Quantity</th>
                <th>Email</th>
                <th>Address</th>
                <th>Payment</th>
            </tr>
            <%
                List<transaksiBeans> transaksiList = (List<transaksiBeans>) request.getAttribute("transaksiList");
                if (transaksiList != null) {
                    for (transaksiBeans transaksi : transaksiList) {
            %>
                        <tr>
                            <td><%= transaksi.getNameBuku() %></td>
                            <td><%= transaksi.getNamaUser() %></td>
                            <td><%= transaksi.getNamaPembeli() %></td>
                            <td><%= transaksi.getHargaBuku() %></td>
                            <td><%= transaksi.getTanggal() %></td>
                            <td><%= transaksi.getJumlah() %></td>
                            <td><%= transaksi.getEmail() %></td>
                            <td><%= transaksi.getAlamat() %></td>
                            <td><%= transaksi.getMetodePem() %></td>
                        </tr>
            <%
                    }
                }
            %>
        </table>
  
    </div>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
