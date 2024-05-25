/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Users;

/**
 *
 * @author thanm
 */
public class UserDAO extends DBContext {

    public Users CheckUsers(String username, String password) {
        String sql = "SELECT [id]\n"
                + "      ,[username]\n"
                + "      ,[password]\n"
                + "      ,[role_id]\n"
                + "      ,[full_name]\n"
                + "      ,[email]\n"
                + "      ,[phone_number]\n"
                + "  FROM [dbo].[users]\n"
                + "  WHERE username=? and password=?";
        try {

            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Users u = new Users(rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getInt("role_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone_number"));
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean checkUser(String username) {
        String sqlCheckUser = "SELECT [id]\n"
                + "      ,[username]\n"
                + "      ,[password]\n"
                + "      ,[role_id]\n"
                + "      ,[full_name]\n"
                + "      ,[email]\n"
                + "      ,[phone_number]\n"
                + "  FROM [dbo].[users]\n"
                + "  WHERE username=?";
        try {
            PreparedStatement statement = connection.prepareStatement(sqlCheckUser);
            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();
            return resultSet.next();
        } catch (SQLException e) {
            System.out.println("Error in createUser method: " + e.getMessage());
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }
    //Thêm tài khoản người dùng đăng kí vào database
    public boolean createUser(String username, String password, String full_name, String email, String phone_number) {
    String sqlInsert = "INSERT INTO [dbo].[users]\n"
            + "           ([username]\n"
            + "           ,[password]\n"
            + "           ,[role_id]\n" // Thêm cột 'role_id' vào câu lệnh INSERT
            + "           ,[full_name]\n"
            + "           ,[email]\n"
            + "           ,[phone_number])\n"
            + "     VALUES\n"
            + "           (?,?,?,?,?,?)";
    try {
        PreparedStatement insertStatement = connection.prepareStatement(sqlInsert);
        insertStatement.setString(1, username);
        insertStatement.setString(2, password);
        insertStatement.setInt(3, 2); // 'role_id' của user mới là 2
        insertStatement.setString(4, full_name);
        insertStatement.setString(5, email);
        insertStatement.setString(6, phone_number);

        int rowsInserted = insertStatement.executeUpdate();
        if (rowsInserted > 0) {
            return true;
        }
    } catch (SQLException e) {
        System.out.println("Error in createUser method: " + e.getMessage());
    }
    return false;
}


    public static void main(String[] args) {    
        // Tạo một đối tượng UserDAO
        UserDAO userDAO = new UserDAO();

        // Dữ liệu mẫu để thêm vào cơ sở dữ liệu
        String username = "hoang";
        String password = "123";
        String full_name = "Tô Việt Hoàng";
        String email = "hoang@gmail.com";
        String phone_number = "0123123123";

        // Thực hiện thêm người dùng vào cơ sở dữ liệu
        boolean success = userDAO.createUser(username, password, full_name, email, phone_number);

        // Kiểm tra kết quả
        if (success) {
            System.out.println("Thêm người dùng thành công!");
        } else {
            System.out.println("Thêm người dùng thất bại!");
        }
    
}
}
