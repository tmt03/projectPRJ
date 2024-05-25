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
import model.Events;
import model.bxhEvent;

/**
 *
 * @author thanm
 */
public class EventDAO extends DBContext {

    public List<Events> getAllEvent() throws SQLException {
        List<Events> events = new ArrayList<>();
        try {
            String sql = "SELECT [id]\n"
                    + "      ,[name]\n"
                    + "      ,[description]\n"
                    + "      ,[start_date]\n"
                    + "      ,[end_date]\n"
                    + "      ,[score]\n"
                    + "  FROM [dbo].[events]";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Events e = new Events();
                e.setId(resultSet.getInt("id"));
                e.setName(resultSet.getString("name"));
                e.setDescription(resultSet.getString("description"));
                e.setStart_date(resultSet.getString("start_date"));
                e.setEnd_date(resultSet.getString("end_date"));
                e.setScore(resultSet.getInt("score"));
                // Tạo đối tượng Member từ dữ liệu lấy từ cơ sở dữ liệu và thêm vào danh sách
                events.add(e);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return events;
    }

    //Thêm
    public boolean addEvent(Events e) {
        boolean success = false;
        try {
            // Chuẩn bị câu lệnh SQL để thêm dữ liệu vào bảng Members
            String sql = "INSERT INTO [dbo].[events]\n"
                    + "           ([name]\n"
                    + "           ,[description]\n"
                    + "           ,[start_date]\n"
                    + "           ,[end_date]\n"
                    + "           ,[score])\n"
                    + "     VALUES\n"
                    + "           (?,?,?,?,?)";

            // Tạo một PreparedStatement với câu lệnh SQL
            PreparedStatement statement = connection.prepareStatement(sql);

            // Thiết lập các tham số cho câu lệnh SQL
            statement.setString(1, e.getName());
            statement.setString(2, e.getDescription());
            statement.setString(3, e.getStart_date());
            statement.setString(4, e.getEnd_date());
            statement.setInt(5, e.getScore());

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
    public boolean updateEvent(Events e) {
        boolean success = false;
        try {
            // Chuẩn bị câu lệnh SQL để cập nhật thông tin thành viên trong bảng Members
            String sql = "UPDATE [dbo].[events]\n"
                    + "SET [name] = ?,\n"
                    + "    [description] = ?,\n"
                    + "    [start_date] = ?,\n"
                    + "    [end_date] = ?,\n"
                    + "    [score] = ?\n"
                    + "WHERE [id]= ?";

            // Tạo một PreparedStatement với câu lệnh SQL
            PreparedStatement statement = connection.prepareStatement(sql);

            // Thiết lập các tham số cho câu lệnh SQL
            statement.setString(1, e.getName());
            statement.setString(2, e.getDescription());
            statement.setString(3, e.getStart_date());
            statement.setString(4, e.getEnd_date());
            statement.setInt(5, e.getScore());
            statement.setInt(6, e.getId());

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
    public void deleteEvent(String id) {
        String query = "DELETE FROM [dbo].[events]\n"
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
    EventDAO eventDAO = new EventDAO();

    try {
        List<bxhEvent> topEvents = eventDAO.getBxhEvent();

        if (!topEvents.isEmpty()) {
            System.out.println("Top 3 Events:");
            for (int i = 0; i < topEvents.size(); i++) {
                bxhEvent event = topEvents.get(i);
                System.out.println("Event " + (i + 1) + ":");
                System.out.println("Name: " + event.getName());
                System.out.println("Score: " + event.getScore());
                System.out.println("-------------------------");
            }
        } else {
            System.out.println("No top events found.");
        }
    } catch (SQLException ex) {
        System.out.println("An error occurred: " + ex.getMessage());
    }
}

    public List<Events> searchEvent(String keyword2) throws SQLException {
        List<Events> events = new ArrayList<>();
        String query = "SELECT * FROM events WHERE name LIKE ? ";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            // Thiết lập tham số cho truy vấn
            statement.setString(1, "%" + keyword2 + "%");
            ResultSet resultSet = statement.executeQuery();

            // Duyệt qua kết quả trả về và thêm các thành viên vào danh sách
            while (resultSet.next()) {
                Events e = new Events();
                e.setId(resultSet.getInt("id"));
                e.setName(resultSet.getString("name"));
                e.setDescription(resultSet.getString("description"));
                e.setName(resultSet.getString("start_date"));
                e.setDescription(resultSet.getString("end_date"));
                e.setId(resultSet.getInt("score"));
                events.add(e);
            }
        }

        return events;
    }

    public List<bxhEvent> getBxhEvent() throws SQLException {
        List<bxhEvent> topEvents = new ArrayList<>();
        try {
            String sql = "SELECT TOP 3 name, score \n"
                    + "FROM events \n"
                    + "WHERE start_date <= GETDATE() AND end_date >= GETDATE() \n"
                    + "ORDER BY score DESC;";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                bxhEvent e = new bxhEvent();
                e.setName(resultSet.getString("name"));
                e.setScore(resultSet.getInt("score"));
                // Tạo đối tượng Member từ dữ liệu lấy từ cơ sở dữ liệu và thêm vào danh sách
                topEvents.add(e);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return topEvents;
    }
}
