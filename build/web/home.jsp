<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Home - HR Management System</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Custom CSS -->
        <link rel="stylesheet" type="text/css" href="Login_v1/css/util.css">
        <link rel="stylesheet" type="text/css" href="Login_v1/css/main.css">
        <!-- Favicon -->
        <link rel="icon" type="image/png" href="Login_v1/images/icons/favicon.ico"/>
        <style>
            /* Add your custom CSS here */
            .banner {
                position: relative; /* Thay đổi từ absolute thành relative */
                width: 300px;
                height: 30px; /* Điều chỉnh chiều cao theo ý muốn */
                background-color: #714cb5;
                display: flex;
                justify-content: center;
                align-items: center;
                color: #fff; /* Màu chữ trắng */
                font-size: 24px; /* Kích thước font chữ */
                text-align: center; /* Căn giữa nội dung */
            }

            .banner-image {
                width: 100%;
                height: 100px; /* Điều chỉnh kích thước ảnh */
                object-fit: cover; /* Đảm bảo ảnh sẽ được hiển thị đầy đủ trong phần banner */
            }

            /* CSS cho phần thông tin chào mừng */
            .welcome-row {
                margin-top: 20px;
            }

            .welcome-section {
                padding: 20px;
                background-color: #343a40;
                color: #fff;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .welcome-title {
                font-size: 2.5rem;
                font-weight: bold;
            }

            .club-name {
                font-size: 1.5rem;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .club-info {
                font-size: 1.2rem;
                font-style: italic;
            }

            .club-motto {
                font-size: 1.2rem;
                font-weight: bold;
            }

            .club-leadership {
                margin-top: 20px;
            }

            .club-leadership p {
                font-size: 1.2rem;
            }

            .feature-item {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
                text-align: center;
            }

            .feature-item h4 {
                color: #343a40;
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 15px;
            }

            .top-members, .hot-events-table {
                margin-top: 20px;
            }

            .member {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }

            .medal {
                width: 30px;
                height: 30px;
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: #ffd700; /* Màu vàng cho tất cả các huy chương */
                color: #fff;
                border-radius: 50%;
                margin-right: 10px;
                box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.3); /* Hiệu ứng bóng đổ */
            }

            /* Màu sắc đặc biệt cho từng loại huy chương */
            .medal.silver {
                background-color: #c0c0c0; /* Màu bạc */
            }

            .medal.bronze {
                background-color: #cd7f32; /* Màu đồng */
            }

            .medal::after {
                content: attr(data-number); /* Sử dụng giá trị của thuộc tính data-number làm nội dung */
                position: absolute; /* Đặt vị trí tuyệt đối cho số */
                bottom: -10px; /* Dịch chuyển số xuống phía dưới một chút */
                left: 50%; /* Căn chỉnh số ở giữa huy chương */
                transform: translateX(-50%); /* Dịch chuyển số sang trái 50% để căn giữa */
                font-size: 12px; /* Kích thước của số */
            }


            .name {
                flex-grow: 1;
                font-weight: bold;
            }

            .score {
                font-weight: bold;
                color: #6c757d;
            }

            .score i {
                margin-right: 5px;
            }

            .footer {
                background-color: #343a40;
                color: #fff;
                padding: 20px 0;
                text-align: center;
                position: initial;
                bottom: 0;
                left: 0;
                width: 100%;
                z-index: 9999;
            }

            .footer-content {
                margin-bottom: 20px;
            }

            .footer-content p {
                margin-bottom: 10px;
                font-size: 16px;
            }

            .social-media div {
                margin-bottom: 5px;
                font-size: 16px;
            }

            .social-media a {
                color: #fff;
                text-decoration: none;
            }

            .social-media a:hover {
                text-decoration: underline;
            }

            #scrollToTopBtn {
                display: none;
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 9999;
            }

            #scrollToTopBtn.show {
                display: block;
            }

            .btn-dark {
                background-color: #343a40;
                border-color: #343a40;
            }

            .btn-dark:hover {
                background-color: #495057;
                border-color: #495057;
            }


            /*NAVBAR*/
            .navbar {
                position: fixed;
                top: 0;
                width: 100%;
                background-color: #714cb5;
                z-index: 1000; /* Đảm bảo navbar hiển thị trên các phần khác của trang */
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

            /*CÁC HOẠT ĐỘNG*/
            .activity-list {
                margin-top: 20px;
            }

            .activity {
                margin-bottom: 20px;
                text-align: center;
            }

            .activity img {
                max-width: 100%;
                height: auto;
                border: 4px solid #222; /* Màu khung tối */
            }

            .activity h5 {
                margin-top: 10px;
                font-size: 20px; /* Kích thước tiêu đề */
                color: #333; /* Màu chữ tiêu đề */
            }

            .activity p {
                color: #666; /* Màu chữ mô tả */
            }

            .image-container {
                position: relative;
                overflow: hidden;
                border-radius: 10px; /* Bo tròn góc */
            }

            .image-container::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5); /* Màu nền mờ */
                opacity: 0;
                transition: opacity 0.3s ease;
            }




            /*Welcome*/
            .welcome {
                background-color: #428049; /* Màu xanh lá cây */
                color: white; /* Màu chữ trắng */
                padding: 20px; /* Khoảng cách padding */
                margin-bottom: 20px; /* Khoảng cách bottom */
                border-radius: 5px; /* Góc bo tròn */
                transition: transform 0.3s ease; /* Hiệu ứng chuyển động */
                font-size: 2em; /* Kích cỡ chữ */
                font-family: 'Ariel', cursive; /* Font chữ nữ tính */
                text-align: center;
            }

            /* Hover effect */
            .welcome:hover {
                transform: scale(1.05); /* Phóng to chút ít khi hover */
            }


        </style>
    </head>
    <body>
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
                        <script>
                            // Hiển thị thông báo trong 5 giây
                            setTimeout(function () {
                                document.getElementById('welcomeMessage').style.display = 'none';
                            }, 5000);
                        </script>
                    </c:if>

                </ul>
            </div>
        </nav>
        <div class="col-md-12">
            <img src="Login_v1/images/banner1.png" alt="Banner" class="banner-image img-fluid"><br>
            <div class="welcome" id="welcomeMessage" style="display: block;">WELLCOME TO FPC'S HOME</div>
        </div>

        <!-- Main information -->
        <div class="container mt-4">
            <div class="row welcome-row">


                <div class="col-md-12 welcome-section">
                    <h2 class="welcome-title">Chào mừng đến với CLB Tâm Lý Học FPT</h2>
                    <p class="club-name">FPTU Psychology Club</p>
                    <p class="club-info">
                        Câu lạc bộ tâm lý học thuộc Đại học FPT Hà Nội. Chúng tôi cam kết cung cấp môi trường học tập và nghiên cứu chuyên sâu về tâm lý học, 
                        cũng như tạo ra cơ hội để các thành viên phát triển kỹ năng và kiến thức trong lĩnh vực này.
                    </p>
                    <p class="club-motto">~ Nơi lắng nghe và chữa lành tâm hồn ~</p>
                    <div class="club-leadership">
                        <p><strong>Chủ nhiệm:</strong> Thân Minh Tâm</p>
                        <p><strong>Liên hệ:</strong> 0376496466</p>
                        <p><strong>Địa chỉ:</strong> Đại học FPT Hà Nội, Khu Công Nghệ Cao Hòa LẠc, Quận Bắc Từ Liêm, Hà Nội</p>
                    </div>
                </div>
            </div>


            <!-- Feature Section -->
            <div class="row mt-6">
                <div class="col-md-6">
                    <!-- TOP 3 SỰ KIỆN -->
                    <div class="hot-events-table">
                        <h5>TOP 3 SỰ KIỆN Ở THỜI ĐIỂM HIỆN TẠI</h5>                            
                        <a href="event" class="nav-item nav-link active" style="color: #218838">JOIN EVENT</a>


                        <table class="table">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>TÊN SỰ KIỆN</th>
                                    <th>ĐIỂM THƯỞNG</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="h" items="${requestScope.topEvents}" varStatus="loop">
                                    <!-- Dữ liệu của top 3 sự kiện -->
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${h.name}</td>
                                        <td>${h.score}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                    </div>
                </div>
                <div class="col-md-4">    
                    <div class="feature-item mt-4">
                        <h4>TOP 3 THÀNH VIÊN VÀNG</h4>
                        <c:forEach var="tm" items="${requestScope.topMembers}" varStatus="loop">
                            <div class="top-members">
                                <div class="member">
                                    <span class="medal ${loop.index == 0 ? 'gold' : loop.index == 1 ? 'silver' : loop.index == 2 ? 'bronze' : ''}" data-number="${loop.index + 1}">
                                        <i class="fas fa-medal"></i>
                                    </span>
                                    <span class="name">${tm.member_name}</span>
                                    <span class="score"><i class="fas fa-gem"></i>${tm.total_score}</span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

            </div>


            <br>
            <br>

            <div class="col-mt-4">
                <div class="feature-item">
                    <h4>Hoạt động trong thời gian qua</h4>
                    <div class="activity-list">
                        <!-- Danh sách hoạt động -->
                        <div class="activity">
                            <div class="image-container">
                                <img src="Login_v1/images/anh1.png" alt="Activity 1">
                            </div>
                            <h5>WOMEN'S DAY</h5>
                            <p></p>
                        </div>
                        <div class="activity">
                            <div class="image-container">
                                <img src="Login_v1/images/anh2.jpg" alt="Activity 2">
                            </div>
                            <h5>WATER DAY</h5>
                            <p></p>
                        </div>
                        <div class="activity">
                            <div class="image-container">
                                <img src="Login_v1/images/anh3.jpg" alt="Activity 3">
                            </div>
                            <h5>TEAM BUILDING</h5>
                            <p></p>
                        </div>
                    </div>
                </div>
            </div>

        </div>



        <footer class="footer">
            <div class="footer-content">
                <p>Email: fptupsyclub@gmail.com | SĐT: 0333 888 999</p>
                <div class="social-media">
                    <div><a href="https://www.google.com" target="_blank">Facebook: FPTU Psychology Club</a></div>

                </div>
            </div>
            <button id="scrollToTopBtn" class="btn btn-dark">Đến đầu trang</button>
        </footer>


        <script>
            // JavaScript để thực hiện cuộn đến đầu trang
            document.addEventListener('DOMContentLoaded', function () {
                var scrollToTopBtn = document.getElementById('scrollToTopBtn');

                window.addEventListener('scroll', function () {
                    // Hiển thị nút khi cuộn xuống một khoảng cụ thể
                    if (window.scrollY > 100) {
                        scrollToTopBtn.classList.add('show');
                    } else {
                        scrollToTopBtn.classList.remove('show');
                    }
                });

                // Cuộn đến đầu trang khi nhấp vào nút
                scrollToTopBtn.addEventListener('click', function () {
                    window.scrollTo({
                        top: 0,
                        behavior: 'smooth'
                    });
                });
            });

        </script>

        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.7/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <!-- Custom JS -->
        <script src="Login_v1/js/main.js"></script>
    </body>
</html>
