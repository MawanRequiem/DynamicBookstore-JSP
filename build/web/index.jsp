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
        }, 30000); // Ubah gambar setiap 30 detik

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
            @import url('https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic&display=swap');
            /* Menghilangkan margin dan padding pada body dan html */
            body, html {
                font-family: Zen Mathu Ghotic;
                margin: 0;
                padding: 0;
                background-color: #FFFFEF;
            }

            #modal-img{
            width: 180px;
            }
            
            /* Mengatur margin top navbar dan slider */
            nav {
                margin-bottom: 0;
            }

            /* Mengatur gambar slider agar penuh dan tanpa jarak */
            .slider {
                width: 100%;
                height: 100vh; /* Full viewport height */
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
                align-items: center; /* Center align the images */
            }

            .slide img {
                width: 100%;
                height: 100%;
                object-fit: cover; /* Maintain aspect ratio */
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
        /* CSS untuk layout genre-icon */
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
            flex: 0 0 30%; /* Atur lebar kolom menjadi 30% */
            max-width: 30%;
            margin: 10px; /* Jarak antar kolom */
            text-align: center;
        }

            .icons {
            margin: 10px;
            text-align: center;
            color: black; /* Warna teks putih */
            text-decoration: none; /* Menghapus garis bawah tautan */
        }

        .icons img {
            width: 100%;
            height: auto;
          

            .icons:hover {
            background-color: #FFF; /* Warna putih saat hover */
            color: #000; /* Warna teks hitam saat hover */
        }
        }

            /* CSS untuk container dengan warna latar belakang #FFEEA9 */
        .carousel-main-div1 {
            background-color: #FFFFEF;
            padding: 20px; /* Sesuaikan padding sesuai kebutuhan */
            margin-bottom: 20px; /* Jarak bawah antara section Best Seller dan New Release */
        }
        
         .carousel-main-div1 img {
             height: 60%;
        }
        
        .price {
            font-size: 30%
        }
        
           .carousel-main-div1 h3{
             height: 15%;
        }

        /* CSS untuk tombol prev-main dan next-main */
        .prev-main, .next-main {
            background-color: #555; /* Warna latar belakang tombol */
            color: white; /* Warna teks tombol */
            border: none;
            cursor: pointer;
            padding: 10px 15px; /* Sesuaikan ukuran padding sesuai kebutuhan */
            font-size: 18px; /* Sesuaikan ukuran font sesuai kebutuhan */
            border-radius: 5px; /* Agar tombol membulat di sudutnya */
            transition: background-color 0.3s ease; /* Animasi perubahan warna latar belakang */
        }

        .prev-main:hover, .next-main:hover {
            background-color: #333; /* Warna latar belakang saat tombol dihover */
        }

        /* CSS untuk konten slide */
        .carousel-main {
            position: relative; /* Untuk mengatur posisi tombol prev-main dan next-main */
        }

        .card-best, .card-new {
        min-width: 200px;
        margin: 10px;
        padding: 10px;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        background-color: white;
        text-align: center;
        cursor: pointer;
        transition: transform 0.3s ease;
    }

     .icons h3 {
            color: black; /* Warna teks hitam */
            text-decoration: none; /* Menghilangkan underline */
            cursor: pointer; /* Mengubah kursor menjadi pointer saat dihover */
        }

        .icons h3:hover {
            text-decoration: none; /* Tetapkan kembali untuk menghindari garis bawah saat dihover */
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