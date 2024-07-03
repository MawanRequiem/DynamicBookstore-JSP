<%-- 
    Document   : login
    Created on : 1 Jul 2024, 16.36.55
    Author     : personal
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <style>
            html,
            body * {
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
                height: 500px;
                width: 400px;
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
                transition: all .5s ease
            }

            .frame-long {
                height: 615px
            }

            .frame-short {
                height: 400px;
                margin-top: 50px;
                box-shadow: 0px 2px 7px rgba(0, 0, 0, 0.1)
            }

            .nav {
                width: 100%;
                height: 50px;
                padding-top: 20px;
                text-align: center;
                opacity: 1;
                transition: all .5s ease
            }

            .nav-up {
                transform: translateY(-100px);
                opacity: 0
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
                color: #ffffff
            }

            .signin-active a {
                text-align: center;
                padding-bottom: 10px;
                font-weight: bold;
                color: #007BFF;
                text-decoration: none;
                border-bottom: solid 2px #1059FF;
                transition: all .25s ease;
                cursor: pointer
            }

            .signin-inactive a {
                padding-bottom: 0;
                color: rgba(255, 255, 255, .3);
                text-decoration: none;
                border-bottom: none;
                cursor: pointer
            }
            
             .sign-up {
            text-align: center;
            margin-bottom: 20px;
            color: black; /* Ubah warna teks menjadi hitam */
        }
        
            .signup-active a {
                cursor: pointer;
                color: #ffffff;
                text-decoration: none;
                border-bottom: solid 1px #1059FF;
                padding-bottom: 10px
            }

            .signup-inactive a {
                cursor: pointer;
                color: rgba(255, 255, 255, .3);
                text-decoration: none;
                transition: all .25s ease
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
                transition: opacity .5s ease, transform .5s ease
            }

            .form-signin-left {
                transform: translateX(-400px);
                opacity: .0
            }

            .form-signup {
                width: 430px;
                height: 375px;
                font-size: 12px;
                font-weight: 300;
                padding-left: 37px;
                padding-right: 37px;
                padding-top: 55px;
                position: relative;
                top: -375px;
                left: 400px;
                opacity: 0;
                transition: all .5s ease
            }

            .form-signup-left {
                transform: translateX(-399px);
                opacity: 1
            }

            .form-signup-down {
                top: 0px;
                opacity: 0
            }

            .success {
                width: 80%;
                height: 150px;
                text-align: center;
                position: relative;
                top: -890px;
                left: 450px;
                opacity: .0;
                transition: all .8s .4s ease
            }

            .success-left {
                transform: translateX(-406px);
                opacity: 1
            }

            .successtext {
                color: #ffffff;
                font-size: 16px;
                font-weight: 300;
                margin-top: -35px;
                padding-left: 37px;
                padding-right: 37px
            }

            #check path {
                stroke: #ffffff;
                stroke-linecap: round;
                stroke-linejoin: round;
                stroke-width: .85px;
                stroke-dasharray: 60px 300px;
                stroke-dashoffset: -166px;
                fill: rgba(255, 255, 255, .0);
                transition: stroke-dashoffset 2s ease .5s, fill 1.5s ease 1.0s
            }

            #check.checked path {
                stroke-dashoffset: 33px;
                fill: rgba(255, 255, 255, .03)
            }

            .form-signin input,
            .form-signup input {
                color: black;
                font-size: 13px
            }

            .form-styling {
                width: 100%;
                height: 35px;
                padding: 10px;
                padding-left: 15px;
                border: 1px solid #ccc;
                border-radius: 20px;
                box-sizing: border-box;
                border-radius: 4px;
                margin-bottom: 20px;
                background: rgba(255, 255, 255, .2)
            }

            label {
                font-weight: bold;
                text-transform: uppercase;
                font-size: 13px;
                padding-left: 15px;
                padding-bottom: 10px;
                color: #000; /* Warna teks hitam */
                display: block;
            }

            :focus {
                outline: none;
                border: none
            }

            .form-signin input:focus,
            textarea:focus,
            .form-signup input:focus,
            textarea:focus {
                background: rgba(255, 255, 255, .3);
                border: none
            }

            .btn-signup {
                float: left;
                font-weight: 700;
                text-transform: uppercase;
                font-size: 13px;
                text-align: center;
                color: #ffffff;
                padding-top: 8px;
                width: 100%;
                height: 35px;
                border: none;
                border-radius: 20px;
                margin-top: 23px;
                background: rgba(16, 89, 255, 1);
                transition: all .3s ease
            }

            .btn-signin {
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

            .btn-signin:hover {
                background: #0056b3;
            }

            .btn-animate {
                float: left;
                font-weight: 700;
                text-transform: uppercase;
                font-size: 13px;
                text-align: center;
                color: #ffffff;
                padding-top: 8px;
                width: 100%;
                height: 35px;
                border: none;
                border-radius: 20px;
                margin-top: 23px;
                background-color: rgba(16, 89, 255, 1);
                left: 0px;
                top: 0px;
                transition: all .3s ease
            }

            .btn-animate-grow {
                width: 130%;
                height: 55px;
                position: relative;
                left: -55px;
                top: -20px;
                border-radius: 10px;
                background-color: rgba(16, 89, 255, 1);
            }

            .forgot {
                width: 100%;
                padding-top: 25px;
                text-align: center;
                font-size: 13px;
                color: rgba(255, 255, 255, .3)
            }

            .welcome {
                width: 100%;
                height: 50px;
                padding-top: 50px;
                text-align: center;
                opacity: .0;
                transition: transform .8s .6s ease, opacity .8s .6s ease
            }

            .welcome-left {
                transform: translateY(-780px);
                opacity: 1
            }

            .cover-photo {
                height: 150px;
                position: relative;
                left: 0px;
                top: -900px;
                background: url(http://www.fancyicons.com/free-icons/103/multicolor-large/256/star_256.png) no-repeat center center;
                background-size: cover;
                opacity: .3
            }

            .profile-photo {
                height: 125px;
                width: 125px;
                position: relative;
                border-radius: 70px;
                left: 155px;
                top: -1000px;
                background: url(https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS82mL0lCjn8cUhnzzoE1oYnjPkobX4USGFXw&usqp=CAU) no-repeat center center;
                background-size: 100% 135%;
                opacity: 1;
                transition: top .8s .5s ease, opacity .8s .5s ease
            }

            .profile-photo-left {
                top: -1080px;
                opacity: 1
            }

            .forgot a {
                color: rgba(255, 255, 255, .3);
                text-decoration: none
            }

            .forgot a:hover {
                color: rgba(255, 255, 255, .6);
                text-decoration: underline
            }

            .back {
                width: 100%;
                height: 50px;
                line-height: 50px;
                padding-top: 0px;
                text-align: center;
                font-size: 13px;
                color: rgba(255, 255, 255, .3);
                opacity: 1;
                transition: all .3s ease;
                cursor: pointer
            }

            .back:hover {
                color: rgba(255, 255, 255, .5);
                text-decoration: none
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
    </head>
    <body>
        <div class="container">
    <div class="frame">
        <div class="nav">
            <ul class="links" style="text-align: center;">
                <li class="signin-active"><a class="btn" style="color: #000;">Login</a></li>
            </ul>
        </div>
        <div ng-app ng-init="checked = false">
             <form class="form-signin" action="<%=request.getContextPath()%>/loginServlet" method="post" name="form"> 
                <label for="username">Username</label>
                <input class="form-styling" type="text" name="username" placeholder="" required>
                <label for="password">Password</label>
                <input class="form-styling" type="password" name="password" placeholder="" required>
                <button class="btn-signin">Login</button>
                <button class="btn-signin" type="button" onclick="window.location.href='index.jsp';">Cancel</button>
                <div class="sign-up">Belum punya akun? <a href="register.jsp">Daftar di sini</a></div>
            </form>
        </div>
    </div>
</div>
    </body>
</html>
