<%-- 
    Document   : aksiSeries
    Created on : Jul 5, 2024, 10:14:42 AM
    Author     : Arya Prathama
--%>
<%@ page import="controller.BookDAO, model.bookBeans, java.sql.Connection, java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="db.db" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    db dbInstance = new db();
    Connection connection = dbInstance.getConnection();
    BookDAO bookDAO = new BookDAO();
    List<bookBeans> books = bookDAO.getAllBooks();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
       <link rel="stylesheet" href="css/style.css">
           <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
            .book-detail img{
            width: 140px;
        }
        #modal-img{
            width: 180px;
        }
    </style>
    <script src="jQuery 3.7.1.js"></script>
    <title>Tere Liye Bookstore</title>
</head>
<body>
  <%@ include file="header.jsp" %>

   <section>
        <div id="head-fantasy">
            <h2 class="heading">
                <span>Serial Aksi</span>
            </h2>
            <p class="series-description">Serial Aksi karya Tere Liye adalah serangkaian novel yang menggabungkan elemen petualangan, fantasi, dan aksi. Serial ini menonjol dengan cerita yang kaya akan imajinasi, karakter-karakter yang kuat, serta alur yang menarik dan penuh kejutan. Serial Aksi terdiri dari beberapa buku yang saling berhubungan, masing-masing memiliki cerita yang mendalam dan karakter-karakter unik.</p>
        </div>
        <div class="book-details-container">
            <% for (bookBeans book : books) { 
                if (book.getSerial().equals("aksi")) { %>
                <a class="book-detail" href="#" onclick="openModal(event, '<%= book.getId() %>', '<%= book.getNama() %>', ' <%= book.getHarga() %>', '<%= book.getGenre() %>', '<%= book.getDeskripsi() %>', 'imageServlet?id=<%= book.getId() %>', 'book-page/<%= book.getId() %>.html')">
                    <img src="imageServlet?id=<%= book.getId() %>" alt="<%= book.getNama() %>">
                    <div class="book-info">
                        <h3><%= book.getNama() %></h3>
                        <p><%= book.getGenre() %></p>
                        <p><%= book.getDeskripsi() %></p>
                    </div>
                </a>
            <% } } %>
        </div>
    </section>


  <div id="modal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <img id="modal-img" src="" alt="Book Image">
            <h2 id="modal-title">Book Title</h2>
            <p id="modal-author">Author</p>
            <p id="modal-price">Price</p>
            <p id="modal-genre">Genre</p>
            <p id="modal-synopsis">Synopsis</p>
            <form id="modal-form" action="<%=request.getContextPath()%>/AddToCartServlet" method="post">
                <input type="hidden" id="modal-book-id" name="bookId">
                <input type="hidden" id="modal-book-name" name="bookName">
                <input type="hidden" id="modal-book-price" name="bookPrice">
                <button type="submit">Add to Cart</button>
            </form>
        </div>
    </div>
    </section>


    <!-- JavaScript -->
    <script>
       $(document).ready(function(){
        var showCartNotification = '<%= session.getAttribute("showCartNotification") %>';
        if (showCartNotification === 'true') {
            $('#cartModal').modal('show');
            <% session.setAttribute("showCartNotification", false); %>
        }
    });

    function openModal(event, id, title, price, genre, synopsis, imgSrc) {
        event.preventDefault();
        const modal = document.getElementById('modal');
        document.getElementById('modal-title').innerText = title;
        document.getElementById('modal-price').innerText = 'Rp ' + price;
        document.getElementById('modal-genre').innerText = genre;
        document.getElementById('modal-synopsis').innerText = synopsis;
        document.getElementById('modal-img').src = imgSrc;
        document.getElementById('modal-book-id').value = id;
        document.getElementById('modal-book-name').value = title;
        document.getElementById('modal-book-price').value = price;
        modal.style.display = "block";
    }

    function closeModal() {
        document.getElementById('modal').style.display = "none";
    }
    </script>

  
  <%@ include file="footer.jsp" %>
    <script type="text/javascript" src="javascript/script.js"></script>
</body>
</html>