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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
       @import url('https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic&display=swap');
            /* Menghilangkan margin dan padding pada body dan html */
            body, html {
                font-family: Zen Maru Gothic;
                margin: 0;
                padding: 0;
                background-color: #FFFFEF;
            }
        .card {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            background-color: #FFFFEF;
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
        .input-group {
            position: relative;
        }
        .input-group-append {
            position: absolute;
            top: 0;
            right: 0;
            height: 100%;
            display: flex;
            align-items: center;
            padding: 0 10px;
            cursor: pointer;
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
                            <div class="input-group">
                                <input type="password" class="form-control" id="password" name="password" value="<%= user.getPassword() %>" required>
                                <div class="input-group-append" id="togglePassword">
                                    <i class="fas fa-eye"></i>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="address">Address</label>
                            <input type="text" class="form-control" id="address" name="address" value="<%= user.getAddress() %>">
                        </div>
                        <div class="form-group">
                            <label for="city">City</label>
                            <input type="text" class="form-control" id="city" name="city" value="<%= user.getCity() %>">
                        </div>
                        <div class="form-group">
                            <label for="postCode">Postal Code</label>
                            <input type="text" class="form-control" id="postCode" name="postCode" value="<%= user.getPostCode() %>">
                        </div>
                        <button type="submit" class="btn btn-primary">Update</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Notifikasi Berhasil Update -->
<div class="modal fade" id="updateSuccessModal" tabindex="-1" role="dialog" aria-labelledby="updateSuccessModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateSuccessModalLabel">Update Berhasil</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Anda berhasil memperbarui data Anda.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Notifikasi Tidak Ada Perubahan -->
<div class="modal fade" id="noChangesModal" tabindex="-1" role="dialog" aria-labelledby="noChangesModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="noChangesModalLabel">Tidak Ada Perubahan</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Anda tidak mengganti data akun Anda.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='detail.jsp'">OK</button>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const urlParams = new URLSearchParams(window.location.search);
        const updateSuccess = urlParams.get('updateSuccess');
        const noChanges = urlParams.get('noChanges');
        
        
        if (noChanges === 'true') {
            $('#noChangesModal').modal('show');
        }

        if (updateSuccess === 'true') {
            $('#updateSuccessModal').modal('show');
            $('#updateSuccessModal').on('hidden.bs.modal', function () {
                window.location.href = 'index.jsp'; // Arahkan ke index.jsp setelah modal ditutup
            });
        } else if (updateSuccess === 'false') {
            alert('Gagal memperbarui data. Silakan coba lagi.');
        } else if (noChanges === 'true') {
            $('#noChangesModal').modal('show');
        }

        document.getElementById('togglePassword').addEventListener('click', function () {
            var passwordField = document.getElementById('password');
            var passwordFieldType = passwordField.getAttribute('type');
            var icon = this.querySelector('i');
            if (passwordFieldType === 'password') {
                passwordField.setAttribute('type', 'text');
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordField.setAttribute('type', 'password');
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    });
</script>
</body>
</html>
