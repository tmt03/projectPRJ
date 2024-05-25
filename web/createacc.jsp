<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Account</title>
    <link rel="icon" type="image/png" href="Login_v1//images/icons/favicon.ico"/>
    <link rel="stylesheet" type="text/css" href="Login_v1/vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="Login_v1/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="Login_v1/vendor/animate/animate.css">
    <link rel="stylesheet" type="text/css" href="Login_v1/vendor/css-hamburgers/hamburgers.min.css">
    <link rel="stylesheet" type="text/css" href="Login_v1/vendor/select2/select2.min.css">
    <link rel="stylesheet" type="text/css" href="Login_v1/css/util.css">
    <link rel="stylesheet" type="text/css" href="Login_v1/css/main.css">
</head>
<body>

<div class="limiter">
    <div class="container-login100">
        <div class="wrap-login100">
            <div class="login100-pic js-tilt" data-tilt>
                <img src="Login_v1/images/logo_FPC.png" alt="IMG">
            </div>

            <form class="login100-form validate-form" action="createacc" method="post">
                <span class="login100-form-title">
                    Create Account
                </span>
                <% if (request.getAttribute("errorMessage2") != null) { %>
                    <p style="color: red;"><%= request.getAttribute("errorMessage2") %></p>
                <% } %>

                <div class="wrap-input100 validate-input" data-validate = "Username is required">
                    <input class="input100" type="text" name="username" placeholder="Username">
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
                        <i class="fa fa-envelope" aria-hidden="true"></i>
                    </span>
                </div>

                <div class="wrap-input100 validate-input" data-validate = "Password is required">
                    <input class="input100" type="password" name="password" placeholder="Password">
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
                        <i class="fa fa-lock" aria-hidden="true"></i>
                    </span>
                </div>

                <div class="wrap-input100 validate-input" data-validate = "Full Name is required">
                    <input class="input100" type="text" name="fullName" placeholder="Full Name">
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
                        <i class="fa fa-user" aria-hidden="true"></i>
                    </span>
                </div>

                <div class="wrap-input100 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
                    <input class="input100" type="email" name="email" placeholder="Email">
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
                        <i class="fa fa-envelope" aria-hidden="true"></i>
                    </span>
                </div>

                <div class="wrap-input100 validate-input" data-validate = "Phone Number is required">
                    <input class="input100" type="text" name="phoneNumber" placeholder="Phone Number">
                    <span class="focus-input100"></span>
                    <span class="symbol-input100">
                        <i class="fa fa-phone" aria-hidden="true"></i>
                    </span>
                </div>

                <div class="container-login100-form-btn">
                    <button class="login100-form-btn">
                        Create Account
                    </button>
                </div>

                <div class="text-center p-t-136">
                    <a class="txt2" href="login.jsp">
                        Back to Login
                        <i class="fa fa-long-arrow-left m-l-5" aria-hidden="true"></i>
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="Login_v1/vendor/jquery/jquery-3.2.1.min.js"></script>
<script src="Login_v1/vendor/bootstrap/js/popper.js"></script>
<script src="Login_v1/vendor/bootstrap/js/bootstrap.min.js"></script>
<script src="Login_v1/vendor/select2/select2.min.js"></script>
<script src="Login_v1/vendor/tilt/tilt.jquery.min.js"></script>
<script>
    $('.js-tilt').tilt({
        scale: 1.1
    })
</script>
<script src="Login_v1/js/main.js"></script>

</body>
</html>
