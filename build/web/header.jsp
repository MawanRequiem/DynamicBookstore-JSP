<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic&display=swap');
        html, body {
            font-family: Zen Maru Gothic;
        }
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .search-container {
            position: relative;
            display: flex;
            align-items: center;
            width: 800px; /* Make the search bar longer */
            margin: 0 auto; /* Center align the search bar */
        }
        .search-container input[type="search"] {
            width: 100%; /* Make the input take the full width of the container */
            padding: 10px 40px 10px 20px; /* Adjust padding to make space for the icon */
            border-radius: 20px;
            border: 1px solid #ccc;
            outline: none;
        }
        .search-container button {
            background: none;
            border: none;
            position: absolute;
            right: 10px;
            cursor: pointer;
        }
        .search-container button img {
            width: 20px;
            height: 20px;
        }
        .suggestions-container {
            position: absolute;
            background-color: white;
            width: 800px; /* Make the suggestions box smaller than the search bar */
            max-height: 300px;
            overflow-y: auto;
            z-index: 1000;
            top: 50px; /* Adjust top position */
            border-radius: 15px;
            left: 23%; /* Adjust position to center it under the search bar */
            border: 1px;
        }
        .suggestion-item {
            padding: 10px;
            cursor: pointer;
        }
        .suggestion-item:hover {
            background-color: #f0f0f0;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1001;
            padding-top: 100px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0,0,0);
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .author-link {
            display: block; /* Pastikan elemen tersebut dapat menampung padding/margin */
            text-decoration: none; /* Hapus garis bawah dari hyperlink */
            color: inherit; /* Warna teks mengikuti warna dari elemen induk */
            font-size: 24px; /* Ukuran font mirip dengan <h3> */
            font-weight: bold; /* Tebal seperti <h3> */
            cursor: pointer; /* Mengubah cursor menjadi pointer saat hover */
            color: white;
        }
        .author-link:hover {
            color: white; /* Warna teks saat hover, sesuaikan dengan desain */
            text-decoration: none; /* Garis bawah saat hover */
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
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

        function getSearchSuggestions(query) {
            if (query.length === 0) {
                document.getElementById('suggestionsContainer').innerHTML = '';
                return;
            }

            $.ajax({
                url: 'searchServlet',
                method: 'GET',
                data: { query: query, action: 'suggest' },
                success: function(response) {
                    $('#suggestionsContainer').html(response);
                },
                error: function() {
                    $('#suggestionsContainer').html('<p>Error retrieving suggestions.</p>');
                }
            });
        }

        function selectSuggestion(value) {
            document.getElementById('search-input').value = value;
            document.getElementById('suggestionsContainer').innerHTML = '';
            document.getElementById('searchForm').submit();
        }
    </script>
</head>
<body>
    <%
         String userType = request.getParameter("user");
        if ("admin".equals(userType)) {
            session.setAttribute("isAdmin", true);
        }

        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        String username = (String) session.getAttribute("uName");
        boolean isLoggedIn = (username != null);
    %>    <header>
        <div class="top-bar">
            <a href="index.jsp" class="author-link">Tere Liye</a>
            <div class="navbar">
                <nav>
                     <form id="searchForm" action="searchServlet" method="GET" class="search-container" onsubmit="performSearch(event)">
                        <input type="search" id="search-input" name="query" class="form-control" placeholder="Cari Produk, Judul Buku, Penulis" onkeyup="getSearchSuggestions(this.value)">
                        <button type="submit">
                            <img src="https://cdn2.iconfinder.com/data/icons/ios-7-icons/50/search-512.png" alt="Search">
                        </button>
                    </form>
                    <div id="suggestionsContainer" class="suggestions-container"></div>
                    <a href="index.jsp" class="navtext">Home</a>
                    <a href="allbooklist.jsp" class="navtext">All Book</a>
                    <a href="cart.jsp" class="navtext">Cart</a>
                    <a href="TranshistoryServlet" class="navtext">Pesanan</a>
                    <% if (isAdmin != null && isAdmin) { %>
                        <a href="admin.jsp" class="navtext"><%= username %></a>
                    <% } else { %>
                        <% if (isLoggedIn) { %>
                            <a href="detail.jsp" class="navtext"><%= username %></a>
                        <% } else { %>
                            <a href="login.jsp" class="navtext">Login</a>
                        <% } %>
                    <% } %>
                </nav>
            </div>
        </div>
    </header>
    <div id="modal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <img id="modal-img" src="" alt="Book Image">
            <h2 id="modal-title">Book Title</h2>
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
</body>
</html>
