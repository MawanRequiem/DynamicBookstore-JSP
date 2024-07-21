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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic&display=swap');
        body, html {
            font-family: 'Zen Maru Gothic', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #FFFFEF;
        }
        .card-body {
            font-family: 'Zen Maru Gothic', sans-serif;
            flex: 1 1 auto;
            padding: 1.25rem;
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
        .btn-group-custom {
            display: flex;
            justify-content: space-between;
            width: 100%;
            font-weight: bold;
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
        .info-group {
            position: relative;
        }
        #togglePassword {
            cursor: pointer;
        }
        .update-btn-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .update-btn-group button {
            flex: 1;
            margin: 5px;
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
                    <form method="post" action="UpdateServlet">
                        <input type="hidden" name="id" value="<%= user.getId() %>">
                        <div class="info-group">
                            <label for="name">Name</label>
                            <input type="text" name="name" class="form-control" id="name" value="<%= user.getName() != null ? user.getName() : "" %>" placeholder="Enter your name">
                        </div>
                        <div class="info-group">
                            <label for="username">Username</label>
                            <p class="form-control-plaintext" id="username"><%= user.getUsername() %></p>
                        </div>
                        <div class="info-group">
                            <label for="email">Email</label>
                            <input type="email" name="email" class="form-control" id="email" value="<%= user.getEmail() != null ? user.getEmail() : "" %>" placeholder="Enter your email">
                        </div>
                        <div class="info-group">
                            <label for="address">Address</label>
                            <input type="text" name="address" class="form-control" id="address" value="<%= user.getAddress() != null ? user.getAddress() : "" %>" placeholder="Enter your address">
                        </div>
                        <div class="info-group">
                            <label for="city">City</label>
                            <select name="city" class="form-control" required>
                                <option value="" disabled>Select your city</option>
                                <% String[] cities = {"Ambon", "Atambua", "Balikpapan", "Banda Aceh", "Bandar Lampung", "Bandung", "Banyuwangi", "Bau-Bau", "Bekasi", "Bengkulu", "Bima", "Binjai", "Bitung", "Bogor", "Bukittinggi", "Cilegon", "Cimahi", "Cirebon", "Denpasar", "Depok", "Dumai", "Ende", "Gorontalo", "Jakarta", "Jambi", "Jayapura", "Kendari", "Kotamobagu", "Kupang", "Langsa", "Lhokseumawe", "Lubuklinggau", "Luwuk", "Makassar", "Magelang", "Malang", "Manado", "Mataram", "Maumere", "Medan", "Padang", "Padang Sidempuan", "Palangkaraya", "Palembang", "Palopo", "Palu", "Pangkal Pinang", "Pariaman", "Pekanbaru", "Pematang Siantar", "Pontianak", "Praya", "Probolinggo", "Purwokerto", "Ruteng", "Sabang", "Salatiga", "Samarinda", "Semarang", "Serang", "Sibolga", "Singkawang", "Solo", "Sorong", "Sungai Penuh", "Surabaya", "Tanjung Balai", "Tanjung Pandan", "Tanjung Pinang", "Tanjung Selor", "Tarakan", "Tebing Tinggi", "Ternate", "Tomohon", "Waingapu", "Yogyakarta"};
                                for(String cityOption : cities) {
                                %>
                                    <option value="<%= cityOption %>" <%= cityOption.equals(user.getCity()) ? "selected" : "" %>><%= cityOption %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="info-group">
                            <label for="postCode">Post Code</label>
                            <input type="text" name="postCode" class="form-control" id="postCode" value="<%= user.getPostCode() != null ? user.getPostCode() : "" %>" placeholder="Enter your post code">
                        </div>
                        <div class="info-group">
                            <label for="password">Password</label>
                            <div class="input-group">
                                <input type="password" name="password" class="form-control" id="password" value="<%= user.getPassword() %>" placeholder="Enter your password">
                                <div class="input-group-append">
                                    <span class="input-group-text" id="togglePassword">
                                        <i class="fas fa-eye"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="update-btn-group">
                            <button type="submit" class="btn btn-primary">Update</button>
                            <button type="button" class="btn btn-custom-red" onclick="confirmLogout()">Logout</button>
                            <button type="button" class="btn btn-custom-red" onclick="confirmDelete()">Delete Account</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Logout -->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="logoutModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="logoutModalLabel">Logout Confirmation</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to logout?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <a href="logoutServlet" class="btn btn-custom-red">Logout</a>
            </div>
        </div>
    </div>
</div>
                    
<!-- Modal Delete Account -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Delete Account Confirmation</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete your account? This action cannot be undone.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <a href="DeleteServlet" class="btn btn-custom-red">Delete Account</a>
            </div>
        </div>
    </div>
</div>

<!-- Modal Konfirmasi Lihat Riwayat -->
<div class="modal fade" id="viewHistoryModal" tabindex="-1" role="dialog" aria-labelledby="viewHistoryModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="viewHistoryModalLabel">Konfirmasi Melihat Riwayat</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to see your transaction history?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-dismiss="modal">No</button>
                <button type="button" class="btn btn-primary" id="confirmViewHistoryButton">See History</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function confirmLogout() {
        $('#logoutModal').modal('show');
    }

    function confirmDelete() {
        $('#deleteModal').modal('show');
    }


    document.getElementById('confirmViewHistoryButton').addEventListener('click', function() {
        window.location.href = "TranshistoryServlet";
    });

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
</script>
</body>
</html>
