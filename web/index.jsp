<%@ page import="controller.BookDAO, model.bookBeans, java.sql.Connection, java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="db.db" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    db dbInstance = new db();
    Connection connection = dbInstance.getConnection();
    BookDAO bookDAO = new BookDAO();
    List<bookBeans> books = bookDAO.getAllBooks();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        var counter = 1;
        setInterval(() => {
            document.getElementById('radio' + counter).checked = true;
            counter++;
            if(counter > 3){
                counter = 1;
            }
        }, 30000); // Ubah gambar setiap 30 detik

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
    </script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic&display=swap');
        body, html {
            font-family: 'Zen Maru Gothic', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #FFFFEF;
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
        
        nav {
            margin-bottom: 0;
        }

        .slider {
            width: 100%;
            height: 100vh;
            overflow: hidden;
            position: relative;
        }

        .slides {
            display: flex;
            width: 300%;
            height: 100%;
        }

        .slides input {
            display: none;
        }

        .slide {
            width: 33.3333%;
            transition: margin-left 0.7s;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 0;
        }

        .navigation-auto {
            position: absolute;
            width: 100%;
            margin-top: -40px;
            display: flex;
            justify-content: center;
        }

        .auto-btn1, .auto-btn2, .auto-btn3 {
            border: 2px solid #fff;
            padding: 5px;
            border-radius: 50%;
            cursor: pointer;
            transition: 0.4s;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .auto-btn1:hover, .auto-btn2:hover, .auto-btn3:hover {
            background: #fff;
        }

        #radio1:checked ~ .first {
            margin-left: 0;
        }

        #radio2:checked ~ .first {
            margin-left: -33.3333%;
        }

        #radio3:checked ~ .first {
            margin-left: -66.6667%;
        }

        .manual-btn {
            border: 2px solid #fff;
            padding: 5px;
            border-radius: 50%;
            cursor: pointer;
            transition: 0.4s;
            display: inline-block;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .manual-btn:hover {
            background: #fff;
        }

        .navigation-manual {
            position: absolute;
            bottom: 20px;
            width: 100%;
            display: flex;
            justify-content: center;
            z-index: 1000;
        }

        .genre-icon {
            width: 100%;
            padding: 20px 0;
            background-color: #FFFFEF;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .column {
            flex: 0 0 30%;
            max-width: 30%;
            margin: 10px;
            text-align: center;
        }

        .icons {
            margin: 10px;
            text-align: center;
            color: black;
            text-decoration: none;
        }

        .icons img {
            width: 100%;
            height: auto;
        }

        .icons:hover {
            background-color: #FFF;
            color: #000;
        }

        .carousel-main-div1 {
            background-color: #FFFFEF;
            padding: 20px;
            margin-bottom: 20px;
        }

        .carousel-main-div1 img {
            height: 60%;
        }

        .price {
            font-size: 30%;
        }

        .carousel-main-div1 h3 {
            height: 15%;
        }

        .prev-main, .next-main {
            background-color: #555;
            color: white;
            border: none;
            cursor: pointer;
            padding: 10px 15px;
            font-size: 18px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .prev-main:hover, .next-main:hover {
            background-color: #333;
        }

        .carousel-main {
            position: relative;
        }

        .card-best, .card-new {
            min-width: 200px;
            margin: 10px;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            background-color: #FFFFEF;
            text-align: center;
            cursor: pointer;
            transition: transform 0.3s ease;
            position: relative;
        }

        .icons h3 {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .icons h3:hover {
            text-decoration: none;
        }
    </style>
    <title>Tere Liye Bookstore</title>
</head>
<body>
    <%@ include file="header.jsp" %>
    <!-- Slideshow container -->
    <div class="slider">
        <div class="slides">
            <input type="radio" name="radio-btn" id="radio1" checked>
            <input type="radio" name="radio-btn" id="radio2">
            <input type="radio" name="radio-btn" id="radio3">

            <div class="slide first">
                <img src="image/BEST OF TERE LIYE1.png" alt="Slide 1">
            </div>

            <div class="slide">
                <img src="image/BEST OF TERE LIYE 2.png" alt="Slide 2">
            </div>

            <div class="slide">
                <img src="image/BEST OF TERE LIYE 3.png" alt="Slide 3">
            </div>

            <div class="navigation-auto">
                <div class="auto-btn1"></div>
                <div class="auto-btn2"></div>
                <div class="auto-btn3"></div>
            </div>
        </div>

        <div class="navigation-manual">
            <label for="radio1" class="manual-btn"></label>
            <label for="radio2" class="manual-btn"></label>
            <label for="radio3" class="manual-btn"></label>
        </div>
    </div>

    <!-- Section genre-icon -->
    <section class="genre-icon">
        <a href="aksiSeries.jsp">
            <div class="icons">
                <img src="image/Serial Aksi/pulang.jpeg" alt="Book Icon">
                <div>
                    <h3>Serial Aksi</h3>
                </div>
            </div>
        </a>
        <a href="duniaParalelSeries.jsp">
            <div class="icons">
                <img src="image/dunia paralel/bumi.jpg" alt="Book Icon">
                <div>
                    <h3>Serial Dunia Paralel</h3>
                </div>
            </div>
        </a>
        <a href="anakSeries.jsp">
            <div class="icons">
                <img src="image/serial anak/anak spesial.jpeg" alt="Book Icon">
                <div>
                    <h3>Serial Anak Nusantara</h3>
                </div>
            </div>
        </a>
        <a href="gogonSeries.jsp">
            <div class="icons">
                <img src="image/gogons/1.jpg" alt="Book Icon">
                <div>
                    <h3>Serial The Gogons</h3>
                </div>
            </div>
        </a>
        <a href="nonSeries.jsp">
            <div class="icons">
                <img src="image/non seri/teruslahbodoh.jpg" alt="Book Icon">
                <div>
                    <h3>Novel non-serial</h3>
                </div>
            </div>
        </a>
        <a href="cerpen.jsp">
            <div class="icons">
                <img src="image/cerpen/berjutarasa.jpg" alt="Book Icon">
                <div>
                    <h3>Kumpulan Cerpen</h3>
                </div>
            </div>
        </a>
    </section>

    <!-- Best Seller Section -->
    <h1 class="heading"> <span>Best Seller</span> </h1>

    <div class="carousel-main-div1" id="carousel1">
        <div class="carousel-main">
            <div class="carousel-slide-best">
                <% for (bookBeans book : books) { %>
                <a href="#" class="card-best <%= book.getStock() <= 0 ? "out-of-stock" : "" %>" onclick="openModal(event, '<%= book.getId() %>', '<%= book.getNama() %>', '<%= book.getHarga() %>', '<%= book.getGenre() %>', '<%= book.getDeskripsi() %>', 'imageServlet?id=<%= book.getId() %>', '<%= book.getStock() %>')">
                    <img src="imageServlet?id=<%= book.getId() %>" alt="<%= book.getNama() %>">
                    <h3><%= book.getNama() %></h3>
                    <p><%= book.getGenre() %></p>
                    <p>Stock buku: <%= book.getStock() %> item</p>
                    <span class="price">Rp <%= book.getHarga() %></span>
                </a>
                <% } %>
            </div>
            <div>
                <button class="prev-main" onclick="moveSlideBest(-1)">&#10094;</button>
                <button class="next-main" onclick="moveSlideBest(1)">&#10095;</button>
            </div>
        </div>
    </div>

    <!-- New Release Section -->
    <h1 class="heading"> <span>New Release</span> </h1>

    <div class="carousel-main-div1" id="carousel2">
        <div class="carousel-main">
            <div class="carousel-slide-new">
                <% for (bookBeans book : books) { %>
                <a href="#" class="card-new <%= book.getStock() <= 0 ? "out-of-stock" : "" %>" onclick="openModal(event, '<%= book.getId() %>', '<%= book.getNama() %>', '<%= book.getHarga() %>', '<%= book.getGenre() %>', '<%= book.getDeskripsi() %>', 'imageServlet?id=<%= book.getId() %>', '<%= book.getStock() %>')">
                    <img src="imageServlet?id=<%= book.getId() %>" alt="<%= book.getNama() %>">
                    <h3><%= book.getNama() %></h3>
                    <p><%= book.getGenre() %></p>
                    <p>Stock buku: <%= book.getStock() %> item</p>
                    <span class="price">Rp <%= book.getHarga() %></span>
                </a>
                <% } %>
            </div>
            <div>
                <button class="prev-main" onclick="moveSlideNew(-1)">&#10094;</button>
                <button class="next-main" onclick="moveSlideNew(1)">&#10095;</button>
            </div>
        </div>
    </div>

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

    <%@ include file="footer.jsp" %>

    <script type="text/javascript" src="javascript/script.js"></script>
</body>
</html>
