<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        html, body * {
            box-sizing: border-box;
            font-family: 'Open Sans', sans-serif
        }

        body {
            background: rgb(144, 220, 255);
            font-family: 'Raleway', sans-serif;
        }

        .container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .frame {
            height: 700px;
            width: 500px;
            background: white;
            background-size: cover;
            padding: 20px;
            text-align: center;
            margin-left: auto;
            margin-right: auto;
            border-top: solid 1px rgba(255, 255, 255, .5);
            border-radius: 8px;
            box-shadow: 0px 0px 40px rgba(0, 0, 0, 0.1);
            box-sizing: border-box;
            overflow: hidden;
            transition: all .5s ease;
        }

        .frame-long {
            height: 615px;
        }

        .frame-short {
            height: 400px;
            margin-top: 50px;
            box-shadow: 0px 2px 7px rgba(0, 0, 0, 0.1);
        }

        .nav {
            width: 100%;
            height: 50px;
            padding-top: 20px;
            text-align: center;
            opacity: 1;
            transition: all .5s ease;
        }

        .nav-up {
            transform: translateY(-100px);
            opacity: 0;
        }

        .nav ul {
            list-style: none;
            padding: 0;
        }

        .nav ul li {
            display: inline;
            margin: 0 10px;
        }

        .nav ul li a {
            text-decoration: none;
            font-size: 16px;
            color: #333;
            transition: color 0.3s ease;
        }

        .nav ul li a:hover {
            color: #007BFF;
        }

        li {
            padding-left: 10px;
            font-size: 18px;
            display: inline;
            text-align: left;
            text-transform: uppercase;
            padding-right: 10px;
            color: #ffffff;
        }

        .signin-active a {
            text-align: center;
            padding-bottom: 10px;
            font-weight: bold;
            color: #007BFF;
            text-decoration: none;
            border-bottom: solid 2px #1059FF;
            transition: all .25s ease;
            cursor: pointer;
        }

        .signin-inactive a {
            padding-bottom: 0;
            color: rgba(255, 255, 255, .3);
            text-decoration: none;
            border-bottom: none;
            cursor: pointer;
        }

        .form-group {
            text-align: left;
        }

        .form-group label {
            font-weight: bold;
            text-transform: uppercase;
            font-size: 13px;
            color: #000;
            display: block;
            margin-bottom: 5px;
        }

        .form-control {
            width: 100%;
            height: calc(2.25rem + 2px);
            padding: .375rem .75rem;
            font-size: 1rem;
            line-height: 1.5;
            color: #495057;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid #ced4da;
            border-radius: .25rem;
            transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
        }

        .btn-primary {
            font-weight: 700;
            text-transform: uppercase;
            font-size: 16px;
            text-align: center;
            color: white;
            cursor: pointer;
            padding-top: 8px;
            width: 100%;
            height: 35px;
            border: none;
            border-radius: 4px;
            margin-top: 23px;
            background: #007BFF;
            transition: background 0.3s ease;
        }

        .btn-primary:hover {
            background: #0056b3;
        }

        .card-body {
            width: 100%;
            text-align: left;
            margin-top: 20px;
            height: 375px;
            font-size: 16px;
            font-weight: 300;
            padding-left: 37px;
            padding-right: 37px;
            padding-top: 55px;
            transition: opacity .5s ease, transform .5s ease;
        }

        .sign-up {
            text-align: center;
            margin-top: 10px;
        }

        .sign-up a {
            color: #007BFF;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirm-password").value;
            if (password !== confirmPassword) {
                $('#passwordMismatchModal').modal('show');
                return false;
            }
            return true;
        }

        window.onload = function() {
            var registrationStatus = '<%= request.getAttribute("registrationStatus") %>';
            if (registrationStatus === 'success') {
                $('#successModal').modal('show');
            } else if (registrationStatus === 'emailUsed') {
                $('#errorModal').modal('show');
            }
        };
    </script>
</head>
<body>
<div class="container">
    <div class="frame">
        <div class="nav">
            <ul class="links" style="text-align: center;">
                <li class="signin-active"><a class="btn" style="color: #000;">Register</a></li>
            </ul>
        </div>
        <div class="card-body">
            <form action="registerServlet" method="post" onsubmit="return validateForm();">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="confirm-password">Confirm Password</label>
                    <input type="password" class="form-control" id="confirm-password" name="confirmPassword" required>
                </div>
                <button type="submit" class="btn-primary">Register</button>
                <button class="btn-primary" type="button" onclick="window.location.href='index.jsp';">Cancel</button>
                <div class="sign-up">Sudah punya akun? <a href="login.jsp">Klik di sini</a></div>
            </form>
        </div>
    </div>
</div>

<!-- Success Modal -->
<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="successModalLabel">Registration Successful</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Your account has been created successfully.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="window.location.href='login.jsp';">Go to Login</button>
            </div>
        </div>
    </div>
</div>

<!-- Error Modal -->
<div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="errorModalLabel">Registration Failed</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                The email address is already in use. Please use a different email.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Password Mismatch Modal -->
<div class="modal fade" id="passwordMismatchModal" tabindex="-1" aria-labelledby="passwordMismatchModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="passwordMismatchModalLabel">Password Mismatch</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Passwords do not match. Please try again.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
