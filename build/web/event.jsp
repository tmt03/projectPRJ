<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>EVENTS - FPTU PSYCHOLOGY CLUB</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
                z-index: 1;
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

            /*CÁC HOẠT ĐỘNG*/
            .activity-list {
                margin-top: 20px;
            }

            .activity {
                background-color: #f8f9fa;
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 10px;
            }

            .activity h5 {
                font-size: 18px;
                margin-bottom: 5px;
            }

            .activity p {
                font-size: 14px;
                color: #6c757d;
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
        <div class="container-fluid">
            <div class="row">
                <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4" >

                    <div class="main-content-container mt-4">
                        <h2>DANH SÁCH SỰ KIỆN</h2>
                        <form id="searchForm">
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" name="keyword2" id="searchInput" placeholder="Nhập từ khóa tìm kiếm">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary" type="submit" id="searchButton" onclick="searchEvent()">Tìm kiếm</button>
                                </div>
                            </div>
                        </form>
                        <c:if test="${sessionScope.user.role_id == 1}">

                            <!-- Nút "Thêm SK" -->
                            <button type="button" class="btn btn-success add-member-btn" data-toggle="modal" data-target="#addEventModal">
                                THÊM SỰ KIỆN
                            </button>
                        </c:if>
                        <button type="btton" class="btn btn-success add-member-btn" data-toggle="modal" data-target="#joinEventModal">JOIN EVENT</button>

                        <div class="modal fade" id="joinEventModal" tabindex="-1" role="dialog" aria-labelledby="joinEventModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="joinEventModalLabel">Thêm thành viên vào sự kiện</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <form id="joinEventForm" method="post" action="joinevent">
                                            <div class="form-group">
                                                <label for="eventId">Chọn sự kiện:</label>
                                                <select class="form-control" id="eventId" name="event_Id">
                                                    <!-- Option elements for events -->
                                                    <c:forEach var="e" items="${dataE}">
                                                        <option value="${e.id}">${e.name}</option>
                                                    </c:forEach>
                                                    <!-- End of dynamic options -->
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="memberId">Chọn thành viên:</label>
                                                <select class="form-control" id="memberId" name="member_Id">
                                                    <c:forEach var="m" items="${requestScope.data}">
                                                        <option value="${m.id}">${m.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <button type="submit" class="btn btn-primary" value="join" name="join">JOIN EVENT</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>



                        <!-- Modal Sửa Thành Viên -->
                        <div class="modal fade" id="editEventModal" tabindex="-1" aria-labelledby="editEventModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="editEventModalLabel">SỬA THÔNG TIN SỰ KIỆN</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Form để sửa thông tin thành viên -->
                                        <form method="post" action="event">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" id="editId" name="editId" >
                                            <div class="form-group">
                                                <label for="editName">TÊN SỰ KIỆN:</label>
                                                <input type="text" class="form-control" id="editName" name="editName"  required>
                                            </div>
                                            <div class="form-group">
                                                <label for="editDescription">THÔNG TIN SỰ KIỆN:</label>
                                                <input type="text" class="form-control" id="editDescription" name="editDescription"  required>
                                            </div>
                                            <div class="form-group">
                                                <label for="editStart_date">NGÀY BẮT ĐẦU:</label>
                                                <input type="date" class="form-control" id="editStart_date" name="editStart_date" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="editEnd_date">NGÀY KẾT THÚC:</label>
                                                <input type="date" class="form-control" id="editEnd_date" name="editEnd_date" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="editScore">ĐIỂM HOẠT ĐỘNG</label>
                                                <select class="form-control" id="editScore" name="editScore" required>

                                                    <option value="30">HIGH SCORE</option>
                                                    <option value="20">MEDIUM SCORE</option>
                                                    <option value="10">LOW SCORE</option>
                                                </select>
                                            </div>
                                            <!-- Các trường khác tương tự -->
                                            <!-- Kết thúc ví dụ -->
                                            <button type="submit" class="btn btn-primary">SAVE</button>
                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive" >
                            <table class="table member-table">
                                <thead>
                                    <tr>
                                        <th>TÊN SỰ KIỆN</th>
                                        <th>THÔNG TIN SỰ KIỆN</th>
                                        <th>NGÀY BẮT ĐẦU</th>
                                        <th>NGÀY KẾT THÚC</th>
                                        <th>ĐIỂM HOẠT ĐỘNG</th>
                                            <c:if test="${sessionScope.user.role_id == 1}">
                                            <th>LỰA CHỌN</th>
                                            </c:if>

                                    </tr>
                                </thead>
                                <tbody id="EventTableBody">
                                    <!-- Dữ liệu sự kiện sẽ được hiển thị ở đây -->
                                    <!-- Ví dụ: -->
                                    <c:forEach var="m" items="${requestScope.dataE}" >
                                        <tr>
                                            <td>${m.name}</td>
                                            <td>${m.description}</td>
                                            <td>${m.start_date}</td>
                                            <td>${m.end_date}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${m.score == 30}">HIGH SCORE</c:when>
                                                    <c:when test="${m.score == 20}">MEDIUM SCORE</c:when>
                                                    <c:when test="${m.score == 10}">LOW SCORE</c:when>
                                                    <c:otherwise></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <c:if test="${sessionScope.user.role_id == 1}">
                                                <td class="member-actions">
                                                    <!-- Sửa sự kiện -->
                                                    <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#editEventModal" onclick="populateEditFormE(${m.id}, '${m.name}', '${m.description}', '${m.start_date}', '${m.end_date}', '${m.score}')">Sửa</button>
                                                    <!-- Xóa member -->
                                                    <form id="deleteForm" action="event" method="post">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="eventId" value="">
                                                        <button type="button" class="btn btn-primary btn-sm" onclick="confirmDeleteE('${m.id}')">Xóa</button>
                                                    </form>


                                                </td>
                                            </c:if>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Modal Thêm Sự Kiện -->
                        <div class="modal fade" id="addEventModal" tabindex="-1" aria-labelledby="addEventModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="addEventModalLabel">THÊM SỰ KIỆN MỚI</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Form để thêm sự kiện mới -->
                                        <form method="post" action="event" accept-charset="UTF-8">
                                            <input type="hidden" name="action" value="add">
                                            <!-- Các trường nhập liệu -->
                                            <div class="form-group">
                                                <label for="name">TÊN SỰ KIỆN:</label>
                                                <input type="text" class="form-control" id="name" name="name"  required>
                                            </div>
                                            <div class="form-group">
                                                <label for="description">THÔNG TIN SỰ KIỆN:</label>
                                                <input type="text" class="form-control" id="description" name="description"  required>
                                            </div>
                                            <div class="form-group">
                                                <label for="start_date">NGÀY BẮT ĐẦU:</label>
                                                <input type="date" class="form-control" id="start_date" name="start_date" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="end_date">NGÀY KẾT THÚC:</label>
                                                <input type="date" class="form-control" id="end_date" name="end_date" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="score">ĐIỂM HOẠT ĐỘNG</label>
                                                <select class="form-control" id="score" name="score" required>
                                                    <option value="30">HIGH SCORE</option>
                                                    <option value="20">MEDIUM SCORE</option>
                                                    <option value="10">LOW SCORE</option>
                                                </select>
                                            </div>
                                            <button type="submit" class="btn btn-primary" >THÊM SỰ KIỆN</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <!-- Script -->
        <script>
                                                            function populateEditFormE(id, name, description, start_date, end_date, score) {

                                                                document.getElementById("editId").value = id;
                                                                document.getElementById("editName").value = name;
                                                                document.getElementById("editDescription").value = description;
                                                                document.getElementById("editStart_date").value = start_date;
                                                                document.getElementById("editEnd_date").value = end_date;
                                                                document.getElementById("editScore").value = score;

                                                            }


                                                            function confirmDeleteE(id) {
                                                                if (confirm("Bạn có chắc chắn muốn xóa không?")) {
                                                                    document.querySelector('input[name="eventId"]').value = id;
                                                                    document.getElementById("deleteForm").submit();
                                                                }
                                                            }
        </script>

    </body>
</html>
