<%-- 
    Document   : allbook
    Created on : Jul 1, 2024, 9:30:15 AM
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
    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic&display=swap');
        html, body {
            font-family: Zen Maru Gothic;
            background-color: #FFFFEF;
        }
        .book-item img {
            width: 180px;
        }
        #modal-img {
            width: 180px;
        }
      .out-of-stock {
            background-color: gray;
            pointer-events: none;
            cursor: not-allowed;
            position: relative;
            opacity: 0.6;
        }
        
        .out-of-stock::after {
            content: "SOLD OUT";
            color: red;
            font-size: 20px;
            font-weight: bold;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(255, 255, 255, 0.8);
            padding: 5px;
        }
    </style>
    <title>Tere Liye Bookstore</title>
</head>
<body>
    <%@ include file="header.jsp" %>

    <section class="best-seller" id="best-seller">
        <h1 class="heading"><span>Action</span></h1>
        <div class="carousel-container" id="carousel-action">
            <button class="carousel-button prev" onclick="plusSlidesAllBook('carousel-action', -1)">‹</button>
            <div class="carousel-slide">
                <div class="book-list">
                    <% for (bookBeans book : books) { 
                        if (book.getGenre().equals("Action")) { %>
                        <a href="#" class="book-item <%= book.getStock() <= 0 ? "out-of-stock" : "" %>" onclick="openModal(event, '<%= book.getId() %>', '<%= book.getNama() %>', '<%= book.getHarga() %>', '<%= book.getGenre() %>', '<%= book.getDeskripsi() %>', 'imageServlet?id=<%= book.getId() %>', '<%= book.getStock() %>')">
                            <img src="imageServlet?id=<%= book.getId() %>" alt="<%= book.getNama() %>">
                            <h2><%= book.getNama() %></h2>
                            <p>Rp <%= book.getHarga() %></p>
                            <p class="genre">Genre: <%= book.getGenre() %></p>
                            <p>Stock: <%= book.getStock() %> items</p>
                        </a>
                    <% } } %>
                </div>
            </div>
            <button class="carousel-button next" onclick="plusSlidesAllBook('carousel-action', 1)">›</button>
        </div>

        <h1 class="heading"><span>Adventure</span></h1>
        <div class="carousel-container" id="carousel-adventure">
            <button class="carousel-button prev" onclick="plusSlidesAllBook('carousel-adventure', -1)">‹</button>
            <div class="carousel-slide">
                <div class="book-list">
                    <% for (bookBeans book : books) { 
                        if (book.getGenre().equals("Adventure")) { %>
                        <a href="#" class="book-item <%= book.getStock() <= 0 ? "out-of-stock" : "" %>" onclick="openModal(event, '<%= book.getId() %>', '<%= book.getNama() %>', '<%= book.getHarga() %>', '<%= book.getGenre() %>', '<%= book.getDeskripsi() %>', 'imageServlet?id=<%= book.getId() %>', '<%= book.getStock() %>')">
                            <img src="imageServlet?id=<%= book.getId() %>" alt="<%= book.getNama() %>">
                            <h2><%= book.getNama() %></h2>
                            <p>Rp <%= book.getHarga() %></p>
                            <p class="genre">Genre: <%= book.getGenre() %></p>
                            <p>Stock: <%= book.getStock() %> items</p>
                        </a>
                    <% } } %>
                </div>
            </div>
            <button class="carousel-button next" onclick="plusSlidesAllBook('carousel-adventure', 1)">›</button>
        </div>

        <h1 class="heading"><span>Romance</span></h1>
        <div class="carousel-container" id="carousel-romance">
            <button class="carousel-button prev" onclick="plusSlidesAllBook('carousel-romance', -1)">‹</button>
            <div class="carousel-slide">
                <div class="book-list">
                    <% for (bookBeans book : books) { 
                        if (book.getGenre().equals("Romance")) { %>
                        <a href="#" class="book-item <%= book.getStock() <= 0 ? "out-of-stock" : "" %>" onclick="openModal(event, '<%= book.getId() %>', '<%= book.getNama() %>', '<%= book.getHarga() %>', '<%= book.getGenre() %>', '<%= book.getDeskripsi() %>', 'imageServlet?id=<%= book.getId() %>', '<%= book.getStock() %>')">
                            <img src="imageServlet?id=<%= book.getId() %>" alt="<%= book.getNama() %>">
                            <h2><%= book.getNama() %></h2>
                            <p>Rp <%= book.getHarga() %></p>
                            <p class="genre">Genre: <%= book.getGenre() %></p>
                            <p>Stock: <%= book.getStock() %> items</p>
                        </a>
                    <% } } %>
                </div>
            </div>
            <button class="carousel-button next" onclick="plusSlidesAllBook('carousel-romance', 1)">›</button>
        </div>

        <h1 class="heading"><span>Family</span></h1>
        <div class="carousel-container" id="carousel-family">
            <button class="carousel-button prev" onclick="plusSlidesAllBook('carousel-family', -1)">‹</button>
            <div class="carousel-slide">
                <div class="book-list">
                    <% for (bookBeans book : books) { 
                        if (book.getGenre().equals("Family")) { %>
                        <a href="#" class="book-item <%= book.getStock() <= 0 ? "out-of-stock" : "" %>" onclick="openModal(event, '<%= book.getId() %>', '<%= book.getNama() %>', '<%= book.getHarga() %>', '<%= book.getGenre() %>', '<%= book.getDeskripsi() %>', 'imageServlet?id=<%= book.getId() %>', '<%= book.getStock() %>')">
                            <img src="imageServlet?id=<%= book.getId() %>" alt="<%= book.getNama() %>">
                            <h2><%= book.getNama() %></h2>
                            <p>Rp <%= book.getHarga() %></p>
                            <p class="genre">Genre: <%= book.getGenre() %></p>
                            <p>Stock: <%= book.getStock() %> items</p>
                        </a>
                    <% } } %>
                </div>
            </div>
            <button class="carousel-button next" onclick="plusSlidesAllBook('carousel-family', 1)">›</button>
        </div>

        <h1 class="heading"><span>Fantasy</span></h1>
        <div class="carousel-container" id="carousel-fantasy">
            <button class="carousel-button prev" onclick="plusSlidesAllBook('carousel-fantasy', -1)">‹</button>
            <div class="carousel-slide">
                <div class="book-list">
                    <% for (bookBeans book : books) { 
                        if (book.getGenre().equals("Fantasy")) { %>
                        <a href="#" class="book-item <%= book.getStock() <= 0 ? "out-of-stock" : "" %>" onclick="openModal(event, '<%= book.getId() %>', '<%= book.getNama() %>', '<%= book.getHarga() %>', '<%= book.getGenre() %>', '<%= book.getDeskripsi() %>', 'imageServlet?id=<%= book.getId() %>', '<%= book.getStock() %>')">
                            <img src="imageServlet?id=<%= book.getId() %>" alt="<%= book.getNama() %>">
                            <h2><%= book.getNama() %></h2>
                            <p>Rp <%= book.getHarga() %></p>
                            <p class="genre">Genre: <%= book.getGenre() %></p>
                            <p>Stock: <%= book.getStock() %> items</p>
                        </a>
                    <% } } %>
                </div>
            </div>
            <button class="carousel-button next" onclick="plusSlidesAllBook('carousel-fantasy', 1)">›</button>
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
            <p id="modal-stock">Stock buku: </p>
            <form id="modal-form" action="<%=request.getContextPath()%>/AddToCartServlet" method="post">
                <input type="hidden" id="modal-book-id" name="bookId">
                <input type="hidden" id="modal-book-name" name="bookName">
                <input type="hidden" id="modal-book-price" name="bookPrice">
                <button type="submit" id="modal-add-to-cart">Add to Cart</button>
            </form>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        $(document).ready(function(){
            var showCartNotification = '<%= session.getAttribute("showCartNotification") %>';
            if (showCartNotification === 'true') {
                $('#cartModal').modal('show');
                <% session.setAttribute("showCartNotification", false); %>
            }
        });

         function openModal(event, id, title, price, genre, synopsis, imgSrc, stock) {
            event.preventDefault();
            if (stock <= 0) return; // Prevent modal for out of stock books

            const modal = document.getElementById('modal');
            document.getElementById('modal-title').innerText = title;
            document.getElementById('modal-price').innerText = 'Rp ' + price;
            document.getElementById('modal-genre').innerText = genre;
            document.getElementById('modal-synopsis').innerText = synopsis;
            document.getElementById('modal-img').src = imgSrc;
            document.getElementById('modal-book-id').value = id;
            document.getElementById('modal-book-name').value = title;
            document.getElementById('modal-book-price').value = price;
            document.getElementById('modal-stock').innerText = 'Stock buku: ' + stock + ' item';
            if (stock > 0) {
                document.getElementById('modal-add-to-cart').disabled = false;
            } else {
                document.getElementById('modal-add-to-cart').disabled = true;
            }
            modal.style.display = "block";
        }

        function closeModal() {
            document.getElementById('modal').style.display = "none";
        }
        window.onclick = function(event) {
            const modal = document.getElementById('modal');
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
    <script type="text/javascript" src="javascript/script.js"></script>
    <%@ include file="footer.jsp" %>
</body>
</html>
