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
    }, 5000);
    
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
    <style>
        .carousel-slide-new, .carousel-slide-best{
            margin: 50px;
        }
        #modal-img{
            width: 180px;
        }

        .card-best img, .card-new img{
            width: 180px;
            height: 280px;
        }

        /* CAROUSEL CSS */
        .slider {
            width: 100%;
            height: 900px; 
            overflow: hidden;
            position: relative; /* Add this to position manual buttons */
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
            transition: 0.7s;
            height: 100%;
            display: flex;
            justify-content: center;
        }

        .slide img {
            width: 80%; /* reduce image width */
            height: 80%; /* reduce image height */
            object-fit: cover; /* maintain aspect ratio */
            border-radius: 30px;
        }

        .navigation-auto {
            position: absolute;
            width: 100%;
            margin-top: -40px;
            display: flex;
            justify-content: center;
        }

        .auto-btn1:hover, .auto-btn2:hover, .auto-btn3:hover{
            opacity: 1;
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
            background-color: rgba(0, 0, 0, 0.5); /* Make the buttons more noticeable */
            color: #fff; /* Change text color for better visibility */
        }

        .manual-btn:hover {
            background: #fff;
            color: #000; /* Change color on hover */
        }

        .manual-btn::before {
            content: attr();
            font-size: 16px;
            font-weight: bold;
            color: #fff;
        }

        .navigation-manual {
            position: absolute; /* Position the manual buttons */
            bottom: 200px; /* Reduce the white space under the buttons */
            width: 100%;
            display: flex;
            justify-content: center;
            z-index: 1000; /* Ensure they are above other elements */
        }
    </style>
    <title>Tere Liye Bookstore</title>
</head>
<body>
    <%@ include file="header.jsp" %>
    <br><br>
    <!-- Slideshow container -->
    <div class="slider">
        <div class="slides">
            <input type="radio" name="radio-btn" id="radio1" checked>
            <input type="radio" name="radio-btn" id="radio2">
            <input type="radio" name="radio-btn" id="radio3">

            <div class="slide first">
                <img src="image/1.png" alt="Slide 1">
            </div>

            <div class="slide">
                <img src="image/2.png" alt="Slide 2">
            </div>

            <div class="slide">
                <img src="image/3.png" alt="Slide 3">
            </div>

            <div class="navigation-auto">
                <div class="auto-btn1"></div>
                <div class="auto-btn2"></div>
                <div class="auto-btn3"></div>
            </div>
        </div>

        <div class="navigation-manual">
            <label for="radio1" class="manual-btn">•</label>
            <label for="radio2" class="manual-btn">•</label>
            <label for="radio3" class="manual-btn">•</label>
        </div>
    </div>

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

    <h1 class="heading"> <span>Best Seller</span> </h1>

    <div class="carousel-main-div1" id="carousel1">
        <div class="carousel-main">
            <div class="carousel-slide-best">
                <% for (bookBeans book : books) { %>
                    <a href="#" class="card-best" onclick="openModal(event, '<%= book.getId() %>', '<%= book.getNama() %>', '<%= book.getHarga() %>', '<%= book.getGenre() %>', '<%= book.getDeskripsi() %>', 'imageServlet?id=<%= book.getId() %>')">
                        <img src="imageServlet?id=<%= book.getId() %>" alt="<%= book.getNama() %>">
                        <h3><%= book.getNama() %></h3>
                        <p><%= book.getGenre() %></p>
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

    <div class="carousel-main-div1" id="carousel1">
        <div class="carousel-main">
            <div class="carousel-slide-new">
                <% for (bookBeans book : books) { %>
                    <a href="#" class="card-new" onclick="openModal(event, '<%= book.getId() %>', '<%= book.getNama() %>', '<%= book.getHarga() %>', '<%= book.getGenre() %>', '<%= book.getDeskripsi() %>', 'imageServlet?id=<%= book.getId() %>')">
                        <img src="imageServlet?id=<%= book.getId() %>" alt="<%= book.getNama() %>">
                        <h3><%= book.getNama() %></h3>
                        <p><%= book.getGenre() %></p>
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
            <form id="modal-form" action="<%=request.getContextPath()%>/AddToCartServlet" method="post">
                <input type="hidden" id="modal-book-id" name="bookId">
                <input type="hidden" id="modal-book-name" name="bookName">
                <input type="hidden" id="modal-book-price" name="bookPrice">
                <button type="submit">Add to Cart</button>
            </form>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <script type="text/javascript" src="javascript/script.js"></script>
</body>
</html>
