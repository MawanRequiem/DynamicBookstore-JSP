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
        @import url('https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic&display=swap');
        html, body {
            height: 100%;
            margin: 0;
            font-family:Zen Maru Gothic;
            background: url('image/gambar-register.png') no-repeat center center fixed;
            background-size: cover;
        }

        .container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .frame {
            height: 685px;
            width: 400px;
            background: rgba(255, 255, 229, 0.8);
            background-size: cover;
            padding: 20px;
            margin-left: auto;
            margin-right: auto;
            border-top: solid 1px rgba(255, 255, 255, .5);
            border-radius: 8px;
            box-shadow: 0px 0px 40px rgba(0, 0, 0, 0.1);
            box-sizing: border-box;
            overflow: hidden;
            transition: all .5s ease;
        }

        .nav {
            width: 100%;
            height: 50px;
            padding-top: 20px;
            text-align: center;
            opacity: 1;
            transition: all .5s ease;
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

        .form-signin {
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
            background: transparent;
        }

        .form-styling {
            width: 100%;
            height: 35px;
            padding: 10px;
            padding-left: 15px;
            border: 1px solid #ccc;
            border-radius: 20px;
            box-sizing: border-box;
            margin-bottom: 10px;
            background: rgba(255, 255, 255, .2);
            color: black;
        }

        label {
            font-weight: bold;
            font-size: 13px;
            padding-left: 15px;
            color: #EB6611;
            display: block;
        }

        .btn-primary, .btn-cancel {
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
            transition: background 0.3s ease;
        }

            .btn-secondary {
            color: white;
            background-color: #EB6611;
            border-color: #EB6611;
        }

        .btn-primary {
            background: #EB6611;
        }

        .btn-primary:hover {
            background: #B64E00;
        }

        .btn-cancel {
            background: #EB6611;
            margin-top: 10px;
        }

        .btn-cancel:hover {
            background: #B64E00;
        }

        .sign-up {
            text-align: center;
            margin-top: 10px;
            color: black;
        }

        .sign-up a {
            color: #EB6611;
            text-decoration: none;
            font-weight: bold;
        }

        .form-styling:focus {
            background: rgba(255, 255, 255, 0.8);
        }

        .form-styling:not(:placeholder-shown) {
            background: rgba(255, 255, 255, 0.8);
        }

        .frame.active {
            background: rgba(255, 255, 229, 1);
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

        $(document).ready(function() {
            $('.form-styling').on('focus', function() {
                $('.frame').addClass('active');
            });

            $('.form-styling').on('blur', function() {
                if (!$(this).val()) {
                    $('.frame').removeClass('active');
                }
            });

            $('form').on('submit', function() {
                $('.frame').addClass('active');
            });
        });
    </script>
</head>
<body>
<div class="container">
    <div class="frame">
        <div class="nav">
            <ul class="links text-center">
                <li class="signin-active">
                    <span style="color: #FF7D29; font-weight: bold; text-transform: uppercase; font-size: 18px;">Register</span>
                </li>
            </ul>
        </div>
        <div class="card-body">
            <form action="registerServlet" method="post" onsubmit="return validateForm();">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" class="form-control form-styling" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" class="form-control form-styling" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control form-styling" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control form-styling" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="confirm-password">Confirm Password</label>
                    <input type="password" class="form-control form-styling" id="confirm-password" name="confirmPassword" required>
                </div>
                <button type="submit" class="btn-primary">Register</button>
                <button class="btn-primary" type="button" onclick="window.location.href='index.jsp';">Cancel</button>
                <div class="sign-up">Sudah punya akun? <a href="login.jsp">Klik disini</a></div>
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