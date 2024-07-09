<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.bookBeans" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Book</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h1>Edit Book</h1>
        <%
            bookBeans book = (bookBeans) request.getAttribute("book");
        %>
        <form action="adminServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="bookId" value="<%= book.getId() %>">
            <div class="form-group">
                <label for="editGambarBuku">Gambar Buku</label>
                <input type="file" class="form-control-file" id="editGambarBuku" name="gambarBuku" accept="image/*">
            </div>
            <div class="form-group">
                <label for="editNamaBuku">Nama Buku</label>
                <input type="text" class="form-control" id="editNamaBuku" name="namaBuku" value="<%= book.getNama() %>" required>
            </div>
            <div class="form-group">
                <label for="editHargaBuku">Harga Buku</label>
                <input type="number" class="form-control" id="editHargaBuku" name="hargaBuku" value="<%= book.getHarga() %>" required>
            </div>
            <div class="form-group">
                <label for="editGenreBuku">Genre Buku</label>
                <input type="text" class="form-control" id="editGenreBuku" name="genreBuku" value="<%= book.getGenre() %>" required>
            </div>
            <div class="form-group">
                <label for="editDeskripsiBuku">Deskripsi Buku</label>
                <textarea class="form-control" id="editDeskripsiBuku" name="deskripsiBuku" required><%= book.getDeskripsi() %></textarea>
            </div>
            <div class="form-group">
                <label for="editStockBuku">Stock Buku</label>
                <input type="number" class="form-control" id="editStockBuku" name="stockBuku" value="<%= book.getStock() %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
    </div>
</body>
</html>
