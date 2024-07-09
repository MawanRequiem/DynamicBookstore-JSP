<%-- 
    Document   : header
    Created on : Jul 5, 2024, 10:45:47 AM
    Author     : Arya Prathama
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
      <%
String username = (String) session.getAttribute("uName");
boolean isLoggedIn = (username != null);
%>    
    <body>
         <header>
    <div class="top-bar">
        <img src="image/serial anak/tere liyee.png" height="60" class="logo"> <!-- Pastikan ukuran gambar disesuaikan -->
        <div class="navbar">
            <nav>
                <input type="search" id="search-input" class="form-control" placeholder="Cari Produk atau judul buku">
                <a href="index.jsp" class="navtext">Home</a>
                <a href="allbooklist.jsp" class="navtext">All Book</a>
                <a href="cart.jsp" class="navtext">Cart</a>
                <% if (isLoggedIn) { %>
                    <a href="detail.jsp" class="navtext"> <%= username %></a>
                <% } else { %>
                    <a href="login.jsp" class="navtext">Login</a>
                <% } %>
            </nav>
        </div>
    </div>
</header>
    </body>
</html>
