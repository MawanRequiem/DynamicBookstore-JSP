<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.userBeans" %>
<%@ page import="controller.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Account Details</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .btn-custom-red {
            background-color: red;
            color: white;
        }
        .btn-custom-red:hover {
            background-color: darkred;
        }
        .cancel-btn {
            position: absolute;
            top: 20px;
            left: 20px;
            background-color: red;
            color: white;
        }
    </style>
</head>
<body>
<%
    String username = (String) session.getAttribute("uName");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    UserDAO userDAO = new UserDAO();
    userBeans user = userDAO.getUserByUsername(username);
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div class="container mt-5">
    <a href="index.jsp" class="btn btn-danger cancel-btn">Cancel</a>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    Update Account Details
                </div>
                <div class="card-body">
                    <form action="UpdateServlet" method="post">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" required>
                        </div>
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" class="form-control" id="username" name="username" value="<%= user.getUsername() %>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="password" name="password" value="<%= user.getPassword() %>" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Update</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
