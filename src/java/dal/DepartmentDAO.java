/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Departments;
import model.DepartmentMemberCount;

/**
 *
 * @author thanm
 */
public class DepartmentDAO extends DBContext {

    public List<Departments> getAllDepartment() throws SQLException {
        List<Departments> department = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[name]\n"
                    + "      ,[description]\n"
                    + "      ,[start_date]\n"
                    + "      ,[end_date]\n"
                    + "      ,[location]\n"
                    + "  FROM [dbo].[departments]";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Departments d = new Departments();
                d.setId(resultSet.getInt("id"));
                d.setName(resultSet.getString("name"));
                d.setDescription(resultSet.getString("description"));
                // Tạo đối tượng Member từ dữ liệu lấy từ cơ sở dữ liệu và thêm vào danh sách
                department.add(d);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return department;
    }

    public List<DepartmentMemberCount> getDepartmentMemberCounts() throws SQLException {
        List<DepartmentMemberCount> departmentCounts = new ArrayList<>();

        try {
            String query = "SELECT departments.id, departments.name, departments.description, COUNT(members.id) AS member_count\n"
                    + "FROM departments\n"
                    + "LEFT JOIN members ON departments.id = members.department_id \n"
                    + "GROUP BY departments.id, departments.name, departments.description";

            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int departmentId = resultSet.getInt("id");
                String departmentName = resultSet.getString("name");
                String departmentDescription = resultSet.getString("description");
                int memberCount = resultSet.getInt("member_count");

                DepartmentMemberCount department = new DepartmentMemberCount(departmentId, departmentName, departmentDescription, memberCount);
                departmentCounts.add(department);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return departmentCounts;
    }

    //Thêm
    public boolean addDepartment(Departments d) {
        boolean success = false;
        try {
            // Chuẩn bị câu lệnh SQL để thêm dữ liệu vào bảng Members
            String sql = "INSERT INTO [dbo].[departments]\n"
                    + "           ([name]\n"
                    + "           ,[description]\n"
                    + "           ,[start_date]\n"
                    + "           ,[end_date]\n"
                    + "           ,[location])\n"
                    + "     VALUES\n"
                    + "           (?,?,?,?,?)";

            // Tạo một PreparedStatement với câu lệnh SQL
            PreparedStatement statement = connection.prepareStatement(sql);

            // Thiết lập các tham số cho câu lệnh SQL
            statement.setString(1, d.getName());
            statement.setString(2, d.getDescription());

            // Thực thi câu lệnh SQL để thêm thành viên vào cơ sở dữ liệu
            int rowsAffected = statement.executeUpdate();

            // Kiểm tra xem việc thêm thành viên thành công hay không
            if (rowsAffected > 0) {
                success = true;
            }

            // Đóng kết nối và tài nguyên
            statement.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return success;
    }

    //Sửa
    public boolean updateDepartment(Departments d) {
        boolean success = false;
        try {
            // Chuẩn bị câu lệnh SQL để cập nhật thông tin thành viên trong bảng Members
            String sql = "UPDATE [dbo].[departments]\n"
                    + "   SET [name] = ?\n"
                    + "      ,[description] = ?\n"
                    + "      ,[start_date] = ?\n"
                    + "      ,[end_date] = ?\n"
                    + "      ,[location] = ?\n"
                    + " WHERE [id] = ?";

            // Tạo một PreparedStatement với câu lệnh SQL
            PreparedStatement statement = connection.prepareStatement(sql);

            // Thiết lập các tham số cho câu lệnh SQL
            statement.setInt(1, d.getId());
            statement.setString(2, d.getName());
            statement.setString(3, d.getDescription());

            // Đặc điểm định danh để cập nhật thành viên
            // Thực thi câu lệnh SQL để cập nhật thông tin thành viên trong cơ sở dữ liệu
            int rowsAffected = statement.executeUpdate();

            // Kiểm tra xem việc cập nhật thông tin thành viên thành công hay không
            if (rowsAffected > 0) {
                success = true;
            }

            // Đóng kết nối và tài nguyên
            statement.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return success;
    }

    //Xóa
    public void deleteDepartment(String id) {
        String query = "DELETE FROM [dbo].[departments]\n"
                + "      WHERE id=?";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
        }
    }

    //Tìm kiếm
    public static void main(String[] args) {
        // Tạo một đối tượng MemberDAO
        MemberDAO dao = new MemberDAO();

        // Thực hiện việc xóa thành viên
        String memberIdToDelete = "8"; // Thay đổi id thành viên cần xóa tại đây
        dao.deleteMember(memberIdToDelete);

        // In ra thông báo sau khi xóa thành viên thành công
        System.out.println("Thành viên với ID " + memberIdToDelete + " đã được xóa thành công.");
    }

    public List<Departments> searchDepartment(String keyword2) throws SQLException {
        List<Departments> department = new ArrayList<>();
        String query = "SELECT * FROM departments WHERE name LIKE ? ";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            // Thiết lập tham số cho truy vấn
            statement.setString(1, "%" + keyword2 + "%");
            ResultSet resultSet = statement.executeQuery();

            // Duyệt qua kết quả trả về và thêm các thành viên vào danh sách
            while (resultSet.next()) {
                Departments d = new Departments();
                d.setId(resultSet.getInt("id"));
                d.setName(resultSet.getString("name"));
                d.setDescription(resultSet.getString("description"));
                department.add(d);
            }
        }

        return department;
    }

}
