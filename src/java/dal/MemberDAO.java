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
import model.Members;

/**
 *
 * @author thanm
 */
public class MemberDAO extends DBContext {

    public List<Members> getAllMembers() throws SQLException {
        List<Members> members = new ArrayList<>();
        try {
            String sqlmembers = "SELECT [id]\n"
                    + "      ,[joined_date]\n"
                    + "      ,[status]\n"
                    + "      ,[name]\n"
                    + "      ,[mssv]\n"
                    + "      ,[gender]\n"
                    + "      ,[phone]\n"
                    + "      ,[email]\n"
                    + "      ,[birthdate]\n"
                    + "      ,[department_id]\n"
                    + "  FROM [dbo].[members]";
            PreparedStatement statement = connection.prepareStatement(sqlmembers);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Members member = new Members();
                member.setId(resultSet.getInt("id"));
                member.setJoinedDate(resultSet.getString("joined_date"));
                member.setStatus(resultSet.getString("status"));
                member.setName(resultSet.getString("name"));
                member.setMssv(resultSet.getString("mssv"));
                member.setGender(resultSet.getString("gender"));
                member.setPhone(resultSet.getString("phone"));
                member.setEmail(resultSet.getString("email"));
                member.setBirthdate(resultSet.getString("birthdate"));
                member.setDepartment_id(resultSet.getInt("department_id"));
                // Tạo đối tượng Member từ dữ liệu lấy từ cơ sở dữ liệu và thêm vào danh sách
                members.add(member);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return members;
    }

    //Thêm
    public boolean addMember(Members member) {
        boolean success = false;
        try {
            // Chuẩn bị câu lệnh SQL để thêm dữ liệu vào bảng Members
            String sql = "INSERT INTO [dbo].[members]\n"
                    + "           ([joined_date]\n"
                    + "           ,[status]\n"
                    + "           ,[name]\n"
                    + "           ,[mssv]\n"
                    + "           ,[gender]\n"
                    + "           ,[phone]\n"
                    + "           ,[email]\n"
                    + "           ,[birthdate]\n"
                    + "           ,[department_id])\n"
                    + "     VALUES\n"
                    + "           (?,?,?,?,?,?,?,?,?)";

            // Tạo một PreparedStatement với câu lệnh SQL
            PreparedStatement statement = connection.prepareStatement(sql);

            // Thiết lập các tham số cho câu lệnh SQL
            statement.setString(1, member.getJoinedDate());
            statement.setString(2, member.getStatus());
            statement.setString(3, member.getName());
            statement.setString(4, member.getMssv());
            statement.setString(5, member.getGender());
            statement.setString(6, member.getPhone());
            statement.setString(7, member.getEmail());
            statement.setString(8, member.getBirthdate());
            statement.setInt(9, member.getDepartment_id());

            // Thực thi câu lệnh SQL để thêm thành viên vào cơ sở dữ liệu
            int rowsAffected = statement.executeUpdate();

            // Kiểm tra xem việc thêm thành viên thành công hay không
            if (rowsAffected > 0) {
                success = true;
            }

            // Đóng kết nối và tài nguyên
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    //Sửa
    public boolean updateMember(Members member) {
        boolean success = false;
        try {
            // Chuẩn bị câu lệnh SQL để cập nhật thông tin thành viên trong bảng Members
            String sql = "UPDATE [dbo].[members]\n"
                    + "   SET [joined_date] = ?\n"
                    + "      ,[status] = ?\n"
                    + "      ,[name] = ?\n"
                    + "      ,[mssv] = ?\n"
                    + "      ,[gender] = ?\n"
                    + "      ,[phone] = ?\n"
                    + "      ,[email] = ?\n"
                    + "      ,[birthdate] = ?\n"
                    + "      ,[department_id] = ?\n"
                    + "WHERE [id] = ?";

            // Tạo một PreparedStatement với câu lệnh SQL
            PreparedStatement statement = connection.prepareStatement(sql);

            // Thiết lập các tham số cho câu lệnh SQL
            statement.setString(1, member.getJoinedDate());
            statement.setString(2, member.getStatus());
            statement.setString(3, member.getName());
            statement.setString(4, member.getMssv());
            statement.setString(5, member.getGender());
            statement.setString(6, member.getPhone());
            statement.setString(7, member.getEmail());
            statement.setString(8, member.getBirthdate());
            statement.setInt(9, member.getDepartment_id());
            statement.setInt(10, member.getId()); // Đặc điểm định danh để cập nhật thành viên

            // Thực thi câu lệnh SQL để cập nhật thông tin thành viên trong cơ sở dữ liệu
            int rowsAffected = statement.executeUpdate();

            // Kiểm tra xem việc cập nhật thông tin thành viên thành công hay không
            if (rowsAffected > 0) {
                success = true;
            }

            // Đóng kết nối và tài nguyên
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    //Xóa
    public void deleteMember(String id) {
        String query = "DELETE FROM [dbo].[members]\n"
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

    public List<Members> searchMembers(String keyword) throws SQLException {
        List<Members> members = new ArrayList<>();
        String query = "SELECT * FROM members WHERE name LIKE ? ";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            // Thiết lập tham số cho truy vấn
            statement.setString(1, "%" + keyword + "%");
            ResultSet resultSet = statement.executeQuery();

            // Duyệt qua kết quả trả về và thêm các thành viên vào danh sách
            while (resultSet.next()) {
                Members member = new Members();
                member.setId(resultSet.getInt("id"));
                member.setName(resultSet.getString("name"));
                member.setMssv(resultSet.getString("mssv"));
                member.setGender(resultSet.getString("gender"));
                member.setPhone(resultSet.getString("phone"));
                member.setEmail(resultSet.getString("email"));
                member.setBirthdate(resultSet.getString("birthdate"));
                member.setJoinedDate(resultSet.getString("joined_date"));
                member.setStatus(resultSet.getString("status"));
                member.setDepartment_id(resultSet.getInt("department_id"));
                members.add(member);
            }
        }

        return members;
    }

}
