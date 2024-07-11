<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.bookBeans" %>
<%@ page import="java.util.List" %>
<%@ page import="model.transaksiBeans" %>
<%@ page import="controller.adminDao" %>
<%@ page import="model.bookBeans" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Book</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
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
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle custom-dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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

<div class="container mt-4">
    <h1>Edit Book</h1>
    <%
        bookBeans book = (bookBeans) request.getAttribute("book");
    %>
    <form action="adminServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="bookId" value="<%= book.getId() %>">
        <div class="form-group">
            <label for="gambarBuku">Gambar Buku</label>
            <input type="file" class="form-control-file" id="gambarBuku" name="gambarBuku" accept="image/*" >
        </div>
        <div class="form-group">
            <label for="namaBuku">Nama Buku</label>
            <input type="text" class="form-control" id="namaBuku" name="namaBuku" value="<%= book.getNama() %>" required>
        </div>
        <div class="form-group">
            <label for="hargaBuku">Harga Buku</label>
            <input type="number" class="form-control" id="hargaBuku" name="hargaBuku" value="<%= book.getHarga() %>" required>
        </div>
        <div class="form-group">
            <label for="genreBuku">Genre Buku</label>
            <select class="form-control" id="genreBuku" name="genreBuku" required>
                <option value="">Pilih Genre</option>
                <option value="Action" <%= "Action".equals(book.getGenre()) ? "selected" : "" %>>Action</option>
                    <option value="Adventure" <%= "Adventure".equals(book.getGenre()) ? "selected" : "" %>>Adventure</option>
                <option value="Romance" <%= "Romance".equals(book.getGenre()) ? "selected" : "" %>>Romance</option>
                <option value="Family" <%= "Family".equals(book.getGenre()) ? "selected" : "" %>>Family</option>
                <option value="Fantasy" <%= "Fantasy".equals(book.getGenre()) ? "selected" : "" %>>Fantasy</option>
            </select>
        </div>
        <div class="form-group">
            <label for="serialBuku">Serial Buku</label>
            <select class="form-control" id="serialBuku" name="serialBuku" required>
                <option value="">Pilih Serial</option>
                <option value="cerpen" <%= "cerpen".equals(book.getSerial()) ? "selected" : "" %>>Cerpen</option>
                <option value="duniaParalel" <%= "duniaParalel".equals(book.getSerial()) ? "selected" : "" %>>Dunia Paralel</option>
                <option value="gogons" <%= "gogons".equals(book.getSerial()) ? "selected" : "" %>>Gogons</option>
                <option value="nonSeri" <%= "nonSeri".equals(book.getSerial()) ? "selected" : "" %>>Non Serial</option>
                <option value="aksi" <%= "aksi".equals(book.getSerial()) ? "selected" : "" %>>Serial Aksi</option>
                <option value="anak" <%= "anak".equals(book.getSerial()) ? "selected" : "" %>>Serial Anak</option>
            </select>
        </div>
        <div class="form-group">
            <label for="deskripsiBuku">Deskripsi Buku</label>
            <textarea class="form-control" id="deskripsiBuku" name="deskripsiBuku" rows="3" required><%= book.getDeskripsi() %></textarea>
        </div>
        <div class="form-group">
            <label for="stockBuku">Stock Buku</label>
            <input type="number" class="form-control" id="stockBuku" name="stockBuku" value="<%= book.getStock() %>" required>
        </div>
        <button type="submit" class="btn btn-primary">Update Book</button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
