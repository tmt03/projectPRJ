<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>MEMBERS - FPTU PSYCHOLOGY CLUB</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            /* Custom styles */


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
                        <h2>Danh sách thành viên</h2>
                        <form id="searchForm">
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" name="keyword" id="searchInput" placeholder="Nhập từ khóa tìm kiếm">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary" type="submit" id="searchButton" onclick="searchMembers()">Tìm kiếm</button>
                                </div>
                            </div>
                        </form>

                        <c:if test="${sessionScope.user.role_id == 1}">
                            <!-- Nút "Thêm thành viên" -->
                            <button type="button" class="btn btn-success add-member-btn" data-toggle="modal" data-target="#addMemberModal">
                                Thêm Thành Viên
                            </button>
                        </c:if>
                        <!-- Modal Sửa Thành Viên -->
                        <div class="modal fade" id="editMemberModal2" tabindex="-1" aria-labelledby="editMemberModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="editMemberModalLabel2">Sửa Thông Tin Thành Viên</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Form để sửa thông tin thành viên -->

                                        <form method="post" action="member">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" id="editId" name="id">
                                            <!-- Các trường nhập liệu -->

                                            <div class="form-group">
                                                <label for="editName">Họ Và Tên:</label>
                                                <input type="text" class="form-control" id="editName" name="editName"  required>
                                            </div>
                                            <div class="form-group">
                                                <label for="editMssv">Mã số sinh viên:</label>
                                                <input type="text" class="form-control" id="editMssv" name="editMssv"  required>
                                            </div>
                                            <div class="form-group">
                                                <label for="editGender">Giới tính:</label>
                                                <select class="form-control" id="editGender" name="editGender" required>
                                                    <option value="Male">Male</option>
                                                    <option value="Female">Female</option>
                                                    <option value="Other">Other</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="editPhone">Số điện thoại:</label>
                                                <input type="tel" class="form-control" id="editPhone" name="editPhone" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="editEmail">Email:</label>
                                                <input type="email" class="form-control" id="editEmail" name="editEmail" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="editBirthdate">Ngày sinh:</label>
                                                <input type="date" class="form-control" id="editBirthdate" name="editBirthdate" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="editJoinedDate">Ngày tham gia:</label>
                                                <input type="date" class="form-control" id="editJoinedDate" name="editJoinedDate" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="editStatus">Trạng thái:</label>
                                                <select class="form-control" id="editStatus" name="editStatus" required>
                                                    <option value="Active">Active</option>
                                                    <option value="Deactive">Deactive</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="editDepartment_id">Phân Ban:</label>
                                                <select class="form-control" id="editDepartment_id" name="editDepartment_id" required>
                                                    <option value="1">Ban Nội dung</option>
                                                    <option value="2">Ban Truyền thông</option>
                                                    <option value="3">Ban Văn hóa</option>
                                                </select>
                                            </div>
                                            <!-- Các trường khác tương tự -->
                                            <!-- Kết thúc ví dụ -->
                                            <button type="submit" class="btn btn-primary">Lưu Thay Đổi</button>
                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive" >
                            <table class="table member-table">
                                <thead>
                                    <tr>
                                        <th>Tên</th>
                                        <th>Mã số sinh viên</th>
                                        <th>Giới tính</th>
                                        <th>Số điện thoại</th>
                                        <th>Email</th>
                                        <th>Ngày sinh</th>
                                        <th>Ngày tham gia</th>
                                        <th>Status</th>
                                        <th>Phân Ban</th>
                                            <c:if test="${sessionScope.user.role_id == 1}">
                                            <th>Chức năng</th>
                                            </c:if>
                                    </tr>
                                </thead>
                                <tbody id="memberTableBody">
                                    <!-- Dữ liệu thành viên sẽ được hiển thị ở đây -->
                                    <!-- Ví dụ: -->

                                    <c:forEach var="m" items="${requestScope.data}" >
                                        <tr>
                                            <td>${m.name}</td>
                                            <td>${m.mssv}</td>
                                            <td>${m.gender}</td>
                                            <td>${m.phone}</td>
                                            <td>${m.email}</td>
                                            <td>${m.birthdate}</td>
                                            <td>${m.joinedDate}</td>
                                            <td>${m.status}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${m.department_id == 1}">Nội Dung</c:when>
                                                    <c:when test="${m.department_id == 2}">Truyền Thông</c:when>
                                                    <c:when test="${m.department_id == 3}">Văn Hóa</c:when>
                                                    <c:otherwise>[Không xác định]</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <c:if test="${sessionScope.user.role_id == 1}">

                                                <td class="member-actions">
                                                    <!-- Sửa member -->
                                                    <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#editMemberModal2" onclick="populateEditForm(${m.id}, '${m.name}', '${m.mssv}', '${m.gender}', '${m.phone}', '${m.email}', '${m.birthdate}', '${m.joinedDate}', '${m.status}', '${m.department_id}')">Sửa</button>

                                                    <!-- Xóa member -->
                                                    <form id="deleteForm" action="member" method="post">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="memberId" value="">
                                                        <button type="button" class="btn btn-primary btn-sm" onclick="confirmDelete('${m.id}')">Xóa</button>
                                                    </form>
                                                </td>
                                            </c:if>>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Modal Thêm Thành Viên -->
                        <div class="modal fade" id="addMemberModal" tabindex="-1" aria-labelledby="addMemberModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="addMemberModalLabel">Thêm Thành Viên Mới</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Form để thêm thành viên mới -->
                                        <form method="post" action="member" accept-charset="UTF-8">
                                            <input type="hidden" name="action" value="add">
                                            <!-- Các trường nhập liệu -->
                                            <div class="form-group">
                                                <label for="name">Họ Và Tên:</label>
                                                <input type="text" class="form-control" id="name" name="name" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="mssv">Mã số sinh viên:</label>
                                                <input type="text" class="form-control" id="mssv" name="mssv" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="gender">Giới tính:</label>
                                                <select class="form-control" id="gender" name="gender" required>
                                                    <option value="Nam">Nam</option>
                                                    <option value="Nữ">Nữ</option>
                                                    <option value="Khác">Khác</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="phone">Số điện thoại:</label>
                                                <input type="tel" class="form-control" id="phone" name="phone" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="email">Email:</label>
                                                <input type="email" class="form-control" id="email" name="email" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="birthdate">Ngày sinh:</label>
                                                <input type="date" class="form-control" id="birthdate" name="birthdate" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="joinedDate">Ngày tham gia:</label>
                                                <input type="date" class="form-control" id="joinedDate" name="joinedDate" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="status">Trạng thái:</label>
                                                <select class="form-control" id="status" name="status" required>
                                                    <option value="Active">Active</option>
                                                    <option value="Deactive">Deactive</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="department_id">Phân Ban:</label>
                                                <select class="form-control" id="department_id" name="department_id" required>
                                                    <option value="1">Ban Nội dung</option>
                                                    <option value="2">Ban Truyền thông</option>
                                                    <option value="3">Ban Văn hóa</option>
                                                </select>
                                            </div>
                                            <button type="submit" class="btn btn-primary" >Thêm Thành Viên</button>
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
                                                            function populateEditForm(id, name, mssv, gender, phone, email, birthdate, joinedDate, status, department_id) {
                                                                document.getElementById("editId").value = id;
                                                                document.getElementById("editName").value = name;
                                                                document.getElementById("editMssv").value = mssv;
                                                                document.getElementById("editGender").value = gender;
                                                                document.getElementById("editPhone").value = phone;
                                                                document.getElementById("editEmail").value = email;
                                                                document.getElementById("editBirthdate").value = birthdate;
                                                                document.getElementById("editJoinedDate").value = joinedDate;
                                                                document.getElementById("editStatus").value = status;
                                                                document.getElementById("editDepartment_id").value = department_id;
                                                            }

                                                            function confirmDelete(id) {
                                                                if (confirm("Bạn có chắc chắn muốn xóa không?")) {
                                                                    document.querySelector('input[name="memberId"]').value = id;
                                                                    document.getElementById("deleteForm").submit();
                                                                }
                                                            }
        </script>

    </body>
</html>
