<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.bookBeans" %>
<%@ page import="controller.adminDao" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Page</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/admin.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar-brand, .nav-link, .btn-outline-warning {
            color: #ffc107 !important;
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
    color: #ffc107; /* Warna teks menu dropdown */
    background-color: #343a40; /* Warna latar belakang menu dropdown */
    border-radius: 5px; /* Menambahkan sudut membulat pada tombol dropdown */
    margin-right: 40px; /* Menambahkan margin kanan */
    margin-left: 10px; /* Menambahkan margin kiri */
    padding: 5px 10px; /* Menambahkan padding agar lebih seimbang */
}

.custom-dropdown-toggle:hover {
    color: #ffc107; /* Warna teks saat hover */
    background-color: #495057; /* Warna latar belakang saat hover */
}

.custom-dropdown-menu {
    background-color: #343a40; /* Warna latar belakang dropdown menu */
    border: none; /* Menghilangkan border */
}

.custom-dropdown-item {
    color: #fff; /* Warna teks item dropdown */
}

.custom-dropdown-item:hover {
    color: #ffc107; /* Warna teks saat hover pada item */
    background-color: #495057; /* Warna latar belakang saat hover pada item */
}

/* Styling untuk pesan selamat datang */
/* Styling untuk pesan selamat datang */
.welcome-message {
    display: inline-flex; /* Membuat elemen-anak di dalamnya sejajar secara horizontal */
    align-items: center; /* Memastikan elemen-anak sejajar di tengah secara vertikal */
    padding-left: 20px; /* Menambahkan padding kiri */
    margin-left: auto; /* Mendorong elemen ke kanan */
}

/* Styling untuk teks 'Welcome' */
.welcome-text {
    color: white; /* Warna teks putih */
}

/* Styling untuk teks username */
.username-text {
    color: #ffc107;/* Warna teks kuning */
    font-weight: bold; /* Menambahkan sedikit penekanan pada username */
    margin-left: 8px; /* Memberikan sedikit jarak antara 'Welcome' dan username */
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

  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <% if (isLoggedIn) { %>
        <span class="navbar-text mr-3">
            <span style="color: white;">Welcome </span>
            <span style="color: #ffc107;"><%= username %></span>
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
                <a class="dropdown-item custom-dropdown-item" href="AdminTransactionServlet">Jumlah Terjual</a>
                <a class="dropdown-item custom-dropdown-item" href="#">Sisa Buku</a>
                <a class="dropdown-item custom-dropdown-item" href="#">Pesanan</a>
                   <a class="dropdown-item custom-dropdown-item" href="logoutServlet">Logout</a>
            </div>
        </li>
    </ul>
</div>
</nav>


    <div class="container mt-4">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Gambar Buku</th>
                    <th>Nama Buku</th>
                    <th>Harga Buku</th>
                    <th>Genre Buku</th>
                    <th>Deskripsi Buku</th>
                    <th>Stock Buku</th>
             
                </tr>
            </thead>
            <tbody>
                <% for (bookBeans book : books) { %>
                    <tr>
                        <td>
                            <img src="<%= request.getContextPath() %>/imageServlet?id=<%= book.getId() %>" alt="Book Image">
                        </td>
                        <td><%= book.getNama() %></td>
                        <td><%= book.getHarga() %></td>
                        <td><%= book.getGenre() %></td>
                        <td><%= book.getDeskripsi() %></td>
                        <td><%= book.getStock() %></td>
                        <td>
                            <form action="adminServlet" method="post" style="display: inline-block;">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="bookId" value="<%= book.getId() %>">
                                <button type="submit" class="btn btn-warning">Edit</button>
                            </form>
                            <form action="adminServlet" method="post" style="display: inline-block;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="bookId" value="<%= book.getId() %>">
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <button class="btn btn-warning btn-tambah-buku" data-toggle="modal" data-target="#tambahBukuModal">Tambah Buku +</button>

    <!-- Tambah Buku Modal -->
    <div class="modal fade" id="tambahBukuModal" tabindex="-1" role="dialog" aria-labelledby="tambahBukuModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="tambahBukuModalLabel">Tambah Buku</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="adminServlet" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="add">
                        <div class="form-group">
                            <label for="gambarBuku">Gambar Buku</label>
                            <input type="file" class="form-control-file" id="gambarBuku" name="gambarBuku" accept="image/*">
                        </div>
                        <div class="form-group">
                            <label for="namaBuku">Nama Buku</label>
                            <input type="text" class="form-control" id="namaBuku" name="namaBuku" required>
                        </div>
                        <div class="form-group">
                            <label for="hargaBuku">Harga Buku</label>
                            <input type="number" class="form-control" id="hargaBuku" name="hargaBuku" required>
                        </div>
                        <div class="form-group">
                            <label for="genreBuku">Genre Buku</label>
                            <input type="text" class="form-control" id="genreBuku" name="genreBuku" required>
                        </div>
                        <div class="form-group">
                            <label for="deskripsiBuku">Deskripsi Buku</label>
                            <textarea class="form-control" id="deskripsiBuku" name="deskripsiBuku" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="stockBuku">Stock Buku</label>
                            <input type="number" class="form-control" id="stockBuku" name="stockBuku" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Tambah</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
