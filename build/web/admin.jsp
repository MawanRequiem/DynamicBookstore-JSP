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
    </style>
</head>
<body>
    <%
        // Fetch books from the database
        adminDao dao = new adminDao();
        List<bookBeans> books = dao.getAllBooks();

        String username = (String) session.getAttribute("uName");
        boolean isLoggedIn = (username != null);
    %>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <% if (isLoggedIn) { %>
            <span class="navbar-text mr-3">Welcome <%= username %></span>
        <% } %>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown"
            aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Menu
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                        <a class="dropdown-item" href="#">Jumlah Terjual</a>
                        <a class="dropdown-item" href="#">Sisa Buku</a>
                        <a class="dropdown-item" href="#">Pemesanan</a>
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
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody id="bookTableBody">
                <% for (bookBeans book : books) { %>
                    <tr data-book-id="<%= book.getId() %>">
                        <td>
                            <img src="<%= request.getContextPath() %>/imageServlet?id=<%= book.getId() %>" alt="Book Image">
                        </td>
                        <td><%= book.getNama() %></td>
                        <td><%= book.getHarga() %></td>
                        <td><%= book.getGenre() %></td>
                        <td><%= book.getDeskripsi() %></td>
                        <td><%= book.getStock() %></td>
                        <td>
                            <button class="btn btn-warning btn-edit">Edit</button>
                            <button class="btn btn-danger btn-delete">Delete</button>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <!-- Button to open the modal form -->
    <button class="btn btn-warning btn-tambah-buku" data-toggle="modal" data-target="#tambahBukuModal">Tambah Buku +</button>

    <!-- Modal for adding a new book -->
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
                    <form id="tambahBukuForm" action="adminServlet" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="gambarBuku">Gambar Buku</label>
                            <input type="file" class="form-control-file" id="gambarBuku" name="gambarBuku" accept="image/*" required>
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
                        <input type="hidden" id="bookId" name="bookId">
                        <button type="submit" class="btn btn-primary" id="submitButton">Tambah</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script>
        document.getElementById('tambahBukuForm').addEventListener('submit', function(event) {
            event.preventDefault();
            var formData = new FormData(this);

            fetch('adminServlet', {
                method: 'POST',
                body: formData
            })
            .then(response => response.text())
            .then(result => {
                if (result.trim() === 'success') {
                    location.reload();
                } else {
                    alert('Failed to add/update book.');
                }
            })
            .catch(error => console.error('Error:', error));
        });

        document.getElementById('bookTableBody').addEventListener('click', function(event) {
            if (event.target.classList.contains('btn-delete')) {
                var row = event.target.closest('tr');
                var bookId = row.dataset.bookId;

                fetch('adminServlet?action=delete&bookId=' + bookId, {
                    method: 'GET'
                })
                .then(response => response.text())
                .then(result => {
                    if (result.trim() === 'success') {
                        row.remove();
                    } else {
                        alert('Failed to delete book.');
                    }
                })
                .catch(error => console.error('Error:', error));
            } else if (event.target.classList.contains('btn-edit')) {
                var row = event.target.closest('tr');
                var cells = row.cells;
                var bookId = row.dataset.bookId;

                document.getElementById('gambarBuku').value = ''; // Reset file input
                document.getElementById('namaBuku').value = cells[1].textContent;
                document.getElementById('hargaBuku').value = cells[2].textContent;
                document.getElementById('genreBuku').value = cells[3].textContent;
                document.getElementById('deskripsiBuku').value = cells[4].textContent;
                document.getElementById('stockBuku').value = cells[5].textContent;
                document.getElementById('bookId').value = bookId;
                document.getElementById('submitButton').textContent = 'Update';

                $('#tambahBukuModal').modal('show');
            }
        });
    </script>
</body>
</html>
