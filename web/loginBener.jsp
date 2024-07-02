<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
    <%
    // Retrieve the username from the session
    String username = (String) session.getAttribute("uName");
    if (username != null) {
        // Jika username ada, arahkan ke halaman index.jsp
        response.sendRedirect("index.jsp");
    } else {
        // Jika username tidak ada, arahkan ke halaman error.jsp
        response.sendRedirect("eror.jsp");
    }
    %>
</body>
</html>
