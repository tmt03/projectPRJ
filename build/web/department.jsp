<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DEPARTMENT</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            .sidebar {
                position: absolute;
                top: 0;
                left: 0;
                height: 100%;
                width: 250px;
                background-color: #343a40;
                padding-top: 60px;
                color: #fff;
                z-index: 1; /* Đảm bảo sidebar hiển thị dưới navbar */
            }

            .sidebar-item {
                padding: 10px 20px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                text-decoration: none;
                display: block;
            }

            .sidebar-item:hover {
                background-color: rgba(255, 255, 255, 0.1);
            }

            .main-content {
                margin-left: 250px;
                padding-top: 60px;
            }

            .main-content-container {
                padding: 20px;
                background-color: #f8f9fa;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .department-header {
                margin-bottom: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .department-title {
                font-size: 24px;
                font-weight: bold;
            }

            .add-member-btn {
                background-color: #28a745;
                border-color: #28a745;
            }

            .add-member-btn:hover {
                background-color: #218838;
                border-color: #1e7e34;
            }

            .member-table {
                width: 100%;
                margin-top: 20px;
            }

            .member-table th {
                background-color: #343a40;
                color: #fff;
            }

            .member-table td, .member-table th {
                padding: 8px;
                text-align: center;
            }

            .member-actions {
                white-space: nowrap;
            }

            /*NAVBAR*/
            .navbar {
                background-color: #714cb5;
            }

            .navbar-brand {
                font-weight: bold;
                font-size: 1.5rem;
            }

            .navbar-nav .nav-item .nav-link {
                color: #fff;
            }

            .dropdown-menu {
                background-color: #343a40;
            }

            .dropdown-menu .dropdown-item {
                color: #fff;
            }

            .dropdown-menu .dropdown-item:hover {
                background-color: #495057;
            }

            .dropdown:hover .dropdown-menu {
                display: block;
            }

            .dropdown-toggle::after {
                display: none;
            }

            .hot-events-table {
                background-color: #f8f9fa;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .hot-events-table h5, .feature-item h4 {
                margin-bottom: 20px;
                color: #343a40;
            }

            .hot-events-table table {
                width: 100%;
            }

            .hot-events-table th,
            .hot-events-table td {
                padding: 10px;
                text-align: center;
            }

            .hot-events-table th {
                background-color: #343a40;
                color: #fff;
            }

        </style>
    </head>
    <body>

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" >FPTU PSYCHOLOGY CLUB</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-center" id="navbarNavAltMarkup">
                    <div class="navbar-nav">
                        <a class="nav-item nav-link active" href="home">Trang chủ</a>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownCenter" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Quản lý</a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdownCenter">
                                <a class="dropdown-item" href="member">Quản lý thành viên</a>
                                <a class="dropdown-item" href="department">Quản lý phân ban</a>
                                <a class="dropdown-item" href="event">Quản lý sự kiện</a>
                            </div>
                        </li>

                        <a class="nav-item nav-link active" href="joinevent">Báo cáo</a>

                    </div>
                </div>
                <ul class="navbar-nav">
                    <c:if test="${sessionScope.user != null}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                ${sessionScope.user.full_name}
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="logout">Đăng xuất</a>
                            </div>
                        </li>
                    </c:if>

                </ul>
            </div>
        </nav>


        <!-- Main Content -->
        <div class="main-content">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">

                        <div id="content" class="department">
                            <div class="main-content-container">
                                <!-- Bảng thành viên -->
                                <table class="table member-table">
                                    <thead>
                                        <tr>
                                            <th>Tên Phân Ban</th>
                                            <th>Mô tả</th>
                                            <th>Số thành viên hiện tại</th>                                            
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody id="contentMembers">
                                        <c:forEach var="d" items="${requestScope.dataD}">
                                            <tr>
                                                <td>${d.departmentName}</td>
                                                <td>${d.departmentDescription}</td>
                                                <td>${d.memberCount}</td>                                               
                                                <td></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>   
                    </div>
                </div>
            </div>
        </div>



        <!-- Bootstrap JS và jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </body>
</html>
