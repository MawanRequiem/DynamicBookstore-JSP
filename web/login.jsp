<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Zen+Maru+Gothic&display=swap');
        html, body {
            height: 100%;
            margin: 0;
            font-family: Zen Maru Gothic;
            background: url('image/gambar-login.png') no-repeat center center fixed;
            background-size: cover;
        }

        .container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .frame {
            height: 500px;
            width: 400px;
            background: rgba(255, 255, 229, 0.8);
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

        .nav {
            width: 100%;
            height: 50px;
            padding-top: 20px;
            align-items: center;
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
            margin-bottom: 20px;
            background: rgba(255, 255, 255, .2);
            color: black;
        }

        label {
            font-weight: bold;
            text-transform: uppercase;
            font-size: 13px;
            padding-left: 15px;
            padding-bottom: 10px;
            color: #EB6611;
            display: block;
        }

        .btn-signin, .btn-cancel {
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

        .btn-signin {
            background: #EB6611;
        }

        .btn-signin:hover {
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

        .text-eb6611 {
            color: #EB6611;
            font-weight: bold;
            text-decoration: none;
            cursor: pointer;
            font-size: 16px;
        }

        .modal-custom {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            padding: 20px;
            text-align: center;
        }

        .modal-header-custom {
            border-bottom: none;
            padding-bottom: 0;
        }

        .modal-footer-custom {
            border-top: none;
            padding-top: 0;
        }

        .modal-body-custom {
            padding: 20px 0;
        }

        .modal-title-custom {
            color: #EB6611;
            font-weight: bold;
        }

        .modal-button-custom {
            background-color: #EB6611;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }

        .modal-button-custom:hover {
            background-color: #B64E00;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="frame">
        <div class="nav">
            <ul class="links text-center">
                <li class="signin-active">
                    <span style="color: #FF7D29; font-weight: bold; text-transform: uppercase; font-size: 18px;">Login</span>
                </li>
            </ul>
        </div>
        <form class="form-signin" action="<%=request.getContextPath()%>/loginServlet" method="post" name="form">
            <label for="username">Username</label>
            <input class="form-styling" type="text" name="username" placeholder="" required>
            <label for="password">Password</label>
            <input class="form-styling" type="password" name="password" placeholder="" required>
            <button class="btn-signin" type="submit">Login</button>
            <button class="btn-cancel" type="button" onclick="window.location.href='index.jsp';">Cancel</button>
            <div class="sign-up">Belum punya akun? <a href="register.jsp">Daftar di sini</a></div>
        </form>
    </div>
</div>

<!-- Success Modal -->
<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content modal-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title modal-title-custom" id="successModalLabel">Login Successful</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body modal-body-custom">
                You have successfully logged in.
            </div>
            <div class="modal-footer modal-footer-custom">
                <button type="button" class="modal-button-custom" data-dismiss="modal" onclick="window.location.href='index.jsp';">OK</button>
            </div>
        </div>
    </div>
</div>

<!-- Error Modal -->
<div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content modal-custom">
            <div class="modal-header modal-header-custom">
                <h5 class="modal-title modal-title-custom" id="errorModalLabel">Login Failed</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body modal-body-custom">
                Incorrect username or password. Please try again.
            </div>
            <div class="modal-footer modal-footer-custom">
                <button type="button" class="modal-button-custom" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    $(document).ready(function() {
        <% if (request.getAttribute("loginSuccess") != null && (Boolean) request.getAttribute("loginSuccess")) { %>
        $('#successModal').modal('show');
        <% } else if (request.getAttribute("loginSuccess") != null && !(Boolean) request.getAttribute("loginSuccess")) { %>
        $('#errorModal').modal('show');
        <% } %>
    });

    $(document).ready(function() {
        // Deteksi saat input username atau password fokus
        $('.form-styling').on('focus', function() {
            $('.frame').addClass('active');
        });

        // Deteksi saat input kehilangan fokus
        $('.form-styling').on('blur', function() {
            if (!$(this).val()) {
                $('.frame').removeClass('active');
            }
        });

        // Deteksi saat form submit
        $('form').on('submit', function() {
            $('.frame').addClass('active');
        });
    });
</script>
</body>
</html>