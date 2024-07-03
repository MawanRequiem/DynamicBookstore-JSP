<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.userBeans" %>
<%@ page import="controller.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Details</title>
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
        .btn-group-custom {
            display: flex;
            justify-content: space-between;
        }
        .btn-group-custom .btn {
            flex: 1;
            margin: 0 5px;
        }
        .info-group {
            border: 1px solid #dee2e6;
            border-radius: .25rem;
            padding: .75rem;
            margin-bottom: .75rem;
        }
        .info-group label {
            font-weight: bold;
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
                    Account Details
                </div>
                <div class="card-body">
                    <div class="info-group">
                        <label for="name">Name</label>
                        <p class="form-control-plaintext" id="name"><%= user.getName() %></p>
                    </div>
                    <div class="info-group">
                        <label for="username">Username</label>
                        <p class="form-control-plaintext" id="username"><%= user.getUsername() %></p>
                    </div>
                    <div class="info-group">
                        <label for="email">Email</label>
                        <p class="form-control-plaintext" id="email"><%= user.getEmail() %></p>
                    </div>
                    <div class="info-group">
                        <label for="password">Password</label>
                        <p class="form-control-plaintext" id="password">••••••••</p>
                    </div>
                    <div class="btn-group-custom">
                        <a href="update.jsp" class="btn btn-primary">Update</a>
                        <button type="button" class="btn btn-custom-red" onclick="confirmLogout()">Logout</button>
                        <button type="button" class="btn btn-custom-red" onclick="confirmDelete()">Delete Account</button>
                        <button type="button" class="btn btn-custom-red" onclick="viewHistory()">View History</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function confirmLogout() {
        if (confirm("Are you sure you want to logout?")) {
            window.location.href = "logoutServlet";
        }
    }

    function confirmDelete() {
        if (confirm("Are you sure you want to delete your account? This action cannot be undone.")) {
            window.location.href = "DeleteServlet";
        }
    }
        
            function viewHistory() {
        if (confirm("Are you sure you want to delete your account? This action cannot be undone.")) {
            window.location.href = "TranshistoryServlet";
        }
    }
</script>
</body>
</html>
